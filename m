Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A5C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965FD266D2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k60Bppei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFCX76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:59:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33842 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFCX74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:59:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so17952368ljg.1;
        Mon, 03 Jun 2019 16:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqThuczxsFCFZkur6KJWulLtapQL3gTUFJ19FHZKV/o=;
        b=k60BppeiYDGXr/8cw+/i6gkMEieMA2oxCh1gkK1trnjKkspsRnaKfvmPqipDEgnTA2
         2TZZ9Wcx/jW2UVgOiqXwCw5unpugyMSAw6WP/ZWXwkIC94g2GC5g5NeYgIVJo7MSfHdR
         zsRvFeyaCii996hORHMYQy9iycJQdT1NWHoqRTz7T/d4D+WVVJE1HMaWkQVkEcd8QVIo
         PZuuygF2rviX2H7R2XOQSpCSputKJN0LbHVdwxixqQ5SU3ww152P+89My2E4GAjj3PVQ
         a76Xubr70QY9BwDkgrJcO9onIyMKIueQl/qCD0v/0SaPcv/hPEGIaU61rJQBNA0CDqEH
         r61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqThuczxsFCFZkur6KJWulLtapQL3gTUFJ19FHZKV/o=;
        b=WK9p+XjJ8WvNJ1/tRvKmrrj9GtKO0jbWyeyyECCkXiEiYQamI+Lu6rAnPu465Z98ae
         dFLuORCgSkaeVYy977ZvG9Lvh1OP3xf+dtmppt/WSsFBtGj9jfJ4HmTAXhuJ/q0QM7ZD
         KOilU6H9Dsv6KrzNRNG3pVZ8WWkmFYJmR89xv89ieIoA7FHvauHE9MEL+IQBAamZVwhR
         ofdoPtiWzkVXZAecaz+D6Hgauog47i5+SWVhWiBsl5iwz3AwDFNBw+nGlOAlPSg1D8O0
         nx31cVBBxMu6M/xYsXMi5Kiy3Ez93vrQH4eeESA0iDEVgTE8wNspHTZO/imJ1GDNgZL3
         z/8A==
X-Gm-Message-State: APjAAAXjU4KwZQ6Vyv38FIEoa8hsKCa3Htn0oNbsMaVXKQs1TeVdCwuE
        i0i44dqwjYoTJ6ZYJBpGJVX2zWwv
X-Google-Smtp-Source: APXvYqzxU1L91s+nF+uTkI7ljYxKi2yCXevqHFfyfItOv22SYfRFYnL/+HnPWuILbGwhaOdwnYWkLQ==
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr15666110ljg.139.1559606393627;
        Mon, 03 Jun 2019 16:59:53 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id n7sm2943151lfi.68.2019.06.03.16.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:59:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] regulator: core: Don't attach generic coupler to Tegra SoC regulators
Date:   Tue,  4 Jun 2019 02:59:02 +0300
Message-Id: <20190603235904.19097-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603235904.19097-1-digetx@gmail.com>
References: <20190603235904.19097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today generic coupler can't handle regulators coupling that is specific to
NVIDIA Tegra SoC's, hence don't allow generic coupler to attach to those
regulators. Later on it should be possible to switch at least Tegra20 to a
generic coupler, once all prerequisite bits will get resolved in upstream
(voltage management support by all drivers, etc).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5a5b86d3edfb..68cccaf2e8f2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4866,6 +4866,16 @@ static int regulator_init_coupling(struct regulator_dev *rdev)
 static int generic_coupler_attach(struct regulator_coupler *coupler,
 				  struct regulator_dev *rdev)
 {
+	/*
+	 * Generic coupler isn't suitable for NVIVIA Tegra SoC's, at least
+	 * for now. Hence filter out the unwanted regulators as they shall be
+	 * managed by a platform-specific coupler.
+	 */
+	if (of_property_read_bool(rdev->dev.of_node, "tegra-core-regulator") ||
+	    of_property_read_bool(rdev->dev.of_node, "tegra-rtc-regulator") ||
+	    of_property_read_bool(rdev->dev.of_node, "tegra-cpu-regulator"))
+		return -EPERM;
+
 	return 0;
 }
 
-- 
2.21.0

