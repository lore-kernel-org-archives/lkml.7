Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422D5ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147902084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8we2DPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfJGNRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:17:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44697 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbfJGNR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:17:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id i14so8174554pgt.11;
        Mon, 07 Oct 2019 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcVoHFsDeIeHDLHpP7WttsttV9wlf7B4Ed2NE5p2jfc=;
        b=j8we2DPkY8qn+stB744bONJ67YWamBNHxL94s06qmhPOvNOxpNbaeg/JlgBeuQ8bI/
         t979StZKifPnuS0XpqgKtaBeVAgzemBwfS8D/ircyEDW879HjNzikZXk8boNF6QJyYYa
         PHU4d4HbhWoJsZ0W5iLm6C38QT0tqjN76pbxsee8o9ehi/skETp6hTCapbubIiZo6EUy
         IZuX9cDUn1plRP3rJYBEwwMGl9V5eJ2eEyDlvPVJeZQJYsc5qDzW4CY1wfSORW5ixBg+
         1cUtH8XRmTt0F5br+Or23osASybUCRNjODHW3IWqflzJiOpN7WVnOGvMn/3VFzh99oXc
         6C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcVoHFsDeIeHDLHpP7WttsttV9wlf7B4Ed2NE5p2jfc=;
        b=eFMGIffF5GD218EdCisZX2TT9IuNpVCez3gvZYcsFi+YhorGWycRyfj5FdjKxqhdCJ
         dbdqybMFLY+OCsfafC2Hxp2PxLDRtGuW8tnW+7AcTHo7+iiAZ3/pidSktYaZBReKa/bt
         nzJ+iXn5ffcOpUrUBonZyluMcgnlA0GeHZxa7qFoO7uVAjBs+xveOw9H3lzDjiAI2STz
         dyCPT1hLwqlgOpw6Ow18I2kFImPmKpNNVKQJvVtdAKUMnZ8nlx0UzLsWXiSM1XQWcxYH
         1OIbx4ONphmgOARkvZxpDTzNr6UgUheO+PhymTPVtM0HtucOcSavbar7lKljRvJkL2Bd
         IEsw==
X-Gm-Message-State: APjAAAU9I2gW2f+IGMX/+xD5hsqLyTyAO06u6/AKxfwgbv/3dBjoJQuc
        3hemR8m7xow+qWUKyTE5D9U=
X-Google-Smtp-Source: APXvYqyocRcmzQldhoXRSqKuK/uto+P5hrbSB6RYEWfYDa0ATI0WIHFndNsKQKqySId7xTa4x9+Xlw==
X-Received: by 2002:a63:6d6:: with SMTP id 205mr10680788pgg.442.1570454248388;
        Mon, 07 Oct 2019 06:17:28 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.138])
        by smtp.gmail.com with ESMTPSA id r186sm16938650pfr.40.2019.10.07.06.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:17:28 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 5/5] arm64/ARM: configs: Change CONFIG_PWM_MESON from m to y
Date:   Mon,  7 Oct 2019 13:16:49 +0000
Message-Id: <20191007131649.1768-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007131649.1768-1-linux.amoon@gmail.com>
References: <20191007131649.1768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using microSD card we cannot get the mainline kernel to boot
using mainline u-boot it fails with below logs.
Build PWM_MESSON as build-in solve the issue.

[    1.569240] meson-gx-mmc ffe05000.sd: Got CD GPIO
[    1.599227] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
[    1.600605] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
[    1.607166] pwm-regulator regulator-vddcpu-a: Failed to get PWM: -517
[    1.613273] pwm-regulator regulator-vddcpu-b: Failed to get PWM: -517
[    1.619931] hctosys: unable to open rtc device (rtc0)

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Odroid N2 Schematics says "GPIOC_6 should not pulled low if GPIOC is not
work as SDCARD"
Is their any other approch to help resolve this issue.

Boot log failed with cold boot:
[0] https://pastebin.com/cEtWq2iX
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a867ac32d4..72f6a7dca0d6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -774,7 +774,7 @@ CONFIG_MPL3115=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
-CONFIG_PWM_MESON=m
+CONFIG_PWM_MESON=y
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
-- 
2.23.0

