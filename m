Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D818EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A882521850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZn5atac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbfDQWll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35803 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so147229pfh.2;
        Wed, 17 Apr 2019 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XEK6Pvi3zB6H8VfU96ClgLVU6pHyUCojM/czvj15Lo=;
        b=RZn5atacQWnTfP+DZ829vuRvEG0BlvCymGCZM1SyV3GB+OCHkkuzq/VENl3awp7phK
         lv93zs8Rvu05pV/MqgAhhnT5gmQqHut5u2tTP+BbBv7q/UnuP4TknyRB8le6ypD0gtmW
         xddOyqcp/bfeYOSZMgKta4+PFxLx8oD0uOsDmqb5u7qy6+8fws6tpNHo6Eall2i/GXAv
         cxxmIH5ZErS6hFuQsuFrcZzwhIttCHPzgovkgefPVP1Hk4x9nleCcr/0ut8kCzuXtiMV
         SgyGCgGowgpGdvll/JQ2O90mnlSmiCcvQan/aehhhbdw7wgAFI/4UYaJoFLA2x+6MgPL
         bFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XEK6Pvi3zB6H8VfU96ClgLVU6pHyUCojM/czvj15Lo=;
        b=BTQw32KF3Xah2pp9EpSAkRw+8L6RERaPyVhu0LuwC5axdcrA0JSTXJQega/QJnu5gX
         0ZeSf3h66bz76azR+k6DX+GRbeUHd4V292T1P01cnz0zsCIuTET5m/Yoi86L7UfEFOp7
         YB+rEqJqI+jqVdrkwJ9azlRiPQWi6MEGx4fuqP/MSvumbFwdqmasZ9qHMQbGTaIar24O
         4mnuqZ01MRzNjgM/knGBMJlj1UcOS189tZUcic6f/Olurry47y75xbz532HNfyZ362RS
         l2lKTOrUFZ7qF6wIna9spz7SfzgLAkNuI+OKJJWALyMR1j8CPn531GFzm/ImAUEdBmqM
         VgUA==
X-Gm-Message-State: APjAAAVGD50Cb/OHX3zMG2cN6aQq3uMuPSh2PqQ/JN574akO2c3PwXGi
        sgsZrSWc8L4zUUj5I6ub4oE=
X-Google-Smtp-Source: APXvYqw6SZVmZDHQnbEW8jS+B9in9NK6LXGkGvMkr2K8pqGnrEanq+es0SX8zXXzIL8XSatPVohwXQ==
X-Received: by 2002:a63:cc0b:: with SMTP id x11mr68565422pgf.35.1555540538443;
        Wed, 17 Apr 2019 15:35:38 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:35:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 15/16] PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
Date:   Thu, 18 Apr 2019 01:29:24 +0300
Message-Id: <20190417222925.5815-16-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reflect that driver serves NVIDIA Tegra30 and later SoC
generations, let's rename the driver's source file to "tegra30-devfreq.c".
This will make driver files to look more consistent after addition of a
driver for Tegra20.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/Makefile                               | 2 +-
 drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (100%)

diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d3f12c..47e5aeeebfd1 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
-obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
similarity index 100%
rename from drivers/devfreq/tegra-devfreq.c
rename to drivers/devfreq/tegra30-devfreq.c
-- 
2.21.0

