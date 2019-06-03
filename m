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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C6C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44AF270B2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY8h8Wmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFCTFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:05:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43461 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id 16so3710131ljv.10;
        Mon, 03 Jun 2019 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETNkw8fFUbaK1GsH9w3HEMnksKyWiZUE22AHo7ajX+U=;
        b=CY8h8WmpWp2u0+cokTb39locVU2prxk6QwaH6+0+aw2cBoHKZvL5PEWfiu7JQs3Uo/
         BsjCLJ2onfdmOrvDTXsmZuHwv8JY0zLOvZY1U2hFAh6cPKLAn3gTrfeN6XWswKhOJ+3M
         wA+hV3ZR+dsDyh2dt7HsNP9jKQVb0qqjcq7l5xz+1WOEbItJvTJ80GQJw9h5kY6G2Z3Z
         3kN3MPwV+Z+SDEkFsI7USdOMMwJcrh73g/7p9SNOfTkNBEbmMvwXgW1dJZYOV4jfGvKx
         +Czzxg1yl/a4Qd1vNJCuEBLwzEnNa0qnJdTW+BL2mOk2qqc03r9d9OSxIsaQqgofAx4R
         j6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETNkw8fFUbaK1GsH9w3HEMnksKyWiZUE22AHo7ajX+U=;
        b=r2fs7V3DHng37x6R/fzv5jK/tc2xdTDpbnZ12ss/s702tyNjJzHhxC66Nj5qFlfutr
         o0RUbjWXCyGICrNJfN7epngbS7XNpVfBRIOSGsHZCI/eV64NMWzk63O4j7me23r9TeJc
         7x3AcmmOItsEgf/SFFqaNRCrmch72L9GdkFjQ18FnSb2or4fmEcCXN3+afqeJsooOd3q
         A7CANTl/N1Ag1B2w5mh7MNpOhmMcHNbCUx9Q2JjKn/hO+FkSiG5Po7/TiPJnEgBseMun
         3wodcIzxTDXIDKIj6HRiPbBDHzZ0nxNHGfZgNnCf0Rp1Rn6G+W7d/l4hfZxf4HaaRGzT
         M1jg==
X-Gm-Message-State: APjAAAXiH698FKPdJouu1WmMGJb8/qXe4An7AZhfsTpT8Pdet9I1q1kT
        Jj4C8jGBABOO/SoFFZY4GDA=
X-Google-Smtp-Source: APXvYqxQRsHEFoS0bcsLgzG562Q4RL+81J3KPPWi4gc2p7n5sDd7pPPiyXedMyERUe0wAZ9eUPKS1w==
X-Received: by 2002:a2e:9d43:: with SMTP id y3mr13612103ljj.154.1559588653193;
        Mon, 03 Jun 2019 12:04:13 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] clocksource/drivers/tegra: Reset hardware state on init
Date:   Mon,  3 Jun 2019 21:59:41 +0300
Message-Id: <20190603185948.30438-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset timer's hardware state to ensure that initially it is in a
predictable state.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 57e7aa2b80a3..739f83fdb318 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -132,6 +132,9 @@ static int tegra_timer_setup(unsigned int cpu)
 {
 	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
 
+	writel(0, timer_of_base(to) + TIMER_PTV);
+	writel(TIMER_PCR_INTR_CLR, timer_of_base(to) + TIMER_PCR);
+
 	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
 	enable_irq(to->clkevt.irq);
 
-- 
2.21.0

