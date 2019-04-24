Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250FC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21BB21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117320;
	bh=NOCSRD3naLNI0oZ1YvB42PYmwW4ahyF+Qwll3PynFmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vxHz1gr9eYL+XzT/xVKhpY/7PWrFyFnb5Nn0szl1uNSddurD5IHoeKDV2Ro2MFMIt
	 UwLoRBaU0jYJPCbWBUqfehKG86onxsM0hf7BtEvDvsnIT4YtR4JyzqXqOaQEc8kZjP
	 2J691ZCq1q1rbVzNL2MDp6qrkOmeziBuIeR1bQXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfDXOsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732489AbfDXOsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:48:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40EA218FD;
        Wed, 24 Apr 2019 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117314;
        bh=NOCSRD3naLNI0oZ1YvB42PYmwW4ahyF+Qwll3PynFmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0anTz4eEHALtCD02Sth8faADOmuK+yvDbYsvqGkE/O+42GyoQNfzPhxkKaHXvSLi
         BnsMnj8UZHj0Vpr5HL2oLy6rwwasjg4JYL6OMj0vPOSx5cHEaXfah/rUQJZLxmu4ZJ
         P9BXThUYaHnN9HhpGUZ+Lr++RO6MXDIngJorMSig=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 31/35] sh: fix multiple function definition build errors
Date:   Wed, 24 Apr 2019 10:47:05 -0400
Message-Id: <20190424144709.30215-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
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
2.19.1

