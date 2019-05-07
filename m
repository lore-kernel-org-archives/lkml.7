Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1672DC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD050205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iF+0g7n/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfEGPPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:15:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45105 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfEGPPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:15:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so3402863pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:to:subject:date:message-id:in-reply-to:references;
        bh=ezJJYEzxOSAxwZu5Qv2HQh0qcKaC7e6tAejJ+6qzI9Q=;
        b=iF+0g7n/cGqvlvQeGxp24KtUxCsPs5OnWSZxz/XHDeizhBZE7614RnZcXAUMn008mt
         dS7YBnc+jzPJXOfz5nDgtuadv8DNFXP3xqgyusW6CyoA2VbHBp3KRZ7sAUYN4EpZ3VdP
         K5n7Ti0LA37SB2HOGCFiS/tNcrMZkRk9+krjFnMnkoVNhEF9qRGmTzDtHU73HYCFFN58
         TgoN1B4+dkLZ5TTz3pCmEFFp8AeZpCwuBm3WxGcDxWVuVLQaQflBs7mJMyCoTiUMNNdj
         vcRq4MNqefMYJuPrivAOmfYlMH8msmZJtWlSnwZtcsdcIlF45eVITjv7sMfQyBRrury9
         lsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=ezJJYEzxOSAxwZu5Qv2HQh0qcKaC7e6tAejJ+6qzI9Q=;
        b=EilNImCmQ0+YXyx1NB3ko0bTXPfSt2coz6az4236ohAMBEnDiLiiZj1LnAinLjKZv9
         LBGERUlunVZEq4bajXWBapQkBvtSH6QWmceg7Fv0bAWE8bTlPhvnE+J0RMhRHXIVPuVZ
         +Hoaj6Z11YBK82WhE+3gLnUdHoxwbgIOk0Gd8EBezOmEYUBODsjvagerEH8DsRWZC9wu
         0hInOesFJJcm2+7ZANX9BNPzSoa7dXR2yyuogVmFMbBSsVcencUIRASaQ1JOEdiYBzA2
         FX/W9Iaa4ouX8iEgWCC6ej48unu9ZAeaniu5pjnI8xIkt4kacxxAJWHjM5AVaVkg5LaV
         GyuA==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAXsVV9UQD3+VmY0Xx1PmdJBhiNNCtdrXAhfSe/Oq5V71BO6yelM
        Q+uyO2COh1fwif7LkPvBAHMV7bS65fJMVtSVSiGLC0ZB/brLtE+ezqQquRbq08T1cB2TW4RvLhd
        g/3U8rwn/on1fz5C/9g==
X-Google-Smtp-Source: APXvYqw92q/y/dpF3qOih3WEvN/1uShPh4h/eO54vUyzDYo/E8LVRT/CQ3YgidasSD0wUxoLDRXJwA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr40804350plp.336.1557242147782;
        Tue, 07 May 2019 08:15:47 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 2sm5397398pgc.49.2019.05.07.08.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 08:15:47 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 v2 2/3] i2c-ocore: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Tue,  7 May 2019 20:45:07 +0530
Message-Id: <1557242108-13580-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="US-ASCII"
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


-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
