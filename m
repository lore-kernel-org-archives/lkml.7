Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355AC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A18B20856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bAurLtNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfEVJA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:00:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfEVJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:00:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so980107pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=bAurLtNG1r6grBqOh3k9tYx2/GOoh3DWYKTog+DPlm6JLrOFuG5plFUVyItMkCA2Me
         HDMc+vnIafhTtOqCkDKFooJWxTA6p4Q/TqlwVnQR5gHGHpMUwVCx/y8KzoOQqXU5+f9r
         A9cbIXH/W7h7rSIk/2Z8tYzU0B+QzaV6DjDciiM7pkNsH51shN9uSSOyAETTXThORikI
         pcHBe7+5dxj52sHpDu5Fsa/UQXdpZRLAtzyE44mJKdFYfjadorVZrU+VTo+wX6f43Ymy
         PU37nWLB0/lljEFtxixmCU1wEx2jQBvisx/PP7yfMt//+Uvbn/EMU1JVrsDCZjI7IvHa
         +UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=qIkNhSC7tnACHKJ0AKZdQMLe4JJCabfgIneNbV64+iEYqOwPfTrDJvKMf068MssRrF
         a0jAf/0h4wUzzn7FcXhCZBIFTBXzshanPaUk10jYXLPt66OcNx82R57cDzyqsl7C1PPj
         qgeTlxud9D4UqtrzlP63US9bPagRfs+MBGrjAbyYH3bOF3B1vv1KDoW3kh0ev4U5EGJq
         WPovOv05OZ6sfAmxy0XDO88SCeBNH6ej5va2dvk51jcX8bN0+D2l+rixnk86VW+5StUQ
         vSRzrt5KxURpzVK6R0h+E/scXmm7twytnodaRvU+f1idro50Ami8Mm+U+hz7ADQjTJkG
         tcow==
X-Gm-Message-State: APjAAAUxKoMh4WXi8KsOrYuo9HCcdeu/87QJca0u+arKD2B0zWu8d6mX
        tBILZj2fwRplj95V5HMTS1aksg==
X-Google-Smtp-Source: APXvYqx6owL4lFuS+KUh+HszLqBBHspzwoUHs0/Pbe2/cL0VhEPTHRSusTQ2hCdYj4VENiSmZOFKKw==
X-Received: by 2002:aa7:9a8c:: with SMTP id w12mr9738993pfi.187.1558515627409;
        Wed, 22 May 2019 02:00:27 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id z6sm42465905pfr.135.2019.05.22.02.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 02:00:26 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Wed, 22 May 2019 14:29:33 +0530
Message-Id: <1558515574-11155-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558515574-11155-1-git-send-email-sagar.kadam@sifive.com>
References: <1558515574-11155-1-git-send-email-sagar.kadam@sifive.com>
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

