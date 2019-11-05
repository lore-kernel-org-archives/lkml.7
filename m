Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB6C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063412053B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oeAsvNex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfKEW2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:28:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40507 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfKEW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:27:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so8253092plt.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsnI3SikgfVj/jlXxDFzF5p8kBoEYs8xVT3Ywimc1KQ=;
        b=oeAsvNexD3P1DqYm9KEBBhKIxOJYF5CEjxS25Ze6MXYdp20a+m4kVyP3zMzQcqxQRw
         jRaHDxyBpBcIJgNlpvsxkfj0spIuhqu0yQoRu+7zlGnBqmGgxrVK/7f8lByBXmxc4HiE
         StfjOBL3j100JudvtSU/D8XUeA8WHSQaFyKZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsnI3SikgfVj/jlXxDFzF5p8kBoEYs8xVT3Ywimc1KQ=;
        b=gVXvQEd63X28TKcXeW2wv/UjiFUHUwUV4fWuing5exz6cpikDNeIdf8naGbvQqGjMD
         Bfycn6PfIZRf8PQXpz6srgw7FkaPeIO/MAmpoDNU3M9P3H6Fx/CcxPLojU6X/Z5J3QhJ
         OV8zWS0gR7qs3BoxXg8B07KptQQKyMi5KA3OSefRUw/FzYhW0TfK5DRFpaLLDmB/sRG6
         VGa2u3dGA8AfykCj6qIZn1S7o1N/p02AIGm0ifVqx8lvl3B09cXgeiNGNFPdBoZJ90nC
         bHHou+BbeO7rkabHNOmDfbTfPp/GWz9DSpBLtYyByYuJoELxHLlAXriQje3bL467Ahf9
         J+EQ==
X-Gm-Message-State: APjAAAV0Jy7PuvefvLro8VZpbJW7EgVX6N58tbpz8uSv/QRV0asHFSlo
        apMXeLvWO6g8cfp1efiu50ldiQ==
X-Google-Smtp-Source: APXvYqwgaY4hEu6T+BNKfyf+BBEQPcfGgeh6aKYH9b4ddptYMz5lhKpCeNThjWU2px7VqD5ba/146w==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr35208852plb.289.1572992829761;
        Tue, 05 Nov 2019 14:27:09 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id z11sm26385299pfg.117.2019.11.05.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:08 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 07/17] Revert "Input: cros_ec_keyb - add back missing mask for event_type"
Date:   Tue,  5 Nov 2019 14:26:42 -0800
Message-Id: <20191105222652.70226-8-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 62c3801619e16b68a37ea899b76572145dfe41c9.

This patch is not needed anymore since we clear EC_MKBP_HAS_MORE_EVENTS
flag before calling the notifiers in patch
"9d9518f5b52a (platform: chrome: cros_ec: handle MKBP more events flag)"

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v4, v3.
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 8d4d9786cc74..a29e81fdf186 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -226,8 +226,6 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 {
 	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
 						  notifier);
-	uint8_t mkbp_event_type = ckdev->ec->event_data.event_type &
-				  EC_MKBP_EVENT_TYPE_MASK;
 	u32 val;
 	unsigned int ev_type;
 
@@ -239,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;
 
-	switch (mkbp_event_type) {
+	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);
 
@@ -266,7 +264,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	case EC_MKBP_EVENT_SWITCH:
 		pm_wakeup_event(ckdev->dev, 0);
 
-		if (mkbp_event_type == EC_MKBP_EVENT_BUTTON) {
+		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
 			val = get_unaligned_le32(
 					&ckdev->ec->event_data.data.buttons);
 			ev_type = EV_KEY;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

