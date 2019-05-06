Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3FAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4622A2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155209;
	bh=ploqfepncoVXrCe87IV0KnwkIwovppJmkPjVgS6u8tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bcOnHR2Yaea0s9yCYjNCoi0ccwfI5aUwmNvHw9SBnz5BRdLCyGjo2GCYVhsYMA7a9
	 RsgnY1WEu0q75lhtMpT9ZZ+PQa7/WDQxrZ9lDyKOl+vX0icS/s+6YLSHpFojKK9/Um
	 2bBiM4RqDOe8WbPN3nXHdD92fAc+GQikooFdXtNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEFPGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfEFOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:37:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A6E206A3;
        Mon,  6 May 2019 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153452;
        bh=ploqfepncoVXrCe87IV0KnwkIwovppJmkPjVgS6u8tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXOr6AhtrsnQi0FxlRLrUMM5IXm4o6FKZsE/DMtbGyFVlQ1VX6jR/EV1NYxn0gFbL
         H29W38aNWzPld+ZpgwPZS1Nj5n3l8dtlCTDEAe2tPdmn1Y6a2HQnGRc0cDyWGRWZLj
         KGDSdwL7R3anZZNPao4xSF0VLwHZ3usbh52lNRMc=
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
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 077/122] sh: fix multiple function definition build errors
Date:   Mon,  6 May 2019 16:32:15 +0200
Message-Id: <20190506143101.753765207@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
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
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/sh/boards/of-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 958f46da3a79..d91065e81a4e 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -164,10 +164,10 @@ static struct sh_machine_vector __initmv sh_of_generic_mv = {
 
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



