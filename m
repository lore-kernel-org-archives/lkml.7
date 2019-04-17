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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD18C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3753B21902
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMWkuCWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfDQWjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:39:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32844 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:39:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so220234pgh.0;
        Wed, 17 Apr 2019 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hT2F8IjKIQoszn6Buk6j3BScSUALq9H2lCvIgZ7MA44=;
        b=nMWkuCWPEy6xYKGNLnQQZ2wVDGHklhg6yR+3Z9AOiIxqZwzSE/SJ7ugOYVcpODMCo1
         CoffGqPHSX6M40W37VklMFwsmrDvnSr11u8i3JJncfIAq02G3hkrW1MIDNCBEeymzdSO
         rc8cpqLIDDN6wqu01N0JGG6p6VpVx5TFVmxPolw+51jTVMzXGXtVfLddGjGUHOoJogRI
         1dvNd+Izp9Q8tgNYAZwIlXrzj5K7qo3TRKNr8HoSR1S2H074rWzOEZ391KkeoFEp2BHe
         94oeOAHb+tt0/wsPNej06r99G7qw7yoMn3OMrlm8uxCdoy1eCExoicq4Pz67oDDnfnCB
         ZOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hT2F8IjKIQoszn6Buk6j3BScSUALq9H2lCvIgZ7MA44=;
        b=XkkX/oKQXibHCCYecAgZD8gybHaDM8Rbj3Asb3V0gt/1lp2M49E4bGzFUXeULNV0Hz
         +4K40iLH9kzpEqhSjsZCm+lRj/yylps3tlfseq0jUdi4dm763wBbBpSqp0LBM9s5HA4o
         BRGVyFss6AYE7FIx31mKs9F78ydCMVDSg9osOx2tMmhnQTXhrHWlIusMErzLpPs5U/eg
         5h/1Yf21H5hJ6rM37mcRe9AcrFSC8sV9c9nTLbzSF4lUMrADQbc4GjOOS/oH/qjN7IvI
         NttZQ78v92pAjy9qzXlzsh0gIYP/HODLK2q4tDTnjq+ZB6Fgx4700PisS+AFi5Rx4cPX
         GSYA==
X-Gm-Message-State: APjAAAUIZp7I3G5wG6VcesEBhKg4/ddINkT+JbdsJsAKubnhi0NQeXXh
        2ou3/K160qHABFcXUaZjtfQ=
X-Google-Smtp-Source: APXvYqw/qkTcwNganclPa7L+waXlLyeek6AotB65mpl+0/MFZQZpqItmhFqEAnYG8x6gJc8zWzDb5A==
X-Received: by 2002:a65:6655:: with SMTP id z21mr49205781pgv.33.1555540470935;
        Wed, 17 Apr 2019 15:34:30 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 05/16] PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
Date:   Thu, 18 Apr 2019 01:29:14 +0300
Message-Id: <20190417222925.5815-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real benefit from doing so, hence let's drop that rate setting
for consistency.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index c7428c5eee23..24ec65556c39 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -653,8 +653,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	clk_set_rate(tegra->emc_clock, ULONG_MAX);
-
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
 	err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
 	if (err) {
-- 
2.21.0

