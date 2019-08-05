Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17759C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CD9214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 23:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVla6KTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfHEXcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:32:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44226 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEXcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 19:32:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so40514113pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkJZsBEn/CiiuZNhsnLr0nSUJKwxAQY9KFBx3uOaLzo=;
        b=BVla6KTEpKUsi2JPfceTSbxAKyqH5jrH4XqqkmrMT1+57w231S3ir7e9VLkaSMDJlz
         FEuw5OnOBz+gBdON/yvqKUU+A1gTri8F7kEHVSGNS3YH9ES9+uDhp/Q+xeNyCrGzZJjw
         B0RcRCta5/6rpmtTYdJuwA2qMrR0Oln/7LTRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkJZsBEn/CiiuZNhsnLr0nSUJKwxAQY9KFBx3uOaLzo=;
        b=pwHFxAvG7Q8LWIUIgbCameQx1puo06fykplgFLMRMJTdl9eGjPxTP3rRQUTQ9arGPu
         a2fpi67Tbfcq3JJnJaTArzJoxgtyeVE8+7IL4lPltolpr9GCRty7qtmtKW9CUqM+i7nr
         PXT7DJhbHYwYnJ+XfZtbdKjvaeDMFNCIKEQYX6+20xzuUEYPNJN7eWv9pP7blZV3U750
         LC1B4GGuEuG21NF2DEi2RW3mMfykC3W2Qei/7bT3+1aY9dArt5SeDAtipzo9NTk5Qlin
         4hYQpxDTeJsfACF8Ao03F2Uv/VXlBeob/q08puuzGTt97A/eDBBDejpQnYTTNvluefiC
         qOLw==
X-Gm-Message-State: APjAAAV1VJ7a/uEOgKp6iZgv1maxd7eP3cXxEuVEe+/h22PxMMP/kjtD
        tIAoOSTMyFkLrqxIApaLdoL7QQ==
X-Google-Smtp-Source: APXvYqz2ZiBz50jumbmTgWp5vdv/wsrJgV24UFUfx0VjaX+bimV63+csf6KP0Pd3/yyEgfaO+elfYg==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr228070pjt.16.1565047962658;
        Mon, 05 Aug 2019 16:32:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u128sm97748195pfu.48.2019.08.05.16.32.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 16:32:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v3] hwrng: core: Freeze khwrng thread during suspend
Date:   Mon,  5 Aug 2019 16:32:41 -0700
Message-Id: <20190805233241.220521-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwrng_fill() function can run while devices are suspending and
resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
is suspended, the hwrng may hang the bus while attempting to add some
randomness. It's been observed on ChromeOS devices with suspend-to-idle
(s2idle) and an i2c based hwrng that this kthread may run and ask the
hwrng device for randomness before the i2c bus has been resumed.

Let's make this kthread freezable so that we don't try to touch the
hwrng during suspend/resume. This ensures that we can't cause the hwrng
backing driver to get into a bad state because the device is guaranteed
to be resumed before the hwrng kthread is thawed.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I'm splitting this patch off of the larger series so it can
go through the crypto tree. See [1] for the prevoius round.
Nothing has changed in this patch since then.

[1] https://lkml.kernel.org/r/20190716224518.62556-2-swboyd@chromium.org

 drivers/char/hw_random/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 95be7228f327..3b88af3149a7 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/fs.h>
 #include <linux/hw_random.h>
 #include <linux/kernel.h>
@@ -421,7 +422,9 @@ static int hwrng_fillfn(void *unused)
 {
 	long rc;
 
-	while (!kthread_should_stop()) {
+	set_freezable();
+
+	while (!kthread_freezable_should_stop(NULL)) {
 		struct hwrng *rng;
 
 		rng = get_current_rng();
-- 
Sent by a computer through tubes

