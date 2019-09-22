Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A405FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A92D20640
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180724;
	bh=TWjJkqkJlUZehErOcJO7xJ7Tm4AAI0bMcn2ZPApoIwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G87OwM9y/DqSalSAGqm9zkP5v6ON5pQIc/Lifu8UV38+aH95LmCEDa5JxkapGaFHu
	 rG5Fk4IUAVyZRhpQ3uKnfZA5narw2n3kzyt/W44B0rLHzFY/bn9xleWSEFQ8MiDCNE
	 HzY9gs0OjUimLlQRFrCWOh4Oh01lCKDry1RiCi0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437899AbfIVTcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391679AbfIVSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:48:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AFED2196E;
        Sun, 22 Sep 2019 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178115;
        bh=TWjJkqkJlUZehErOcJO7xJ7Tm4AAI0bMcn2ZPApoIwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7FsRjayGjbzMFXqFCJHAtJT+Q3f/VdwenrAODlcgZ8DKHnm4qbw+p8yoxU3pMuNd
         EQzbFd50e8hWa+GQkBIuNRvpTUbTfemxrPk+N9BJHa1N5iEiCS2Sfjtuu4QLDk3nd0
         /oXtIAV5X+zHsmyiqaJdxbjA/qquSN941mMGe5zQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "M. Vefa Bicakci" <m.v.b@runbox.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 172/203] platform/x86: intel_pmc_core_pltdrv: Module removal warning fix
Date:   Sun, 22 Sep 2019 14:43:18 -0400
Message-Id: <20190922184350.30563-172-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "M. Vefa Bicakci" <m.v.b@runbox.com>

[ Upstream commit 0b43e41e93815ecd9616759cf5d64d3a7be8e6fb ]

Prior to this commit, removing the intel_pmc_core_pltdrv module
would cause the following warning:

  Device 'intel_pmc_core.0' does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.
  WARNING: CPU: 0 PID: 2202 at drivers/base/core.c:1238 device_release+0x6f/0x80

This commit hence adds an empty release function for the driver.

Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_pmc_core_pltdrv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index a8754a6db1b8b..186540014c480 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -18,8 +18,16 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
+static void intel_pmc_core_release(struct device *dev)
+{
+	/* Nothing to do. */
+}
+
 static struct platform_device pmc_core_device = {
 	.name = "intel_pmc_core",
+	.dev  = {
+		.release = intel_pmc_core_release,
+	},
 };
 
 /*
-- 
2.20.1

