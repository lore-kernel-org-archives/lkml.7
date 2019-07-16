Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B6C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB762173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsSLV5wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfGPWpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:45:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbfGPWpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so3899545pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7aVjiR+JK3ggYYZ7yXO08DXVJw3fb9HDv02tv0JnQs=;
        b=WsSLV5wxog6kvWIkL7tsl/dpBk3h6KCtQVzK3wRMQZycgoNetF0L2hlVtTIwv+mdb7
         7cdOcd7E5s69ObFuTWG9V3q2o8BXcDlXi1AKT8WQLwj1muCboCZQwl1QXuY+k0KdETX/
         dlhJO7ZtlW1HnyxfHdjlR711IWf195ERVsWbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7aVjiR+JK3ggYYZ7yXO08DXVJw3fb9HDv02tv0JnQs=;
        b=RnuViVsbxnswb3uPrvXNNRGq7RjfqnEamASGHZFCa+zEGv1WOtTZMtVNq5s/rFPhNV
         XkIRdm4/Rnpl2UFLU5l2idV1Stfpl4EGAtUTCnuQG68CG+B06U95YdBVTqevNdM5ZtPf
         T0oI0x7FbDUMhOJawMTmblugwKCqAwcy7apEAkhp1PagNOT45wOTlNVsQxjP2C7lprSb
         XLY9sgJMefO7dTgfnMRuYCSLCMH8uZxZxJ9mlKtW3Jca7e7T4KNT5/mgdjK9nOSnM/AU
         D7FaZLtYxa4YErXX44Va1cGnQMG/NPMVNgO1wIBtcUVA4qPnZKLd7BGUsRmuL9+q162p
         1Kjg==
X-Gm-Message-State: APjAAAUwj8oCFitej1w2jyCvqQSEhQ0yxpbbXda5ZwHEXjXJdbglEfqh
        NCtoTQ+bcZoHbqfRYLKAQ7dEgw==
X-Google-Smtp-Source: APXvYqxPH9EK3keRCVn+uuCQzmztl+iHZMi6aDlVgkc8dTyHKxOKu67J/eMo+6OI5dwAp8p0Iblpbw==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6mr39696288plk.14.1563317121296;
        Tue, 16 Jul 2019 15:45:21 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
Date:   Tue, 16 Jul 2019 15:45:13 -0700
Message-Id: <20190716224518.62556-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716224518.62556-1-swboyd@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Duncan Laurie <dlaurie@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
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

