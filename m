Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614EEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F421473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i2iXEMeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfFNMbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:31:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13611 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:31:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0393b10000>; Fri, 14 Jun 2019 05:31:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 05:31:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 05:31:45 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 12:31:44 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 12:31:44 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 14 Jun 2019 12:31:43 +0000
Received: from dhcp-10-19-65-14.client.nvidia.com (Not Verified[10.19.65.14]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0393ae0001>; Fri, 14 Jun 2019 05:31:44 -0700
From:   Bitan Biswas <bbiswas@nvidia.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Sivaram Nair <sivaramn@nvidia.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bitan Biswas <bbiswas@nvidia.com>
Subject: [PATCH V1] firmware: tegra: early resume bpmp
Date:   Fri, 14 Jun 2019 05:31:39 -0700
Message-ID: <1560515499-1015-1-git-send-email-bbiswas@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560515505; bh=exJ9JHFPJP+5N/mN9hpEt8WRKiK/ZQdiCxv0VhMcx2E=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=i2iXEMeuyb1JUvpjOVLCFhUjKeIu9f+3JyfYdf2Q1GK83hfu1fo5IxcIAZymXQfdg
         WveAlyu5pvBl76zU0kud2Gi4tUwtjPXZRpQZkFXo71oXYAN4jl+lww3/LZgihUOIz4
         Od/CdXebOvfG9+ODlsh0rU1IgvORAO80a4mZHNMx1j7HNAiMStqBl26uNL2MDr7iPW
         VvMTPArzFW3UZoCfXT4pv0DabrQUpBtdr8oINBKXf+Lq9BbQk3jKJ/g2C63AKULkeM
         GwcaS7ggT1A51Hn3x0mryvVNGE26LEJ2LWdNfPKoSbGCdCc5WF531GPYYOyUVJQZm3
         HjoBzzDfzfHmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early resume Tegra bpmp to fix Xavier clock rate error as follows:
[  159.017101] of_serial 3110000.serial: calling platform_pm_resume+0x0/0x58 @ 317, parent: cbb
[  159.025501] of_serial 3110000.serial: platform_pm_resume+0x0/0x58 returned 0 after 14 usecs
[  159.033694] tegra-i2c 31c0000.i2c: calling platform_pm_resume+0x0/0x58 @ 317, parent: cbb
[  159.042254] tegra-i2c 31c0000.i2c: failed changing clock rate: -22
[  159.048216] PM: dpm_run_callback(): platform_pm_resume+0x0/0x58 returns -22
[  159.055553] tegra-i2c 31c0000.i2c: platform_pm_resume+0x0/0x58 returned -22 after 13072 usecs
[  159.063875] PM: Device 31c0000.i2c failed to resume: error -22

Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
---
 drivers/firmware/tegra/bpmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index dd775e8..de09036 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -811,7 +811,9 @@ static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 		return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tegra_bpmp_pm_ops, NULL, tegra_bpmp_resume);
+const struct dev_pm_ops tegra_bpmp_pm_ops = {
+	.resume_early = tegra_bpmp_resume
+};
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC) || \
     IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
-- 
2.7.4

