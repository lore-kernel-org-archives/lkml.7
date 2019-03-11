Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6A32075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T9zU464e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCKSCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:02:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9767 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKSCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:02:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c86a2c40000>; Mon, 11 Mar 2019 11:02:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Mar 2019 11:02:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Mar 2019 11:02:42 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Mar
 2019 18:02:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Mar 2019 18:02:42 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.53]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c86a2c20002>; Mon, 11 Mar 2019 11:02:42 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 02/10] mmc: sdhci: allow host to specify maximum tuning loops
Date:   Mon, 11 Mar 2019 11:02:31 -0700
Message-ID: <1552327359-8036-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552327364; bh=QW+qvi1XMAJOuUTjk+X0lOvp6QOHlS0K7vDz+5MBqBI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=T9zU464eTv45owJ9Y5TPne9WjxAjAzTSpKVYZvtMtwOyxJ9PFkzNpfA7/i3obF5Kp
         hszXGOvrVXyhe9Bi6+ZW14ZMoRoVWT02+tTB087AVoXlyg6uiKTU6a/IjDuFCloK16
         Hfp0FbAkaUZj3x5iy94a9mW1Lets64l9KqJXrdhiBSBJtnghDb6pKRNrAjc+dMNMIn
         c2YAhrA1vSLwGjyFIBhlcnM9rOfnOAo576XNmkjHSr/H4kSpHvv7fqRZG39fddddH4
         DxQDB4Lh8pIT9bPhwA0SkKWVcJm+3Rxvf7NVDCnunKmVyx2dzZta4YAIlTQdBt1ue/
         JnQmak7+ctL7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the Host Controller Standard Specification Version 4.20,
limitation of tuning iteration count is removed as PLL locking
time can be longer than UHS-1 tuning due to larger PVT fluctuation
and it will result in increase of tuning iteration to complete the
tuning.

This patch creates sdhci_host member tuning_loop_count to allow
hosts to specify maximum tuning iterations and also updates
execute_tuning to use this specified maximum tuning iteration count.

Default tuning_loop_count is set to same as existing loop count of
MAX_TUNING_LOOP which is 40 iterations.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..bbc0e0bb7128 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2369,9 +2369,9 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 	/*
 	 * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
-	 * of loops reaches 40 times.
+	 * of loops reaches tuning loop count.
 	 */
-	for (i = 0; i < MAX_TUNING_LOOP; i++) {
+	for (i = 0; i < host->tuning_loop_count; i++) {
 		u16 ctrl;
 
 		sdhci_send_tuning(host, opcode);
@@ -3494,6 +3494,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	host->cqe_err_ier = SDHCI_CQE_INT_ERR_MASK;
 
 	host->tuning_delay = -1;
+	host->tuning_loop_count = MAX_TUNING_LOOP;
 
 	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..57bb3e3dca89 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -596,6 +596,7 @@ struct sdhci_host {
 #define SDHCI_TUNING_MODE_3	2
 	/* Delay (ms) between tuning commands */
 	int			tuning_delay;
+	int			tuning_loop_count;
 
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
-- 
2.7.4

