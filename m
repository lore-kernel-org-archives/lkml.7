Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CCAC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113612147A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHe21AKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfHKUcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:32:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38924 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHKUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:31:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so10009336wmc.4;
        Sun, 11 Aug 2019 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqEyWiFMPAZ1NvJfJjLqIDmYUzdmfNk5EDDyLjyH02E=;
        b=KHe21AKdQYzpf8mH5+VzMOd91TmxEZmAxwbxGDwKukO7Ann4MMaqndFz4uoH4rYSfZ
         QfoZF7odDseQ1LhaqKu7s07hG0k4HNpeDzgm6JqXrpLrBH4T4epkF7+AFlTfw+GiwXOl
         p+Uwm+XQE35n2BXrPCso+gsVp73LeexHhywIn7W48BnYP2Mf7W7mej4aLODyrtmIH4/8
         eCKrtO3wRkG+xhYamCGgP0KjVNQwNNUoCwaCQrYUmN3ob60NVlprGXB1LtukWjByXIdu
         7qXsg2r3Z+ppyy/xoU4Y4TkTnEX9qqI2sTMd4JIl66zMDHgtlyimdKezOO/hY/XnRmvY
         i4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqEyWiFMPAZ1NvJfJjLqIDmYUzdmfNk5EDDyLjyH02E=;
        b=MtXlZrjcKpUYImMufLU6CgJdwJSNawCZPI9871UYpuA66B2zljyHABJKGmYXlKtWDD
         u0rzdUqxRjndZ+iyMcJtINQ0ypkCZCKpHS3XyM/TbuTjJe3YXG80TwoXw2pv04pnHVde
         Qmecnuj9DLBcZvd1ND/+kS/zo/TUtisB2BTev8NOhrb3I3NFU9iWKp1Y+zr6j31BPwvm
         wTDS9dwWZ6BjdByQO5D5bSqme5vpCDImA5g+aYrX1rRZi6YQPlI1elpVg0WnObjvKWc9
         CIVzI3FceEUYJLiAbBR2+zD++m/YAOSm9uTB704evtbWM9KEkgW0gtO//AtYH2TY5s/M
         RU9A==
X-Gm-Message-State: APjAAAUdc9cxfJLfV9GKUAVF4puUqBo+v20WauBWrz3wGEy1XwLSsbtA
        1usG7uAZRG4gJcJp45vczm0=
X-Google-Smtp-Source: APXvYqxQ0D6hBVy7gRNf9suLk16jU3u90wVI74bZGyD7Iq0fC5+3xfhAkOnad4WI0haC0pJ4awz0kQ==
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr10158445wmo.136.1565555517369;
        Sun, 11 Aug 2019 13:31:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id a8sm11063269wma.31.2019.08.11.13.31.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 13:31:56 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 3/3] arm64: defconfig: Enable Sun4i SPDIF module
Date:   Sun, 11 Aug 2019 22:31:44 +0200
Message-Id: <20190811203144.5999-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811203144.5999-1-peron.clem@gmail.com>
References: <20190811203144.5999-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 and H6 use the Sun4i SPDIF driver.

Enable this to allow a proper support.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..b0638849c14c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -558,6 +558,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.20.1

