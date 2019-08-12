Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F96C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A2A2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfJxQ05n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfHLWg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:36:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41546 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfHLWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so3256240pfz.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEVqEnZhQhVV35dLTE4fV+ZJ16fecFLxF4vVFu1o1hU=;
        b=BfJxQ05nyCUD2yykz83BYfJcO7SjUsLU4oEJou/mnS22Lte6HruK8O6ckupd9hUxw7
         lUSbPWVbmOP2oeJbyjDnPoYCMKQpniyn/DegbKcbIWj+YwPj+9QuiQnm4VmvFL5KqLey
         KaKTAoNHbMYPrUFlRM+L1RzmsaJjWXSrNC7RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEVqEnZhQhVV35dLTE4fV+ZJ16fecFLxF4vVFu1o1hU=;
        b=AeQKwNrbNn2Fo/K/lW0L/+HZ3SI89imJw8G+XBgtePHzpgk/85I4ZWYrPFJqyOLc8Q
         5tMsHsRgolw4/M97Ay5LFuJ/mBDGtrcs5jH6yVlagpN3I3YpKuPZ2nRUuHY1JAc8pJr6
         YNj4SMg+GeX0zwSFvt/kED5I+mYy/8PCV0+6fkO5VdH3a4wKYQJe1A+zkWxy/oiY0Tk4
         DgHadoVD2P1FSasoYeoZjea+0qQ0g0Xq0CBfNVcapy0Y2eEVTPmWpNyQ5lEOsSCZYI0g
         xDML4l+ARNn9S9jXv9yAVS5q909PCmdcYNNNnE1QNxdJCfsoMUDd4G1jeBJXTSFYU5oj
         yAkg==
X-Gm-Message-State: APjAAAUryEkf3IQjY9Ljgcg+g9dfRcQmW+1KiQs/nnIcnnKt6/iZFeye
        CCSHUt4lCywNTK0vdbAfHEpsNw==
X-Google-Smtp-Source: APXvYqz86X3o0dGJ23vCO1fyItdzE6+jO7gjy9ZsDTYcnR/UMFXR30FC+/Cmr/ihjD9Gny74O6ywfw==
X-Received: by 2002:a62:8688:: with SMTP id x130mr9714539pfd.162.1565649385400;
        Mon, 12 Aug 2019 15:36:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 1/6] tpm: Add a flag to indicate TPM power is managed by firmware
Date:   Mon, 12 Aug 2019 15:36:17 -0700
Message-Id: <20190812223622.73297-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the TPM power is managed by firmware and therefore we
don't need to stop the TPM on suspend when going to a light version of
suspend such as S0ix ("freeze" suspend state). Add a chip flag,
TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED, to indicate this so that certain
platforms can probe for the usage of this light suspend and avoid
touching the TPM state across suspend/resume.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm-interface.c | 8 +++++++-
 drivers/char/tpm/tpm.h           | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1b4f95c13e00..0b3def8e8186 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/freezer.h>
 #include <linux/tpm_eventlog.h>
 
@@ -395,7 +396,11 @@ int tpm_pm_suspend(struct device *dev)
 		return -ENODEV;
 
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
-		return 0;
+		goto suspended;
+
+	if ((chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED) &&
+	    !pm_suspend_via_firmware())
+		goto suspended;
 
 	if (!tpm_chip_start(chip)) {
 		if (chip->flags & TPM_CHIP_FLAG_TPM2)
@@ -406,6 +411,7 @@ int tpm_pm_suspend(struct device *dev)
 		tpm_chip_stop(chip);
 	}
 
+suspended:
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_pm_suspend);
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index e503ffc3aa39..28f73331aa2e 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -162,6 +162,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
 	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
 	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
+	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	= BIT(6),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
-- 
Sent by a computer through tubes

