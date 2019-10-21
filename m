Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E96FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337212089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 05:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dcTyKTJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfJUFzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 01:55:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44335 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfJUFyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 01:54:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so7681160pfn.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 22:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hX0C6B+JnRorkRcAH+QZtlo4gKeiA3mE2oXHCalaLuk=;
        b=dcTyKTJX2xKLB4Zw2xVpiQuOXNlCEBWCedHV+KVgVKnlKxoXdQNW/gJaKSzFkiCiDR
         6CLZrsO+TYjy4Jc2eBIjqX9+s6z+UroT5wYzzC3A/j14pOlaExYTTOIhtW+/PdqSvd9L
         jyI3g70DvS9e6vPZt2biPYx7Z0aCPrmQVZzWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hX0C6B+JnRorkRcAH+QZtlo4gKeiA3mE2oXHCalaLuk=;
        b=EcxOlVERLwKiDrA/KZvMci7HUYnPkllKylpo7hFzq7cskAdN0pEs4Q/rb4zJNUnENE
         NAgt3YaHUOQc1qA8O5t2KQB0KN3rKZiuA1QR71uzOuuyFMAd37yIz2NSfbxGgb0CQk4x
         yxyeh8e2m1IyTsA/k75P8VC6HXSPCrlE2MR1hZ87eczOVvdS0r8U7wkjtC7HZw2T9vYg
         DceYir8tf5oTDeJ/Ot+32u93a8948hV7KtpOq9i+637S96J2Bd31AtnaF2a+Dn9I+Egn
         jmt7LE9q4VPS9G9dseSJs3lmxEuDDDIlRfnEC5CjvhseCoiVLrqqgirYGK8N/SSNlue7
         NkSg==
X-Gm-Message-State: APjAAAVC0a9l3WkVy3tFdCKJrMVr/k9upKVbBKWLWrtwpkbswkNzDprZ
        MiqKgFVkh8rR/TmgBz2ISVoDKQ==
X-Google-Smtp-Source: APXvYqydxQF2RicEsD7rpkJfMdv6kyRfYVhicrlOuWuABQ9tge3/6scXgRqNHd4YyZ4I69FKH7nDpQ==
X-Received: by 2002:a63:f34f:: with SMTP id t15mr24512541pgj.453.1571637264657;
        Sun, 20 Oct 2019 22:54:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id g35sm12964961pgl.27.2019.10.20.22.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 22:54:24 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 08/18] Revert "Input: cros_ec_keyb - add back missing mask for event_type"
Date:   Sun, 20 Oct 2019 22:53:53 -0700
Message-Id: <20191021055403.67849-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191021055403.67849-1-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
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
New to v2.

 drivers/input/keyboard/cros_ec_keyb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 8d4d9786cc745..a29e81fdf1861 100644
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
2.23.0.866.gb869b98d4c-goog

