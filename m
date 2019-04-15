Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB8C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA3F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czVmYOou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfDOOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46920 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbfDOOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so4406030lfj.13;
        Mon, 15 Apr 2019 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vb5aKDrshoN/AsERjs9oArk+gZDepbjo8hgOV69FmyQ=;
        b=czVmYOouenoz7kyLQ/xzLM2TMkDlbUR2oSjA8nTbIpQkSys6vvoo2ka0tq8AcMcHuW
         c75nDGcefIXDbb83LX1WHdJAKxFZpmiEyUbUUbthBINCzndWfyUfJm6jHPXSvdV1U3bp
         Ra4mNXHOO0N+JF323Km1/raFzlNTT4BPtyEpmze+clulOgB7WIr9+8NWGzsAH+44pgEj
         LM2ol2e/+zGbGoFaqvgmVv98cChmiXTWBM4r9ibEHaPg/I1ob69g4MDdkrbBADrVLnAh
         PH9CLpDmZ7D9YpDFWNHkiF4asMMUr0Lo1oMbfdmImMPd5fcElGAVAwBJZR5K7ueMcop+
         BuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vb5aKDrshoN/AsERjs9oArk+gZDepbjo8hgOV69FmyQ=;
        b=pALHjBMQ5ycv9ZoLQn1QnGr0Tepp0LCdSZCM+r983edKH+xAaNYDhe4rgv843V+yao
         f1rx2fhlx7bH1+p5fE9hP7V2XXgDTL4HHNgtkvECR0+CiTFPR8WH+ShbK49YwkMKmdik
         2kfNeh6Jwa2vvsbG47P4iPc75wpW36j+TPwnqHMEebBex9mjZ7USXMpyfqNlXp05IwEJ
         72YgUsBLHi0pI+INQIZmYcyjgcgDvg3DqfnJwmteQumpeaxvLdnNUZRZJLFEg5NqrmhB
         G9kr1hvIeVahevf5+Zt1iz7konLEXLE337pdZfkrMjWh67TR/smHYfeQT0eDvqPm0WML
         PRWA==
X-Gm-Message-State: APjAAAVb+nmLicctm46AvBcKTs/NHSiYv3u/YYqofHKrBChxXtE9RRtC
        66knmv6rOqnKE/F24HGwm14=
X-Google-Smtp-Source: APXvYqycYgYjwaH8ozMlI+luULH0EHgG6Yavyf6/wvkvChmg2K17n1kaItbgXkjllJDtadhy6/qMvg==
X-Received: by 2002:ac2:558d:: with SMTP id v13mr2960397lfg.76.1555340139178;
        Mon, 15 Apr 2019 07:55:39 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 04/19] PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
Date:   Mon, 15 Apr 2019 17:54:50 +0300
Message-Id: <20190415145505.18397-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real benefit from doing so, hence let's drop that rate setting
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 69581c9082d4..d62fb1b0d9bb 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -648,8 +648,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	clk_set_rate(tegra->emc_clock, ULONG_MAX);
-
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
 	if (err) {
-- 
2.21.0

