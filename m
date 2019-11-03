Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31088CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DCA21D71
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 20:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXznQXsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfKCUm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 15:42:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45398 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfKCUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 15:42:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so1748950ljg.12;
        Sun, 03 Nov 2019 12:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4x/QuAqBCJ/LT9bCDEwLgUjzwR3ulsMuNaXUn+CnmQ0=;
        b=WXznQXsTUZ5JDt6RkYbOmWVkyREz5cQyxsA1Bp4XsC/73Txbj2xa+GbKYobwSJIFpa
         ssU6b+JN5B+/932RtngKjvTsHlqsSm7b9nuHu7tp/U0E5tgyoDoiC3YP5F78Hu9wGAgy
         6LUbeYKXdW0mwA3wCrygderyqXxfQzFmxD+EWkv997GTf2y75KH0RVvAYJ6ACFSPhKR0
         nqB7Ga9AZgWeGKxz/MsUC8kbg8RKb4HCOIvdFdLOppnevCaWYpMOZqrxmPPsLVi/KqQA
         4pYWTVxufKl6pg/9uBz9SjmZ5b4MfNttpny84a/VZn2ROapwKqVtnyNfUuzIQG+xwhhj
         YaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4x/QuAqBCJ/LT9bCDEwLgUjzwR3ulsMuNaXUn+CnmQ0=;
        b=FiBWYGvXdPW0C5vnR/TI730T01DGD0nvAmzR5ki/GvZuVRI0AxWTLMCbnUy/pMrX2y
         xR2zbfQC79ED5IznhC+Pjc/qFjBMaqOi5EX0/k4g0oOaICFSvG157l+df21biNg8OSdR
         SCL2pR8c+fzqZeEv8Odhyggb3Mrive1sGkTGaoQ3ONeSS5BE3KR5ySnpLg/3/7P9OU6K
         XRXvKw52H90HrM/keeY9UwbkSq+uk65Mz2zzt5YxeZpSfaKzRp2TPGAXNcISESFQMX7U
         2GnYQCb4pVADISfHbpzrICkSEVdCouOwvIh/Rw1hsXAmx1gg+FCb1dUkmm9RUIFDghHQ
         3tUg==
X-Gm-Message-State: APjAAAU9kl2WinwSI8FPBDpPBcx21bVKCXeCN5cUG1NKaTQjZ7MrX22W
        6Qfbvd0InSF4P81/984I9XXIcPjy
X-Google-Smtp-Source: APXvYqxeuIn2rXVwQPy09d4By0+x6mqGttl/UmFBS51Buvy+5kT6+ZSKYyVQWHSph5BN/JkgDsHQsg==
X-Received: by 2002:a2e:481:: with SMTP id a1mr16382138ljf.209.1572813738828;
        Sun, 03 Nov 2019 12:42:18 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id e22sm7099853ljg.73.2019.11.03.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:42:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 17/18] PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient
Date:   Sun,  3 Nov 2019 23:41:29 +0300
Message-Id: <20191103204130.2172-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191103204130.2172-1-digetx@gmail.com>
References: <20191103204130.2172-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCCPU boosts up very aggressively by 800% and boosts down very mildly by
10%. This doesn't work well when system is idling because the very slow
de-boosting results in lots of consecutive-down interrupts, in result
memory stays clocked high and CPU doesn't enter deepest idling state
instead of keeping memory at lowest freq and having CPU cluster turned
off. A more faster de-boosting fixes the case of idling system and doesn't
affect the case of an active system.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9c645e83ef8b..732cacb54c3b 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -124,7 +124,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.offset = 0x200,
 		.irq_mask = 1 << 25,
 		.boost_up_coeff = 800,
-		.boost_down_coeff = 90,
+		.boost_down_coeff = 40,
 		.boost_up_threshold = 27,
 		.boost_down_threshold = 10,
 		.avg_dependency_threshold = 5 * KHZ,
-- 
2.23.0

