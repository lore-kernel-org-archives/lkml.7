Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3EEC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9621852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gps6OGJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfGZHV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:21:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35745 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGZHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:21:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so24085974pfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 00:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bryuP5AdFGVr6HHrw1EtAVKw7WCYNq7V2nl1DGECvfA=;
        b=gps6OGJTOEXQrFDHI9KKDyeJAzkYfi0TmbZdKCbEVIfNPXO1MGIyvHCxKJZKZ2908D
         8XhglJ9iu97qcWacqggfiZbM3MgPQAxKVysMA1FLX022aoa88vdKAroM1s8uWc2h0PT0
         Kpn0ecFWdL5evyDt/j6yMWM6Q8Zng4FpW/EpDk/7uSf7lrykUAdOTdU5J+vuOry7coOp
         guNCY1bzr+id756TYU4TSqeXOb4oOORc+SXP1I6ZwkiyJoYwtMbjooqI2nfXC9f5jwVi
         uINDC8XBa8bXnc5pzc8jVs3S/HmX9owAqK91YB8T0EPBFtqSV2efYSE6gkZN9fd9bKVg
         5COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bryuP5AdFGVr6HHrw1EtAVKw7WCYNq7V2nl1DGECvfA=;
        b=MFdEVMccFmvlXSu7R16AoTFRD4L4sr6Sy0X5sEfkbHn3Jo3y9oXA751xAjhHwnwExu
         iEER82jDyQ5RrKFqhLwbNIVbZcywqAwWkhnxaruGBb+FJ54iU49pAYLSSAwQ8V7qOb55
         aZrrQyyLwFCWuxAMhTpDxhwvTsMaE+gG0y7EEx8q7mqGgcdKP61SUxW/YIAhF2PGFCDz
         aaiH/4nAUKeH7rGB0dCLdnn2/cy/WkT9jwmCPxDAjILzAbAwW3AjVAxpY4CiNDo2UZve
         HrAtiNUgHFQXS2dkO3er68iiw955DZmVEaLSoGaP4PaYs2+xSIl6osb7VpUd0o4TFSgb
         dO/w==
X-Gm-Message-State: APjAAAXPVh5JIjotQv7rMEHEfTlsAavBAhCiXDBhYnaM9KD3TFWKPV61
        tZTP/MNKxA5Zk1q2Z1U4lptl9w==
X-Google-Smtp-Source: APXvYqzS59p+DlCx6jRNsTMAnzW6kRqAEKsib4wA9AHCRCnW1gi6S9Ot0/7XGf3sPxBezwzHe9aWmg==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr98101963pjp.27.1564125684991;
        Fri, 26 Jul 2019 00:21:24 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:24 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] spi: sprd: adi: Remove redundant address bits setting
Date:   Fri, 26 Jul 2019 15:20:48 +0800
Message-Id: <3cb57b8aadb7747a9f833e9b4fe8596ba738d9f6.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADI default transfer address bits is 12bit on Spreadtrum SC9860
platform, thus there is no need to set again, remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index df5960b..11880db 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -380,9 +380,6 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 	const __be32 *list;
 	u32 tmp;
 
-	/* Address bits select default 12 bits */
-	writel_relaxed(0, sadi->base + REG_ADI_CTRL0);
-
 	/* Set all channels as default priority */
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIL);
 	writel_relaxed(0, sadi->base + REG_ADI_CHN_PRIH);
-- 
1.7.9.5

