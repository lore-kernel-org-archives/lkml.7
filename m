Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B93C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6923206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q28sN2rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfEEQZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 12:25:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34292 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfEEQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 12:25:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id s7so3662902ljh.1;
        Sun, 05 May 2019 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FSZQiIHMp/OF8rYpDO9NLzid+dz67fJNiFTup4WxAY=;
        b=Q28sN2rf0yktL0AiaZUsttkvA25LhQe16CQGDLcZ9WLr6/AfBTFTlCPi+9kKwrvi5v
         34mRlCos44ZSEOg0NbRWxrt4OhvNTrdVj/mAwnLNhjL4wEN/6gaB8HXVuuCcTBoCT21y
         JSFoOMiP2Hxd/h0usGdlKPVd81yYVf6LZmchnzsmTmYradudZcD3uSA/X6w2xU9/bYVd
         EQLhmDLx4VqHauU9USfEVsXpOos7flYM/nULky05BvPThKfMn7xdS3XlTYY+Z52Thxb5
         E5+B7PeIuzkgR4qTGemx7Trlc/acfZUJ978zZQzJk9lAEhGDvozibYkEswU2j8yTn/K8
         znPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FSZQiIHMp/OF8rYpDO9NLzid+dz67fJNiFTup4WxAY=;
        b=LIqqarrHjyV+G5/0CFd9NH/FBx7gudQfF4bwQhPBtRaG3B9CdCsPQUETnr2N+2li/p
         9MBTQioznC6quWWRclYZWmkatjBIy/5Bxnj5cfH2w1JIw3nxka5oNq6/dbcKp3lxpU4R
         ERbiUgyz3jEDkowvbN5EXO2G8hJH/bftN3NJ5xyOdbCwUdaAkXkyc2wQl/kHveqVRqd8
         A3fTjiRq5obDNwT+D6csza4XXUGPuhoA0rwAR8BMj5F0JrRd+ykN1zsG3dkbAWCKcXNY
         +F25VGmX22KhBzYSlWAqRv9q6NF26/vhtvGCHH7rCDLpfcUnEdp/jfn1OjM7FtUlRI1j
         O6Tw==
X-Gm-Message-State: APjAAAUUOPFW2mWmhLx2o7mA2MMUPaxx73mVQvq+I48mq529xAHrqim1
        RRs4+fKHnxkLrIYwLR7H1+U=
X-Google-Smtp-Source: APXvYqx1E3S1jlWY4CR0ZROMNcFqj5j2JndVWizLf6CbXFae0hsXdMGWLJ85jK05p4i4V9gzrABmpQ==
X-Received: by 2002:a2e:7611:: with SMTP id r17mr4674866ljc.95.1557073519478;
        Sun, 05 May 2019 09:25:19 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id g13sm1581649lfh.49.2019.05.05.09.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 09:25:18 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] clocksource/drivers/tegra: Release all IRQ's on request_irq() error
Date:   Sun,  5 May 2019 19:24:34 +0300
Message-Id: <20190505162436.23125-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505162436.23125-1-digetx@gmail.com>
References: <20190505162436.23125-1-digetx@gmail.com>
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
index cdac9e240714..7c06c0335fe3 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -291,7 +291,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
 			ret = -EINVAL;
-			goto out;
+			goto out_irq;
 		}
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
@@ -301,7 +301,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
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

