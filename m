Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E90C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58F521903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116571;
	bh=IYW5w0xi9plVoNDSuVhwR4xqJW4WyynHnCVHp/FYZDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6WP6FP7sPw3y2GPmoZac+9TEdhXXGJc4o9IP75o4auopgjaJQSzo5fP/kbcPSnvc
	 l7sG4yOpmDnObtV+nyLR0GtXqHgx8Fg33iUyeny4W385VCzWMFQbMoXWWAFWGcyX5v
	 k5g76R1yxtvgg6fFsD+sGGKRAIdyBK6s+r9WHIAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfDXOgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731024AbfDXOgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:36:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D5F21900;
        Wed, 24 Apr 2019 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116567;
        bh=IYW5w0xi9plVoNDSuVhwR4xqJW4WyynHnCVHp/FYZDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCTgn4+G8QNlRsGIJXdvlSMlqzhhYPKCOjf6fLIgPztu8SXEZrn7T0CobNOoJtqBY
         pKQlE/s84EoO++vHynWCbD13399tyzp8JDGstW8DR3MPn6XlquCTG+e09rLEzXTpqm
         7TroOm22Y8Hf1rg11NR0akolXJYupvrB154CmHTM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 55/66] sh: fix multiple function definition build errors
Date:   Wed, 24 Apr 2019 10:33:29 -0400
Message-Id: <20190424143341.27665-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
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
2.19.1

