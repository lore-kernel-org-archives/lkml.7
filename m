Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC312C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9050320578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofkFLjPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfG2Oju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:39:50 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:49328 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2Oju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:39:50 -0400
Received: by mail-yb1-f201.google.com with SMTP id f126so46463098ybg.16
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5wtApmPqdujWjA9F4SYVODjwHiZTI/wDFkD9zKi6pFM=;
        b=ofkFLjPoP7nFpdRGV+qW9OhBErrvHHRYeOVQr58xxhBgStMW+scR3huS5gAZiPa2hJ
         r6EaqtALeWg3VLm81AskV8f/pmFYO7fygpsIiMNN53D0mASwh9u6Od+D2lJTMzvplQp8
         iMvLZofnEoY5RoHrBUhp9fD0SdOXBDO8kX6CLc0TccsWkpqFuhDznKmB9rWgDYV5gsrb
         YPY01Fw9ml9MAaYDVTeGfe9cQTRzHiG6ADo9fDDq/pttzoBCmf3bsqNHBoiFslw9C8Oc
         DwCSDVcoulNkXbQyTsGzL8f01aBF13L+m4K84+HzjAzNqaXaMw7Ww1sL8oO2uCJSIfqf
         4udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5wtApmPqdujWjA9F4SYVODjwHiZTI/wDFkD9zKi6pFM=;
        b=IX0EpKjtXUZzjWjWPm3OH4nl7izniO42mLXWW5UiM2l9cXQMBfM+d1iT0kwdrNo9go
         Jw0aANPxsMi8ckC9kB2D/cfxz1oj4UZOM5/sn8/s1TaJ5jzG9YTyT/YGLJbNjk6QN8Yf
         QsiSkkRxgWnEsgDU/4aiRvwF39R4pv+tRkKGsjRFOPfjae83KCG5F7p9DYyQMepeuFtS
         5DVLQOAAIGbrhL6O2lLzuPMve9qUknpx8qmU0IM+3QKixOwEVpX0SpW8fabtCB2DcBe6
         +L9RMHdtpWQjTtrHWzm3nCELxs4s60xR1gItQTdjWmy+KsmrLbMw6zy0VCQ+UabcYbnN
         UB7g==
X-Gm-Message-State: APjAAAUNNOTFyBjRp7biAU83UjTpaZOIudzT4qyAlsrwKSnhsi14BIf1
        euEm+O6w+xyhDQVYe2n1Q0fFu7lxroBE
X-Google-Smtp-Source: APXvYqx+5ObrcXnvgSADglQTDx7O8U1bocpyXSBm3dER6/s6Lklsk5z5tObeYTICuQqdH82AeBE6Fumyzbtc
X-Received: by 2002:a25:9305:: with SMTP id f5mr59313976ybo.520.1564411189075;
 Mon, 29 Jul 2019 07:39:49 -0700 (PDT)
Date:   Mon, 29 Jul 2019 22:39:32 +0800
Message-Id: <20190729143932.167915-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3] platform/chrome: cros_ec_trace: update generating script
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, cychiang@google.com,
        dgreid@google.com, tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove ", \" from the last line.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v1:
- simpler awk code
Changes from v2:
- use c style comments instead of c++ style
- use '@' delimiter in sed instead of '/' to avoid unintentional end of
  comment "*/"

 drivers/platform/chrome/cros_ec_trace.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 0a76412095a9..f6034b774f9a 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -5,8 +5,21 @@
 
 #define TRACE_SYMBOL(a) {a, #a}
 
-// Generate the list using the following script:
-// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/mfd/cros_ec_commands.h
+/*
+ * Generate the list using the following script:
+ * sed -n 's@^#define \(EC_CMD_[[:alnum:]_]*\)\s.*@\tTRACE_SYMBOL(\1), \\@p' \
+ * include/linux/mfd/cros_ec_commands.h | awk '
+ * {
+ *   if (NR != 1)
+ *     print buf;
+ *   buf = $0;
+ * }
+ * END {
+ *   gsub(/, \\/, "", buf);
+ *   print buf;
+ * }
+ * '
+ */
 #define EC_CMDS \
 	TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
 	TRACE_SYMBOL(EC_CMD_HELLO), \
-- 
2.22.0.709.g102302147b-goog

