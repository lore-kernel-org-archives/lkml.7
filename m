Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B748C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AC22089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 23:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoWsJOFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfEAXmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 19:42:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36617 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEAXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 19:42:06 -0400
Received: by mail-it1-f196.google.com with SMTP id v143so369126itc.1;
        Wed, 01 May 2019 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z1/0wnRgSXVSbQEBOMgThnXBDYE/41xcxe12SD/BoTE=;
        b=BoWsJOFLffHIXIsVblQVK7Kf7fvH0QiYKLB0RtZmrtQYpj1/rxGKUDuoHWJGzbVWwJ
         YAAguodthyUOeWrWfr9M1+yBFhdjmbd7AjMztC4MeBl8SBT7DURWNyvPFCoIo1BfVv4c
         C7AwhtZMdpjyvO8h2cXrWVBx+9b+WCeMhsMZsBz3BdayN8Dka5EsYrwywOSVeKGHi44a
         +IwzpBtOJZ5kIcecuN6R4qyrSK4dJDgsvHI6lfj12TM3kRdO2WYfeLKuZac/AwKhbC7g
         quoRl/d/brVETVoieyS6joYKt7kwYp91/HXzjXDx+fMippJ5cvPdI1UZbe1iLfNeQJdk
         CQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1/0wnRgSXVSbQEBOMgThnXBDYE/41xcxe12SD/BoTE=;
        b=DXz7dc5HFTET9+BMrlIqbPlS3O7bF9P2hPCn9bnQbJlGLaTpwFtL7P5RC6Iv6qrHNl
         QU3SL22qadS2OMkh3xuaWnCWtBcDgXBwya1lWhfSDvIkd3YxVzMEbv48MgGzRCKeQXD7
         YMfbAveh0mp8JY9nsuBVDWTcWl94Gweveg0UO8dP9E3ZB0/bP8RsvZriuL0OghWc3dCl
         zldZe2GUKnVCvfMudaF5YHmxVVs0qPp+oaWL1Ff4gD9dKqWXw+yDf5vHbJKm6v8dbsLd
         IcRxU0rpm6mC0+GgzIjQ01F3o0C0ornW/f6nGv28eDZpVbbYz6Oxsa7tsWlNWeqyV27K
         +UPw==
X-Gm-Message-State: APjAAAWsjIuagGYROhBFng8s0o4n0RqMQklBMzRjLpOOlKAdXAReURL+
        UCgyuY5MMJLTpLqbbq7i488=
X-Google-Smtp-Source: APXvYqyLg4mQdd07IAKZY57ly/ftKTQKgE8EwPbml4f1Ty2EgmSXyIdyMyFpD40wyPFwka0iwWbtcw==
X-Received: by 2002:a24:6495:: with SMTP id t143mr206730itc.156.1556754125561;
        Wed, 01 May 2019 16:42:05 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/16] PM / devfreq: tegra: Mark ACTMON's governor as immutable
Date:   Thu,  2 May 2019 02:38:09 +0300
Message-Id: <20190501233815.32643-11-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACTMON's governor supports only the Tegra's devfreq device and there
is no need to use any other governor, hence let's mark Tegra governor as
immutable to permanently stick it with Tegra's devfreq device.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig         | 1 -
 drivers/devfreq/tegra-devfreq.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d338f6d..a78dffe603c1 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -94,7 +94,6 @@ config ARM_EXYNOS_BUS_DEVFREQ
 config ARM_TEGRA_DEVFREQ
 	tristate "Tegra DEVFREQ Driver"
 	depends on ARCH_TEGRA_124_SOC
-	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 5265d735419f..65b3a7c72293 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -606,6 +606,7 @@ static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
 	.get_target_freq = tegra_governor_get_target,
 	.event_handler = tegra_governor_event_handler,
+	.immutable = true,
 };
 
 static int tegra_devfreq_probe(struct platform_device *pdev)
-- 
2.21.0

