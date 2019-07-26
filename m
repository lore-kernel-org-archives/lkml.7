Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E58218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154867;
	bh=TOvUZ/V6H7pXioIIJXW/vE91et+Coe2BrdMyH+z6fVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qeD+Xr4EC67m9KIFTI80bePynG0l2e00PGHn6IMXwSdiOd787XJtct9K0wzCX59pS
	 Uy/odh98kR66WrJPK8/jbniTRlrGUrGggwajxTf99s6Nq+ItpIWPgnam8Xkd/IAQYY
	 a8IJNh+/XDfKlTHP8bOaaD/CnD3S+zL0t8sdqA+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfGZP1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfGZP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:27:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E010205F4;
        Fri, 26 Jul 2019 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154862;
        bh=TOvUZ/V6H7pXioIIJXW/vE91et+Coe2BrdMyH+z6fVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOqZRr6FKFfPZnHWnGcxjQ9OGFvhJrZB7BhVd+qsSy7DuIM1pt9uZNErHbpczraEA
         lBAVOZMReozDA6Fs9WFfMgTM/krh4DX4bf++iJsDqLMa9+mS66bC86AYvC2arb1tyV
         zaC4K9AGB/UII6ttNKCfHd1f58ye4wfKAEPJ7L8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, od@zcrc.me,
        linux-mips@vger.kernel.org
Subject: [PATCH 5.2 52/66] MIPS: lb60: Fix pin mappings
Date:   Fri, 26 Jul 2019 17:24:51 +0200
Message-Id: <20190726152307.584006536@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 1323c3b72a987de57141cabc44bf9cd83656bc70 upstream.

The pin mappings introduced in commit 636f8ba67fb6
("MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers")
are completely wrong. The pinctrl driver name is incorrect, and the
function and group fields are swapped.

Fixes: 636f8ba67fb6 ("MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: od@zcrc.me
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/jz4740/board-qi_lb60.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -466,27 +466,27 @@ static unsigned long pin_cfg_bias_disabl
 static struct pinctrl_map pin_map[] __initdata = {
 	/* NAND pin configuration */
 	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-nand",
-			"10010000.jz4740-pinctrl", "nand", "nand-cs1"),
+			"10010000.pin-controller", "nand-cs1", "nand"),
 
 	/* fbdev pin configuration */
 	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_DEFAULT,
-			"10010000.jz4740-pinctrl", "lcd", "lcd-8bit"),
+			"10010000.pin-controller", "lcd-8bit", "lcd"),
 	PIN_MAP_MUX_GROUP("jz4740-fb", PINCTRL_STATE_SLEEP,
-			"10010000.jz4740-pinctrl", "lcd", "lcd-no-pins"),
+			"10010000.pin-controller", "lcd-no-pins", "lcd"),
 
 	/* MMC pin configuration */
 	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "mmc", "mmc-1bit"),
+			"10010000.pin-controller", "mmc-1bit", "mmc"),
 	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "mmc", "mmc-4bit"),
+			"10010000.pin-controller", "mmc-4bit", "mmc"),
 	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "PD0", pin_cfg_bias_disable),
+			"10010000.pin-controller", "PD0", pin_cfg_bias_disable),
 	PIN_MAP_CONFIGS_PIN_DEFAULT("jz4740-mmc.0",
-			"10010000.jz4740-pinctrl", "PD2", pin_cfg_bias_disable),
+			"10010000.pin-controller", "PD2", pin_cfg_bias_disable),
 
 	/* PWM pin configuration */
 	PIN_MAP_MUX_GROUP_DEFAULT("jz4740-pwm",
-			"10010000.jz4740-pinctrl", "pwm4", "pwm4"),
+			"10010000.pin-controller", "pwm4", "pwm4"),
 };
 
 


