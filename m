Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC12EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A9221BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178439;
	bh=9tdpQ5MRKMrYml1SMjDNx+7OaO3nSLGYFfNcKHsiyus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cNWTdgd1jnwJmWOVzFR8E+Tw4md3C2ZkKE0Er+Ktizlr63DwR37wlTgJpQYZOb7Cd
	 /gyFbSyvOON9ML13DAV4gl5XiWrVifrbAYQXErLcT8q4pP8qJb5gZmCQ2CjPjyLDsv
	 O1kTaY2PMbZvVoTt6nsB8vWapXGxHRC3DdvNsouA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394476AbfIVSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394356AbfIVSxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:53:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9788F21D56;
        Sun, 22 Sep 2019 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178418;
        bh=9tdpQ5MRKMrYml1SMjDNx+7OaO3nSLGYFfNcKHsiyus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hANXvmHKk5eh9LKgk04E5ky98ADlXLQVTyk7wzq+k3oVc89QO75mfFQqd1/4QoPfN
         QiHqsucIOlxbd1n0Li5ilZ9B5iujZWY8x77Hu6BPXyVaA2DjWu5UCeGTEL5Ll1a6ig
         Q4+ojAbJeIOq1sJhO79sjwLhNEdhmzPxB5VqdkoI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 156/185] platform/x86: intel_pmc_core: Do not ioremap RAM
Date:   Sun, 22 Sep 2019 14:48:54 -0400
Message-Id: <20190922184924.32534-156-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "M. Vefa Bicakci" <m.v.b@runbox.com>

[ Upstream commit 7d505758b1e556cdf65a5e451744fe0ae8063d17 ]

On a Xen-based PVH virtual machine with more than 4 GiB of RAM,
intel_pmc_core fails initialization with the following warning message
from the kernel, indicating that the driver is attempting to ioremap
RAM:

  ioremap on RAM at 0x00000000fe000000 - 0x00000000fe001fff
  WARNING: CPU: 1 PID: 434 at arch/x86/mm/ioremap.c:186 __ioremap_caller.constprop.0+0x2aa/0x2c0
...
  Call Trace:
   ? pmc_core_probe+0x87/0x2d0 [intel_pmc_core]
   pmc_core_probe+0x87/0x2d0 [intel_pmc_core]

This issue appears to manifest itself because of the following fallback
mechanism in the driver:

	if (lpit_read_residency_count_address(&slp_s0_addr))
		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;

The validity of address PMC_BASE_ADDR_DEFAULT (i.e., 0xFE000000) is not
verified by the driver, which is what this patch introduces. With this
patch, if address PMC_BASE_ADDR_DEFAULT is in RAM, then the driver will
not attempt to ioremap the aforementioned address.

Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_pmc_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index be6cda89dcf5b..01a530e2f8017 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -882,10 +882,14 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (pmcdev->map == &spt_reg_map && !pci_dev_present(pmc_pci_ids))
 		pmcdev->map = &cnp_reg_map;
 
-	if (lpit_read_residency_count_address(&slp_s0_addr))
+	if (lpit_read_residency_count_address(&slp_s0_addr)) {
 		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
-	else
+
+		if (page_is_ram(PHYS_PFN(pmcdev->base_addr)))
+			return -ENODEV;
+	} else {
 		pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
+	}
 
 	pmcdev->regbase = ioremap(pmcdev->base_addr,
 				  pmcdev->map->regmap_length);
-- 
2.20.1

