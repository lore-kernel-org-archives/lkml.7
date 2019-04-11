Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E977C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6865220850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4rpvYON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfDKWaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:30:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33092 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfDKWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:30:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so7053243ljc.0;
        Thu, 11 Apr 2019 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfwEQnrKW1Lt+UjYKDauX5BBzSk4KvQZH0bhWzaKNqs=;
        b=E4rpvYONus7P4KGzFOey1J3G7vWbsugbPgRonVGW94zLgAGuF+xptfas5FeENGmOIc
         z+DCfjB4V89zLLC/p++bxtY13vfOIMxPqopZ6IY5il5Y3t0zAsN1quqvYI5k0dO00t4i
         kbGMYM5p13y4hmd6Zh01YYgaxhVKihPQBJYEsZsireltz5QdbbtTFtWId/sxN/syx6xa
         5VSMUFIaAPbQlrBtFr7DZorFXiTI4lDVD09wwibYd3iqjy4TE7AS1RI7qLH99kJsmxr0
         9Q6Xon7dDLjNdmpDW1kfq3coQtLgRg+c9jVLLSKlorMa0GK/vsnk5rJNiSw4l5wFuVvC
         jLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfwEQnrKW1Lt+UjYKDauX5BBzSk4KvQZH0bhWzaKNqs=;
        b=jc8EeWnyEFtxRRu05zdZNmjXUKYG1tHvnkpKWVV2VPVn9FMek8ZlwwhmVV2idZQDj6
         5SGSr9je3yP+nxdy56bao1y9tGu+wzutpO9hZ3cjRxGiwve/YgusdRxmyWJQwe0uXJlH
         DOjFbNNKBNYG9eo075EGuZpfOQWeZrVtKDa5/9t+yyceSYSp8awSwzaBNkgIDjgSqWX1
         HVXN+OlsuI01zrVQeBRqpHZSLmNLPfygZ5lClUQ1wM0UTwDnw0NBhku55JDMk5TPdiF0
         8r2U0xHaSULmmv/m6tVLHqxFSy19tCN63bmxCklOY6Cyhgl/duzGwh1X5DtCGfHNIf/z
         pfog==
X-Gm-Message-State: APjAAAWzgRGRo4ZcVdntjH0DnqGoxO/QlctBWG6fP8grDw4t2X45WJvQ
        qOQFpGSrCMHeFpO8Q8Yqn7FSkmMc
X-Google-Smtp-Source: APXvYqzf3w0qvTxcWT8WrEWumI47wq2JhEkpcfSvj1lLrVtky4WIQQvK/UFGQaX1+sRere8DY92lGw==
X-Received: by 2002:a2e:9348:: with SMTP id m8mr9662448ljh.23.1555021802835;
        Thu, 11 Apr 2019 15:30:02 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id d13sm1646000lfa.40.2019.04.11.15.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:30:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 4/8] PM / devfreq: tegra: Don't release IRQ manually on driver removal
Date:   Fri, 12 Apr 2019 01:29:10 +0300
Message-Id: <20190411222914.25539-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411222914.25539-1-digetx@gmail.com>
References: <20190411222914.25539-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ releasing is handled by "managed resources", hence there is no
need to release IRQ manually.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 6185e7ab20a8..ed67d7a48176 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -717,7 +717,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 static int tegra_devfreq_remove(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
 	u32 val;
 	unsigned int i;
 
@@ -729,8 +728,6 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
 
 	actmon_write_barrier(tegra);
 
-	devm_free_irq(&pdev->dev, irq, tegra);
-
 	clk_notifier_unregister(tegra->emc_clock, &tegra->rate_change_nb);
 
 	clk_disable_unprepare(tegra->clock);
-- 
2.21.0

