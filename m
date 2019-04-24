Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DC7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E1E21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116873;
	bh=pF4nU/zkCo4InwO1KyU4D/0dJtR4/tleLUTPcBlzENU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ptp+DOAbjOBYz+doaBSRcrw3tErG1WUn5jKw+qXCbRjAP4SkjaW3ZWQvbHKv0bzFL
	 ErmECqYWfZQRNSWYKv9cIJ98LEuhuR7jeUgXvEdkK8wLcsCO8KR+HVGAylxB4uisnt
	 ksCc6IoK+GGbnP9DLQA8awU6V5xJmHXJvS9BfImU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfDXOlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732072AbfDXOlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:41:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB12C218FD;
        Wed, 24 Apr 2019 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116868;
        bh=pF4nU/zkCo4InwO1KyU4D/0dJtR4/tleLUTPcBlzENU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ZF4A9w+u1mJvOyORoVQ85V/krd6+K7nhbu2LS2vEZFiTbWA7a9AwNdoshnZdx8oL
         3IxQlslYdlQmCy8jZ+69s/n/dyrTMFuGQBxcnkAdh6B/Mz/bhOsT7SnQrKglYEU4KU
         i0RbbkvDfAwhGLvPGaBlAbV/qUmPJDQ5PDpdsFOI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 46/52] sh: fix multiple function definition build errors
Date:   Wed, 24 Apr 2019 10:39:04 -0400
Message-Id: <20190424143911.28890-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

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
index 26789ad28193..cb99df514a1c 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -175,10 +175,10 @@ static struct sh_machine_vector __initmv sh_of_generic_mv = {
 
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
2.19.1

