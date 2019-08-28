Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D3D2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrHtPwM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfH1IV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:21:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43161 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfH1IVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:21:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so871107pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+xDpWo2oT08ou9fvGrkptCYBMIqSmZRdTRAyh6265I=;
        b=PrHtPwM6tq7xoo1QWNWyhW8OOQJaq69j7oe0TIWZQrJLHUxb57TWrvr+EyPCpSjxcz
         x+7xMbyAzfpt877DerOKPBpQkFO2nQUhiJPsNAqSqZB/G6E1+eA0zA0sTsocG9NRX4lh
         w5BTT4jgcEDX+ObY/F5s2cdIssgj8YhHJ6HSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+xDpWo2oT08ou9fvGrkptCYBMIqSmZRdTRAyh6265I=;
        b=Vjv03PKepgtbcnR93z+2ZIhYUM78STgUFCtoTlM/mdZ7AXsgXc9LLqvxuLwQCLG5pO
         tQCUFQ8PeVUcc6hMKkZ7eKm8qcDgTB7uI6F8Zz3QP6Grcijzx3hUEQDcROBK7+tRZkmh
         BpeSPbXeqtH8Mlvf+7KVy17pIxUsAYoCm3xE/0cGarSuIu31prHjXTAeXIHpA+Oik1a5
         25zjAJ6Pb8GzfgWfqYrFQygt7GcOaeqPxGe+uEIQLBQ8rw6Sxszh509ligl8+QARry+9
         fGMh3XOS+hf8o0OyqARITEohYAu6DTZXB3xG6kRISFZlCM5Pfup1gzSUFH70hgxvX45v
         iQiQ==
X-Gm-Message-State: APjAAAX13CfikKZFpyoK45mHG3bDigS0hgcDFpxPTx13W9++tKuvzVgI
        Cf0vFDITk8N3KIsionm2zMGZHA==
X-Google-Smtp-Source: APXvYqyS/9fSKUn7Cu6qNhd0MavSj9l+c5ef+ep/CtdNuSaGiQS/h7VtXA9ix52t3bQb/5XrVpJVew==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr3021258plq.135.1566980513957;
        Wed, 28 Aug 2019 01:21:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y10sm1296959pjp.27.2019.08.28.01.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:21:53 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 2/4] tpm: Add a flag to indicate TPM power is managed by firmware
Date:   Wed, 28 Aug 2019 01:21:48 -0700
Message-Id: <20190828082150.42194-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828082150.42194-1-swboyd@chromium.org>
References: <20190828082150.42194-1-swboyd@chromium.org>
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
Cc: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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

