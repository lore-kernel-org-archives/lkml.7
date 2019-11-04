Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE58E214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnd4hIvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbfKDWBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:01:54 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40808 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388979AbfKDWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:01:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so12847107ljg.7;
        Mon, 04 Nov 2019 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poTJBSF/GUDkNTSs4u0rRqSIrUnXV6hdBnQ1YS7E5D8=;
        b=jnd4hIvxBfGM3BwmmoAgZifQmAV1bkMm/UctTvqlbRpUbU8MxGIKVLlooMYyjNju/5
         umBHr+YS5YZec95U7fShlVigQnntezfk1GYJ2651gyIu2GQAkPAFOceNra8DXxXP6E3Z
         vMsPtOOpyvm1q/dtkcVc37aHIsidMH3tC60i97NR+qQQMcPb18FYlzK92CmMjBIfY95g
         wIBdAIWsEUP/BZH/JMFFIt8UnQRWbaEI/RPBlBup6AyUMBR588LDPP80DkTikjPoE377
         xbV7wIywbBX1KjYv6Xv00QnKMMyfKI4xlGt6xsN4tLyOQLmAklzY/BP6TBXP6zdrTD5+
         Fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poTJBSF/GUDkNTSs4u0rRqSIrUnXV6hdBnQ1YS7E5D8=;
        b=OVm8imJX/G1h+RCxPHhnO3S/fGnMIXPcyLNroxhES2kwFCxcxk+S5/oUslKNHfzdrv
         p8hMtF7nyFZO3MYztVEhJFUtD7kY5aLZF3R2bdfgXFXO0GDeKWkfXDolxvhLvc74Klvl
         n1r127Yi/bHXXKxqofP9NoqbwA2Tw0wufEuygNbzZJSJLKTpKOwXUQSxx0tVlaLwie4T
         GWgsqYJuLUN0GPain/ElOXiNkNahRD+YTkUZRIohguguThoJecmkR2E6VdzsD7oifj0t
         aupsTmFAhpaVOvPCA1kwifFERz+qxpiOzF/m6Chh5Cot8gEDpO2i0a4fPQ08zLTn6p08
         7K2w==
X-Gm-Message-State: APjAAAVMC72mSyT7hn5WG/vhEKxPeP1mMYWOQGyLrCUjes+D8CRP7Z5L
        otL2+qcfV98eiI58fFsNsAo=
X-Google-Smtp-Source: APXvYqy7ugXp6y2JKp7I43IqVyG5wWQmxrO2L4CODFzHF2NcCLMRQ+fBBc5rH/3tVmnrxZcP6Xdk2w==
X-Received: by 2002:a05:651c:10e:: with SMTP id a14mr19835328ljb.177.1572904871025;
        Mon, 04 Nov 2019 14:01:11 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id g3sm7454669ljj.59.2019.11.04.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 14:01:10 -0800 (PST)
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
Subject: [PATCH v9 12/19] PM / devfreq: tegra30: Include appropriate header
Date:   Tue,  5 Nov 2019 00:56:10 +0300
Message-Id: <20191104215617.25544-13-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104215617.25544-1-digetx@gmail.com>
References: <20191104215617.25544-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not very correct to include mod_devicetable.h for the OF device
drivers and of_device.h should be included instead.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 9bd4dd982927..7c8126e74750 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/reset.h>
-- 
2.23.0

