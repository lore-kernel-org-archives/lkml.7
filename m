Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD36AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6962184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8t6Hiou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbfDQWlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43395 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so163609plp.10;
        Wed, 17 Apr 2019 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wI1Y30GzShQIq71Qmpx4lrEpWFmLVF7D2Tq0E543U/s=;
        b=b8t6HiouiwCTPb8TzfzulDQl83HhdDbCn6A7eTvNss7MmEBUTk1CRakMqZzq01eam8
         5q/ZOiwlGY7UYXhPT/j8pEV+rPf7N9zqR4JK3+h7dcDE+FWiBsBLOGbkUxG7sFE2e9aG
         7xCqqrN/D5s4Q6zl02LtKFCwTiVzFuHhnNOL56A3V1nvFXC4oYmxjU7/Na7RX2W5u9Ob
         HW/lg12A0aFe5DNym1EIMVPzsLlY/dvn3DpgzNJN37OWwz6bWy0yCdUvOex4mU8fHqu8
         vAGK4Gnj5Ri40RYLX2qbgf11Pf4FtCIxIpuBjRKjUswmWrtJCaJqFAO1bMlOrvvNKof/
         NsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wI1Y30GzShQIq71Qmpx4lrEpWFmLVF7D2Tq0E543U/s=;
        b=Bf9nAx5+j91kIyCpWjKhfam5FY1jZWPHXhpH2CCzSOII/HWt+x0KVhDSAWzYoiyz8k
         3KRg4yka0acAVcV8VCNzQcdTRCxAQfueWjLMZrj8VJg2ZkVtI9P69IrvprKO2L/V/pxC
         j8NCUvuh71h7zRy/qPH7+eNeovGMrrodZHek2Ve7UV1Ud3z8ZniyQdOaIiqM/S939LuP
         Cns3mOHFMCxsPbUKi+Zz93IMi1YuhccxvFjOfqK0hj4ZiAGEE+JgB0DVpvmU0RRhE5kE
         M3dH3BPS++t2WR3nP1KrBy5NsUzwaU+GBLejsU6kvBvAmouEJ8cOVrfxGql8jY8VcR9q
         7n3w==
X-Gm-Message-State: APjAAAXcD7HjKQIGewv0JT1ttF3uIL4GEkWM0VxvhGTbFUiDKaYcHpFd
        ndQeWpgAzJf6EJLqF2VmSn4=
X-Google-Smtp-Source: APXvYqyNvTpK/tL3ZSyPN7NxYDJWkUAKYB4uSXmmvnQr6oPf+JnU6CPycgxFPboLVmL0g7o8A4NcQg==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr92257864plz.101.1555540531587;
        Wed, 17 Apr 2019 15:35:31 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:35:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for the driver
Date:   Thu, 18 Apr 2019 01:29:23 +0300
Message-Id: <20190417222925.5815-15-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's compilation doesn't have any specific dependencies, hence
the COMPILE_TEST option can be supported in Kconfig.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 56db9dc05edb..a6bba6e1e7d9 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
 
 config ARM_TEGRA_DEVFREQ
 	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for the Tegra family of SoCs.
-- 
2.21.0

