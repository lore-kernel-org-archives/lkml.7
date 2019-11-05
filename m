Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F547C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB432190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvXGUDs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfKENnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:43:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35865 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388615AbfKENnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:43:01 -0500
Received: by mail-yw1-f68.google.com with SMTP id y64so5426618ywe.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=njeGNBuVFQ43NI4DdNgIJL31gMijUvEBHfE4Xmmetwc=;
        b=BvXGUDs9nIxDhMeJUhdvT5Mrkk2WJyzK542AKZFQUaW/ATM//VfL8Iq7pR9VcpInrH
         nMZXU3awfM6KLv7i2Uwrbxo0Od9JNV55xhQGK2p0SqX7bVoaXRWACVTBRwroflPvKvbA
         TSMnUaTfzakRXNgz5z2iPZV/GqxRbkjgogUPz+XSr0GHX5YzAVgPGoraW7JmHlCkfvEu
         RybalO/nMyZ9qLjIZxFCYOUIZP/7HczjKYDtYqspSOKY6zSSF3PyDWFLi3zUSX6idmus
         PoZVXbf82wTBtdTUHhOZN3EEBK7H6SP98iNkAcm5QfObC6OKLJlJn8GcW6emah+DFHZ4
         Uv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=njeGNBuVFQ43NI4DdNgIJL31gMijUvEBHfE4Xmmetwc=;
        b=bEgUilBWL/0s4WlZh/mFGBfwkNGtnzoRN0HyxS6ibRnEuHWj+fwJOfGaqN/yJHuGZQ
         8Au+KavjCrXteMCkz96n6l9zHUjvzrxtC+adlOskvgsFALQ/7Q04xqSAvmeiO4T4o4rr
         DnEu/6eXbE+jzromuBqFiKd+7hew1+Ycw7g4yStx3IoWEkCOQkZc4OXuIRvWVhMsca+4
         SXQLExTgqQnhlnz2arUgAD/wK1tx2Dl0DufpRMjI2jZLPyX7hSPKMqFVTe+1BZkoz1y+
         6OwrFzDjD0xl4cX5LUvEqe9q8aUfz/YF6bEmFzZs42qq2sA4KaOovHXSshM6ZstS6xHA
         vyUg==
X-Gm-Message-State: APjAAAXhpg82zVga2yDQR7FPSePR4EMCyfqrtJgjtgORlnUl/tgm+i6p
        7hDDjOXZLzbUb3mBHGJgGhQ=
X-Google-Smtp-Source: APXvYqwAZps/+Nk40M2NKxBJ1i+2bdSbJSSirVXkegeUiIlBNzUhi+OGLaa5kFersS+OrE2WTQf3LQ==
X-Received: by 2002:a81:1ac4:: with SMTP id a187mr1397999ywa.5.1572961380383;
        Tue, 05 Nov 2019 05:43:00 -0800 (PST)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id g71sm5088366ywe.90.2019.11.05.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:42:55 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_ILI210X
Date:   Tue,  5 Nov 2019 07:42:45 -0600
Message-Id: <20191105134245.22568-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6q-logicpd board supports an LCD with an ili2117
touchscreen controller.

This patch enables the TOUCHSCREEN_ILI210X which will support
the ili2117.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0f7381ee0c37..d1ec6afe4aee 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -181,6 +181,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
 CONFIG_TOUCHSCREEN_GOODIX=y
+CONFIG_TOUCHSCREEN_ILI210X=y
 CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
-- 
2.17.1

