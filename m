Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE88C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A550E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hUt0r1uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCVFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:05:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35467 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:05:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so201051pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mjnpk7ucPEtpGkipTJSrZo3aPa7VvXM6E9i1mbpjX3w=;
        b=hUt0r1uBlcu53Fm730vWi3AaCVdQnXJNGTwKWCF/uSMLFCmeyfrlgSQvpdLQXDLTet
         az4UoJwJE2/pkAk87UriA5OiiZ94iCQE0k8cPfr5L0axtF8HtWxVsayZhDZcL4x8IPz+
         4UUau6OWGBgyoCvTBv+hY8SU1WoC0WYgNf03E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mjnpk7ucPEtpGkipTJSrZo3aPa7VvXM6E9i1mbpjX3w=;
        b=OS3NFz48WdwPxf2Nd7bClWTZfuBKIO4FxMrKUj9oIEnnaOYT6AN7TgMYPpSU3/EzP5
         5K21WE3Rh9R74YG9nwGdmYA/EeuYxYMWHOuTuFlLRIkLVzSUMw9kH7xkRSfb4d5uK9oZ
         WKJ5gyal4egYvW9qiXnoCtf3GjFYp/aqvm/EIa+VCStSNKYWvJcXwJ9sDDxq7nd+1NIT
         DJv/IqLg68ahcUjkpIFN+MyLCDR4Qqsf05Ud74q5uL5sVOJDoMZfLLIFU+BBmeKbQeOy
         grrMB2+C4JEWjYq6Xp+D38axaDzh6FywBococeI8Vfvt3JBnDNzhdLEb0IYJWPDaEYci
         8yqQ==
X-Gm-Message-State: APjAAAWUeYZSMLdeSc0Q7+CF4roXeciXweL3c3OjHsT3BK6e8uyigJvH
        fHs3If6/T5RlAzWnyvSVfdWBUg==
X-Google-Smtp-Source: APXvYqygDuaJO8bgHaT9HoT7V6Urp3100w2rIqzzHvU/1jJFw475ED7SGoTRgX1/YrxMSoSm5LDYJQ==
X-Received: by 2002:a65:6496:: with SMTP id e22mr1783320pgv.249.1554325545320;
        Wed, 03 Apr 2019 14:05:45 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l26sm27147365pfb.20.2019.04.03.14.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 14:05:44 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Date:   Wed,  3 Apr 2019 14:05:35 -0700
Message-Id: <20190403210535.32236-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
bit operations to get rid of compiler warning and improve readability of
the code

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 562942d0c05c..a845b8decac8 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -717,7 +717,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 			/* mark the last byte */
 			if (i == msg->len - 1)
-				val |= 1 << M_TX_WR_STATUS_SHIFT;
+				val |= BIT(M_TX_WR_STATUS_SHIFT);
 
 			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 		}
@@ -844,7 +844,7 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 
 	iproc_i2c->bus_speed = bus_speed;
 	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
-	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
+	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
 	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
 	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
@@ -995,7 +995,7 @@ static int bcm_iproc_i2c_resume(struct device *dev)
 
 	/* configure to the desired bus speed */
 	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
-	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
+	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
 	val |= (iproc_i2c->bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
 	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
-- 
2.17.1

