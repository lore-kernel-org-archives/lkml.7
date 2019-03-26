Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1548C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6C0207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cqvRgXjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfCZASo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:18:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15872 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCZASo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:18:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c996fe10000>; Mon, 25 Mar 2019 17:18:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 17:18:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 Mar 2019 17:18:43 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 00:18:43 +0000
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
Subject: [PATCH v2 0/1] x86/mm: Fix limit mmap() of /dev/mem to valid physical
Date:   Mon, 25 Mar 2019 17:18:16 -0700
Message-ID: <20190326001817.15413-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553559521; bh=Ar2rKTHyUtl4aYwVRAxRlJMl89iafQ2aXTYpxu+WCO0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:X-Originating-IP:
         X-ClientProxiedBy:Content-Transfer-Encoding:Content-Type;
        b=cqvRgXjdzSmLk9NZ6OfUvmp4wfyVlWef1Yu+K6xe08gd/khlZs1opUw4eVZGGEiHD
         jrz0wdXsmNw0Hr2JZJgM47gqZPDvd8JW90kKtyxyBS3/speV+cHWThkXLHJ52JoxNr
         vzx/4TspKXwl3U73Jh1pSmy2V62CUG34vVHZBTAhFvxkjgFEHIYUvi9BDiL/XB6f1o
         mKWCfTKg8jOMQBwgAWQA3JVEnRl06UDuTHSjswHdY4Tns3TYCJmW7X4NrpVMGFfBeR
         4fc8y5uXU87hs63ghTqjx/VzEKI0I2yspZ4hjfQzAatZ2TBAw4MajGMjcvxI22DXv/
         ZGvsFQYj7f8tw==
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

Changes from v1 to v2:
 * Updated the change log and patch as suggested by Thomas Gleixner.

Ralph Campbell (1):
  x86/mm: Fix limit mmap() of /dev/mem to valid physical addresses

 arch/x86/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.20.1

