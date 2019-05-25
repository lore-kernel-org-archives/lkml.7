Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5876AC282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E8121734
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUrGqIVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfEYQXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44805 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfEYQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so4443738wru.11;
        Sat, 25 May 2019 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz71BHS9e6D0Hy+3p0/CgKuWt1VgJzq7zAM5T7mHY2o=;
        b=jUrGqIVcaMBSQcLPCUQrRz5m5HvJXlyQ468xiszvGOrzlbZiJta79v1MI4OHS9BrJw
         slJRfaQIZKHfawdD+VE64WDHAPRL8caZPMvUxY+fajXRhXJTwKAflma5EW4AsMaWbWy/
         cpt652xyVNGp12XtgtneQfp0kk6rTic5HQrz5e4nzEcg6RBBUSY+ml1QHvBDYRVmC0wT
         3GdZg17rdLHujZf4MJlVc2IGS1SceA3Aibdddsw19d5+Dd70wtQAOCVOteyeTCOaxbpg
         J+mjNfS1QZ5ksoqvUxq++X25DwHkdiBEra11GEMmjPQWPi8wHwQOPRuz9TWYguyOY4sE
         DNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz71BHS9e6D0Hy+3p0/CgKuWt1VgJzq7zAM5T7mHY2o=;
        b=qWUlQ/CKvqXJyLAiJg69s1nfmQNRxTwcFqkRJ3MmJhPZr7rqrfsQ+Gih8QNK1URSJe
         AGnPJsOVB6a132EgqVZVUGcYrIbu5YhtyHkx23zilhv38pJyZqA2AyyGeDoUjnI2EUOy
         +vqNl3eEmAjtHiLsJfxXQh0g/eHnQsLl/C2NEudoK5WD467Smgz3wnRfWWveWazxvo7t
         QTDzXBx9N4pIGZEVIxl2USUUKzjZVZ9UcAf7l8d2+s3k79W9r194HNXAsZbJzhKI6ddq
         5gCz+7YPM4oN7z+mRauXP+z75d9BZQgH1X5OrEtPZAroJ7Ar9GAiEpulEQ4IwgttKp+6
         55BA==
X-Gm-Message-State: APjAAAWeiN4Yd11IPo2VKTmD0aNaIOVZvk9+1LIzCEHyKW4XEtp1tiWB
        RxxII6JErywl1PSjPyCeU2w=
X-Google-Smtp-Source: APXvYqwOH/zwDPb6sFjgA3noRqLyg0IS8DDT4t4lmVfw9uSbTr3HjpeHNuNaUkAdH15jvnlEPnlHJA==
X-Received: by 2002:adf:f9c5:: with SMTP id w5mr37265578wrr.26.1558801419314;
        Sat, 25 May 2019 09:23:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:38 -0700 (PDT)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 7/7] arm64: defconfig: Enable Sun4i SPDIF module
Date:   Sat, 25 May 2019 18:23:23 +0200
Message-Id: <20190525162323.20216-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
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

