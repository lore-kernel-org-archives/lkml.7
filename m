Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD1CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CFE206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577098813;
	bh=YcQqQUGLs0gtLzZjdiG2bxe+NtYknVXCVpbhU8oA+1U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a5WzvB7NuJzAXGwWc8xfhlSDbOQqiMrPB3xS30CnSo6tKO9IcbrtdsB+0E9Cd+VK/
	 Xxu0+zOx+16M+2Pyp20ozKpB9UDLRhCD+WyfeQHlSKnqnV/w7wmaAcCwYjoJ8GkGIO
	 sZSXV4zAJ8ZdIcD0DQKNvBpSq1tbudps6S81p0Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfLWLAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWLAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:00:12 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FFB206B7;
        Mon, 23 Dec 2019 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577098812;
        bh=YcQqQUGLs0gtLzZjdiG2bxe+NtYknVXCVpbhU8oA+1U=;
        h=From:To:Cc:Subject:Date:From;
        b=WcPwiPNT2/P0jKhnMDp1SdHKn3IFVCNhjbjg4X+OfoO6gkHUj0HIZXfXL99ebxREr
         Mnpmh/NBD3hhFYQUUaAGy3OefiZ9voh1T46Et/JzbpCeyTzIbw0Y+2qzqWJIzx84RX
         +MK7ztFM+Igr7BGg6jGE7tYbPAMC96gMi/lLhZSE=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/2] fix recent nds32 build breakage
Date:   Mon, 23 Dec 2019 13:00:02 +0200
Message-Id: <20191223110004.2157-1-rppt@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

The kbuild robot reported build breakage of nds32 architecture [1] that
happens with CONFIG_CPU_CACHE_ALIASING=n and CONFIG_HUGHMEM=y.

There are two issues: one with a missing macro during conversion of page
folding and another one is a conflict between cacheflush.h definitions in
arch/nds32 and asm-generic.

[1] https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/

Mike Rapoport (2):
  asm-generic/nds32: don't redefine cacheflush primitives
  nds32: fix build failure caused by page table folding updates

 arch/nds32/include/asm/cacheflush.h | 11 ++++++----
 arch/nds32/include/asm/pgtable.h    |  2 +-
 include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.24.0

