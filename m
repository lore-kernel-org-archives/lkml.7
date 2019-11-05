Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC6C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C52053B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5foCbE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbfKEW1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:27:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44781 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbfKEW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:27:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id q16so10373150pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 14:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhVYLzxUNaTO2eJtNvvu76dlTz9gLsrnk1niF8shIV0=;
        b=D5foCbE5j9OLfEzFyq4H1YMO0PGoPiIC+rP3EDdt4wK5cO7kKdWtvS2iZ1a58Emo77
         T9FQanEXeiY3SWg+qj7Fb2Dac1naXkKbOOGQjsQdfvnkphTLwnfFZV5/Rv+MCDyUdt7s
         5F+StfKV7mmDKS09Fii53Vhxv9ddJUlQd0rGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhVYLzxUNaTO2eJtNvvu76dlTz9gLsrnk1niF8shIV0=;
        b=Lb83MageR4AnQgSBIDRRatDo7D7ioI7UQl/0DDXNN9HR5Dfiiq9XlEb8sgwr4LLey+
         IzbZ7Oyq7MfwcQxwHTRQnggwstA6ir3MhD/QUqKjz8X7h9LSQwy+T+cYWetSEAXektBd
         H1crtCDhgxNnNH7GluW62Wul1a6TSdG55M19AuMvd4kgpN5VPiQ15aAV0SrWjbcnMGku
         /hge/zTnqlRwMjPUWbMv13XQA7lWH6fQAfnK35V/esQDoNqqakGG6p9CaMSB/gqZ9CUe
         ziacxT7Nkdo6RUWGSV7Ojds2TBEm1JLYVfoiGeJP0PMdK/4dRloRZupc/6PCRIJmHbMx
         09IQ==
X-Gm-Message-State: APjAAAULlwdYVmF2R6UbTaDjBJpxChzx7eLdrgiyduam64SVNXmyGQ8X
        v/2Wsnx4eO40+VM1e6oD2AJttQ==
X-Google-Smtp-Source: APXvYqxJoKLWcFreLAtY4FZfJFm2Lidgb1jQm2lRl5bmAx2ZiRuynxYeDgk0BQIlQmVt+CeIh+Lfzg==
X-Received: by 2002:a17:902:fe8f:: with SMTP id x15mr7401709plm.343.1572992831230;
        Tue, 05 Nov 2019 14:27:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m15sm9589863pfh.19.2019.11.05.14.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:10 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 08/17] Revert "Input: cros_ec_keyb: mask out extra flags in event_type"
Date:   Tue,  5 Nov 2019 14:26:43 -0800
Message-Id: <20191105222652.70226-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
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
No changes in v4, v3.
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index a29e81fdf186..2b71c5a51f90 100644
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
2.24.0.rc1.363.gb1bccd3e3d-goog

