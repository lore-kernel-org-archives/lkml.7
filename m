Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECBEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A7A22303
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 00:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wlm8Gnf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKSAzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 19:55:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3csvm9Lo3WzW9dQ2Mg0+fMkG8GO7nCH6rOEcZI9Nfuk=; b=Wlm8Gnf1hGKAlw/pBo3kvpPZV
        9PyQ59JgUb67ox9WYvelT0Zt356laDKnncqYKw3474FeJumyqDeGAYttca49XgxY9axasz/5hhQPk
        4Se4P8xv8kWgoVaFhFx5PWoUrnujAAMU38+JdWOWrI1W6Yq6ER+hUHuXFHpp+GAkXuT/YH2oWHfaz
        9qvdmGaOVQlAuZOEXhSY2T4P+SxKLqv54NtqLdYwa97eFSX8yvZ3m3jy4VvhciC0Bs1VkiLkUDJqw
        thzMmjH/sHu6ylzz+yX6PXq9sTVDz0XlTMGNmzqlKHVNwpvRsxB05LMVNNSyGro7UQcdbWk+oSx7y
        YxCYcM/2A==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWrna-0004LZ-Ic; Tue, 19 Nov 2019 00:55:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/sh/: fix NUMA build errors
Message-ID: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
Date:   Mon, 18 Nov 2019 16:55:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
SYS_SUPPORTS_SMP and SMP.

kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
code + data inside topology.c is only built when CONFIG_NUMA is
set/enabled, so these arch/sh/ configs need to select SMP and
SYS_SUPPORTS_SMP to build the NUMA support.

Fixes this build error in 3 different SUPERH configs:

mm/page_alloc.o: In function `get_page_from_freelist':
page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
or maybe these should be fixed in the defconfig files?

or alternatively, does it make any sense to support NUMA without SMP?

 arch/sh/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- lnx-54-rc8.orig/arch/sh/Kconfig
+++ lnx-54-rc8/arch/sh/Kconfig
@@ -508,6 +508,8 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SHX2
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_SMP
+	select SMP
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
@@ -518,6 +520,8 @@ config CPU_SUBTYPE_SH7366
 	select CPU_SHX2
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_SMP
+	select SMP
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 


