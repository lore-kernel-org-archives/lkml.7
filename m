Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED592067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="jfDIUAnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbfKFRde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:33:34 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:18094 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfKFRdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573061611;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Q505lUbwACTJ9Uat4QENPFE8hnyp9XvLsCrJ6IfHY4w=;
        b=jfDIUAnWxTd0q9aLEsdT4yTfaywlMGW81FmtL7SuOyQqhdEeWgrNNOUEEh7iCJdD+4
        2uLYaG7V+1h43SjDi2vtTcR9EbOwQNZ/2KaGJX6UvN/QoQZwfNALLHUUSjs/bqqlESGn
        YKNUHAzbQUQCYXjePprQ67gLYEJWTVjcBLs368qy5+lebF9nIRR3JoOdWQNb/dN6PdF+
        2xajYs5j7t2z8FvKUDkMMQ2GAuTffsuisxETobnSAR/cgtnWwn5JIWprhm0m3DEc8aIm
        S8mexClmwPcB/hlSxiPUuOFywAgcN+2q6RbnNjEJQFbWLVZ4BYeHB9nWW6WfrBRXIVo3
        1Sdw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6HXUhYT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:33:30 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] regulator: ab8500: Remove AB8505 USB regulator
Date:   Wed,  6 Nov 2019 18:31:24 +0100
Message-Id: <20191106173125.14496-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB regulator was removed for AB8500 in
commit 41a06aa738ad ("regulator: ab8500: Remove USB regulator").
It was then added for AB8505 in
commit 547f384f33db ("regulator: ab8500: add support for ab8505").

However, there was never an entry added for it in
ab8505_regulator_match. This causes all regulators after it
to be initialized with the wrong device tree data, eventually
leading to an out-of-bounds array read.

Given that it is not used anywhere in the kernel, it seems
likely that similar arguments against supporting it exist for
AB8505 (it is controlled by hardware).

Therefore, simply remove it like for AB8500 instead of adding
an entry in ab8505_regulator_match.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/regulator/ab8500.c       | 17 -----------------
 include/linux/regulator/ab8500.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index efb2f01a9101..f60e1b26c2d2 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -953,23 +953,6 @@ static struct ab8500_regulator_info
 		.update_val_idle	= 0x82,
 		.update_val_normal	= 0x02,
 	},
-	[AB8505_LDO_USB] = {
-		.desc = {
-			.name           = "LDO-USB",
-			.ops            = &ab8500_regulator_mode_ops,
-			.type           = REGULATOR_VOLTAGE,
-			.id             = AB8505_LDO_USB,
-			.owner          = THIS_MODULE,
-			.n_voltages     = 1,
-			.volt_table	= fixed_3300000_voltage,
-		},
-		.update_bank            = 0x03,
-		.update_reg             = 0x82,
-		.update_mask            = 0x03,
-		.update_val		= 0x01,
-		.update_val_idle	= 0x03,
-		.update_val_normal	= 0x01,
-	},
 	[AB8505_LDO_AUDIO] = {
 		.desc = {
 			.name		= "LDO-AUDIO",
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
index 7cf8f797e13a..505e94a6e3e8 100644
--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -37,7 +37,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_AUX6,
 	AB8505_LDO_INTCORE,
 	AB8505_LDO_ADC,
-	AB8505_LDO_USB,
 	AB8505_LDO_AUDIO,
 	AB8505_LDO_ANAMIC1,
 	AB8505_LDO_ANAMIC2,
-- 
2.23.0

