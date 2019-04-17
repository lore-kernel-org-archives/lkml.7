Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13C9217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFggYSzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbfDQWl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35817 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so218136pgf.2;
        Wed, 17 Apr 2019 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gSgxpoZvck6q57Fc1Ag09/Sll6e8T2kyeInAsQ6ito=;
        b=IFggYSzs8G7bxWUnIIOIIj21Eh1evC1LMf7z4nyyPoV81gbY3yXu4F0BClwO9GzbgH
         YPn2ZJ8s53zbtg0Fq9o4Zy2PugCEWSCWg4XGHMuZszYnfIA6RlamNzuxflUdcgGexdbF
         DcZxg16UdNatokBEz0fOIOp0BG2a8ElFTctPuFc8GHc407qYwZhs7zFoRKPQBRsGi0sx
         z6S/SeknBS69ziIz6LCjZp7+LGGWmQzF5G12w5ZrPbw0sSb0DlnuCcolk4jKmAFBW2iI
         x18zSzpvaroqgrWuIJoEMGNGizLRrNxD4Fm69439ZG2CVo6CAoMEmt/A0jTBhb6uJu0h
         jS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gSgxpoZvck6q57Fc1Ag09/Sll6e8T2kyeInAsQ6ito=;
        b=ccCKGU5jDpYbk2FRcGoM52lzrGNhvTU5hYIfZfArIOk4BL9u5iSKpPvVvPEMx1z2CV
         oUJbFU7hiuiYajTVBrFjdaTWIWf+sFruM7O0hW2ieFtdO5pOYA/pxrDBG78g1RVCN6p4
         zBBZBtiBlUlrqOr1XHLRjS9ZbciWMsEn9KVAyWZuRqTZ87DwTqPvRh448VdhlKbrhZhK
         ml48/DKLat7KhvMFA/XqkoW907dYSWnIKBd8z7rCqFYCj5BfJImlzk4cnL9NYG6bVDM+
         3NC0TCQqZ6CqhGhMpeQgDzG/nTf/cl5tVOFr2TIQtmgGAnaKhafJfy0/EwNYgINhbJfO
         z4YQ==
X-Gm-Message-State: APjAAAX0TT1bs1//69wnc/g0rtANxmPasyCtJUXHpHeVChYGjSCHvG9O
        yM8RCnVDJzG7j9+TmI3VoXo=
X-Google-Smtp-Source: APXvYqykeUB6eirz9G4egN4Ti2bhq0KETwXQb4JSVJ9+C9N0Y2UHGYBmzeGmjZHPuB48abZtPm9gXQ==
X-Received: by 2002:a62:204b:: with SMTP id g72mr90392624pfg.51.1555540443714;
        Wed, 17 Apr 2019 15:34:03 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 01/16] PM / devfreq: tegra: Fix kHz to Hz conversion
Date:   Thu, 18 Apr 2019 01:29:10 +0300
Message-Id: <20190417222925.5815-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kHz to Hz is incorrectly converted in a few places in the code,
this results in a wrong frequency being calculated because devfreq core
uses OPP frequencies that are given in Hz to clamp the rate, while
tegra-devfreq gives to the core value in kHz and then it also expects to
receive value in kHz from the core. In a result memory freq is always set
to a value which is close to ULONG_MAX because of the bug. Hence the EMC
frequency is always capped to the maximum and the driver doesn't do
anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
frequency scaling works properly now.

Cc: <stable@vger.kernel.org> # 4.14+
Tested-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c89ba7b834ff..43cd1233f87b 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -486,11 +486,11 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
-	unsigned long rate = *freq * KHZ;
+	unsigned long rate;
 
-	opp = devfreq_recommended_opp(dev, &rate, flags);
+	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
-		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
+		dev_err(dev, "Failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
 	}
 	rate = dev_pm_opp_get_freq(opp);
@@ -499,8 +499,6 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
-	*freq = rate;
-
 	return 0;
 }
 
@@ -510,7 +508,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
 	struct tegra_devfreq_device *actmon_dev;
 
-	stat->current_frequency = tegra->cur_freq;
+	stat->current_frequency = tegra->cur_freq * KHZ;
 
 	/* To be used by the tegra governor */
 	stat->private_data = tegra;
@@ -565,7 +563,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		target_freq = max(target_freq, dev->target_freq);
 	}
 
-	*freq = target_freq;
+	*freq = target_freq * KHZ;
 
 	return 0;
 }
-- 
2.21.0

