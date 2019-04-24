Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298BEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD4821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvA2TxBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfDXXPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36604 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfDXXPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id u17so16013477lfi.3;
        Wed, 24 Apr 2019 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yogvJdlcRlyk/Ntfpj1OZayRB/FKN7aLgT26Ew/zgfw=;
        b=VvA2TxBbaeVQ8ePGe1gr9u5EP8N4rsRwrp4AwhEGNG9DOAUdZEucZLqwZymSl3/K7K
         vaH+01yGOs+XcRRrlbBdhXwJIksauORmgzpyN9ZCvviMuGMD3UOdt55eblhP7ioYWbTn
         Rmh2JY531kTIhocPk1zm3gyMzZHSnMGyQgmpgGOmbKDOyOtuwDblr2PdbhBHKsDlB5L2
         sDd2hZ3BKSIyx3m0ckj1jg+MP0mPKtcW4kHZo8QTSzeaNkMyXhPd0mQZOqSMr+R5VO7U
         AavD4/vAEbnEWPI16IfgfDCT/T2eiwjDXOfYkX6/klCsssjJVdivJZ+MgLHoLhPeY5pD
         jkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yogvJdlcRlyk/Ntfpj1OZayRB/FKN7aLgT26Ew/zgfw=;
        b=iWcKdpuxQOawloze1K7xxuHheGniM/7rVV88Llf2HC8pAhXLX+bY/Su6scK8AZAmML
         mSDNYcX9myWVTF7TJ6GSsZTGoIl0JF1klfkeUOs5VFMG9ioATFPD/8g3Nz4D7WgGf+lV
         fZ0f67TQVZoDMzTGPdIEAYu3IYOm4j5rvhfmM5SGCGB998+8TloOmv0wQnOMNtEX2iWJ
         GwhhqWUSD++2Mjt45WKPal/1O8X24ythZj0b9TsANseg9i5q8Y7y88A62IyiuDmgvWWQ
         KOPHpZjR3P8GL6+d00zTP+OWYpV2eEGp6+Mbg3K8Ldq61s6R45dX9nxOvc5sk48l9Fbv
         lwCQ==
X-Gm-Message-State: APjAAAXdpAcojCI2LEr9KgFIGxyqx4i5imozFR9S8XYY/8vpIlMFuUfM
        Zzl8TGqFb2elJck/pNuXwzc=
X-Google-Smtp-Source: APXvYqzL8cxr3mOdqIuBmWhYJUhVd+UP0iF14LtVP2Xc9Je/1sKsrln4Uc35gLhQ+I9EeSsXSymkRQ==
X-Received: by 2002:ac2:5203:: with SMTP id a3mr18675859lfl.111.1556147712634;
        Wed, 24 Apr 2019 16:15:12 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] clocksource/drivers/tegra: Release all IRQ's on request_irq() error
Date:   Thu, 25 Apr 2019 02:14:42 +0300
Message-Id: <20190424231444.20876-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
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
index d171a214f066..df3139ed7157 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -316,7 +316,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 			pr_err("%s: can't map IRQ for CPU%d\n",
 			       __func__, cpu);
 			ret = -EINVAL;
-			goto out;
+			goto out_irq;
 		}
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
@@ -326,7 +326,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
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

