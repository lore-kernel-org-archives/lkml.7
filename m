Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3833E2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 02:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS5ZfROF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391972AbfIFCcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 22:32:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34079 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfIFCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 22:32:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2375249plr.1;
        Thu, 05 Sep 2019 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+363ozv7hHWtnDZ7Q+OUTPSDfOt22ArWkNBA2J7l/rE=;
        b=dS5ZfROFghyniETTIersxbAr8Bj66TmNb2OqDTLsPycKxwqcrBV08/bF5y48sucgSE
         +ooQ+tqt2RGwbOGMslvWVQXiHJ6So+teUEt8MxliZag5O9FiUvQY9PTj4KBNc34Z941J
         rCkDfsgsU/Iplurfctr7UcCEFQUE2gPqZOoaXnHPxu/PAcyscM4/j+XnYwDe9JjJ3p0y
         lfU22ilkRUAlJvp/FuJ/CnSYU0zDc0tN3yOG6+YiHIbLiVDTvc0H8i8Uy4ueTTPxu2Uo
         Jqd97gWflwKfRQ3wJOfCbusAxpP952fdY0z+ni4s6Cd4hAM4XmtMWLMGGo/wVs+2v0n6
         VAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+363ozv7hHWtnDZ7Q+OUTPSDfOt22ArWkNBA2J7l/rE=;
        b=ZuwKgDTAtAhQuZZLYGZv3xnQvgHzIjXemKu6d99QKlVOciip0AFq2ds4PVlIcy0Zt6
         n/1T6qPFiPLmILkW6FPRQCXdJneoxyVJJSECxqA649sj+YlWJmGxriiQH/23Y4y3jyp6
         NlDCu6zkRVccoTy3FGfvrvcHXoo70e3g00V1ALruRbn6bKitcqO4dEAucRdDvdcgv+bU
         bLtNEwH/glMc1l4E2pWK91WOrtXsdPCTlrZ4N1OU0hdrmwgAU93vDoeEEABWmc56cDFg
         PszMUkTETVsPfj4z0IJuXCbLZvCVPLrmSeLJ/5RahLhBnOrfzmfHJsmsc9Jbe5dj2xms
         jFaQ==
X-Gm-Message-State: APjAAAWNqeD7ycsZVBY3FSv/q6r5Y8uuY+Ww5Bi6Q9dKApIe1Nqsl5R+
        vUMGAM2ofXrYgUQvJeO5Lio=
X-Google-Smtp-Source: APXvYqxed7C6ImU9htYUulA/MMFbq9ztOqgZHE25K0Mb7LpnO+bv0q6cjA24s6bUSZiinFwboMmXyA==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr6818012plz.90.1567737133927;
        Thu, 05 Sep 2019 19:32:13 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id l3sm5161332pjq.24.2019.09.05.19.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 19:32:13 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V8 4/5] mmc: sdhci: Export sdhci_abort_tuning function symbol
Date:   Fri,  6 Sep 2019 10:32:18 +0800
Message-Id: <8495caa6af2bcfb916e57e626dd2d9eaeb0310c5.1567734321.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567734321.git.benchuanggli@gmail.com>
References: <cover.1567734321.git.benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Export sdhci_abort_tuning() function symbols which are used by other SD Host
controller driver modules.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9106ebc7a422..0f2f110534db 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2328,7 +2328,7 @@ void sdhci_reset_tuning(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
 
-static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
+void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
 	sdhci_reset_tuning(host);
 
@@ -2339,6 +2339,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 
 	mmc_abort_tuning(host->mmc, opcode);
 }
+EXPORT_SYMBOL_GPL(sdhci_abort_tuning);
 
 /*
  * We use sdhci_send_tuning() because mmc_send_tuning() is not a good fit. SDHCI
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 72601a4d2e95..437bab3af195 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -797,5 +797,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
 
 #endif /* __SDHCI_HW_H */
-- 
2.23.0

