Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FAAC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9012063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9qJfWwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfHMJi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:38:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41148 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbfHMJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:38:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id 196so4111392pfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaD6A+K4/8jdvOIsXluiNkAgL7M1+kFjGExIzAUXUW8=;
        b=P9qJfWwQxPZfidskchVBFJ6nzdSG06wa9bYO4Ka8Z3FpbaIb/pOM0nWavs1Rp0cmwE
         avzBz1VE8gXB7z8yFrZriS82QzSv0+jDDzi0wloLQEWVaq4cFhu7k0W3SFCupnzo7Awb
         ok5s05HaN62VYRuFe331qpIqNLxTOiLF3gKl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaD6A+K4/8jdvOIsXluiNkAgL7M1+kFjGExIzAUXUW8=;
        b=DUUDbVLIOu7aN4eYfLORiLX/7BoJA5ZnUooVzrQD//cx1s9A45X4r1EtO3AsMH4bVf
         TgZIJA+d3aTUlidPT0SNqDRBtoBjHqDqqAcHQVT4DGgDLh351WivOnJQxK0uddEfOJgv
         YkQs4mj8CKANldonXf488rihC4kU4HxhpMGNvWjAD3FTO4GctL4aifKAAEaEPdwfS9t/
         Cyu+r6UwbbP3jdns2l729FTKYMyvxPyp78Hj0W8G0NB2HymIgXMLe9odPUwEl9AofLHk
         BRqtX5GVp0kfrJzQOkOflaNb5XeDsUoLg/zJpi/wSBazxQm8uDU4g/I4rq8Hi3ZZ+aN0
         Vb1w==
X-Gm-Message-State: APjAAAV1X+QQXFJqTGL5HPctIEOFDVql5lQ+7vuJ94T+32Jn5tJNTZxf
        3E73Ix9vSlhWk95GtiWGYVI6mw==
X-Google-Smtp-Source: APXvYqy+sJLrmolDFV0o4Mz+fxfscm7CXTjw8yiXTupKIB8qVuUNk3Kz27oocXNCPBU7aDi5xwq5dA==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr1383491pjs.92.1565689108872;
        Tue, 13 Aug 2019 02:38:28 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:c4f0:9345:d0e8:a355])
        by smtp.gmail.com with ESMTPSA id d2sm993283pjs.21.2019.08.13.02.38.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:38:28 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Ting Shen <phoenixshen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Fei Shao <fshao@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cros_ec_keyb: Add back missing mask for event_type
Date:   Tue, 13 Aug 2019 17:38:21 +0800
Message-Id: <20190813093821.74158-1-fshao@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patch we didn't mask out event_type in case statement,
so switches are always picked instead of buttons, which results in
ChromeOS devices misbehaving when power button is pressed.
This patch adds back the missing mask.

Fixes: d096aa3eb604 ("Input: cros_ec_keyb: mask out extra flags in event_type")
Signed-off-by: Fei Shao <fshao@chromium.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 38cb6d82d8fe..bef7bee6f05e 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -226,6 +226,8 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 {
 	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
 						  notifier);
+	uint8_t mkbp_event_type = ckdev->ec->event_data.event_type &
+				  EC_MKBP_EVENT_TYPE_MASK;
 	u32 val;
 	unsigned int ev_type;

@@ -237,7 +239,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;

-	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
+	switch (mkbp_event_type) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);

@@ -264,7 +266,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	case EC_MKBP_EVENT_SWITCH:
 		pm_wakeup_event(ckdev->dev, 0);

-		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
+		if (mkbp_event_type == EC_MKBP_EVENT_BUTTON) {
 			val = get_unaligned_le32(
 					&ckdev->ec->event_data.data.buttons);
 			ev_type = EV_KEY;
--
2.23.0.rc1.153.gdeed80330f-goog
