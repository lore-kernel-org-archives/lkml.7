Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B7C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276032072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pde6ihhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgAGSYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:24:34 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42573 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgAGSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:24:34 -0500
Received: by mail-io1-f66.google.com with SMTP id n11so304019iom.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdtlkqmysC7QcigjNy0+cwRHAkpjBdnPxWkVa9R9ZTc=;
        b=Pde6ihhRfhCEc1QLIWN9x0aQKeHppyfDrxyzpNRSG1dxnxtAWlg/fBBJn9ZVO0D2om
         t/7FpHC6yhqrGe2we73EUw+Mu271GixYR/hUGzTUiTVKyS4Op6dl7bJmefYaUY3oFACR
         WhcvyWNkD0yxE7AzI4pReybNDzi1bLhVTg67M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdtlkqmysC7QcigjNy0+cwRHAkpjBdnPxWkVa9R9ZTc=;
        b=bMgo/SPU7bncg8n/yxb+wVANnxHi8wgbrz/H+YpKuWc+M+KXzf8LCvD25BSbDqPvlr
         8bVMFp/VS+tqRTIK/V25jXRroi0Z7z2HFh0bmDsWKK/0fZ69mGteY8TvagUwYHm05EI1
         1PyM0s0jZq5YkgcckXRHQer+nw5FQVTxmHd0Ped/tNhNPuz7h9D7yq8Dg4v3EgLUc+Qz
         rqFIcRvZZCC49+JSYvGlcaOVBPQE/ypPSl9sBIcdKy3d6CgcEEXKEaJFnDBSGsN9JziT
         82GlvcGq3W0iYYRyCu3DrBE+0rV8w0gvy3jElGAmHVhjii1+XatjVTdUm7RhWrh82MUu
         k/2w==
X-Gm-Message-State: APjAAAW9Mj2/0GN7oHroYQTVopHoKnCLJQcXQ2ZvDhkRE3c9oSXc1Cmf
        rNmw00K9aCXNYF45Dg7Fouifd8qsgdY=
X-Google-Smtp-Source: APXvYqw/WmxL9NAtLHb7W1A1r1n7VaH7LI3xfNDXWjHSe+XtzaZw2EhBz5qPFVbs45dSyh4HEEE+8A==
X-Received: by 2002:a02:9f06:: with SMTP id z6mr785413jal.2.1578421472726;
        Tue, 07 Jan 2020 10:24:32 -0800 (PST)
Received: from localhost ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id q1sm64504iog.8.2020.01.07.10.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 10:24:32 -0800 (PST)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH] platform/chrome: wilco_ec: Fix keyboard backlight probing
Date:   Tue,  7 Jan 2020 11:24:21 -0700
Message-Id: <20200107112400.1.Iedcdbae5a7ed79291b557882130e967f72168a9f@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC on the Wilco platform responds with 0xFF to commands related to
the keyboard backlight on the absence of a keyboard backlight module.
This change allows the EC driver to continue loading even if the
backlight module is not present.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 .../platform/chrome/wilco_ec/keyboard_leds.c  | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/keyboard_leds.c b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
index bb0edf51dfda..5731d1b60e28 100644
--- a/drivers/platform/chrome/wilco_ec/keyboard_leds.c
+++ b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
@@ -73,13 +73,6 @@ static int send_kbbl_msg(struct wilco_ec_device *ec,
 		return ret;
 	}

-	if (response->status) {
-		dev_err(ec->dev,
-			"EC reported failure sending keyboard LEDs command: %d",
-			response->status);
-		return -EIO;
-	}
-
 	return 0;
 }

@@ -87,6 +80,7 @@ static int set_kbbl(struct wilco_ec_device *ec, enum led_brightness brightness)
 {
 	struct wilco_keyboard_leds_msg request;
 	struct wilco_keyboard_leds_msg response;
+	int ret;

 	memset(&request, 0, sizeof(request));
 	request.command = WILCO_EC_COMMAND_KBBL;
@@ -94,7 +88,18 @@ static int set_kbbl(struct wilco_ec_device *ec, enum led_brightness brightness)
 	request.mode    = WILCO_KBBL_MODE_FLAG_PWM;
 	request.percent = brightness;

-	return send_kbbl_msg(ec, &request, &response);
+	ret = send_kbbl_msg(ec, &request, &response);
+	if (ret < 0)
+		return ret;
+
+	if (response.status) {
+		dev_err(ec->dev,
+			"EC reported failure sending keyboard LEDs command: %d",
+			response.status);
+		return -EIO;
+	}
+
+	return 0;
 }

 static int kbbl_exist(struct wilco_ec_device *ec, bool *exists)
@@ -140,6 +145,13 @@ static int kbbl_init(struct wilco_ec_device *ec)
 	if (ret < 0)
 		return ret;

+	if (response.status) {
+		dev_err(ec->dev,
+			"EC reported failure sending keyboard LEDs command: %d",
+			response.status);
+		return -EIO;
+	}
+
 	if (response.mode & WILCO_KBBL_MODE_FLAG_PWM)
 		return response.percent;

--
2.24.1.735.g03f4e72817-goog

