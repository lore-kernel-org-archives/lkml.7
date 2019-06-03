Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB667C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE9D26FD4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMrvAxcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFCTEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35871 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so14466181lfc.3;
        Mon, 03 Jun 2019 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtwYPIjZ42A6onEXbTjq/QuGswOItAJSTPwR+apDGiY=;
        b=sMrvAxcYfXNUviEHEnCtvKgFVE836xKMCpUXm73t5lOkP5xUvKxgb5/vk75z0Sjajo
         5krxgUniGjRrd/KPOmOD8i+pXAoaMGMd+63f99E4Ebe1QpxRQ7TT91KZATx2+aT2kAzL
         ke0VDy4NjLHdCQ3m5iBEgswbHThd8+p2Lqk8FDX98kJCeBN7OHpBy2bm40vzWY4jRDgY
         EPtlZw7svD1ZzInc22n5kGwVpG+Jdmu0v9k9+8EeUwUNRmem8oSzlSF4rsKGqQudCoKA
         jwWyT4ZorP4SuWRCUaTCA4WVXP9iVmLTS0hMj6c2RLt8feNYuRcZGiid/Fvj32G5E9ZD
         q8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtwYPIjZ42A6onEXbTjq/QuGswOItAJSTPwR+apDGiY=;
        b=FV9ZIMl/+uO7AHvm48oQ50XZeD2QRzefiYtTorCsW81pqJwqS0MfllYSEhhWesJUk+
         Y/Un/TRvYDA+60mBA28suk9tMSHwRDqu2P+Z05OyXf3AAvr2KXMA8X0V7pp3lx4ihatJ
         tn2255Z9NGD00JBeUsoyvsbOZaH7Hub7JqTvbbSssxVhilH7su/1+sPdAJWZp5s5Pznk
         xOdJodcXT4W/AKvsU38XXGqM6j8GJeX1exWT7EShMFE/LBjnEg+UabA0QD9nrdgk9qYB
         WphCWK6ijxHlqdv0mi/oI5BCM83GkCVvbvfeSN9583BlRdpVB5NbWFZkU2NJWEd2alJs
         qytg==
X-Gm-Message-State: APjAAAWzIDKHisLB6gNsVz1teSEE4UXh+x5dhtA3W/71QQw51ZVUS6mS
        DR1zPIe9ONHGnl0LpT0oDOQeUxo5
X-Google-Smtp-Source: APXvYqzqzLCtVGr7EitdsLEfbcc9TA3vFm+FQ8dUIaK97cWDR55QlhwCkEm47jV09PlMx00U/VkVHg==
X-Received: by 2002:ac2:5922:: with SMTP id v2mr14401591lfi.180.1559588665943;
        Mon, 03 Jun 2019 12:04:25 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:25 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/10] clocksource/drivers/tegra: Rename timer-tegra20.c to timer-tegra.c
Date:   Mon,  3 Jun 2019 21:59:48 +0300
Message-Id: <20190603185948.30438-11-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename driver's source file to better reflect that it's not specific to
older SoC generations.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/Makefile                           | 2 +-
 drivers/clocksource/{timer-tegra20.c => timer-tegra.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{timer-tegra20.c => timer-tegra.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 236858fa7fbf..4145b21eaed3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
-obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
+obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+= bcm_kona_timer.o
diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra.c
similarity index 100%
rename from drivers/clocksource/timer-tegra20.c
rename to drivers/clocksource/timer-tegra.c
-- 
2.21.0

