Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946DFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AA221479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sV/VcYZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfIHKNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:13:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41502 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfIHKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id a4so9878361ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sPoOSzMWXk49KLRI+pedfbA4qsHre5+gtEz1gpf9mk=;
        b=sV/VcYZ2BooaL1Ed4/JLXyL+FFPx5r/Fg0Pt5aluWRCqss/4oGxxSjBGWqBioYI5RU
         v4SxQ+SPBdlAysfX9R6Yy8SxWWzozZ5+wno5kdF3I4MiVMlRlGDB+R9wkXB9MB4D73Fo
         QvbA14N96UHo/B3KRfTNMSLbH2q4XbwA8aJMyG+FCAnJ1t+3xd8D3cKKursF++iAAyP5
         Dg2CIP52xIMApN5VBqLNAmTEL3rx8ZvpvLizycZnrIBFpcWnhCOd9MBJl9v/72ZLiAu+
         GAOKWgrHwEeV9PfQ2dFG/yN7qLDoEQ8qtD19py0d52XwpqCzGz6z8vjZ5hShIlC9/swQ
         oMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sPoOSzMWXk49KLRI+pedfbA4qsHre5+gtEz1gpf9mk=;
        b=oXhwUHTvenrU31q6+HZge/yxqkmuGe84mp+laVHc7vALpnElvQqAk/+/rlFETZHMTF
         BePAGvzZV08ULaVx3PcZZdu3uXqC7/96mMvma5ArSTabgfi9tBZsNw/tTXj+PEm8HLd4
         MS4YotD7svCLFDgr02EW1nXExkRYUuID9LfTwFPUqNsrB5n95M/Rotyix0gyJrsN8xCB
         b1paaM154MDsixAnEscKLnpHv4S2WLBl+AHaUAGXM594IorDB2tlPqwpDmOog2VmXk+B
         U0LwHIeuwluWiQ/lDA8hJ6lMCMs39s0tNI2SF4gF8Xs+A+zm7YWGCoju8lceupwhcTRw
         Fm8w==
X-Gm-Message-State: APjAAAUzWDTe4FP+S/ezR01nnGSRS7pGUdltV8G7kJQcNR5Uzw1m/Iix
        wQbjSClZUmsfrxCEb6hv9fz9xw==
X-Google-Smtp-Source: APXvYqxsu+ihTaK46jp2BGSVrQH8cszNNO0DDP2bedFXjb8aIitfZqu6ZSJZy99q998j7SGRNa6VEA==
X-Received: by 2002:a2e:b4e3:: with SMTP id s3mr12408526ljm.143.1567937569769;
        Sun, 08 Sep 2019 03:12:49 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:49 -0700 (PDT)
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
Subject: [PATCH v2 06/11] mmc: core: Clarify that the ->ack_sdio_irq() callback is mandatory
Date:   Sun,  8 Sep 2019 12:12:31 +0200
Message-Id: <20190908101236.2802-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
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

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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
index a9d52a4d5041..0e6afe66cf68 100644
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

