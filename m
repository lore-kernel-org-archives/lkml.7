Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C420C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAEC206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hKnJBVWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEFM5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:57:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEFM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:57:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id j11so6713434pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AZwN4Y8XxFUK2pvt2N7G+01LXJuGE7M19RGGBuG2SYw=;
        b=hKnJBVWqMGJCsq/b4yG5yQ3YyVPH8QCMFEt15kpkj0ig0/GAPBdsTC7mLxoDrvbhMX
         mLHM301iBO2DSckX1JDR9YUqGRrQzzmT/7wzfPxD2iMHTygGIYoQPGP5SUZIPgmlyEHn
         v5ekJE76muREcBmXVd29r6Kf96uVKyvgZlNF+HMrDmOpN4dxHJqZHbhCTVgnBDra93Ul
         RdN5vSctEmwI9geG2kgV0nGD7C2NmdtTb4mg1SgSQBL9TwDPEJdO5QPBm1jB2CYw5is8
         w6I7atptCsJeuLv1BNzLZPApIqAfpJbYLoRK7/D891Uzhl6ZH3Lggynd4lWIrZmWIFOl
         fwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AZwN4Y8XxFUK2pvt2N7G+01LXJuGE7M19RGGBuG2SYw=;
        b=e4xcpL9Cx9nHzocEENmh7xnyIVlYPuH8YwRe9GDh6YiLKh3PI2JnO0/zIP+XOYSOnS
         k+PTK9qX/E7LRAVFsiB0CNjLiaUX3BBPpiwMqYgjKZC0UFMwdcuVlkhK9rYUgVrIM6Fl
         pQFkdd6upSzG2UEJPSresrb2dqfiHp4SxcKXDiF+jHotUssU4efpmtoAs7x9chCi4pxB
         glTL+3S2Ocobrcna/UilmaqHx4EHI/BAnfaANyazlRPAe+mECmy6+6gdz+7Rs7jLvBCq
         SsoI2cqgp1lVids/dvf4VhYDlV20qlkaPAlhHmA4tNeFyzom3HIR1uan0YOwUawoscvd
         UzAw==
X-Gm-Message-State: APjAAAWqoMoNUiW/C4VPfXectGoTfwGfDM0bG2lQWATpCl8DWLfIfZRu
        phzU/nUmCR+Tf3O6ESqpAJ1w6Y704rsrdw==
X-Google-Smtp-Source: APXvYqySdJKvrX5oi/GsnI2Zz/4BtbWRcPafJni1v7sN+SE8nvhny3X09satX04k94LSFysH41SGqw==
X-Received: by 2002:a65:654c:: with SMTP id a12mr31839474pgw.101.1557147447917;
        Mon, 06 May 2019 05:57:27 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p81sm18031132pfa.26.2019.05.06.05.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 05:57:27 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        paul.walmsley@sifive.com, sagar.kadam@sifive.com,
        peter@korsgaard.com, andrew@lunn.ch, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 v1 2/3] i2c-ocore: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Mon,  6 May 2019 18:23:59 +0530
Message-Id: <1557147240-29551-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
References: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device id table for Opencores I2C master used in HiFive Unleashed
platform having FU540-c000 chipset.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 4e1a077..7bf7b0c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -85,6 +85,7 @@ struct ocores_i2c {
 
 #define TYPE_OCORES		0
 #define TYPE_GRLIB		1
+#define TYPE_SIFIVE_REV0	2
 
 static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
 {
@@ -465,6 +466,10 @@ static u32 ocores_func(struct i2c_adapter *adap)
 		.data = (void *)TYPE_OCORES,
 	},
 	{
+		.compatible = "sifive,fu540-c000-i2c",
+		.data = (void *)TYPE_SIFIVE_REV0,
+	},
+	{
 		.compatible = "aeroflexgaisler,i2cmst",
 		.data = (void *)TYPE_GRLIB,
 	},
-- 
1.9.1

