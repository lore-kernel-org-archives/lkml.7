Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D66C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC6926E13
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3s055+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfFCTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39690 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFCTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so14055927ljf.6;
        Mon, 03 Jun 2019 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yr9SuSgJcQmXUlZFQ7lwiMnKS2BHo2uA+j1WQjZheiI=;
        b=E3s055+eW2sv5I81gn8QCFRXvItC0/V5xvnISyi8A3ciuJhw7x8N2Si9BZ12wM+7Ga
         XAh/ViLLsgtlOi/G6HweQ2bcshNRK5R0mxwiAkn91VnBoMNOy/Q0JjK5ldJy1iFLtSW+
         rM2hduyugpUkKIV/91OKv4stNqeP4VN4gAHebNmhRtwToBt3aKmvgelXN+jqyTwaOBDa
         MtZu1v35MaPbuMf82dda47LEtjTj8u6yQYq4SLAKCJwtYgScfWyDvrgNo7Anf8bUcaeA
         m5b1N5ji1GyPqFsHTEYXb/QJC94vPWSEiGwOcdgCtXqyWrijZCpWfTL7beJ3fIO57zG0
         wIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yr9SuSgJcQmXUlZFQ7lwiMnKS2BHo2uA+j1WQjZheiI=;
        b=Q3EDFUbWGte3EASpR3eQ+fnMNV0Ui5suX0fzYsyWJUBIJ2tUADEBFV6K2WQlm48lMy
         UHZyUixpmnnDNKveAI9S/M4h2vDGeDUBNXUgmjpTUefmlFsrbqZVvb3DrsudY2fzU6Yq
         /ZaUq5s6//FISEt8f1A0pF/6eh4UejOMKneGfI/qOFHLHexuCyXIqbPWWCLa5suu+PYA
         5Ld07ds7WlEN1rffP4VSklrLjXGHrj3ifi4WR7ubZhMmCrQzkmLO5kGqsH3/YgAUomrq
         6nTXvHU/7lbZ5p3ZkArBK96ngbytlQhOawTXumEWnI2DoOJZitIcTyIfXVErx5f8DuxZ
         8bJA==
X-Gm-Message-State: APjAAAVZKwmFXWlq4gNzqye+9F8lQYTfw4juDTIpHfWUqdeUd4eK8U86
        maT+dtJBzJ9ECWa7DIn7VWY=
X-Google-Smtp-Source: APXvYqyg+xmTH9fD+oqdbNzvuv/qhrGXfjJqlYpMU9Lc2aiLLBsQIHCmIct4c3rLlTNfvCK4DrJrXQ==
X-Received: by 2002:a2e:3912:: with SMTP id g18mr6751671lja.38.1559588656460;
        Mon, 03 Jun 2019 12:04:16 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/10] clocksource/drivers/tegra: Release all IRQ's on request_irq() error
Date:   Mon,  3 Jun 2019 21:59:43 +0300
Message-Id: <20190603185948.30438-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release all requested IRQ's on the request error to properly clean up
allocated resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 55e9b3e1fbeb..18b81d814b3b 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -293,7 +293,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
 			ret = -EINVAL;
-			goto out;
+			goto out_irq;
 		}
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
@@ -303,7 +303,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		if (ret) {
 			pr_err("%s: cannot setup irq %d for CPU%d\n",
 				__func__, cpu_to->clkevt.irq, cpu);
-			ret = -EINVAL;
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+			cpu_to->clkevt.irq = 0;
 			goto out_irq;
 		}
 	}
-- 
2.21.0

