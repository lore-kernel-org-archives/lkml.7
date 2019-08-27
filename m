Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E76C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A96E20673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIBrEHni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfH0AdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:33:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45177 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0AdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:33:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so11582690pgp.12;
        Mon, 26 Aug 2019 17:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n7+sVYqdxpLe5mIpwExuqi9YJ4e/DMZsey8GaSh+g3U=;
        b=tIBrEHnigI/eO8+DqVievvAJ0iiXeG4bgq+gtA0yve51p/wWam0jg8qwhjybHbY+ZU
         2eRv6vASzoerWnyQHuIc/bpYb3IbPhES/KpAYV7vOWnjkwNXszJeR05aTjissuS/D1Do
         WUGkKDXRmFCCisxNNd7iaW+gOpBFuh207cSazd+9H/EdlolAEFaFGyk/balsUb1APm0T
         wUm3nbBEpXVHLPb2/lLlSZ2mIJ34YdS7ByyzoDnRDXqZwDvUpQCIATmbz9FuGRY+UsRq
         bnIs5gIaD3df0UAYNi/Wl+FQUa7fuXG3pwNjtmnFvAB0BRL1Ba5GWJQGNxdlQwoyqXHB
         ioKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n7+sVYqdxpLe5mIpwExuqi9YJ4e/DMZsey8GaSh+g3U=;
        b=isUpXBNhS5ZkrUE+RzBjhgsYoJhZMXI0DkSBSiyQi8NcG8UVUNG+kI9cB3eRVMNRJg
         fT3Rua+QGwdA/V2KRiqCxPMpxRRwilpEAAtH9VZkRAWuFmXDbvjuOz0HocadSLpfC9iR
         qr2Dr3hoJBVJE6lFUwVTpDwiaFppV0ylEJEQjUE0gfxXLX1vraPjj8wP97Kkvj8qL8ez
         c7WmYoNwkBS6aR1mNV65NyAH/+FEV3N+5F4XNqkk2+rm08J7+6qlt61+PuNKJm9llRn6
         ndRm7PYfr1C8Ug4XCEArHnazMMTwRb0MJOBu0aZYw7GB4MQ+S5aIso3xnVdQUDfjvOFZ
         1MIw==
X-Gm-Message-State: APjAAAUl8bV+uvR3m74r10GZN2iCyICup/1nLVHae1najSqdUcIPAuXW
        yjVDwgbAZc/Ul5vejn1b88k=
X-Google-Smtp-Source: APXvYqzgruKmhT1BbYpLtT/VhTwCRvQzEWzH2u04GCGwn+pKudxllttb2V56VanAeKAaFh3jIiV5vw==
X-Received: by 2002:a62:d0:: with SMTP id 199mr23097357pfa.157.1566865999446;
        Mon, 26 Aug 2019 17:33:19 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id r4sm14371142pfl.127.2019.08.26.17.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:33:18 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V6 4/5] mmc: sdhci: Export sdhci_abort_tuning function symbol
Date:   Tue, 27 Aug 2019 08:33:22 +0800
Message-Id: <20190827003322.2445-1-benchuanggli@gmail.com>
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

