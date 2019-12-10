Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A19FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC0B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012789;
	bh=IeNIQDPcwkickLJ2DTiLL8BG+ZNio8sQfsfdhilggbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DQ7mjoQRZfiIXm34UB1HC80mCe0CPo5xJo4jmUE2TowNYptwxKFidydyUYbv3v8IK
	 iuW8bKMk3cfS/qZWsOibt+jWBaglFQoPPL9LIXcjvkVU/WQJE0ftP+w9IWXZKB8mBE
	 gGgnLm9d6tQD+XfCV4+cdyeIWcN1gz4WEdLQtUuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfLJVTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:19:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbfLJVMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9DB246AA;
        Tue, 10 Dec 2019 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012342;
        bh=IeNIQDPcwkickLJ2DTiLL8BG+ZNio8sQfsfdhilggbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItQSSk9jFpbz/E0FHEHmXkGvivCgXdBXsNINdkmGAchGxrtRVSSb2GQ4LnC/OFKdz
         Y9xaidAG3xKF72x2T0hPCa+jSD8u6xe9heFznxNMDBOzsO4ssoilBcxTFskGrStMYu
         71zU/9JIXyqC+xHbol8R9mUZ/+u6qyUnMKXjrGAU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 273/350] mailbox: tegra: Fix superfluous IRQ error message
Date:   Tue, 10 Dec 2019 16:06:18 -0500
Message-Id: <20191210210735.9077-234-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit c745da8d4320c49e54662c0a8f7cb6b8204f44c4 ]

Commit 7723f4c5ecdb ("driver core: platform: Add an error message to
platform_get_irq*()") added an error message to avoid drivers having
to print an error message when IRQ lookup fails. However, there are
some cases where IRQs are optional and so new optional versions of
the platform_get_irq*() APIs have been added for these cases.

The IRQs for Tegra HSP module are optional because not all instances
of the module have the doorbell and all of the shared interrupts.
Hence, since the above commit was applied the following error messages
are now seen on Tegra194 ...

 ERR KERN tegra-hsp c150000.hsp: IRQ doorbell not found
 ERR KERN tegra-hsp c150000.hsp: IRQ shared0 not found

The Tegra HSP driver deliberately does not fail if these are not found
and so fix the above errors by updating the Tegra HSP driver to use
the platform_get_irq_byname_optional() API.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20191011083459.11551-1-jonathanh@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/tegra-hsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 4c5ba35d48d43..834b35dc3b137 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -657,7 +657,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	hsp->num_db = (value >> HSP_nDB_SHIFT) & HSP_nINT_MASK;
 	hsp->num_si = (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
 
-	err = platform_get_irq_byname(pdev, "doorbell");
+	err = platform_get_irq_byname_optional(pdev, "doorbell");
 	if (err >= 0)
 		hsp->doorbell_irq = err;
 
@@ -677,7 +677,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 			if (!name)
 				return -ENOMEM;
 
-			err = platform_get_irq_byname(pdev, name);
+			err = platform_get_irq_byname_optional(pdev, name);
 			if (err >= 0) {
 				hsp->shared_irqs[i] = err;
 				count++;
-- 
2.20.1

