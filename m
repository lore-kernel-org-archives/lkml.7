Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808DAC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508FE2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZDsNj7nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfCBFUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:20:39 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17551 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfCBFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a129f0000>; Fri, 01 Mar 2019 21:20:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Mar 2019 21:20:37 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:36 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:36 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12a20001>; Fri, 01 Mar 2019 21:20:36 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 03/11] mmc: sdhci: add support for post tuning process
Date:   Fri, 1 Mar 2019 21:20:17 -0800
Message-ID: <1551504025-3541-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504031; bh=I88WLCNl1yV3gNupXuAzY6+a4EyFKT0wLnMQMi5w4B8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZDsNj7nmu9ANc4VbFPMN+eoIsn4zxTmSZiM+g84l2c9WIBjxtsSZkdHVbYskpfopB
         +jtEVVWkEWAL4lCEKFChZeTpk3Z9irSG0TBIWbMifRlaajs3emJzrw+PlP/ypBjp84
         ZULqUYZCAKId0lCY1Oi3q6TiHl6kYdtO9rp3u0XDtWUQHa/6RSVD6mXgTzgINIDB09
         auSf5UDs2LzZPGH0Km8qINdSXmxY3NrGF75u28C8KhVkoKsgnsO6nAj1uy9c+6FNcu
         Y33lFFZH0ynO31EyM70+9m1pxCEZ45eSrwh4Web4wCqLfhECWF0SrnYeSY4V02m8Xy
         lMNjEHOpyvdww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for post tuning process needed for some hosts
to perform after successful completion of HW tuning.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 6 +++++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9e919218006..976d4d1e2400 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2392,8 +2392,12 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
-			if (ctrl & SDHCI_CTRL_TUNED_CLK)
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				if (host->ops->post_tuning)
+					host->ops->post_tuning(host);
 				return 0; /* Success! */
+			}
+
 			break;
 		}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c80e0d6f9b10..236d67778645 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -639,6 +639,7 @@ struct sdhci_ops {
 	void		(*reset)(struct sdhci_host *host, u8 mask);
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	int	(*get_max_tuning_loop_count)(struct sdhci_host *host);
+	void	(*post_tuning)(struct sdhci_host *host);
 	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
-- 
2.7.4

