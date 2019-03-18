Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43883C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FJewH+wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCRM3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:29:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34507 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRM3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:29:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so16351860wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8SlkkWNbz8a6Pc/LUbBX1rm7FrHNXiQoSoIVyFdUZw=;
        b=FJewH+wDZHcwOwyJi5kBiKgQQd8hG+TeDskk9AxaNyKVUf5nOj+1b5B3IVFlbAr9sZ
         BYWNCDEVdW5pLoPP07YDfEZvcr9iO0wSxKBY7OCpVZbdOCTlniUhMsT0BH1Eyf3pGrZG
         rFGzYGLVD23Yh7EKSt82tMYMJtn2lTXvrx2a2R+NMJ2OIjLIdXhOMRM3iIHu3l2Q5NhM
         TsNVPc6STRdhmiDVufI8REQhHaJWPykeVMf16XvlHsCf5eQdadfj1q+iX5VzKY83gczs
         8hbZTMBewBYCkIF/6aF+RZkEvezw3MFFFgyyYa7k4REsiiLcRStVzQ7UGCOJZDKx3uaw
         nRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8SlkkWNbz8a6Pc/LUbBX1rm7FrHNXiQoSoIVyFdUZw=;
        b=r9eUqpkaw54EB7+CgD25INkRjK9MMnQUzQCR/LQFE3k+ZNGrGzmXGdXQ7pekY61+2Z
         FEBNHSx8D71igJv4UCJm073qt+c0jYADUygozxV7h8UiuxYzeDH3djtGt2N8eKFH6sSz
         09grw7INlSUqKr221bm12BbkLf1RovUmHCA12Ln5qSHMnujAsqK+xQi3CrpX31p79JBV
         GVaLr4lTVWD+sp+gnjjpCuXtEW5w62pDvFY42JktoXNb/nunezf29Gfw+49IXQqhGC3/
         Gp2mr9hgBOoNP0OWmRDyY59ABi456kGt90KmkFRxDWRhP8+Scdb0QoCydA3IfF/iWD8F
         Rd9A==
X-Gm-Message-State: APjAAAXFRMcoyvfP60KDud3RE9RsOQhOgPOlp+hfo7dDO/xW0bDtqccg
        XFfzNGTa7ETFN14ZdLqiyID42A==
X-Google-Smtp-Source: APXvYqyqPkqDRnK2qQIQ0zwEKOzBBuWdBYm9YKIL3s05ue3JBZr12bvZghfT0RxoUckkXcHLLojjKQ==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr12293328wrr.123.1552912147777;
        Mon, 18 Mar 2019 05:29:07 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id v13sm2368112wmj.43.2019.03.18.05.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:29:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 2/2] ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform build
Date:   Mon, 18 Mar 2019 13:29:01 +0100
Message-Id: <20190318122901.7231-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318122901.7231-1-brgl@bgdev.pl>
References: <20190318122901.7231-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add all DaVinci boards to multi_v5_defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/multi_v5_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76fa26d1..d7b2dfe11b05 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -14,6 +14,18 @@ CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91SAM9=y
+CONFIG_ARCH_DAVINCI=y
+CONFIG_ARCH_DAVINCI_DM644x=y
+CONFIG_ARCH_DAVINCI_DM355=y
+CONFIG_ARCH_DAVINCI_DM646x=y
+CONFIG_ARCH_DAVINCI_DA830=y
+CONFIG_ARCH_DAVINCI_DA850=y
+CONFIG_ARCH_DAVINCI_DM365=y
+CONFIG_MACH_SFFSDR=y
+CONFIG_MACH_NEUROS_OSD2=y
+CONFIG_MACH_DM355_LEOPARD=y
+CONFIG_MACH_MITYOMAPL138=y
+CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_ARCH_MXC=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MACH_MX27ADS=y
-- 
2.20.1

