Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC6B23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAhNS1CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfICOXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:23:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38112 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbfICOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id h3so9391390ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEFp+hq6WF76ZDQD++03UfUz54PPaJzLtrNfLK0kmKc=;
        b=rAhNS1CG/SmhFG+9WpuAZAeuPWOmk3PRWJElNLoXN9FlAYJrC5d2tMGtSLKAzzr6aX
         M6RoloYPdbqO7f5KwLApFXL+4m6Bk52g/kRO26+PDT6sL6QjdkhUhNAlS/6BUor2GIw9
         L9o7YJEmuiMYtKfrqR+2Ryk2eKnBqa02t4dRxFRR1EMsKXIt8npFYRpTLyGUypZVdH9z
         AbwkoOLM+mUoCkGcJjfZFqVq4Ll6oXSS/5PGsQexGh5kQ2u8yJScqJKun/W57FppaC2V
         Fyd+KYGI6mXusxA9Gfyyo7L8okOZ+fwTC9VNxuYyKTKc841K7x6ArZGR+e/EomnDuygF
         tY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEFp+hq6WF76ZDQD++03UfUz54PPaJzLtrNfLK0kmKc=;
        b=WjVIEaOra5RdSvY8dYxITOW3yfCxSJ7IxLyj04j7UtPCKJd7ndQzY0P/249Y09RZfM
         SLQJEkM1BPJ4krlf9zdsQsK5hKFVO56HOEVpRIGiAXoEfbC/SO/czzW0B51QtLrov+2q
         EHRJyhL/+wy8evoqgFrowktNImamaM+Tf5fE7gzkHc2Lez7Dg5eApB0urWFx9Q/56nSF
         Kty24DJkt957LJQq625JdslxzCcuKKEKqBtktYuVQ0XW5QQu9GYZseAVHNExdXJ1M/bj
         6cHAoWbshxYC0qAzoKbsPXkVlsHNgN7weD9cX8LDd30xv7lpkxMru54YuGU2++8Ho30X
         0giw==
X-Gm-Message-State: APjAAAVpU0f/ScYhk437wJOs4AC3iB1Hn6MCQAhWgRHQ6cA5RKosRc/z
        nSNC3z4bp5eBnBcpwLMMe5lbSg==
X-Google-Smtp-Source: APXvYqwW7bKtefLZcTuxAgXstvnr8V4cg5OryM4fdGNKnmzlZIkWikBetS9faCFtCgLjjSTO6ycVQw==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr8923823ljs.148.1567520561447;
        Tue, 03 Sep 2019 07:22:41 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
Date:   Tue,  3 Sep 2019 16:22:02 +0200
Message-Id: <20190903142207.5825-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
the ->ack_sdio_irq() is already mandatory, which was not the case for those
host drivers that called sdio_run_irqs() directly.

As there are no longer any drivers calling sdio_run_irqs(), let's clarify
the code by dropping the unnecessary check and explicitly state that the
callback is mandatory in the header file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 3 +--
 include/linux/mmc/host.h    | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0962a4357d54..d7965b53a6d2 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -115,8 +115,7 @@ static void sdio_run_irqs(struct mmc_host *host)
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
 		process_sdio_pending_irqs(host);
-		if (host->ops->ack_sdio_irq)
-			host->ops->ack_sdio_irq(host);
+		host->ops->ack_sdio_irq(host);
 	}
 	mmc_release_host(host);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0a565c7ff1..ecdc1b0b1313 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -128,6 +128,7 @@ struct mmc_host_ops {
 	int	(*get_cd)(struct mmc_host *host);
 
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
+	/* Mandatory callback when using MMC_CAP2_SDIO_IRQ_NOTHREAD. */
 	void	(*ack_sdio_irq)(struct mmc_host *host);
 
 	/* optional callback for HC quirks */
-- 
2.17.1

