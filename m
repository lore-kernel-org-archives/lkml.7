Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED78BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ABE20684
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siBSDH2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfFIT3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 15:29:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46564 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfFIT24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 15:28:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so1631642ljg.13;
        Sun, 09 Jun 2019 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jv3KwlfoUxJZX+aoCTlHRY+9L8Qx2HAqTMEwpIQvT3Y=;
        b=siBSDH2QgaRFAWmHQDfporl8KJMNRDM7n3XmL6XCBdYsQz6A1DYz3D0MAWLCQ3LlCH
         UCUlZce1OGR3aFcvJZODIp1tLF99XZy5vjfm99+cRaQ2vdCCwmh6Fasp4zNbr/tTiR2S
         8juOvxjI37RBqezIThZQH5JOCmGfyA90jSZAJY+Yd0TPzVQFV32VmAx0UExw+QgtRNtw
         PEmE/HQ5N1kJpso4iyiUtiMhab9jqfiaxibH5Wp5q9KrgODbeSniT5PgCy5C9THq4u7N
         OYOFny9+EyvTTLVR1uzg79of9HAGs3ZW0xaA08V295EtGUxikRHR2xc5zAUKiQ6jy8Zk
         LVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jv3KwlfoUxJZX+aoCTlHRY+9L8Qx2HAqTMEwpIQvT3Y=;
        b=ZwrpLqQwuF5kjf7kyjCky4r96U3Rj2yrjKIGpW1NQiwtM8uyLr0eo3jXsPnhYOqIWH
         h1xX5cQMavqvz0bLQ6leo/KtpHGcP6U4aAG7CTTrBb4vGLWNyODSA3rOaSoUH27fo0NP
         fYrQiqchzylx+1erbW30YBHxGn+JhO8Be8z2HVHpSmdfIFB/0tpb6EvhEerv9GntaZBT
         Br7f/cv8hzc5Nr8S0+HcYLh0928WIMhkHjxgtPjfCoHjmsAEbgjBQrAYkDv8aLMlkg/p
         XY3wYMJkicLAT7UYn6K3i1UNSMdCpfbuWvxZI+8LEV1ka8rfrrHQwjgrWyhTm7zCaM9J
         LTqw==
X-Gm-Message-State: APjAAAXadrd2HNaWx1du1UpQTtem9NGryDZETQMWJURCKVR8Ppym1WH2
        qf9o4ej7TT7Yc3a1d+5RqyQ=
X-Google-Smtp-Source: APXvYqxDEL0gtOO11ONO1i6R/EedBYUDLdHjtBIfljSDcCKFUvBvC8dsXylsfqO9DSKoUNaU2XgNyw==
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr18298119lja.208.1560108534650;
        Sun, 09 Jun 2019 12:28:54 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id e26sm1531685ljl.33.2019.06.09.12.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 12:28:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] clocksource/drivers/tegra: Drop unneeded typecasting in one place
Date:   Sun,  9 Jun 2019 22:27:30 +0300
Message-Id: <20190609192730.29459-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609192730.29459-1-digetx@gmail.com>
References: <20190609192730.29459-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to cast void because kernel allows to do that without
a warning message from a compiler.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 089c2f51ed40..c208908fa288 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -81,7 +81,7 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
 
 static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt = dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
 	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
-- 
2.21.0

