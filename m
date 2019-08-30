Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDFC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D53921874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0t9Y5cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfH3CZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:25:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39041 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfH3CZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:25:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id az1so1599127plb.6;
        Thu, 29 Aug 2019 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ikyf+TpBSFgGm7Vdpj1oS/xRxlgH+ALj4QoDRbTjVfY=;
        b=Y0t9Y5cuF6YAJ6Ar5+Ja9HO/s+x8MS5BKtq5Z6eVy3T8K8sKLZgIJdWiLeTZ0ahMYu
         PvBil1ljM4+nJWF4P90lOpkHmtqAnhujFau4LD4ORtod9Hw+TVuXmTGJ5X2h3nKt7kQ1
         jZTGPVqW4oBqp85uxYmiqFYCojUH/Rh6QNX/T9uXoseD36d2vt10ok4sCrj4IqXpih71
         QL0QSccdwC9zYkQmUd7G7QHgc+Z8y/8ozd0iooI7///6ZGKiJO8mwmZJN8+Wn+rUUDtv
         AOMvtXYEcNpGdyZSs2f44Ww+a0y1IqwwUie4ylb6r4f3HEkNpN+coSyN1/VZXF1yzN5K
         +DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ikyf+TpBSFgGm7Vdpj1oS/xRxlgH+ALj4QoDRbTjVfY=;
        b=hLd9mJToZFZ04apWLhkY7d5H2Fps1HAqoVlIzAe+x2GFuEs0HpKneWhSzexbzfwcCA
         IDATb9NWH9EJ8vawIaQPG78eXVWDMvIp6HrVrWV5T6/iN8qKXJIg29XfvLDiZHnVGqV3
         xABOBv8Cz7V28oV191rvEScp34w3pH8X+NBLT4lnMeFbjbj88ZqjBjj3bj3+WADFT2Q4
         5bCPHbRxaCPIKpzvsk7+ZvMwe5OJxes48Eti4l57H1q8AsSAscIrCgflaRhlC5uy26vl
         3qcNofM4IJIQK/0W0i4uG95+f7dHg4u4LXIQ/NWsJsJ02qtShicyzNqZsWNeLcSIGU7T
         Yj8w==
X-Gm-Message-State: APjAAAUIvymGmSBPlIBxPfBFICT3hiHNH68tcZZ/U2Tc5NJg/nqSbZ/2
        UfKoRkRMHv//AhCx3UHoo9E=
X-Google-Smtp-Source: APXvYqw2IXyYCTQpE7gt5NEa4NIw2wqBSwcHjNB6D3vWezTYVZRM25lS9VmGLfADQ9M2CrOIKVNMYA==
X-Received: by 2002:a17:902:302:: with SMTP id 2mr13235091pld.149.1567131910448;
        Thu, 29 Aug 2019 19:25:10 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id 4sm4609265pfn.118.2019.08.29.19.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:25:09 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 4/5] mmc: sdhci: Export sdhci_abort_tuning function symbol
Date:   Fri, 30 Aug 2019 10:25:05 +0800
Message-Id: <20190830022505.8499-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
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
2.22.1

