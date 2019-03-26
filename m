Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B194C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ADC2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbfCZWkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:40:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbfCZWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:39:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36E68169E;
        Tue, 26 Mar 2019 15:39:58 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FB903F614;
        Tue, 26 Mar 2019 15:39:57 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com,
        james.morse@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 4/4] perf: arm_spe: Enable ACPI/Platform automatic module loading
Date:   Tue, 26 Mar 2019 17:39:38 -0500
Message-Id: <20190326223938.5365-5-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326223938.5365-1-jeremy.linton@arm.com>
References: <20190326223938.5365-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets add the MODULE_TABLE and platform id_table entries so that
the SPE driver can attach to the ACPI platform device created by
the core pmu code.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 7cb766dafe85..ffa2c76c08bb 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1176,7 +1176,13 @@ static const struct of_device_id arm_spe_pmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_spe_pmu_of_match);
 
-static int arm_spe_pmu_device_dt_probe(struct platform_device *pdev)
+static const struct platform_device_id arm_spe_match[] = {
+	{ "arm,spe-v1", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, arm_spe_match);
+
+static int arm_spe_pmu_device_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct arm_spe_pmu *spe_pmu;
@@ -1236,11 +1242,12 @@ static int arm_spe_pmu_device_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver arm_spe_pmu_driver = {
+	.id_table = arm_spe_match,
 	.driver	= {
 		.name		= DRVNAME,
 		.of_match_table	= of_match_ptr(arm_spe_pmu_of_match),
 	},
-	.probe	= arm_spe_pmu_device_dt_probe,
+	.probe	= arm_spe_pmu_device_probe,
 	.remove	= arm_spe_pmu_device_remove,
 };
 
-- 
2.20.1

