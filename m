Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A86C47421
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9623357
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Lsyan+DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfKMPxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:53:08 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:59932 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfKMPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:53:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 20344412D2;
        Wed, 13 Nov 2019 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1573660380; x=1575474781; bh=u6VsNH8spieqcZMUkwhitlLPwcJWZA6GXjz
        wh0sgyTs=; b=Lsyan+DYpW6IleLOjFmf3XpEK9zYBKXdYEnzmDUPEQS42b9Tiby
        hkzVq2+4LuGLOW1Wh3/0ge3qIJZj2e20aqG4D2iugnJ7fbfcAmdlUzKXzukxNb3x
        kFmSghKapTW9B5iuXXBpLI9qeSpr6Ktkp/JHTh3TJzOBpr/uEcCauUOk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Lco3oJBrAxV; Wed, 13 Nov 2019 18:53:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4CECE42F12;
        Wed, 13 Nov 2019 18:52:59 +0300 (MSK)
Received: from localhost.dev.yadro.com (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 13 Nov 2019 18:52:53 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: add inversion signal presence
Date:   Wed, 13 Nov 2019 18:52:37 +0300
Message-ID: <20191113155237.30646-3-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113155237.30646-1-i.mikhaylov@yadro.com>
References: <20191113155237.30646-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the default .get_cd callback. Add inverted signal card detection
check.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8962f6664381..8eded8a6ed8d 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -31,6 +31,7 @@ struct aspeed_sdc {
 struct aspeed_sdhci {
 	struct aspeed_sdc *parent;
 	u32 width_mask;
+	u8 cd_inverted;
 };
 
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
@@ -143,6 +144,21 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static int aspeed_get_cd(struct mmc_host *mmc)
+{
+	struct aspeed_sdhci *aspeed_sdhci;
+	struct sdhci_pltfm_host *pltfm_priv;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	int presence = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
+			 & SDHCI_CARD_PRESENT);
+
+	pltfm_priv = sdhci_priv(host);
+	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
+
+	return presence ^ aspeed_sdhci->cd_inverted;
+}
+
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -183,6 +199,13 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	dev->cd_inverted = 0;
+	host->mmc_host_ops.get_cd = aspeed_get_cd;
+	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted")) {
+		dev->cd_inverted = 1;
+		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion enabled\n");
+	}
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
-- 
2.20.1

