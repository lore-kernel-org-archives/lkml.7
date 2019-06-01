Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDDFC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 06:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9136727148
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 06:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GYWLNCJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfFAGLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 02:11:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43492 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfFAGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 02:11:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so5219670pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=GYWLNCJxwtsJELEDc5nOhmMnFhrKwQdhBjRn/pKyrJmzcf6pahtsoYHDBq+A92qt9z
         CKOroINqBp1vkIndKgWR+oEcf11Suw39Yg7+jtLk5PE8a/8iwxexLe8YnsyRFbt/M0Aw
         U+guAgtPl5u2eJRJhqlKsoxPrYUHxVJNYNxkmTnO6etOVMsMXG7M6kK8xfbHPLMjllgP
         nvCPJBqQQvRf+Q9Ynwl7ENeH6EUxw98uPQSFkCO8TY/kSEKBFOfslVh+dMcAxHDblCDi
         PBhpoERxK22Q4q6VPYMNgQgguFBIG6CDZ5JQtZ6O+QpI5/hQ3Ru0lkdIwgSsMN4MOPps
         UiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=aF2iV9ZBg8vXG1a0wE51GJfoepmMq0NatolKvOESwcVhHkfRGIhpcRs9Ghe79QTyPU
         uRZJlkI42qrx0ptqYNPGD4npF6G+pIZ4VDxFwXG/qJjvjqi9H3I4gLy2JrUyEN+UlDOJ
         DqqpLs+URYhnNMlm6hC1+rqoCFpSfrd5udMtWtJfK7xVBJVM+9VJfFI9TYCvvkpVB+rU
         qSKt7TXWlM/b4HV6hH9TRpuyzE53TYeV2vcXM7uOV4WdQELEqBsdMNKlQ1Luc1WKnDCV
         A1lBTtIZxs3T6jX9b3MljziT5Gzk3tMM7le3ORdxmuu78AsCRAhW3VRAdquIPKhDm8g5
         L6kQ==
X-Gm-Message-State: APjAAAV0H8YoJRfkv/KyPyaYYavg5EHngJZy57nqLiwdvsq9deM6BiW+
        VgwdQXeNBMYzBNCbkBIupxycrRg1nfUyxA==
X-Google-Smtp-Source: APXvYqzlk3hrluDCHk21oBfq1TiS/zO95WiT9eRFQoVOSTZcNwULqaajTm6A9o7fAd6f12vsWlBp5w==
X-Received: by 2002:a63:8449:: with SMTP id k70mr13784046pgd.208.1559369509095;
        Fri, 31 May 2019 23:11:49 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 2sm8935850pgl.40.2019.05.31.23.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 23:11:48 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH REPOST v8 2/3] i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Sat,  1 Jun 2019 11:41:14 +0530
Message-Id: <1559369475-15374-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559369475-15374-1-git-send-email-sagar.kadam@sifive.com>
References: <1559369475-15374-1-git-send-email-sagar.kadam@sifive.com>
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

