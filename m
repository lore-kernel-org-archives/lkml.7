Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C9C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFFC20673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dau3/Ljm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfFNGyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:54:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46387 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfFNGyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:54:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so590639pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp37gFsTYsqZp/7llE25fpprh1EZap60ZXSJKPJnl8E=;
        b=dau3/LjmRZKAmCsJoYy7BlJ7u5EYHxppjWX9OUoxWUj3i1i0014usy5AOT/UbJco3h
         leSs8vDaONA2+7UtXbVrKQ7WRrIJMhojVVCRFRymp1fuW2vdECgOeJzud0BGKS/law+W
         qBqrl9I1AsST2UJ/k55SoZQhKEWOGoi8uQSDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp37gFsTYsqZp/7llE25fpprh1EZap60ZXSJKPJnl8E=;
        b=h9UqfLNFJVWwQz+S8lkjHO/ApmmBvXbkN+YMswh7l6cMRMMsOuLS9WEjc4bMQCvCqn
         8YfLqAufWFr6CyZXRSbpxpL4F9OBILxzaiyg/I3VKQnsQXXAEQb/pdhlrF1Sz6QjPFPk
         oAhzKyLMGgQaOZAJ8DNUyhhaBnYZAxO7/LYCOejaIbsC7EocGclwyKU7BeyJz2VzusvO
         cG+QZtZaa1jrt2spXZE+tmG2FfAWWZslnffebTPI3aGcPBNCnWcZbb/QSsjUQeDUbrjp
         JavI7jQrrCDv/VvTK+Wi87UGB8AppVmKBavoNoXgWVnB1UCTN6Kmq2HzKMwi7JWnGDqt
         IMrw==
X-Gm-Message-State: APjAAAXGEM8o3pncCPwzjoJux8LjA+bQKdOdv4bBkE3w6WyvCFmLI78K
        WJLec5xbT0E514RGMpVWzf5yheP8BPrO+g==
X-Google-Smtp-Source: APXvYqxE6JE5K3ifTOWAfzYm2RLZVozN6psI8nOkdv/xw0NsFO+0qqwOFn6Vg86f+RkCITX+XwaT2A==
X-Received: by 2002:a17:902:7c90:: with SMTP id y16mr1887013pll.238.1560495289860;
        Thu, 13 Jun 2019 23:54:49 -0700 (PDT)
Received: from phoenixshen-z840.tpe.corp.google.com ([2401:fa00:1:10:4297:7d72:77ab:9cf2])
        by smtp.gmail.com with ESMTPSA id h6sm1723113pfn.79.2019.06.13.23.54.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:54:49 -0700 (PDT)
From:   Ting Shen <phoenixshen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Ting Shen <phoenixshen@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date:   Fri, 14 Jun 2019 14:54:38 +0800
Message-Id: <20190614065438.142867-1-phoenixshen@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
the event_type field, the receiver side should mask out this extra bit when
processing the event.

Signed-off-by: Ting Shen <phoenixshen@chromium.org>

---

 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index d5600118159835..38cb6d82d8fe67 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
 		return NOTIFY_OK;
 
-	switch (ckdev->ec->event_data.event_type) {
+	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
 	case EC_MKBP_EVENT_KEY_MATRIX:
 		pm_wakeup_event(ckdev->dev, 0);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

