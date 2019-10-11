Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A00C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793E020679
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ce3U5tmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfJKIfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:35:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4298 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJKIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:35:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da03ebb0000>; Fri, 11 Oct 2019 01:35:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Oct 2019 01:35:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Oct 2019 01:35:03 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Oct
 2019 08:35:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Oct 2019 08:35:03 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.133.51]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da03eb60001>; Fri, 11 Oct 2019 01:35:03 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] mailbox: tegra: Fix superfluous IRQ error message
Date:   Fri, 11 Oct 2019 09:34:59 +0100
Message-ID: <20191011083459.11551-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570782907; bh=uduV90yZCZOVYnuJjhT4IRL+/1ynquThjrPfX23FAWk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Ce3U5tmiHnuM/llBKs2xBAhzGod5yJQAxo1HoOAUtGb5EYCfNdcNcmy5+t8IFilTj
         Uh8rIkKTJmfwJCTGae2xVJpAami5cX+1UkYJGFLFNEoW3NtUlfjXw39XXLpfnOb6IV
         Slc8poAudWP5sFdt+c1cYhkzJVjMKESnb5SemM3s0VhoMseOhI2co5XPjOgMMLH14J
         U8z0LhfiWKU5w6mP2ql7sQmtbGw9+n2ZImHwXC7Mtdx/iu1E7MdHiNLCoDpMKuFT0i
         ysr5iWxBYnj1wnkyi8TNaZrdSYGYzxOANJGPHbRJRYNXnFufALZRZlyILDzRTWmEvL
         TWChwkLcOwQCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/mailbox/tegra-hsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 4c5ba35d48d4..834b35dc3b13 100644
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
2.17.1

