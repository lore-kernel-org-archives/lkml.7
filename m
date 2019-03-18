Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2069C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3272085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aIN8g3yZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCRWrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:47:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7126 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCRWrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:47:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c901fe80000>; Mon, 18 Mar 2019 15:47:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Mar 2019 15:47:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Mar 2019 15:47:19 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Mar
 2019 22:47:18 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 0/1] x86/mm: Fix limit mmap() of /dev/mem to valid physical
Date:   Mon, 18 Mar 2019 15:46:52 -0700
Message-ID: <20190318224653.26549-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552949224; bh=NTlkLDX13fuAizR+ABtxTxwPWLPcmoYda6V4Bq6ahTI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:X-Originating-IP:
         X-ClientProxiedBy:Content-Transfer-Encoding:Content-Type;
        b=aIN8g3yZ1Dc0ar04crB/Ah9hHtOAZu5GJvp9IDuudusTgC4SrMvHARIIWhD0cXRDW
         0p7FY/3CNvWZQjV+uljyTlI5tRiuk3rSnPF31V0WS9C+2k83PstKhkNjbdl7Lm72Jq
         CCjBbIyQf8RoSeeKfWBI5fv4gzCEJ79OdxDTyCd+iEC3VlLTgmv80T2QB9SfUDLm5P
         XHptAsIi+lHvENoguCuOVU7jnXeu//Q1qG8P48kwT7GzTivYqyS8+QJd1KfzLE4fzr
         jt04M91dKech1d/w2oEiaqFRGiNV6QGAjpLvkEj71xQ+HfhQWEdKYjlP+Oah3FnTxI
         HYYv4hy10+bsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

I was debugging with v5.1.0-rc1 and while booting I hit a
kernel BUG at arch/x86/mm/physaddr.c:27
which I fixed with the following patch but now I can't seem
to reproduce the exact setup that triggered it.
Still, it seems like a valid problem and maybe my difficulty
in reproducing it explains why others haven't seen it earlier.

Ralph Campbell (1):
  x86/mm: Fix limit mmap() of /dev/mem to valid physical addresses

 arch/x86/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.20.1

