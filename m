Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D856C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32972339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO0YvTYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfH2BrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:47:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34031 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfH2BrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:47:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so965313pfp.1;
        Wed, 28 Aug 2019 18:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ME3wO/9v2at3HWePbC02aNBPfV17xnOv4AE/KalXLkQ=;
        b=fO0YvTYqcX5Uc5/ogyV3fqZ/Ed1a1DxoEGLtzFMV0STGo9Q+He9nuv79G1wvGhsDcL
         ehMk6twbNbsANJbUcGkY/RVyxLuFfYRRsAtspIS8amwq9mKxnEfYLBG8YbQM3i7XMkMq
         EeEs6Fq3kKAVbnnJ1dPkZ5Yfj42TEpy6bAYX9YqYBK2Nm7c4Z3+PPUR2K9mLHk0GnXjO
         DGejn4DPgKk/jmX4Vl1CvBw3pU/6eD47bK72WIg9MqiIXwa6e/WR/MU2AAGznXz2l0p4
         E7VaErvmXvFaTSjgSXAl6uabM1K7kmdnBscrHjmH9Zu6LdhKN+R+QOAv0/XhYyail4qH
         oEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ME3wO/9v2at3HWePbC02aNBPfV17xnOv4AE/KalXLkQ=;
        b=Hh25PeoEYDCgXwavZzqg6i8a6lJzQLxUmyuYJn0/cizMm0/EKGrzxGgPxDYI9pud7D
         h9hh16k/BPv2Wu0E9uUJRNM7Uv0qY2Fkc4bssNIZ0vTm5jQ/7xlwT58tLiRcpJQ2Jcn/
         su5y2C7+XyC1w+Syf7eY5aBNwJGqnJYjDN5lS6GNfkr0saUMItdLJbZrX1XGy8qycKGL
         f/A9Ri0OdCgu2f20lAYWdrifdKere9cMOOoq+hVV0BHAA6UuPC+JZC3t8HNrVQGT3/H5
         EakCeYTi+zZT26pjC2hmIboZPNa6hba7OiH7qYyQwlXL75q1KeJfwBmUnr73z25Nep0t
         u8pg==
X-Gm-Message-State: APjAAAX/UwuKPoXuFGKuBNks8MEdgefCeoVnnEKgi0shuH6xMuc8r3GH
        ZNl7Ks2TNrofH7L5fiB+btc=
X-Google-Smtp-Source: APXvYqwzNt15f82giMrmdFKSgo9NImQPZPQeGGN95fyVmGMHGe1xse7R9Z3CqhpK5ETY1KRbhaDvAg==
X-Received: by 2002:a63:b46:: with SMTP id a6mr6140542pgl.235.1567043219664;
        Wed, 28 Aug 2019 18:46:59 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j10sm404548pjn.3.2019.08.28.18.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:46:58 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 0/5] a few fixes for sprd's sd host controller
Date:   Thu, 29 Aug 2019 09:46:40 +0800
Message-Id: <20190829014645.4479-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch-set, both sd card and mmc can be setup.  This patch-set was
verified on Unisoc's Whale2 and another mobile phone platform SC9863A.

Changes from v1:
- Added Reviewed-by and Tested-by of Baolin;
- Added fixes tag for all patches in this series.

Chunyan Zhang (5):
  mmc: sdhci-sprd: fixed incorrect clock divider
  mmc: sdhci-sprd: add get_ro hook function
  mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
  mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-sprd: clear the UHS-I modes read from registers

 drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
2.20.1

