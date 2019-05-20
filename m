Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E8EC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD58C214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OAQ0DsHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbfETONB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:13:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42627 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfETONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id 145so6857422pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=4KK0MRvh5MgzBUDrn06tdDHg6h6KtmoqvmbKK6rVaok=;
        b=OAQ0DsHAZfIcur5262VF3nMZHoryfuG6j3qbM/gqN/eIPJOxhv64Emillk+Ncuo0MV
         s7wpVKOr63V4BS9AKRaSULQA9YtCsBe4lJy9bhCZ3lmCmyCv2mU26bKQCVO6QrOUlXRW
         1Z6WwUzW3Zi/wI2jgZf8H/VtrhRTBzoDz4kLUOAU4bt0KU7TR0b3QQ/zAeBDBsJJu0JZ
         bZR1o5HVrFv0a64SNt5A1IXGbTJI7RzJDGc3STIWphIUodtxC49ll4+AYh3zaAx4dJsa
         Kt2jr96X3tScTJUTqkHCELTRGw1ILqZ/NHsfGfZ7b5lQnaYlBuqYrbOJbE7vmr9n27ur
         DD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=4KK0MRvh5MgzBUDrn06tdDHg6h6KtmoqvmbKK6rVaok=;
        b=WjbC0oObRobDs7+7mo2pTxlf5XsN0/8jjxafQO4588bAIQ8dTPQfksVI94YHElcksW
         dUBBwdwvefLl5fsribfxyXAezYzd5h5dePCHMZp4RVxSpush11pKhqZEtDumnaRXf5FU
         lwrc5u48kpnMnojxenQitu8k6BvTlTNPXV3viPibtFDYiqDJeJVawl7zDub30OyA3KhJ
         hgagY+dsIW9R2RRFpPLcsv05bEaor/1yDowisrDUs7CjpxKhOzvbJMhB3vWn9OJQY23r
         1m/e71yLS+Uz8MOIwSQvzlQQnkZPnYvoE4oYUA+1LyUkeKDlDI6hXKgnGtDhl44mNS4F
         n0oQ==
X-Gm-Message-State: APjAAAXPHalsk8f9LUxK8fzk4IQYndF+WkT9gVisphulXuaFYwXNOICl
        2J/5sCiaMLuy7CP5Bucx/jlFbQ==
X-Google-Smtp-Source: APXvYqx6TcjEmaWTHf2leDwIV6L5TLuoA52r8b5QDadU3z7lyJAZACiDuRsvgHZAJCXRuSsqGueiVg==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr50009193pfd.171.1558361580333;
        Mon, 20 May 2019 07:13:00 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id a9sm26388248pgw.72.2019.05.20.07.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:12:59 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Mon, 20 May 2019 19:41:17 +0530
Message-Id: <1558361478-4381-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
References: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
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
index 4e1a077..aee1d86 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -85,6 +85,7 @@ struct ocores_i2c {
 
 #define TYPE_OCORES		0
 #define TYPE_GRLIB		1
+#define TYPE_SIFIVE_REV0	2
 
 static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
 {
@@ -468,6 +469,14 @@ static u32 ocores_func(struct i2c_adapter *adap)
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

