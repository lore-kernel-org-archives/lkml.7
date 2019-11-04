Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA603CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF0D2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPmK3Wwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfKDWCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:02:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44170 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389013AbfKDWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:01:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so13275924ljl.11;
        Mon, 04 Nov 2019 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEkd1uvkkWbvfMLb/tdCjEiVi+fwjLHzsak9MQmCC0U=;
        b=tPmK3WwdAIzZseaX/DBHUkRlYdAmHh1JRCDYGXZNGDn4wBYutuDkWNRBUS9BhKkN7n
         MnNfGlxJnLxYZsKsAok/igXZC6NuVTQIQBXGTrSSWPbkwnTtO0Su9bTVpJlKHOXlt1l1
         30xjp4ZWV4Dhb5UicCjknuJHch1Ym9E6PtchvS7rRmRAp8B9+UGk3wVuK/0QA/4pB+f5
         4+mXWav6FRCwjliXuTPIFfmEoxD1gJoPvY9uLI1LFxPlP4cTkf30C6ma7LIFMzOEsugq
         2QGzfcF4i+zg8ktcU/rxrhp3lLswrj0nDOOuojuuUVIb2JlfxevHfugA+H3LfgR/w5nD
         3QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEkd1uvkkWbvfMLb/tdCjEiVi+fwjLHzsak9MQmCC0U=;
        b=cSXQWn+EV5bngPAJa2RVa8eOukg8BEnfEEmrhM6pth3IZ5VCpALlsy2l15UTJEeZQg
         5iYOojCTtns2UcYbb+AnosviaVXz/gyd24ZaGyW1iweB/mzx3fGvrs1C/4y7mIDq9gTL
         ulJpfxCcuxzNTVVUGXZMSwCyMvuxTPJo8B9x4FrLLdzw/JbBagQGNR6OXmYl/Q0Aocgs
         yayBuYHQB251VUYGtuYK6XSFiQtYIp0YnlC/HP5ZhoaW5RQnNe3O3hSddffk3hadDzpt
         Wx9n07hx+PD7eqxLY4J9eDk7nt5I6L2pnmaPLVj3D2MQAWUnSDPy0ch9ubN5z3UmdsLU
         peDA==
X-Gm-Message-State: APjAAAUDGAZHVaB32/J4QJzlBfIQD3AFinPdVVkENIQ1gTGjXDKt0N88
        TcVEACpoiokys1QXOTmm9xo=
X-Google-Smtp-Source: APXvYqyxCGCqD24misPX/q6DQpFN9t3rDI+tPGV7qA2M4uDJW9MLxVgQo5Iv87hvkxmR/KaoGV2DSg==
X-Received: by 2002:a2e:7310:: with SMTP id o16mr18017588ljc.210.1572904876742;
        Mon, 04 Nov 2019 14:01:16 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 18/19] PM / devfreq: tegra30: Tune up MCCPU boost-down coefficient
Date:   Tue,  5 Nov 2019 00:56:16 +0300
Message-Id: <20191104215617.25544-19-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCCPU boosts up very aggressively by 800% and boosts down very mildly by
10%. This doesn't work well when system is idling because the very slow
de-boosting results in lots of consecutive-down interrupts, in result
memory stays clocked high and CPU doesn't enter deepest idling state
instead of keeping memory at lowest freq and having CPU cluster turned
off. A more faster de-boosting fixes the case of idling system and doesn't
affect the case of an active system.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e44f1a48f838..0b65f89d74d5 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -124,7 +124,7 @@ static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 		.offset = 0x200,
 		.irq_mask = 1 << 25,
 		.boost_up_coeff = 800,
-		.boost_down_coeff = 90,
+		.boost_down_coeff = 40,
 		.boost_up_threshold = 27,
 		.boost_down_threshold = 10,
 		.avg_dependency_threshold = 16000, /* 16MHz in kHz units */
-- 
2.23.0

