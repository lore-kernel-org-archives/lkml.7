Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA70CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAFC20700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dy0NE2JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfJUFyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:54:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfJUFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:54:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so7694684pfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agTpXvCTTB9wh7DBugiS1SMOpvplNNTL1004RlqbTps=;
        b=dy0NE2JV2NoCiDdxCroYxnRuBoAKSlSsMWVmpKZ9481xU7i8pVhw4NYGcBY5eSKVmn
         rY5u70XMTEtwAB98UY8IMLRrrfx/MpkH3r11oJntxhbUT3FO4qALKi8finJbe3s7nKxy
         4Q/krUxvl4JGy+F95QjajqGoihNkBgqHFo6Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agTpXvCTTB9wh7DBugiS1SMOpvplNNTL1004RlqbTps=;
        b=rgtKjVaY/b1LQOsy7yZsEtxF419UYR8zn/tg3w17eJNDqqsmQxDiVGuBv2rcUzGzhb
         LsPt1EqlUcsu79iJsFqE5ndD7jv5aqYM67uOqX+vDD2mPv7orrIbocv8Ejzcjl6RezAz
         UcDhSy6vvSOMaNYIRy28YPImaYrlw87l0yaHcDh9IZA8e7IuaryrI0jzjpiUOsAmqCLu
         WmpPRyMKH6wSMKPHmWYvMjCh8rURnsn3iB1eghpquEdV2DDCJXCM6zqb7AL9YLvI9Olj
         Ulv5adfSSFcUC41zDfX+A5CRcorCGQYF1nGmoe76WWmbXwu2tBLhaAqCgFvRkXCZAuKy
         pR7Q==
X-Gm-Message-State: APjAAAWt62CV3ToXm84o5pVai9Jxt3KqMMQJ0/m6KOvyn/jz41fAyMCz
        aafPdTF4rww+Yo8xZuobqZX63A==
X-Google-Smtp-Source: APXvYqyG8NF0G6wNd0iIRzjhDcom/LjD5zyhDumJ/RKSURlt36qy6yWJgAGhMn4cjRcy2Qss5VhtRQ==
X-Received: by 2002:a63:3c47:: with SMTP id i7mr19600231pgn.237.1571637266080;
        Sun, 20 Oct 2019 22:54:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id s14sm13477263pfe.52.2019.10.20.22.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:25 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 09/18] Revert "Input: cros_ec_keyb: mask out extra flags in event_type"
Date:   Sun, 20 Oct 2019 22:53:54 -0700
Message-Id: <20191021055403.67849-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
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

