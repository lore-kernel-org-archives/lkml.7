Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501DDC47E49
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9F221848
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StrGIVCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfJ0XKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:10:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35651 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfJ0XKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 19:10:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6so469958pln.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 16:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dWhvYQIT5GLEuQFWRMmxKHMUz5gpa4Xd6+5meRvcac=;
        b=StrGIVCnTjmk9Q6WOOMn1S9EUjlETaeBOxzCopMzgK766haJ4BpaDPTvfUf5zBLab8
         8L6xbRDqhMSWficpC/Uq47WpFnKwJe7un/KNOaKaCySA3bWKjm0vbAeT9WcCoE/rx7fo
         +PMKxTR/Re/C90YHa1eQPTtqnBz013OWwSVlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dWhvYQIT5GLEuQFWRMmxKHMUz5gpa4Xd6+5meRvcac=;
        b=Q51T/1O3ATJsvEEOUHqdXzTp5TqpBQsRLRGiDIjQhxSsfpqNI8JARkjb3vJIWgFHbj
         3l/xNt4InDe9/Ub2NeU9fGDnlkj13u3i6qSmwH4b3hOQUr39uQIwN8fRVZSKyubhZy1A
         4i1TNYJ+HOUAtnKm7qqdhnfLrv2vpY+YJYRLAenHDXG6drpOIFcbPnOcM1PjW/vDSewP
         66ysPnTyvL6BClqOKQIDKj6gcfsrsTxsoQcliqnhthY1vIU3jdKB0You+6su1WNqsSYs
         VRySb4rCc5i1KGMm3noRNXhuMBwoNCJYx+jSSDBtsFBLapBGdo1nneYp6dj2PfdT8hiP
         kH6g==
X-Gm-Message-State: APjAAAWWA9vyd/k2HjjnGmyCWl0BGpJlbVGIp1BHJHcUEHL2hrvwCHm5
        a3YnXaqOzj2NsX5F7GGwaSlCrQ==
X-Google-Smtp-Source: APXvYqzbaz5P2iXJqMfWoXSZpI2FSoGkESSI9UBlE5MGhO/8b3h4rLubDPLBEj0YqIQDnJqcJIN/YQ==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr15725121plb.178.1572217802504;
        Sun, 27 Oct 2019 16:10:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id k32sm8620186pje.10.2019.10.27.16.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:02 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 09/18] Revert "Input: cros_ec_keyb: mask out extra flags in event_type"
Date:   Sun, 27 Oct 2019 16:09:12 -0700
Message-Id: <20191027230921.205251-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d096aa3eb6045a6a475a0239f3471c59eedf3d61.

This patch is not needed anymore since we clear EC_MKBP_HAS_MORE_EVENTS
flag before calling the notifiers in patch
"9d9518f5b52a (platform: chrome: cros_ec: handle MKBP more events flag)"

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index a29e81fdf1861..2b71c5a51f907 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;
 
-	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
+	switch (ckdev->ec->event_data.event_type) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);
 
-- 
2.23.0.866.gb869b98d4c-goog

