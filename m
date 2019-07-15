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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE74C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2A8206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCDCTz4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfGOR34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:29:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33991 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbfGOR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:29:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so17128846ljg.1;
        Mon, 15 Jul 2019 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDvoYJijQDj0e5NVUU9jZaC+GnZsfGAQXtnAmVIR6ZQ=;
        b=vCDCTz4k6ibrzwfwNdeN+QpnCYvtQK66tnraZCMhEnIysb+LegW/a5Uc64VRj4SaU2
         8Guoou6qyCgc364/AgBeS6Oj9/PRUt5lhi/C25kV5E0jZ+2IWfgGw91u0PBTrWXDwjcn
         aMaOOvwW+PYPX8vhhpxRw0TjW8cIRyHVj51xe3ZaS3GrLIVwWM5U23xNq87CH+y0cycH
         r5arqIdqvAClhNL9WNLnllouWyl3JNkQA9RJ/go+uJuFtoVaSYxubNenlPueb1o7WW/W
         swt5B/PhZC8orVlaNFvTw8M8gH4f2SSveJtKIypnEOXWMeWuGzbCJtzjT/BTtJJhk7Cf
         8SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDvoYJijQDj0e5NVUU9jZaC+GnZsfGAQXtnAmVIR6ZQ=;
        b=RYl+imMH1buzi1WCdqJJGcba9OtM04tanHnFR2pHBdgdUS1YQBjLTjmVHQ2rSwg7dA
         p6zuLdZJprSuafkZNSVNqD25fwsuUfM5vtYk/DwwmaMClKmHbui7NX+KXOCAXKaxncbH
         QzrjF1Ez/sCSq3DCePRKf5OclEHu04QqObixSYQZJNYAnlOOQ1XiPcj6/XaXdY/wWgiq
         eXxt+S968U8+k3pIkQI8wixx96pS0uEhKz0Or23QXBN8QGGlU5W1w3AV0XHmOt3PfA1n
         baqK0nMDqyqpGft3x3Pdkb39mlQh45gHYz7Jy8qK3kVKng900WRSYbHVr0pkv2CYBi2h
         33rA==
X-Gm-Message-State: APjAAAW1msrPlLHk/XgJYrAOGvYZW6fLOac3e9WQkbksj5OfCCwASmCI
        Y1o/ovrjcq9RjS4YjkQcaFM=
X-Google-Smtp-Source: APXvYqzGgMxupCB4y5ESBKTMjENgc8s/BGZx9EIFl4ilpmAfr/qequ4G3zvviFCti3oOxbKWcNwAcQ==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr14325712ljw.76.1563211788725;
        Mon, 15 Jul 2019 10:29:48 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id b17sm3248765ljf.34.2019.07.15.10.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:29:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] ARM: tegra: Compile sleep-tegra20/30.S unconditionally
Date:   Mon, 15 Jul 2019 20:26:20 +0300
Message-Id: <20190715172629.4437-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715172629.4437-1-digetx@gmail.com>
References: <20190715172629.4437-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sleep-tegra*.S provides functionality required for suspend/resume
and CPU hotplugging. The new unified CPUIDLE driver will support multiple
hardware generations starting from Terga20 and ending with Tegra124, the
driver will utilize functions that are provided by the assembly and thus
it is cleaner to compile that code without any build-dependencies in order
to avoid churning with #ifdef's.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/Makefile | 10 ++++------
 arch/arm/mach-tegra/sleep.h  |  2 --
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 5d93a0b36866..3bb44246d928 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,16 +8,14 @@ obj-y					+= reset.o
 obj-y					+= reset-handler.o
 obj-y					+= sleep.o
 obj-y					+= tegra.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
+obj-y					+= sleep-tegra20.o
+obj-y					+= sleep-tegra30.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pm-tegra20.o
+obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pm-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= pm-tegra30.o
-obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index d219872b7546..4978def9db46 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -118,10 +118,8 @@ void tegra_resume(void);
 int tegra_sleep_cpu_finish(unsigned long);
 void tegra_disable_clean_inv_dcache(u32 flag);
 
-#ifdef CONFIG_HOTPLUG_CPU
 void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
-#endif
 
 void tegra20_tear_down_cpu(void);
 int tegra30_sleep_cpu_secondary_finish(unsigned long);
-- 
2.22.0

