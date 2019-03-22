Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26F72190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfCVQS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:18:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50421 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfCVQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:18:19 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McGxG-1gZP252F1Y-00celC; Fri, 22 Mar 2019 17:18:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 7/8] pwm-backlight: Enable/disable the PWM before/after LCD enable toggle.
Date:   Fri, 22 Mar 2019 17:17:22 +0100
Message-Id: <20190322161727.1153278-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322161727.1153278-1-arnd@arndb.de>
References: <20190322161727.1153278-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:98ZaXMT7Sqw9y1pDFUAjfR/TmDFSO4/c2yDoQqHy9p35Lv3HvzJ
 zciPwkDzqGxDKzw+WyOpVoyffMWXaocOntl7TtlIJdUdjLDZnGzBhBEQEf6Lcgax7rfjMbP
 JadONNGfZ5QYDpBv0C1un4TuFE4fNdhbI6D0fOhl9WT7Zv6H5O/2PwWOG2Xxf4JKv4YOpTw
 wRJEyGTPF0eJPlJ7PkILA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lnfPOrnU93g=:E+yyWykToN2NNLGa8WibcA
 uFG5Nt4M9GyDb6fN4XzH3ZLvT65SN/4quOBwwQevFkiLbG5A4WlwB1O50Y2cvj5lbKqbmscZS
 9LFfGY+rHuIr5ydKLThpH8eEklNBZyRWZjVY+wAjdtgbmJPbxS8uj3ooh2OZ2thwGvBhTS5Jb
 XFOoKGJ/8a25He5M9saGFK3iJfMpJsaQphb4obnGKxq6e623h7vO/Z3Gu3A4qpULAFl2YUYu+
 bIi8VM0xMiUVgb7oZRnRvjgIOysy7yMp0Aro5wd3f+PGiSbzUXSaDk2EGxXp2sJFcMIVrRoX0
 8csmoSFviYm0r2OMsFCZ6KFcru6s+zZ+cG0uDsLGf0nJvdDLduhEgDICbPM9caENgOl9hQYQs
 6iREkPu6gznxJNeh2JmzT3rnVx7ZcPwhqRHI9HscXWH1Re14eNZ5ELG60jhcK5vPueVg31y3J
 rQFkRwl09XG1+ZZ575e7Qe9uf1blU2tiBOpgEOU4Yp2fMlixphAAcPQZtLdFymG3s7MZDZmvf
 VsLnK5qMT5FLLbPReDVbCuK7jWtWjWh83mawfe7+B1qJWtw9K7z1CGh+Mj8foYTCS8JkX5aTS
 aYJoat0Cs/L2hzL08kbCu4x3iiJqgaVtjYmuUIahPbciYsmtLnknUd6Uz+WBLDMNOVm+/UOVR
 UxvOWvLbTKTFP3VLuT4g0jSPcgWBM4wo5vPBv16eWR7ECDybaofPYNok+1uc1+hCX4fFFdFNB
 3YyDKBHSJ24vamhc3MXW7OSz3WfnjCBXHky+aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Before this patch the enable signal was set before the PWM signal and
vice-versa on power off. This sequence is wrong, at least, it is on
the different panels datasheets that I checked, so I inverted the sequence
to follow the specs.

For reference the following panels have the mentioned sequence:
  - N133HSE-EA1 (Innolux)
  - N116BGE (Innolux)
  - N156BGE-L21 (Innolux)
  - B101EAN0 (Auo)
  - B101AW03 (Auo)
  - LTN101NT05 (Samsung)
  - CLAA101WA01A (Chunghwa)

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
(cherry picked from commit 5fb5caee92ba35a4a3baa61d45a78eb057e2c031)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/pwm_bl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 0fa7d2bd0e48..155153ecb894 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
+	pwm_enable(pb->pwm);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
-	pwm_enable(pb->pwm);
 	pb->enabled = true;
 }
 
@@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (!pb->enabled)
 		return;
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	pwm_config(pb->pwm, 0, pb->period);
+	pwm_disable(pb->pwm);
+
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
-- 
2.20.0

