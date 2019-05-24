Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFE1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C1E217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8r+dL8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbfEXPfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:35:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36123 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390164AbfEXPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:35:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id z1so3567386ljb.3;
        Fri, 24 May 2019 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=618TV7pnajoPuI0PqJ6tVBxH02eKydMCb/CmuPQTTi8=;
        b=R8r+dL8r1uz0xwtFfXDEYu04D2f3z1VB8OQWnFdXa8QD3rVCiljKLx7ayuq1ICOSPg
         TSuVQ6ItehIHbkqzYTCcKmgm30kcE6qJMiKqo53D1v7AFbFfGMlW3wW4DshIPSW6Y4el
         ItLeGlgiH8oRrnNm9LISBDx6/VlbeZSPl8iWOy6H3bO5a6/d6D2fE9OMLkNn6XtufwSw
         3v/LmS4iFhBI8kUUs23py7apaLQu+eQASBGq06gkFyyXnCERSdSuAm+vHY9gwfNVt0b/
         x7y89HUc1UlfXcGorGrV281aX5k30W/oRKaXcgy2md2kJ9XN6zFdog+lQaCW8X2wXhNf
         fEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=618TV7pnajoPuI0PqJ6tVBxH02eKydMCb/CmuPQTTi8=;
        b=DqiISh0xYK/T2SaguL51RBuH9Mhxstpdammf6T6tGrhTIRhjtB59vPfnJrsHWzlOgn
         S4Xssqyg3iR6H7ZLybiz5lk9mrKmgsT5XobWVhn98RcdJ+0YxfEqZ55fS53/lylOzozS
         Hv/Cquf2gB/iE9YeC3DtlqaHvyy6cnqDdI3U0Au7BENwLvtIRyqaVdypnS/icSYehXsD
         YgUbIWMVDaKrHHG+NLDo9dUsho7pbSwYa67/ERzzyJPargH2oiWHeGRxx0iG1BxfXJSb
         OGBbs6iiPQjVd3X71v8pVXQIQT82dqmLP6DXCWzgDrWlPAeQRbtp5g0zSp/kJju91bq8
         Oozg==
X-Gm-Message-State: APjAAAWXlfQIO411xwS3IqtbjvoII2qvrm6ydLqfaul7boxNrQHmmMzm
        j773/K5ars5PDOgou8GYHoI=
X-Google-Smtp-Source: APXvYqydJE4Azb7Jl0po0NVqBkXSHCKV0s5gl49jeSg/2C4U0fQLq270oliOBKMRuCTSYxnPORMj2w==
X-Received: by 2002:a2e:818b:: with SMTP id e11mr52951042ljg.82.1558712134287;
        Fri, 24 May 2019 08:35:34 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id y14sm572316ljh.60.2019.05.24.08.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:35:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: [PATCH v3 8/8] clocksource/drivers/tegra: Support COMPILE_TEST universally
Date:   Fri, 24 May 2019 18:32:53 +0300
Message-Id: <20190524153253.28564-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524153253.28564-1-digetx@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove build dependency on ARM for compile-testing to allow non-arch
specific build-bots (like Intel's test robot) to compile the driver and
report about problems.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3300739edce4..8c21e557181b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -137,10 +137,10 @@ config SUN5I_HSTIMER
 	  Enables support the Sun5i timer.
 
 config TEGRA_TIMER
-	bool "Tegra timer driver" if COMPILE_TEST
+	bool "Tegra timer driver"
 	select CLKSRC_MMIO
 	select TIMER_OF
-	depends on ARM || ARM64
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Enables support for the Tegra driver.
 
-- 
2.21.0

