Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D811CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6202070B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnvt7O4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfLCAmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:42:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45806 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfLCAmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:42:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id d20so1623106ljc.12;
        Mon, 02 Dec 2019 16:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAu8VzWG/+L0QpU5qi5zuwKYWMMJhtbx3vr03UqSLdU=;
        b=hnvt7O4ur4Gc5jo6tBCMQ+373oJLCfmF0wKSyvBVPRmGra49O/M0LW6eyOrOE/Qrgf
         qIfuGySay7GzP/LxO2BGO5KeLpJlUJvZs0MrNbCMckATerI1jaIbhiJMbATVmdFWiayG
         gGrcE4mY7pN2Ol5OjFSRAXhLPtbdbNC1DS1QXCefXWRtdVgvtZQ8FbfDgMnGMyugbRzc
         KhTCoraYdpLeGgM6aZxN4UfHmE77bKjAf4mqN2RWI5sSG4qoabVlF36t3c66Nhp1LpNi
         s2M2XL3uGo+IGHaj3XWhF8w7TngbDoRDtuLCDT5+xEQ+BGFGdpqRJCYkEDTj1RZB7Nuk
         0hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAu8VzWG/+L0QpU5qi5zuwKYWMMJhtbx3vr03UqSLdU=;
        b=Pg7zwT5l0m3DYADK+9FcT/WVujoT3N2gzK94dcN5lHvax/WEoTC9yjOdyTlAWKfV+3
         Yu59VSVId7s9khoCQ9qV0GvakP78MHJh3UqxtKAfXUwc2AJ09xFpeBDMwzhE4WN0WbnA
         3C2YO2TVOdqihEqGvbzqUKIsPkk8z6g6+Kg7ZHcxM7n7fW2GAwYvZcZlT4gvQc1Nkm5G
         cjqwOeI9Vyfs7tGH1kdrwvjFM0jjy1VxG0LvkMic/DV3P5pyiMt+AHuYImyT7kYoAtD9
         hfbrv1l/8VrQUgbH5I9k0MN/WuUzfA4B4rD1At9vezSGFOpC7QMgmva26ZpUMnk7BfBJ
         TUwA==
X-Gm-Message-State: APjAAAVtwtdESwa40CIaFOKglr9YnB/VHARewP2g1CNw0pEpPWwwRhtX
        kBVMbFHzPv0VGO2ejpdCvaA=
X-Google-Smtp-Source: APXvYqw9Io9lTNijDet9+E0yfZEj0NuyVytiKA1BHZLYA9S3gp5sr9w3N0StSAkPBMOmUd6kXXy6Fw==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr870450ljg.108.1575333739076;
        Mon, 02 Dec 2019 16:42:19 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y21sm456384ljm.25.2019.12.02.16.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:42:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 17/19] cpuidle: tegra: Disable CC6 state if LP2 unavailable
Date:   Tue,  3 Dec 2019 03:41:14 +0300
Message-Id: <20191203004116.11771-18-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LP2 suspending could be unavailable, for example if it is disabled in a
device-tree. CC6 cpuidle state won't work in that case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index bbd7999a3910..077ff15e32fb 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -31,6 +31,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/irq.h>
 #include <soc/tegra/pm.h>
+#include <soc/tegra/pmc.h>
 
 #include <asm/cpuidle.h>
 #include <asm/firmware.h>
@@ -325,6 +326,10 @@ static void tegra_cpuidle_setup_tegra114_c7_state(void)
 
 static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
+	/* LP2 could be disabled in device-tree */
+	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
+		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+
 	/*
 	 * Required suspend-resume functionality, which is provided by the
 	 * Tegra-arch core and PMC driver, is unavailable if PM-sleep option
-- 
2.24.0

