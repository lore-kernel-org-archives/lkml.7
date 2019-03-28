Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3EC20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Lr+SGaAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfC1Uvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:51:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37920 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfC1Uvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:51:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so299909wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRINBXOdsguAhW1lpNf0zzWQ04z0gK/+bA+ikvUAsbc=;
        b=Lr+SGaAwV1LdP1i7z1M9LtYXP+qnw3USKe+qZBb0lQYqUtkB8s8OHsJX/AMh/1C76w
         aZnxTc68qZ13bZ8dd8xZZhtlVOBevfOsxfHNEfJriY0jajluPueGcEhGNAlJuPq6kwMh
         RvL4R8+BDePLUQrMaNLnxlSUP6V9ixiMFkd2lhskEGad0zNOm7AE59YoqVzWSP1NKfIg
         QAE65Hak5joKFek+M9MUpwTAVF/zkGBDGMt7NX2GVOkj0AAjIV0ls/92EJyK/v6cDi39
         EDSho2P7Elu4Ow5TkucJQDFXfFp6xKsAOa0UzhArjvnkHAd2cfdTB2qfLpQxQDxRCyr5
         bx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRINBXOdsguAhW1lpNf0zzWQ04z0gK/+bA+ikvUAsbc=;
        b=KTyxlt7UGRHYRXu/C3z5wBQZgoQ7BjtAN6pi0TXf/BPMRZUW0/FMT+1HUPsETj3sC2
         +zBKqu5PtReSWkLReGujfneltdbXhHnQpg5LVNxHNHUPTeal+jX71dcN8O+Vs6Pd20VV
         we+maFuznCwGzMElAflXh53dqxMA0xzMlVMrYBlcmW0O7vXpHjvZlb6fsNySvzQyDXgM
         F4nyMN0XT8rAlX+HefK/ETVuIqUK6NQrEEWEhx+4vXvycV9ZMX4jRqpqgd7XRhOetdR7
         uHNmh8rJHOh60rNlOfYyEy5p7GH++ULRqYj259UgEbxQMtkul0UF9fVGm4Pj3ErJQRYz
         fuyQ==
X-Gm-Message-State: APjAAAWZhHCr2i7Hyys9OX+0eixpLEEBUo9FZv6W3ARHNUwIbUzI4UOX
        duIC1V+hWiq6LdEXQVDtSSgd83wF
X-Google-Smtp-Source: APXvYqyZ6gqUSyeG4LWVaS0KscFbkPFC14RiljD2DJ4F5E6PGRrdlQHxSFQj6crx69hA2pMl+yNfFw==
X-Received: by 2002:a1c:c68e:: with SMTP id w136mr1206916wmf.111.1553806308566;
        Thu, 28 Mar 2019 13:51:48 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73999007CF185662A5FF671.dip0.t-ipconnect.de. [2003:dc:d739:9900:7cf1:8566:2a5f:f671])
        by smtp.googlemail.com with ESMTPSA id c10sm94375wrt.65.2019.03.28.13.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:51:47 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] ARM: multi_v7_defconfig: enable the Amlogic Meson ADC and eFuse drivers
Date:   Thu, 28 Mar 2019 21:51:22 +0100
Message-Id: <20190328205122.27092-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190328205122.27092-1-martin.blumenstingl@googlemail.com>
References: <20190328205122.27092-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the SAR ADC driver ADC measurements can be taken though the IIO
framework. Additionally the SAR ADC has a channel which is connected to
an internal temperature sensor. The calibration data for this internal
temperature sensor is stored in the eFuse.

Enable the SAR ADC driver and the eFuse driver for the 32-bit Amlogic
Meson SoCs so we can expose the chip temperature to userspace through
the IIO hwmon driver (whose config option is already enabled:
CONFIG_SENSORS_IIO_HWMON=y).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c75051b9392c..11d0395f3f0c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -925,6 +925,7 @@ CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_CPCAP_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_MESON_SARADC=m
 CONFIG_STM32_ADC_CORE=m
 CONFIG_STM32_ADC=m
 CONFIG_STM32_DFSDM_ADC=m
@@ -979,6 +980,7 @@ CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_TWL4030_USB=m
+CONFIG_MESON_MX_EFUSE=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
-- 
2.21.0

