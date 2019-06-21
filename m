Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78D62089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVvpyVBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfFUGMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:12:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42506 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUGMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:12:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so3014153pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hc7LlnhYKlripj8xIjUSqdLS+0TxDwaADDzz2U0auf4=;
        b=zVvpyVBj1fJ344KOE4nUWG+7s5KWzpfOGopnV2cFnegqyPWrCuMoxxX5v9HH9Z5msi
         N+J6AD7cAuJIKQSVYE4eCOBxlRNxKKlEfoKXWCdtKYRLsKnaFQGQhfcaPOo4UKJVgZgK
         YLlilwII4SMLYxedxWDej8qvRFt9apfjzAZ5YWe8JdxKcqQzRCWNFlC8WpUSUJNerk9s
         87e4tSDIkvdWO0XeezqDlD/2W8YEFn/gCClGB6eAmReP+Mjb/ECtelZA9y3w8YukhTzX
         PGGG/3c8JxaIjGdLnwQnIfiP5eo8MTaf6AQDcw9BJ/b4GAS6IhnLQLehh+TOV9g30aSz
         OPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hc7LlnhYKlripj8xIjUSqdLS+0TxDwaADDzz2U0auf4=;
        b=uir5GbOcH/sm8MC59lwMtgpK/bmX3H3Q+ZgQY6pPfO+wyzVVenCnYDL8Vv4eOnlTAj
         nkcsB7YJW55xcx/6svTM9OQD4Tm84wzb0wGpnqP3Dn0JXDQYEYbmWm5Q03tahTiqq3WB
         Tlv+RBSowpfcZTiSNeasRejPeV5IT06yrEMdXkzsHe9m6DyrWUP2RIdjgPTfVkpPV5Tq
         uWvUr7u+45ktaBQH4n04XUuOVZ7glt6RkbDV58OsQXizvmQraTfquUXSQrUQ/27Xl9d2
         iIxfirNdYEOaU+U8D8TnjVl7Dfu+MgPnBgBnD9AZ/YUuL4LNXMpBFVObXb7PPUiz0uFT
         9kMw==
X-Gm-Message-State: APjAAAXfviqa3+6O5w1jIMwOpuSZ5TKRHVz8xjLCiAk3O4tciSBsYYYJ
        0uqo7hBm4DQb2ASFwqXNpLJtCw==
X-Google-Smtp-Source: APXvYqz+VB2OyxZohTciMXy6FWLRoUom4/hSeT25jg2KnM8hP9F1uMaTXlETllBlDuISal0kQwrtzA==
X-Received: by 2002:a63:3d0f:: with SMTP id k15mr16737667pga.343.1561097570369;
        Thu, 20 Jun 2019 23:12:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm1266134pfm.82.2019.06.20.23.12.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:12:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] Optimize voltage switch for the SD controller
Date:   Fri, 21 Jun 2019 14:12:30 +0800
Message-Id: <cover.1561094029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is used to optimize voltage switch for the
Spreadtrum SD host controller.

Any comments are welcome. Thanks.

Baolin Wang (3):
  mmc: sdhci-sprd: Add start_signal_voltage_switch ops
  dt-bindings: mmc: sprd: Add pinctrl support
  mmc: sdhci-sprd: Add pin control support for voltage switch

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    7 ++
 drivers/mmc/host/sdhci-sprd.c                      |   78 ++++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
1.7.9.5

