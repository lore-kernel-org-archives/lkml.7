Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F1A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="MSyJtv3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKRKrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:47:12 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:41178 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfKRKrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:47:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DE08042009;
        Mon, 18 Nov 2019 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1574074023; x=1575888424; bh=bSKf4yCzpgTW+4k8YJNGqWG52QBL9g0Yq7X
        wprxxbYo=; b=MSyJtv3H0hc/7a7+8fs4AkG/hQC5mYiSzv7Fpyz9mY2gPeXz+7t
        x07Dmb/AUmfe6G/J2fbB+vNkP/8idZLRxJVD7F5RnOlUfYd+1zQLKh3oToBlPBuk
        g8M57OOisit/X281ZMyjsHFJD+VaxsuAywzfikcJqVvTTHGZsyxRm3no=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5ZXqgD56ahqc; Mon, 18 Nov 2019 13:47:03 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8B481437F3;
        Mon, 18 Nov 2019 13:47:02 +0300 (MSK)
Received: from localhost.dev.yadro.com (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 18 Nov 2019 13:47:00 +0300
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
Subject: [PATCH v3 3/3] mmc: sdhci-of-aspeed: add inversion signal presence
Date:   Mon, 18 Nov 2019 13:46:46 +0300
Message-ID: <20191118104646.3838-4-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118104646.3838-1-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
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

Add read_l callback in sdhci_ops with flipping of SDHCI_CARD_PRESENT
bit in case of inverted card detection signal.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8962f6664381..56912e30c47e 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -111,7 +111,19 @@ static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
+static u32 aspeed_sdhci_readl(struct sdhci_host *host, int reg)
+{
+	u32 val = readl(host->ioaddr + reg);
+
+	if (unlikely(reg == SDHCI_PRESENT_STATE) &&
+	    (host->mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH))
+		val ^= SDHCI_CARD_PRESENT;
+
+	return val;
+}
+
 static const struct sdhci_ops aspeed_sdhci_ops = {
+	.read_l = aspeed_sdhci_readl,
 	.set_clock = aspeed_sdhci_set_clock,
 	.get_max_clock = aspeed_sdhci_get_max_clock,
 	.set_bus_width = aspeed_sdhci_set_bus_width,
-- 
2.20.1

