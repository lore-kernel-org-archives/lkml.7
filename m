Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B7C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E217E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0X+MvWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfIDQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:46:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39775 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731631AbfIDQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:46:34 -0400
Received: by mail-io1-f65.google.com with SMTP id d25so43137178iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd6PQChr54NunkxihDMye6FCURG8qhb6MXYTPYLf20E=;
        b=H0X+MvWDHojkg7TT7Xot1qI0sbKDDh+0kTRrCI64n7tiK6nAekYYZScTs+PW9ur4M3
         y5LrEdMAcvWCMikZlTpp+hb7m4Wm46KtTmTwI1q60BfVnWvy1wHA+ITLpzg8OOcFLRFv
         Tgo3T2Vc2th20yxDlG8pocaWB/FTfRNxoOUh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd6PQChr54NunkxihDMye6FCURG8qhb6MXYTPYLf20E=;
        b=qL52RZS1d8Z5AxwsgembWtLfhuhKfVFl6zsGM/czA1UT8J4zTABwjuYYUjgk24Fbgd
         D7t62YbfhgjOEWY0j2YHhrCxmH0MSOYhaENtFRRmZMnF+kBpSzdIkOjEYNw9yJDvPZwJ
         mqo54wGPTXYhwsFZAMcRqvBMm8WARV4GJW9ktueS7+VG/MAiETCODsZD6UaapeRVbaol
         ihcuJ4VS9gqc22NRNS8hTfbu6Q6k42DZEeMwnvDIWjhMuWA8Z81ZZS9bJSuAOFZKFStG
         RtaIxWdLhUeuHbk2Y123YLT8lPZcelG3kvXZFtojgmL5MpWJV67sWlZv9R3prfL4DJbR
         49ag==
X-Gm-Message-State: APjAAAX2rOzqR7+8+iNS4U0lgDhHQlABMlmT8WL563asUlwelK2FPA3k
        0RQ/h9PSZMp/EiAnF2vBbDL8IlmXAwOQNw==
X-Google-Smtp-Source: APXvYqxH+igDQlLwSM5qwDu5hhMtLDs0wMevf1p5TljXXr4s3NH7/317yTaHiUtRf1xU7RSCb1b5oA==
X-Received: by 2002:a05:6638:1e5:: with SMTP id t5mr6265540jaq.79.1567615593561;
        Wed, 04 Sep 2019 09:46:33 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id l186sm2126395ioa.54.2019.09.04.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 09:46:32 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci: Check card status after reset
Date:   Wed,  4 Sep 2019 10:46:24 -0600
Message-Id: <20190904164625.236978-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdhci_do_reset we call the reset callback which is typically
sdhci_reset. sdhci_reset can wait for up to 100ms waiting for the
controller to reset. If SDHCI_RESET_ALL was passed as the flag, the
controller will clear the IRQ mask. If during that 100ms the card is
removed there is no notification to the MMC system that the card was
removed. So from the drivers point of view the card is always present.

By making sdhci_reinit compare the present state it can schedule a
rescan if the card was removed while a reset was in progress.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
Sorry this took me so long to send out. I tested out the patch set on
5.3-rc5 with multiple devices.

This patch was proposed here by Adrian: https://patchwork.kernel.org/patch/10925469/#22691177

 drivers/mmc/host/sdhci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aae973e..b0045880ee3d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -337,8 +337,19 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 
 static void sdhci_reinit(struct sdhci_host *host)
 {
+	u32 cd = host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+
 	sdhci_init(host, 0);
 	sdhci_enable_card_detection(host);
+
+	/*
+	 * A change to the card detect bits indicates a change in present state,
+	 * refer sdhci_set_card_detection(). A card detect interrupt might have
+	 * been missed while the host controller was being reset, so trigger a
+	 * rescan to check.
+	 */
+	if (cd != (host->ier & (SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT)))
+		mmc_detect_change(host->mmc, msecs_to_jiffies(200));
 }
 
 static void __sdhci_led_activate(struct sdhci_host *host)
-- 
2.23.0.187.g17f5b7556c-goog

