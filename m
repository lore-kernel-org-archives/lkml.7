Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ACD21841
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIXAp4Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfGaKBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:01:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44545 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387667AbfGaKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:01:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so31716009pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=hT++od96JIv4ERj/5q43A9sdV6GV4nXuETH/GErjU/I=;
        b=kIXAp4MzviR01IRWqe7+ak4T/tIj/IFNOIOhRvpjmPe4Iky3tFm/wfi5mHwn+pc5DK
         BQr4/V2CGVXy3LsdNBMhg93+PTiKMQhTlHIm5KoA1US4OPQS9jfABuFeaTh5gnT+r2aX
         nIoi4PywtlKhdVqSZOj3IKK1NvCelqy/7qMhasvUnDLoaz2EMKpUZIxxfyXFzAraP4Ox
         iKncbdTOLXT99eGgIOaUMIJJzvIoi2zdT+fSBRWqENUmT/UezZtf8dIF2BK3IICY2HN+
         D695VleypTnWA8Je1k4uXVgjgWZ8D8GJiwdlybFBgC7IWA4KSWK3FBUq7x1kMW9XG3xw
         eB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=hT++od96JIv4ERj/5q43A9sdV6GV4nXuETH/GErjU/I=;
        b=rpPxLIO1cUaaoCWS1GHhA9ISQGI2USoYIuY52GoUD57ombqHBgEHrBuEyutMeoYqwj
         WR595MiSDW4QcPBF+ILVWzQyaTOY4/Or4YHvRmPl8O4khxGKRAW2lKUzWeOH86Ah800I
         ba02eg3gzPY06iYz21kgv1ebgbF5sO4kNUAgfjiNvgA8iOLTVdC4eLJqK1Ocdm8sKemr
         2Z4IP16KZd+n5zCKKFAjX4cPsOhwCJMBMbK9g/4lb9403khmUMFcB1tKUdkEVF14lj+U
         1MOKEMGX0N8ggoo5loM0QUc5FQFq8F8zdK8T3nemFKSK6b7k2l8SCIQB4te9k4xikXUR
         9yaw==
X-Gm-Message-State: APjAAAUZcWhUKk5RBB/5I9TMPGw6NLNbdAyvsMz0PWeQAuruHj86Gb50
        CrFRF0xH55V0RFSDNKJAnBnsyQ==
X-Google-Smtp-Source: APXvYqzXNx5w1M0CUiKp7nGMuwNt7ZCkwdDTEa9GNGjgnC2N3BvUWTewMA7HX54pOwDNkuJOSYLSgw==
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr44975412pfd.109.1564567263283;
        Wed, 31 Jul 2019 03:01:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.01.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:01:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] power: supply: sc27xx: Make sure the alarm capacity is larger than 0
Date:   Wed, 31 Jul 2019 18:00:27 +0800
Message-Id: <5c3bb516c6020410a932c12eb2481fd75c34b7fe.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

We must make sure the alarm capacity is larger than 0, to help to
calibrate the low battery capacity.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index f670131..fa85f40 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -915,6 +915,8 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	data->alarm_cap = power_supply_ocv2cap_simple(data->cap_table,
 						      data->table_len,
 						      data->min_volt);
+	if (!data->alarm_cap)
+		data->alarm_cap += 1;
 
 	power_supply_put_battery_info(data->battery, &info);
 
-- 
1.7.9.5

