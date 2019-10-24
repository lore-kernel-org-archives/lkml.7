Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C33CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95221929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPFphUo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503514AbfJXQik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55657 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503426AbfJXQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so3569651wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZmXO5ePw27XXjmw9aqXqaRd2VOTfPGeZBWp3iFdesM=;
        b=vPFphUo33Onh8HRK4E07pTzJ1f7NIAzAGVk483hJ9mrqwhKfpeM412ZrC+Mtnwzjp0
         DT1qMsJ1/gCPq/F/1t4EqBTeVlCle5hjmdv+3EVPmZqvcSyOISZhN7XQp+GCXC6OBtuO
         J7eCaraw0d5fPtceFvVKfhirGWtc0Vpt1Y1gYBnNRe9ANPznLbQT7maKwMwOUxYQWAZu
         jexVQdSBRqBwtoNmWVaI816+ONrnsa1y6KWin9KEM0kUlFKJrjEtgNJlwaMBQKrnLylh
         M5tKLQIYz2aipnWQ9VGhgsLOmEfw2HuI9knyh2cHeVQy/RnXX32xk1Y8NUkbXHDcSPjL
         +b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZmXO5ePw27XXjmw9aqXqaRd2VOTfPGeZBWp3iFdesM=;
        b=UEsruUxgwwP6yOpheaowsx0AuMcWrzdMEB8CADS+ieCiG5WeFxbUBJPMKmGjQm1+kJ
         /CSrqNb00fuRzbPRghIhrsXvZFgZnLEDFsyHiJx2STeXCiIiPPDtTiyjDSQAP/Zh6BHJ
         YR75KqeD4W6VLAfdsMlJS47/0JPdaUAdTn7iqf8ILcZVwj7f8ANhNEY9N91DCTVmQ0Xe
         xAoxZUP+oK4urRuj2Ofd7I0JxvNGgJIxZzrmqSItppOoe8Ok+X/crruXTngPgG4XaJCf
         3YIkCsCu9CGG/WG7DoM8584FQaohkPuODniz8xKmpTTQSj2IlF5BkHknLiGZIMVhMPk/
         /v6A==
X-Gm-Message-State: APjAAAXsBP21BAzuTgpYEImFwnAyln/42GANnyooTBOQSuILq1oqxXfk
        fbY0HdLmyEWINBlST8S86NG48g==
X-Google-Smtp-Source: APXvYqw9GDfzRHrP4A9ce7Fj+XveS2nLrANg3XywstKg01f16Vn5vDRixFd9NpQ7KjQDR38jIoXuWg==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr6065618wml.26.1571935117250;
        Thu, 24 Oct 2019 09:38:37 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 01/10] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
Date:   Thu, 24 Oct 2019 17:38:23 +0100
Message-Id: <20191024163832.31326-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most contexts '-1' doesn't really mean much to the casual observer.
In almost all cases, it's better to use a human readable define.  In
this case PLATFORM_DEVID_* defines have already been provided for this
purpose.

While we're here, let's be specific about the 'MFD devices' which
failed.  It will help when trying to distinguish which of the 2 sets
of sub-devices we actually failed to register.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index f1825c0ccbd0..cda7f5b942e7 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		cs5535_mfd_cells[i].id = 0;
 	}
 
-	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
 			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
 	if (err) {
-		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
+		dev_err(&pdev->dev,
+			"Failed to add CS5535 sub-devices: %d\n", err);
 		goto err_disable;
 	}
 
-- 
2.17.1

