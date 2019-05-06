Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B7C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1FE21019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153946;
	bh=YFjcCRz1LcmuYwDUcw7LQBICT55MkdrKd0g0k9SqRv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A8MMIhDsVQBsb+/0B4KYe6g7nW7Vp6bTdnboqJpcVG6P+8x3IJGoS4tWA41D83APp
	 2yhHyxR+s2LouE909iqU/VuNu/GSVO9Q/mYYgtEPLK7kx9XZZUdfIornVHs6qGrqoa
	 dfY0dD8X3SeW9w+ghdpWeOWfEtIJNOdjNmcEZrSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfEFOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfEFOpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:45:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B048214AF;
        Mon,  6 May 2019 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153940;
        bh=YFjcCRz1LcmuYwDUcw7LQBICT55MkdrKd0g0k9SqRv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWcmln2UoKWzABiGWx9mFNe9wVW7FAEU/8BJJX+snpTnFxc8iuMHCA/692lT2Qav3
         6aPgUcEvdzfRBMt2H9CzQjadIDE1A3+m0o+0HONzlrQr5wZKwZXooxO3MzHONyhKjr
         cYgUFVsat1cKR/ayxV/GpCD8ZoGZSPFKhN9+7g5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 54/75] sh: fix multiple function definition build errors
Date:   Mon,  6 May 2019 16:33:02 +0200
Message-Id: <20190506143058.139297460@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.287515952@linuxfoundation.org>
References: <20190506143053.287515952@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit acaf892ecbf5be7710ae05a61fd43c668f68ad95 ]

Many of the sh CPU-types have their own plat_irq_setup() and
arch_init_clk_ops() functions, so these same (empty) functions in
arch/sh/boards/of-generic.c are not needed and cause build errors.

If there is some case where these empty functions are needed, they can
be retained by marking them as "__weak" while at the same time making
builds that do not need them succeed.

Fixes these build errors:

arch/sh/boards/of-generic.o: In function `plat_irq_setup':
(.init.text+0x134): multiple definition of `plat_irq_setup'
arch/sh/kernel/cpu/sh2/setup-sh7619.o:(.init.text+0x30): first defined here
arch/sh/boards/of-generic.o: In function `arch_init_clk_ops':
(.init.text+0x118): multiple definition of `arch_init_clk_ops'
arch/sh/kernel/cpu/sh2/clock-sh7619.o:(.init.text+0x0): first defined here

Link: http://lkml.kernel.org/r/9ee4e0c5-f100-86a2-bd4d-1d3287ceab31@infradead.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boards/of-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 4feb7c86f4ac..5e83ea12303b 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -180,10 +180,10 @@ static struct sh_machine_vector __initmv sh_of_generic_mv = {
 
 struct sh_clk_ops;
 
-void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
+void __init __weak arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 {
 }
 
-void __init plat_irq_setup(void)
+void __init __weak plat_irq_setup(void)
 {
 }
-- 
2.20.1



