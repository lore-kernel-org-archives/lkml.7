Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B53C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC87E26DF1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YwsYh5oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfEaSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:30:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44489 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfEaSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:30:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id x3so1174756pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=YwsYh5oJQwEPe3fUMLgYt42UUuHz8TcbW/5SHOSf0IySNNotnBLz6Ncn/XYSUY0lvR
         ehqPrkRrKLNcnGatvl7u/qtHnXUv79GA7hpq0fS+e0pHN2HIQ2XKgPwEtVhWuc+I3rkg
         t4lrlx+nsVcuz1d00TbZ+R/qzKQKNiQ5zy/PkSZDogcb1sT60aJcZPcXHitPzI0MLVzp
         OrC442BKu5YfjC6QmsV0cGLa/+ZjxFmlSF3iDQFzy9gDnH7249MzwnOwswDGrsD4O9i5
         Ew/m3oI79+XGy3jNNLkKi3x/EIdY8tp+v2fQLSVoi0kJcHm60szzVxh2VtaDAby5CZI0
         Y+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=J2KMIVL62WeWRg/kFG9GRrhnX9uKSMzIA7XXgIrPNIIdx3qTBqtILr28amT13UPClV
         1QFZPKt5gKQ9Il0ms83ZDT1z1JmOO0X7JAyczbrD+accUFFIMf7tn6Qo7HJbiUTz8y+o
         UxxmFhhJwd4K5fLUFSBtT0UrA3XrUXb/jiFSS8BgyZmaDda/QMzBbltxZt97NHMjKA9j
         opslNSB0XUQcKzyaP89K3vpx+MSz71h9aTPyg934F4cQ0UPDW65cpwVv3Fkx/L9v/PNw
         pgaY1stqRKmCKgdOe/aeTv2OQfeVNB3Q5I5s8csVVrL8TOBLWClXMzICFwdRs/vv81eX
         LDWQ==
X-Gm-Message-State: APjAAAWxUEJHhyZvFuspGWv3GvPMuRuaSPgES31Wp+kt9VIqC8gmX9ar
        bjNyajQq/cko39bJPECWzE7reQ==
X-Google-Smtp-Source: APXvYqxIXDnKCINPiPDUYB1592TeW9iGXZ+g+jZRRRPmdxLoYPiJ/NXv5iEiJLIhCXbPsgQ9QQWm8w==
X-Received: by 2002:a62:6241:: with SMTP id w62mr12176429pfb.226.1559327453352;
        Fri, 31 May 2019 11:30:53 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 85sm10039511pgb.52.2019.05.31.11.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 11:30:52 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH REPOST v8 2/3] i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Sat,  1 Jun 2019 00:00:22 +0530
Message-Id: <1559327423-13001-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559327423-13001-1-git-send-email-sagar.kadam@sifive.com>
References: <1559327423-13001-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device id table for Opencore's I2C master based re-implementation
used in FU540-c000 chipset on HiFive Unleashed platform.

Device ID's include Sifive, soc-specific device for chip specific tweaks
and sifive IP block specific device for generic programming model.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index c3dabee..b334fa2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -82,6 +82,7 @@ struct ocores_i2c {
 
 #define TYPE_OCORES		0
 #define TYPE_GRLIB		1
+#define TYPE_SIFIVE_REV0	2
 
 static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
 {
@@ -462,6 +463,14 @@ static u32 ocores_func(struct i2c_adapter *adap)
 		.compatible = "aeroflexgaisler,i2cmst",
 		.data = (void *)TYPE_GRLIB,
 	},
+	{
+		.compatible = "sifive,fu540-c000-i2c",
+		.data = (void *)TYPE_SIFIVE_REV0,
+	},
+	{
+		.compatible = "sifive,i2c0",
+		.data = (void *)TYPE_SIFIVE_REV0,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ocores_i2c_match);
-- 
1.9.1

