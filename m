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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C169ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9220872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9AuvPk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfJORCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:02:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42135 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388477AbfJORBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:01:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so15062261lfg.9;
        Tue, 15 Oct 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGjmb/MNUm+G9U/DTi2/uDEoahkabTTfxcEHeZSx3QE=;
        b=g9AuvPk1TIOd9q5Gk7ZwrjT8qZf2kcjsPpk0T4MRH4FC9nDA/8nrAWV5+uOVX4n/Oh
         U2ayMVOBteVql7xCAFrw4t8lwrt5m9E6RI+I7/2chcxaLmP9URYSuadme0BFDAhVMlhj
         ca8Ub2KgsiV47AVlEEYv//cWxobBoJZKieKHJPUfiA1cjt8JfEtAhdYUUcKe6tK/z5hD
         EDSX4AMGnkrdbbKfM+oqGjIrnn9E/hsxKevKqx8Ylbt0bBAv9i2ekQ617uSaA9Y9U/iD
         CNLJmWGCvz3LgloPUeJ23FWYQe3c0ej5mahQhUz1EiR2mBr2Z596DzlNbnNYJnviJX3e
         s+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGjmb/MNUm+G9U/DTi2/uDEoahkabTTfxcEHeZSx3QE=;
        b=rYL9Yf6LxA8VfLU0pu5ld2kAEo4QXmE6FaHra+CMIFQ6FjN0yqYk0iHQP1i2jyBstl
         RNWGRVjXzuWUvnKLr8NicEgcOGDaBLSKI6x+zjdwQc8xhn2M02azuM323mjZjN5vyuCH
         CGZeArdA2h1rIvuM3S7IY3cFKC2QAnAjEIf7fV4At2PnsaS3dftATQ4Gsj0Hkrot4EWk
         7G8Xfce7d/wamA22MfJ3lqHwiWPj5+PYtBXyGZzotcror0Rr87yQaTX9dc2tBnUsXFVS
         xzAjrlu31ztcun0A3NcuHy4SEl7vFg0or4n3n26sNDTuO4beogOKpZVw8q1w5vYhpArt
         V8Jg==
X-Gm-Message-State: APjAAAWZL8v3L41b3SE3V7RpNxoeUy+ogw7HELYwKgrFbkYxiOPCduT1
        Zcld1bo49Rgcbh3U93Vf/MM=
X-Google-Smtp-Source: APXvYqzJLD+MPyOOk8yuZBxjglv6s8ujesc90gedmP7eEFf8v3gSUyESdgpGETsqe6EhKvS3AbHlrg==
X-Received: by 2002:ac2:44ae:: with SMTP id c14mr21275270lfm.116.1571158908279;
        Tue, 15 Oct 2019 10:01:48 -0700 (PDT)
Received: from localhost.localdomain ([94.29.10.250])
        by smtp.gmail.com with ESMTPSA id t6sm5144992ljd.102.2019.10.15.10.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:01:47 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/18] clk: tegra: Add missing stubs for the case of !CONFIG_PM_SLEEP
Date:   Tue, 15 Oct 2019 20:00:06 +0300
Message-Id: <20191015170015.1135-10-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new CPUIDLE driver uses the Tegra's CLK API and that driver won't
strictly depend on CONFIG_PM_SLEEP, hence add the required stubs in
order to allow compiling of the new driver with the CONFIG_PM_SLEEP=n.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/clk/tegra.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 6a7cbc3cfadc..2b1b35240074 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -108,6 +108,19 @@ static inline void tegra_cpu_clock_resume(void)
 
 	tegra_cpu_car_ops->resume();
 }
+#else
+static inline bool tegra_cpu_rail_off_ready(void)
+{
+	return false;
+}
+
+static inline void tegra_cpu_clock_suspend(void)
+{
+}
+
+static inline void tegra_cpu_clock_resume(void)
+{
+}
 #endif
 
 extern void tegra210_xusb_pll_hw_control_enable(void);
-- 
2.23.0

