Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3608FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073DA21872
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmuoZfqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfHFWH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:07:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44507 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfHFWHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:07:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so42308937pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yp39iSDiHsvaqQ+V6c31HHn1q9RV6+/SR9JS6bJ76M=;
        b=kmuoZfqWKtsBp3o3fVOVcDaWAuTSACpIL2N7EmKeieZgU8QkmSIhrTJGg0rinb9r0N
         E/Yt0MVNCPJUULHHl6++mKQo5yi9zD4YN7/XaMicDiYA7D1ANM3/7PoHvbyQclmerWCI
         +qyStL2BOUbneAx1vdDaYfQxMnv65Ek33I6s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yp39iSDiHsvaqQ+V6c31HHn1q9RV6+/SR9JS6bJ76M=;
        b=c3pDByE5/AlMbs4d2kUAYu9vnRW3IFzyEhJn+koQ7R/1dW9ehNVTppJ+9Yfim5EJn3
         Gmlqb+l6FMc/HRzn4sCYuZksjIreIS1gPAXKsqTaOfMool8c5effx5noRKDAq2OnAyXB
         /CAz1sAWBGuvXJSD6UHIdK0HVKQNaZTTiZfHmr82hpVN9eUTMNGZBEsGjKIOAwsE96Mk
         jv3iy/A5WBTUau7C1b5W674vbyzm/o99GPvLlJjzXUaop0uabCQL5e8Am8mf4AYgbECC
         tCzvmd2RXtN1El4DRpOFWkNS03R/1wdJ10of9b7p6FxoYm+it+beKkyZ8FF1T/M+Ny5O
         XgGg==
X-Gm-Message-State: APjAAAVcuSoJf/Ij1ItvJbVThtY4veMvvcDSIMjOxjP7BpSZIaHy5N10
        c/J8AU/AGJ00YCZtNBVvAYEdrA==
X-Google-Smtp-Source: APXvYqx6lgCKd4PA8HLEjTxGg9c+g7VMEbw+wvSX0EcJ29Ge48iD0QDOl6YFqACwtwH+9oO/uNjTlA==
X-Received: by 2002:a17:90a:3548:: with SMTP id q66mr5343352pjb.17.1565129272895;
        Tue, 06 Aug 2019 15:07:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p7sm98982509pfp.131.2019.08.06.15.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:07:52 -0700 (PDT)
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
Subject: [PATCH v3 1/4] tpm: Add a flag to indicate TPM power is managed by firmware
Date:   Tue,  6 Aug 2019 15:07:47 -0700
Message-Id: <20190806220750.86597-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190806220750.86597-1-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the TPM power is managed by firmware and therefore we
don't need to stop the TPM on suspend when going to a light version of
suspend such as S0ix ("freeze" suspend state). Add a chip flag to
indicate this so that certain platforms can probe for the usage of this
light suspend and avoid touching the TPM state across suspend/resume.

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
index 1b4f95c13e00..9bf3ddee6c8c 100644
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
+	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED)
+		if (!pm_suspend_via_firmware())
+			goto suspended;
 
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

