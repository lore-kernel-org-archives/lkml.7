Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA515C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A969F21882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ziu3zpd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406611AbfITScr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:32:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39496 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406577AbfITScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so4296460pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FOFa9cgK5baQpD0SfGUwU5l0g13GQ3zevtR0etuAJA=;
        b=Ziu3zpd4aifAB/blDZvNK/zLz8RvWAe1xaGd2eZQXbE8hu4ifk4lRzjZ3qNv//qBoC
         /mPrcPsMTMlcg0YSjh/iF8fUNI9axGjsSl7z7Q6QxdT6x8N5hEowIwTTOvqxnIRMn6Hq
         iRyQuGWjV7V5G5Bw/p2F4O06HcBEyaJ/+MG+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FOFa9cgK5baQpD0SfGUwU5l0g13GQ3zevtR0etuAJA=;
        b=QizqQn1oW0sLD3uvccEQ5Ey7pA2oTNpNXdEL2CoJefMhb3Mf+hgBjqy5J+v4qSVtCk
         iUL63+eBDifL62OKQPmWRbBsMLDd1ZizLW3PP+CdkXtMD3cIKQ15d+bWviCKbh0B2i1x
         fg51Cldd6KaIKBvkpKOxeUkagplY82u6+Mktob8Fm+YmDRl1lZv+Fmg1ckU2zUYXOgJf
         n2aIbucMvZi88fGrxds2Zv+5zqrbDo/BFBrnqRVyVrgZObDnfnWvOntz9m9JZxQmijIt
         9yMxrCYkBEBr549DVqAJ/mPC6+HgbHaEB9pt+tWvmIAhGfqTgWH5q98VKK4MJh8xMbs8
         m9SQ==
X-Gm-Message-State: APjAAAU3hjNdvb7jZkn+EgCsl34u7h/NWJwtyzrn9FXM2XNirZOgZOSJ
        rTJguuOYenK6x2k86s4lVGe6Yg==
X-Google-Smtp-Source: APXvYqy/78meG18vRVNX7WuMywGXbUxonJGjsyju6ogxEWs43Im8alaQjdMsS7f0HaO0Ibt/Vd4x4w==
X-Received: by 2002:a17:90a:7348:: with SMTP id j8mr6253223pjs.63.1569004364278;
        Fri, 20 Sep 2019 11:32:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:43 -0700 (PDT)
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
Subject: [PATCH v7 2/6] tpm: Add a flag to indicate TPM power is managed by firmware
Date:   Fri, 20 Sep 2019 11:32:36 -0700
Message-Id: <20190920183240.181420-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
References: <20190920183240.181420-1-swboyd@chromium.org>
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
index a7fea3e0ca86..f3bf2f7f755c 100644
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

