Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F3CECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017362084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIG2Les4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbfJORCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:02:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35037 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbfJORB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:01:59 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so15080510lfl.2;
        Tue, 15 Oct 2019 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mx03JaUQ9G9VpAUwSu0CjLskQfozJmwIlVovMAmKChM=;
        b=PIG2Les45wYklyfs/SVsxXfYiVm3RlxCFb6PPOZtF6Td2EJLhdXjxPbrvMcT+pxRHe
         2mz/C4H7igKZ0DaDmcPs9NlN0cu5KM7LYruGgeY4GNDGpMPNyKBDR/8MDLSWFAAEDeEj
         vXZea1pU0cMDqGB2CEcKIgafpjlz9pWJI1Ne1G1qY4/f8cTvDo1bL4OWMVRo4O1R7D7D
         YoPduTEM/6aIJAih3R61xYjWNoVpW77JxrTb5dKx70v8+tmWm4AHNVGspcjbKNfTwaNe
         Qsa4Wam05NxAeywoGk2/+D0GpU8t2pJywD1xlDlZnSyECbb46c9pexGynKvbTn1rvp8t
         4ysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mx03JaUQ9G9VpAUwSu0CjLskQfozJmwIlVovMAmKChM=;
        b=C6rGIyh/PBtyN6KgtF81x+w4I225HHurdeYKl/EJhoqoxKaj7uNVrrCG+r8sbSAGAg
         bqABmyYCI0a7jBfz3iknuKg4ROqjdGrP1ORffqTM8Ue1Qzsq7vVU98dMbLzZyBFmek4E
         Mv7kf2v5dywPzeqpfRyf0jTN/xiI5ge3WGuMiPSeElC+vBkjLLGLA1RF6JZY1y2u2VmN
         VufjPMVPm76Yj5kS2HUBKku0po4kRQsnXYz7uRl2Yt81ZyI9rhDvR8Lpk/2R0zeDXlFh
         oUNdbLClKNG44LQX4S19gyeneQ96CMplvjblwJ4gQsu7VdgZEakt0GV3ZcgSLpj36whG
         PORw==
X-Gm-Message-State: APjAAAWsh/Mzt75D2ZwcaL62vM6B0VJLPCMSe9jlqncAtyYwUoZehEZE
        OjqIsLdwq04ui3j7R9C0JQM=
X-Google-Smtp-Source: APXvYqxMxBYG20YAb0fGS9TNYIAzXvzBRSWDTBvLt0Guvr9miFOHDHZbOAnwwUO/6vaYt/HcZhnttQ==
X-Received: by 2002:a19:855:: with SMTP id 82mr2714520lfi.44.1571158916970;
        Tue, 15 Oct 2019 10:01:56 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/18] ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
Date:   Tue, 15 Oct 2019 20:00:14 +0300
Message-Id: <20191015170015.1135-18-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
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
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e039680d3c72..e15cc31aeaf3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -110,6 +110,7 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_TRUSTED_FOUNDATIONS=y
-- 
2.23.0

