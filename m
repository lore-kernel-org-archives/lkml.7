Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB202C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4F227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKW5BRmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfLRUWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:22:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42269 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfLRUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:22:11 -0500
Received: by mail-lj1-f193.google.com with SMTP id e28so3579914ljo.9;
        Wed, 18 Dec 2019 12:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LVP+iyn0/XBlD8Ke7JIDAuwMPawO+EOabRpPUVKvwY=;
        b=NKW5BRmTUsj8VqgwQfQ6bEVAwVRxd47UgnYDw632pjWprF9XhIR0joM6Dk5bdNoSv5
         Y6yTjL8uJxZOaIBkr1lklmaF70wuhQ3UQX1xLDH69QHaIKHMEYYMrvQ4ToY2KMwWfqmn
         MUWblNu4SX/7BQRdedctg7G7q+msTJlDwwzGr1Xe3R43eywBQ69O7qDdqN9hGikjoBCA
         zbA0O9N39ENAwbWdccgxHOE4XSEgoUNNAMPGKkV65sODBq1lUKjs2LRdrqzV9Zky9AbM
         TMT87N4ZpshQcxvGDVzXCMTIhzhG1zoLYgBHiHbc57AYtrlr3zB4sO+QVa4ZITI0Skyj
         YYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LVP+iyn0/XBlD8Ke7JIDAuwMPawO+EOabRpPUVKvwY=;
        b=rajprKFBcJTBb0n9kgqg9wFXSLQ6ESCBVs7W7fFaoaDl8DYURmkt6OolIJatVLRLhC
         Gnxgak6I7428777nfaCwgf7KQYbIQlk+ULkrhUm8wi9gI4ommjccn4R1ibgJbfR2HpBp
         gTf3ijatdd9dNZDOInyN1Qpqmt2FiUXjQiRuPJAh29uGuj9+cz9ow7Mz/6KNRojs+Od2
         TuDYuGtD+bwnfkJBBX6SgqBLZ4PpHhRG3+r1yAavbxscTwwyq4X4YXeQ4KuXxwcp/Gy9
         3vFGQ+qI51nOekayc80F84VxR/8cyXT0F1r8XTxxj9qgBYdiU4OS4lpkRyiguH0+7ATy
         UyUA==
X-Gm-Message-State: APjAAAVxCTC2br4+ZyFIyodGRqSv7giy5b2x95arDdgtdI39NioRZdOr
        TFeYyr6cOH1g9dxbOpS3als=
X-Google-Smtp-Source: APXvYqzHMyiuwsN2Eme46cqdi8wdMs9EmVAvUMDfxsClyqq1IcMCGxcMqjwczR05MoSmVvp96BI0aw==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr3166213ljj.243.1576700528802;
        Wed, 18 Dec 2019 12:22:08 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m15sm1766993ljg.4.2019.12.18.12.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:22:08 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/12] ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
Date:   Wed, 18 Dec 2019 23:21:40 +0300
Message-Id: <20191218202142.11717-11-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra20-cpufreq now instantiates cpufreq-dt and Tegra30 is fully
supported by that driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e512e606eabd..1e3b85923ca3 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -95,6 +95,10 @@ static void __init tegra_dt_init_late(void)
 	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
 	    of_machine_is_compatible("nvidia,tegra20"))
 		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
+
+	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
 }
 
 static const char * const tegra_dt_board_compat[] = {
-- 
2.24.0

