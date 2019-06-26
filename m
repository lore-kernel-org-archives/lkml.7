Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77416C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0B7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AklW2L6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfFZOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33927 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfFZOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so3096963wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrEC51agRNRESL/CxKm5Wt0sIDAE+3eNmgw8xbBiCeU=;
        b=AklW2L6ALoQqSVGAVlBzQswi1iBI2POuGTC91ZvEaUPyHS3o3RFH9VKw8CCth7NvZ6
         /idnsNFZpBNvQKF4OtvqjAxqlzKw5gLFOmmA0nbw5twOZjCtJrKHuwa0MUclae8RuwAv
         qsJhO3HbDlUcKZ/oH7W/0UHrMghJyVmqN0WU3cfp0N+LRUbXclVeQgoZ/IIo3KDhnfsf
         BO4y4RLf4fJD4b9Ny1P0xcgslloXeaJ0gQR3XqaGEJ1A0ioXzCrd2VJSMT5rUcIq7Lue
         /XfmkBC4jvyCWtJn1RszZDbqR6V4Tw3D8zbQJvlkL/ysjJcBSNOpr8Ps81zDAPj3ZvkU
         IXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rrEC51agRNRESL/CxKm5Wt0sIDAE+3eNmgw8xbBiCeU=;
        b=rdxhZumzYmrTIZ1M46X4jf2ahXTMmvKZ3djiYD0H/yqvo4Rj1yqIAVEaWsCepgA9xe
         AO/F+4HbVswTvZAVF7WFi1hEZH6FBdIK10VWboGmV/RhW2dFiMvH87oLRoBCkisOPVJ0
         4G/8LvU1H4sk23gv9LB1vDdJRKEG+p4SC9Jf70KOHeGiSzW2LbeSEn556njdPcF9ZhPq
         HX1P9T+/UT4918any6DxyDuIz+l8YBmTxk8Vs1kTZXlpwHBhBrTV/lsvLr8iD1KD3M3O
         +75iCPV6IXPra1jw+H4yfMzSdj/KQifHL0zCV7ATxVrrmpi1n5smFBeqlGBAFC65KpSu
         8LrQ==
X-Gm-Message-State: APjAAAXbQ2ZGpvvQGkuLOuCPmfjhRJW7GWKS9o3EqhZqOhhi79k3idKX
        jOAmaj8YFVHcRa8PGc3xqm0/3GoSE/4=
X-Google-Smtp-Source: APXvYqyiQxKEOR1Mf7nQ39jP61ZomTuAppAwtJlmocpq9C5VGmpwQM2YbR/zodtFNTOAWVidc/SJjA==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr3594627wrq.137.1561560449480;
        Wed, 26 Jun 2019 07:47:29 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH 11/25] clocksource/drivers/tegra: Support COMPILE_TEST universally
Date:   Wed, 26 Jun 2019 16:46:37 +0200
Message-Id: <20190626144651.16742-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

Remove build dependency on ARM for compile-testing to allow non-arch
specific build-bots (like Intel's test robot) to compile the driver and
report about problems.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3300739edce4..d17a347e813a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -140,7 +140,7 @@ config TEGRA_TIMER
 	bool "Tegra timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select TIMER_OF
-	depends on ARM || ARM64
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Enables support for the Tegra driver.
 
-- 
2.17.1

