Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF112214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhHKdukW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfLLXfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:35:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38535 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfLLXfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:35:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so569009lfm.5;
        Thu, 12 Dec 2019 15:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aO85qqdL2qrngMuzPa0x+Jh/Nqd2OFRkhn4wziOGIHI=;
        b=VhHKdukWWAl0HfgdTVlu+e+gJekUvy8NWwa4sOZgVoGH/BGdRJa1E04dIJgHW3EBVu
         gKUjcyt9LLYQ6PSObvsPJxyPqrlZ7Hc6WiIGqU6RVdSJe3mYVzpAKTbWP99AgMcETNIa
         3THlPU1k4Cox+e3Seih+r4md/pJ1z3Ve+NpNz9fkyoOKSfnasMAlH7yGn7e7HSWS/cNO
         +DGDJfrRLJ6G8JvCo7d17u7wxGBgKlSQa8W2NXFJuG7SB61CKWXlSZy51JmxOTuVTYgG
         ZaEPRfG8EM+9hYzhlbSTKedU1XdpLJrOwrh3ZONPyTZ+tkEnnN/nIS9JSKG2dSlbZHEH
         Noiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aO85qqdL2qrngMuzPa0x+Jh/Nqd2OFRkhn4wziOGIHI=;
        b=hwurfULxS5BYQrfKt7QUuA2C+ph6OlryxRknQNEqxcVn93avD+mRq097hcEoYxy34M
         qrODhyu1u+WHRUvyZkCC905lAHTJOIx4QtGM0QWMSfdTZaUkko5qgBpvScZlzg5QYcvK
         eD3EYMULvqDFL4Y3YfibkhMswMcvAoVlLfDDTyjV4qtV2OGDk7tWyaSK2IfFifztgdPu
         rl1P03uQa0gCfV3IqpGVp1sGBl7qFizFFKmZDVMUbFd5LraozFObwDpywo9g8bigWD4p
         MguFLnf4m47wW5kxnD4wYxSoq6cjLSuedfI1NlAWdOMRvglXmIDOaIsoVGVncEYTVayS
         PjPQ==
X-Gm-Message-State: APjAAAXstgshLEqkQqnPnm+WjplgHo8Co4q0Maoa9KibNnrCepbxjarq
        EakX0IJekIJswBcVC3GbR9o=
X-Google-Smtp-Source: APXvYqwxBrytrV61kYH19ZVGWsUDa7/qZ5Ys6fgRynMwL6Xtk/yXgq02a0rkTlDCqLm8dRSqToQdDg==
X-Received: by 2002:ac2:44a3:: with SMTP id c3mr7189472lfm.1.1576193711543;
        Thu, 12 Dec 2019 15:35:11 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id q27sm3764283ljm.25.2019.12.12.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 15:35:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] i2c: tegra: Fix suspending in active runtime PM state
Date:   Fri, 13 Dec 2019 02:34:28 +0300
Message-Id: <20191212233428.14648-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212233428.14648-1-digetx@gmail.com>
References: <20191212233428.14648-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that sometime I2C clock is kept enabled during suspend-resume.
This happens because runtime PM defers dynamic suspension and thus it may
happen that runtime PM is in active state when system enters into suspend.
In particular I2C controller that is used for CPU's DVFS is often kept ON
during suspend because CPU's voltage scaling happens quite often.

Note: we marked runtime PM as IRQ-safe during the driver's probe in the
"Support atomic transfers" patch, thus it's okay to enforce runtime PM
suspend/resume in the NOIRQ phase which is used for the system-level
suspend/resume of the driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index b3ecdd87e91f..d309a314f4d6 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1790,9 +1790,14 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 static int __maybe_unused tegra_i2c_suspend(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
+	int err;
 
 	i2c_mark_adapter_suspended(&i2c_dev->adapter);
 
+	err = pm_runtime_force_suspend(dev);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -1813,6 +1818,10 @@ static int __maybe_unused tegra_i2c_resume(struct device *dev)
 	if (err)
 		return err;
 
+	err = pm_runtime_force_resume(dev);
+	if (err < 0)
+		return err;
+
 	i2c_mark_adapter_resumed(&i2c_dev->adapter);
 
 	return 0;
-- 
2.24.0

