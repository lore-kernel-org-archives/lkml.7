Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E046C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7F212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ljwxq5Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfFGKtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:49:39 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17387 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfFGKti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 06:49:38 -0400
X-IronPort-AV: E=Sophos;i="5.60,562,1549926000"; 
   d="scan'208";a="7741348"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Jun 2019 12:49:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 07 Jun 2019 12:49:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 07 Jun 2019 12:49:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559904577; x=1591440577;
  h=from:to:cc:subject:date:message-id;
  bh=jg3ogeYyjZ13Io4RHa3NmQVEVmQp6Dm5x4LA/opROkA=;
  b=ljwxq5PuG5u/2sZxxyIqATOHpl4awhzoMvnGGlAyT61kYH/nTULUnqVf
   vII+tiA6avsw3eXg0ufD19C/NQPhMb+aPZ39o8DvfiqepkwlzTwC1kscT
   3a/IygbrP0atz0RtWOuwYzZB00CqpS8wqTKOdjzF3ojW6+BVmg1+8JGxr
   e4dGFU2LRPpX4vkiMTbo9Bc9l61tZoleGdkvW+oZB94feWkZtr7h+S8aj
   tpYaUoAnVTYepFzJHGJHqg1L04dtGdsRfd8ixIjyWPkQmp/Km5aH/0FsS
   Saek5ARbYH3J8RSwQqpHsQhEgaiFNQ2tzaoSohz+TCDO+Q2HlWwouZxbp
   g==;
X-IronPort-AV: E=Sophos;i="5.60,562,1549926000"; 
   d="scan'208";a="7741347"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Jun 2019 12:49:37 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3BE62280074;
        Fri,  7 Jun 2019 12:49:44 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH modules v2 0/2] Fix handling of exit unwinding sections (on ARM)
Date:   Fri,  7 Jun 2019 12:49:10 +0200
Message-Id: <20190607104912.6252-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some time (050d18d1c651 "ARM: 8650/1: module: handle negative
R_ARM_PREL31 addends correctly", v4.11+), building a kernel without
CONFIG_MODULE_UNLOAD would lead to module loads failing on ARM systems with
certain memory layouts, with messages like:

  imx_sdma: section 16 reloc 0 sym '': relocation 42 out of range
  (0x7f015260 -> 0xc0f5a5e8)

(0x7f015260 is in the module load area, 0xc0f5a5e8 a regular vmalloc
address; relocation 42 is R_ARM_PREL31)

This is caused by relocatiosn in the .ARM.extab.exit.text and
.ARM.exidx.exit.text sections referencing the .exit.text section. As the
module loader will omit loading .exit.text without CONFIG_MODULE_UNLOAD,
there will be relocations from loaded to unloaded sections; the resulting
huge offsets trigger the sanity checks added in 050d18d1c651.

IA64 might be affected by a similar issue - sections with names like
.IA_64.unwind.exit.text and .IA_64.unwind_info.exit.text appear in the ld
script - but I don't know much about that arch.

Also, I'm not sure if this is stable-worthy - just enabling
CONFIG_MODULE_UNLOAD should be a viable workaround on affected kernels.

v2: Use __weak function as suggested by Jessica


Matthias Schiffer (2):
  module: allow arch overrides for .exit section names
  ARM: module: recognize unwind exit sections

 arch/arm/kernel/module.c     | 7 +++++++
 include/linux/moduleloader.h | 5 +++++
 kernel/module.c              | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.17.1

