Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195C4ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ED321A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlFFY6vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfIKHXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:23:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35879 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKHXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:23:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so13125795pfr.3;
        Wed, 11 Sep 2019 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+363ozv7hHWtnDZ7Q+OUTPSDfOt22ArWkNBA2J7l/rE=;
        b=MlFFY6vmdN6JzSxXoup182yy4ANP0O24aePGKFB6Ve7AVQEKB9uEy0LEqxY5lXGtuG
         7paTrgMGqHg7Pu+S6eDC459+G9JlvrqCE0OUT01zINxnkFbTlE3XbSGsZ9r23B2DhWPW
         vyN3x1gjAiYMU4UHVbmm8pOhcZXnauswRDvtCI2zgOefeJSVrIvANl9WxUzMwj+XLMf2
         n0SfbSaAb8wIKnVbC0QNLXr6etxFgvewKqjnJVMioB3zXLUBwJI49iPACx3qyJ28xSpH
         Vm3WEl6/HheEJhxXXPxhGPJ3qdVKlfVzciBOFRG2qCLauEyEjIlo9sZh4A7FBltDRp67
         +7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+363ozv7hHWtnDZ7Q+OUTPSDfOt22ArWkNBA2J7l/rE=;
        b=mlJ8Vjg0OlAR4UJWtEvzr2UDVdBGQv/w5MVnb8FF53iYkRbKRCOlnHE1O0wwm83dv+
         c7MmR6y5Hy8sSWmAV+/HGUIkFY2EEf5QBAupNefpPIS31LtogdK097ZJw6dk9PoS6/yu
         tcXrqx0sHyE0XXcvE0CNC/ZvmoA5yNXc/93o6KFw7mYYWqR+zoBXL6ObSvjcWwT0VmnD
         WcFO4W7OQLiS8ct03HZtdgSYmJ3NPMHPa25VXSRNdbGvwa1qH9W7divZwcQqsYXOur/u
         jtY546CKcWZx4wEYadw+JPJtijRYv5kswjYPD7pUXos0M8RGTfDiF9vmtJP/XTIkcqLD
         n5GA==
X-Gm-Message-State: APjAAAXU0Dh+IJ1+ftD3hMpQa1zj9Cbgwk4lUBaZqs4Mu4DV1NZrTYW/
        hyertn5gOto/R1Hn7WWpjpI=
X-Google-Smtp-Source: APXvYqxFWSIwUy+vMZjIz2+XMH541xgOFi9roE09pdelMazqkJOWzzwtIfPidT0t/JYFn3wlJ9vZEg==
X-Received: by 2002:a17:90b:f02:: with SMTP id br2mr3864564pjb.67.1568186594129;
        Wed, 11 Sep 2019 00:23:14 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id k36sm18517322pgl.42.2019.09.11.00.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:23:13 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V9 4/5] mmc: sdhci: Export sdhci_abort_tuning function symbol
Date:   Wed, 11 Sep 2019 15:23:31 +0800
Message-Id: <8495caa6af2bcfb916e57e626dd2d9eaeb0310c5.1568184581.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568184581.git.benchuanggli@gmail.com>
References: <cover.1568184581.git.benchuanggli@gmail.com>
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

