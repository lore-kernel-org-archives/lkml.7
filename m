Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4FFC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032AE214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkMI4tum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfFROE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:04:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35891 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFROEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so9405399lfc.3;
        Tue, 18 Jun 2019 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcA8/cz5L6PoM8H80xIFBBbunOj0r0rzlcwFIbOLiRc=;
        b=GkMI4tumktLC1zzO1j6ZRbXYLYRitiIaDLM/QWoBd1ofz2W0gi7nON6r7G4DouE5aM
         SbKM/CsvfhyzpTr+H7vZLncxBWxjZ5BoX3RkCDMu05xLo5mZ5mXYh/LoSaZKK5VKZ810
         J2CV33Fc4RfDomEbt+FMZYh3ibNRzSsv7sn3lHu6liQKvChz8gcHBJ/kzDFZgAwUD3O/
         sri/ap2EjN+6QWBu42EURstC6M9b+NU8F33x6SCN07E9TMYBrX1txDLpn6QUvwJ34Wj7
         LzT4tyOBJnWIUoKLGHBuzZgvn+qSK21DEcLd0qHHxmvPGVJl9ILKmuANbVl+5knpupqK
         zBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcA8/cz5L6PoM8H80xIFBBbunOj0r0rzlcwFIbOLiRc=;
        b=QnKdjE/lJH1QJQRKaNUFXCbqhxTgU4IZgI9cJue6Prl4JwoLE30BXc5zPKZGc4F8hg
         pDC/xTgNKLtBHlz2LRa7psecUnzuix6Shfb9uWdWRGpdirRTJup8isbIVZSQjff5/TPv
         Vgm6Gwwf2SacCCWnyazWsmInEpDGGliAOzl1zU74K98dw6z5Lrjzlwi2DnPE+WovIuA/
         gASj23/FYw6fxMcjUtc/24JR2wDoIdWaRUYoUZa0VyKGbcfjLXrckDUJf4Ukh6sdvsES
         4Gn2USGgrVOcLlBaElBaqG1tdU3LRVpiVfcdekvWsQDArT65TLj8OIurCKZkYzlW9ZS1
         YLcw==
X-Gm-Message-State: APjAAAXQf0C+kTG2VgCkt2pO6Jsjh2FVQO6rr05CHXt36wns0/uRAI1q
        QK8Tu1Bnu6Wwf7Y5bthk4mjB0s5O
X-Google-Smtp-Source: APXvYqznh+Oz8fxlgaMVqW2/FKT8cD+/fupVT1JfH4+B1zugchRbpRK6XESty7rUw/uEBpffPyjF+w==
X-Received: by 2002:a19:428b:: with SMTP id p133mr18499679lfa.179.1560866681608;
        Tue, 18 Jun 2019 07:04:41 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] clocksource/drivers/tegra: Restore base address before cleanup
Date:   Tue, 18 Jun 2019 17:03:56 +0300
Message-Id: <20190618140358.13148-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618140358.13148-1-digetx@gmail.com>
References: <20190618140358.13148-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're adjusting the timer's base for each per-CPU timer to point to the
actual start of the timer since device-tree defines a compound registers
range that includes all of the timers. In this case the original base
need to be restore before calling iounmap to unmap the proper address.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index ddf5531c48a9..2673b6e0caa8 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -345,6 +345,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 			irq_dispose_mapping(cpu_to->clkevt.irq);
 		}
 	}
+
+	to->of_base.base = timer_reg_base;
 out:
 	timer_of_cleanup(to);
 
-- 
2.22.0

