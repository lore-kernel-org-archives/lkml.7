Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFDCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACA72084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403851AbfJWJ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:28:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390165AbfJWJ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20CDCB5AF;
        Wed, 23 Oct 2019 09:28:26 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mperttunen@nvidia.com, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH] cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag
Date:   Wed, 23 Oct 2019 11:27:03 +0200
Message-Id: <20191023092703.30767-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver doesn't provide ->get() method to read current frequency.
Let cpufreq core set a frequency which is specified in freq-table by
setting CPUFREQ_NEED_INITIAL_FREQ_CHECK flag. As a result policy->cur
is set to a correct value as well.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/cpufreq/tegra186-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index bcecb068b51b..6ce6298bd2d7 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -93,7 +93,8 @@ static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
 
 static struct cpufreq_driver tegra186_cpufreq_driver = {
 	.name = "tegra186",
-	.flags = CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+	.flags = CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = tegra186_cpufreq_set_target,
 	.init = tegra186_cpufreq_init,
-- 
2.16.4

