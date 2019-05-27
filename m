Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54247C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8972133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6NSmREE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfE0UKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36328 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfE0UKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so17892030wru.3;
        Mon, 27 May 2019 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz71BHS9e6D0Hy+3p0/CgKuWt1VgJzq7zAM5T7mHY2o=;
        b=M6NSmREERHUhm81Eo7IuTxUpuFP+O2QKTs1rHcMBsH+vW/UC9wceluBnsJrjaPOY5h
         MNA6H8BtJHteTlZLpN/sy+oSx9ap1bEV2+F0GDTrPV3fWYabAAwLYtlwnKnRo5PXQcfa
         51O8A/J7YbRZO9sFbqfVf/aLJy5ATWHkbwL7Upj3u450/xMT8SUKVHTj3gOqVKNScrzS
         qaQ4CL2or5UnftkiEbZme3wLRF1+WjEU9V7SbaGVokDpT1KlzJ4CBVSPanilaF4LV3Mp
         yulGDKjxL/2EvbKQcuKqYIwg4o4qgUU0GEhF9lIIA9XX7fYxEqGHgqUE+NkNpLqcUKIZ
         cbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz71BHS9e6D0Hy+3p0/CgKuWt1VgJzq7zAM5T7mHY2o=;
        b=rEDJeZfjK+yGl6o2f5CHI8uJZ1ecvtFMbMFiD5ORmr3Jpt4LO0XiRUI1yLr8hEiyXL
         Bcyy35x0IvrIJ1Ws2jCl/OyrwBBqErsx0lLOtLniDo+Gg4QIiobSvP+jraoEFd4SEvw0
         UzhiOo7uP2MVMeDkYSFEQaTNB3cF7HTTvmkBX/80B70QrIE0RmJjU1wmIxAHtxWY25b5
         mbNBn/Taz1Njfw+KMvlfP0yOAJZA0Iws3AlXSxxTT8/APZGjU6Ag9PJdHIfVdxvnZc4D
         eQ8NUF0Y4gNuXCqh4KtNb45t+99oVyaSSZZpeWVFb6MDjjoVjv294b6oNlF1V0ev+p+M
         AH3w==
X-Gm-Message-State: APjAAAXvftHvSbj2xTgrDjC9ukL0y1aOxhgOjwliqaUem6WhshamvyIi
        034dTMroEfWy4aWUUY2plvA=
X-Google-Smtp-Source: APXvYqwreWc3qdqZlEF37v9TKTLjOM/6tvYOmcXgC1h341LClrB3k+x5Mddc07/qjcrkAIgEu5+tvg==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr58006682wrs.314.1558987821585;
        Mon, 27 May 2019 13:10:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:20 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 7/7] arm64: defconfig: Enable Sun4i SPDIF module
Date:   Mon, 27 May 2019 22:06:27 +0200
Message-Id: <20190527200627.8635-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527200627.8635-1-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
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
index b535f0f412cc..de5b65d45311 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -526,6 +526,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
-- 
2.20.1

