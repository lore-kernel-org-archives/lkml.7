Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AFAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0232071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNgusl9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKRKnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:43:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46454 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfKRKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:43:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so9565596plt.13;
        Mon, 18 Nov 2019 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DRiBrI33Nprk3WLOnX9WeUj7+gPgbUdces5l/DUxGF0=;
        b=aNgusl9cYpO4mPT9D6Wv/8vI2fMz1iZSzlJFDEnTeevCMtCSpjq+JpSEG1Z6schD2Y
         8A4z00sWpuHqmeh07CtFrSC7eF0T4WLOJfyZDi4wv2D4w0EWFgkqPevwPdtC/RuBDMGg
         KBr/UDIancxkbnOOdNRC215z96py7oYKJ1ZLwwCL1QZjTbhgE910BwMES8+cXHQ+FhQ6
         gaGVUgdbbVOGyC19ytpXIY2kFvfgv3JVEvZTsUiNWlUOTAvrGqN4b1Z2hUgNTZOtTHVz
         oOeO46yicNp1w1ZdAjYQkSs4CrdFsWPVfHmOlegJRfkgdZW8/NqQuKPjyEviJkopfND9
         c+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DRiBrI33Nprk3WLOnX9WeUj7+gPgbUdces5l/DUxGF0=;
        b=TQz3BY/oedPk9Wf49SFPwJERwdxEeaSJXksaY5WJWQB9QRbsWAfpIcoGWgP4/rkNa0
         KI5GV3g/UW+kU82rTKABrDKsU7BM56x/xDwY5XmAMaOgfV1MHN049DdN+sgMTpuXK6YF
         qolP+QWzP7czJqbuHxkbVudFSx03XvhqqvtJcYUT7GH84JzPg9Xw/XX4p96BuF1/sgOK
         NBF6C9ERFk4//xXKfzh2Hs+qB6+ZfTXMKXbNHjs0cD6oW4gVv0YG+YmHXtkrom8Ampsi
         /r8SIpM/w1+I/hqBq3UPvhROqECMlTwhlcVv6+9xJqwyBX34hUk9ZhpAxfVQM1Hy5XqR
         1Lvw==
X-Gm-Message-State: APjAAAVdmBvxl2qhZ2qe7iJZ8FsCvq5shTF22CvhSyZ768QyQtJXJxM3
        e1+J5TtBDSIwJ02/2J49zVQ=
X-Google-Smtp-Source: APXvYqxYWzY2t0dxPZMywjcqv80QiLJpdmz8NzKqvPqa/eX2iHQgJ3bvWOnm1d63L6/btGwpeIrEiA==
X-Received: by 2002:a17:902:544:: with SMTP id 62mr29210035plf.195.1574073826989;
        Mon, 18 Nov 2019 02:43:46 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c13sm19343905pfo.5.2019.11.18.02.43.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 02:43:46 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/4] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Mon, 18 Nov 2019 18:43:20 +0800
Message-Id: <2f16c4f2b98474b79584e0bf338ebb6fb4f6617d.1574073572.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Add request_done ops for struct sdhci_ops as a preparation in case some
host controllers have different method to complete one request, such as
supporting request completion of MMC software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/sdhci.c |   12 ++++++++++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b056400..850241f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3157,7 +3160,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (!mrqs_done[i])
+			continue;
+
+		if (host->ops->request_done)
+			host->ops->request_done(host, mrqs_done[i]);
+		else
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0ed3e0e..d89cdb9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -644,6 +644,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*request_done)(struct sdhci_host *host,
+				struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

