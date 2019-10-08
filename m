Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA4C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5EE20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="foD6ZQtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJHK5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:57:18 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:33405 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbfJHK5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570532232;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=TIVgIHfjbKvrmCs+OrKx1iDX7oZqkg8JkPhnCYxZmms=;
        b=foD6ZQtlq5i/MuhofszvaXVjVEl0Sx96oj2WHuHAkp/3R1gZs/cKasQtc3TK7nmVPP
        Xa9VhGKn7Fd9TNW+7khq+nLtgDV9qWWsPP3lxk3dAFJ2L4PEvFXxqdF3Na83P7lZ94N2
        4HUC11YnFxSYZbwhAU0EgaB0tnPIP5mcGrKF2ljpr3jTCdg9X5pLHQTVRC5WbE2F1sYK
        jRKTVZzh/4ertUrMJv7/wOT7M1tLuHnHdiregmSmS/7wTqEmnocRpSRACJNO9NAJ533M
        xSZ+pSSQqJS/Z2FcaGM5ELGULknYfbmKATFBOa4F1iDnxUtD9/0/qWTspGPaNlKCLl6V
        GR4A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXuMPvtxBR0Q=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id L0811cv98AvA7rD
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 8 Oct 2019 12:57:10 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] extcon: sm5502: Clear pending interrupts during initialization
Date:   Tue,  8 Oct 2019 12:54:34 +0200
Message-Id: <20191008105434.119346-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices (e.g. Samsung Galaxy A5 (2015)), the bootloader
seems to keep interrupts enabled for SM5502 when booting Linux.
Changing the cable state (i.e. plugging in a cable) - until the driver
is loaded - will therefore produce an interrupt that is never read.

In this situation, the cable state will be stuck forever on the
initial state because SM5502 stops sending interrupts.
This can be avoided by clearing those pending interrupts after
the driver has been loaded.

Reading the interrupt status registers twice seems to be sufficient
to make interrupts work in this situation.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
This makes interrupts work on the Samsung Galaxy A5 (2015), which
has recently gained mainline support [1].

I was not able to find a datasheet for SM5502, so this patch is
merely based on testing and comparison with the downstream driver [2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1329c1ab0730b521e6cd3051c56a2ff3d55f21e6
[2]: https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/SM-A500FU/drivers/misc/sm5502.c#L1566-L1578
---
 drivers/extcon/extcon-sm5502.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index dc43847ad2b0..c897f1aa4bf5 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -539,6 +539,12 @@ static void sm5502_init_dev_type(struct sm5502_muic_info *info)
 			val = info->reg_data[i].val;
 		regmap_write(info->regmap, info->reg_data[i].reg, val);
 	}
+
+	/* Clear pending interrupts */
+	regmap_read(info->regmap, SM5502_REG_INT1, &reg_data);
+	regmap_read(info->regmap, SM5502_REG_INT2, &reg_data);
+	regmap_read(info->regmap, SM5502_REG_INT1, &reg_data);
+	regmap_read(info->regmap, SM5502_REG_INT2, &reg_data);
 }
 
 static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
-- 
2.23.0

