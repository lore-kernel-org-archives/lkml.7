Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4ACC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707720838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfsQfLg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfGORa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:30:29 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38938 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731881AbfGOR37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:29:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so11565319lfa.6;
        Mon, 15 Jul 2019 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sbsaF7E0TrDeiv6pReKgq+pMBX4p8SmM9uYJr655g4=;
        b=cfsQfLg6uXhCsDhKrfTKfo6Sq0gES7tIIKRYeUMeQPc11O2FFfbXTX6aotF8r2KSpj
         bQGuzhwGyMU7Klx8gsdATDAqcdQjnAAhfH0hkhBOwHt75sD9G+l41xQkUfmBLkrH2o9V
         7n+UNcnfa82X9rlHaRJTdDOZvrNPMv0ov6LNFSCRcqWNyYuYq+sDQ35md1Ra551cVtld
         yNGxmdoZTQFGxBEfRFvXBBN+Egl1SIDZJ1Jub+HSvJ/qRyHcpU8uWAltA2ZvO/k6ZpFV
         QgVWeT2LsIMU3PRFU1KXgIVrQOI3bnbuZDYTtEl0Km55ppFLwKHsHN+Nv6H/GTFGdxRv
         jmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sbsaF7E0TrDeiv6pReKgq+pMBX4p8SmM9uYJr655g4=;
        b=ucLLKEDi/icdTPqUXXMdwE+kUc/Ll3XPXhgasOll6fnHUyfvs1QrF8SSaI7NVX4dBc
         NhJAKca9rUorbK0tves36h2TKhEI5rM+mKaNrJqKSdcEXEmfUI0Sy/NnmMSIlbaTxeIN
         zhsGIB/nPRfhthn7t8XNhApPNmaxNhtXJW34bv7aqOevcnVera3a8+3rFAU2XkxYIil/
         WmKkNumEG6n7RiQAlLVQkoO0mDz6/GMltlMvXuxWeQ2QFq03pu5UmzbinPY7vTK8Ag8L
         2NArSZW5X1/yeVg63ZDeu5zwZBlXySrYb89Ghm8cxrp3LUWz7iiOs8cK0KP2YirE3qC2
         sG/Q==
X-Gm-Message-State: APjAAAVPOZzOfRFO4jTo1IdQDQYOxwCVp7x/Ldo417DX4gJGKJIyNvco
        1Hb+gWQfFj+Yu8mQg1UCpXA=
X-Google-Smtp-Source: APXvYqzh4mCzsVutjVh3P6kwpNAC6f14uhzoqQsZ8erj79ZbfueASsY+KQ7A1LZug29vsoABB/S3DA==
X-Received: by 2002:a19:8c08:: with SMTP id o8mr11940682lfd.57.1563211797598;
        Mon, 15 Jul 2019 10:29:57 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
Date:   Mon, 15 Jul 2019 20:26:29 +0300
Message-Id: <20190715172629.4437-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
it is now a proper platform driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 8f5c6a5b444c..9a2f11a780a8 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -25,6 +25,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.22.0

