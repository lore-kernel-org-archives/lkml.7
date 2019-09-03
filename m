Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D24FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AB22087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ0krnZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfICLva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:51:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42460 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:51:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so17125214wrq.9;
        Tue, 03 Sep 2019 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LFB91c3nmv/pz8b+u80goQVipPJpjyjQS62qRFXUgtQ=;
        b=bJ0krnZRH3xIjehbkmbbVQxBnkUa74KSuTBDO//BQo0cigELoAv1mrtFxrColLkIZM
         omcKsHUfEe9PPcv836qz1cl2MBhLKye0mZu2NLvhOEuEaN2UywKFLZ39fexi+pwe18ZQ
         2HXkAewEgMuqKFVDkXpvnuXzhsuDab9mG1+oyzKqcOX+Vz/UIMWwhjq8h4oNkYiITH4K
         H4wY8S4xnA712lpsnpJoBc4BIEgALRz3H2B6LkKSuQunJ7ug5co/gSfJKJfL6YrUlc24
         oAiOd5ckrjC+FCtJF4F4lWHxd71KtESgi9ImmMb1SNcvCF+fPxFyc7pEJXOsLPtJUBGa
         l2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LFB91c3nmv/pz8b+u80goQVipPJpjyjQS62qRFXUgtQ=;
        b=qYIWYDir8ccONDlup4/U8gsh3CsbmWs7OvcbR5N1Aml1TDTp+Mc9COQvohSm5PTGUH
         /Y9d1xdZOHfGeRrWmrX8CQZzTgAZl0aO7M8gj5q9nEx4kFBRH68HzbvUU519JMQ+m0cR
         F8njjRdKfmVuzTWh6Jx68vKao2SmZe28uaX01zQ9JHitnwAeqJKfFNfglMuYxRSb2heW
         vFsi2lyi4MwRuHpna2ET/rohnsx+hk2g3RxEqSqw13KYWy3xmjsArWAiJqgAscEUWX7W
         L7T2TK0HIRKH7dUXwmvDRV/fmotbhdpW6Jmn3DFolkfWVDqxwjG4vhQoXEQvMDBuSRbS
         b4ig==
X-Gm-Message-State: APjAAAXOpR0R0mf2Ff7OObe8eBsFPomhssit6rzAuflKdalBOLX6VNJa
        d5NbpbIx4/wJw/w7r3lMZKt6nuOZ
X-Google-Smtp-Source: APXvYqwbEWX6uMe+Chq94s40RNi2NT4phCD3BvTPenhL7mFjVNrfZ2XEQ/SieLlzjcCHquFVjwcwPg==
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr8441064wrt.259.1567511487060;
        Tue, 03 Sep 2019 04:51:27 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a192sm22926128wma.1.2019.09.03.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:51:26 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
Date:   Tue,  3 Sep 2019 07:51:14 -0400
Message-Id: <20190903115114.33053-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching from any MMC speed mode that requires 1.8v
(HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
ends up configured for SDR12 with a 50MHz clock which is an illegal
mode.

This happens because the SDHCI_CTRL_VDD_180 bit in the
SDHCI_HOST_CONTROL2 register is left set and when this bit is
set, the speed mode is controlled by the SDHCI_CTRL_UHS field
in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
because there is no UHS mode being set.

The fix is to change sdhci_set_uhs_signaling() to set the
SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
any switch to HS mode.

This was found on a new eMMC controller that does strict checking
of the speed mode and the corresponding clock rate. It caused the
switch to HS400 mode to fail because part of the sequence to switch
to HS400 requires a switch from HS200 to HS before going to HS400.

This fix was suggested by Adrian Hunter

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 61d845fe0b97..068149640ecd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1858,7 +1858,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
 	else if (timing == MMC_TIMING_UHS_SDR12)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-	else if (timing == MMC_TIMING_UHS_SDR25)
+	else if (timing == MMC_TIMING_SD_HS ||
+		 timing == MMC_TIMING_MMC_HS ||
+		 timing == MMC_TIMING_UHS_SDR25)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
 	else if (timing == MMC_TIMING_UHS_SDR50)
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-- 
2.17.1

