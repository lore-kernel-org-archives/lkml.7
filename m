Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656BFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCEE2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714743;
	bh=L5DVtnfAeB1dhNOpFZXhe9aUDAAf5Dkw0v8tUmuSn4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02tdIVhBSbgUsDp7FR5t/axwNpCn+T3MgQ3HupEYZvC8T3mZ17VfhMlufQbQ5ACuz
	 vha8W/onQcVgKyqPWjwakq4vTn45HonlZpRwwEB8v5Qgl/eVElb5IcV+qYjwLtJ6a6
	 WBfAInTY2swaFDAjR9tD1g3ompqMzWSVUjZauZfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfC0TZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387632AbfC0SFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A2E217F9;
        Wed, 27 Mar 2019 18:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709914;
        bh=L5DVtnfAeB1dhNOpFZXhe9aUDAAf5Dkw0v8tUmuSn4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7OndqDdshyZr2ekSR/DiJb0uuZsKPSdGiftlk5ybJ2dSNQ9XLJC/QO80AZdaDt6/
         ZO6pv75+4o/tclUfiyqbO2jIPGlgz14k30r8WwCc9c2WX7zPMPXr4HcAdjzt118bGf
         dhV87uDTbm5/mM5dhVHnN6U4LbusZSlQFduVQIuI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Erwan Velu <erwanaliasr1@gmail.com>,
        Erwan Velu <e.velu@criteo.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 109/262] cpufreq: acpi-cpufreq: Report if CPU doesn't support boost technologies
Date:   Wed, 27 Mar 2019 13:59:24 -0400
Message-Id: <20190327180158.10245-109-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erwan Velu <erwanaliasr1@gmail.com>

[ Upstream commit 1222d527f314c86a3b59a522115d62facc5a7965 ]

There is some rare cases where CPB (and possibly IDA) are missing on
processors.

This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix
erratum 1076 (CPB bit)") and following.

In such context, the boost status isn't reported by
/sys/devices/system/cpu/cpufreq/boost.

This commit is about printing a message to report that the CPU
doesn't expose the boost capabilities.

This message could help debugging platforms hit by this phenomena.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
[ rjw: Change the message text somewhat ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d62fd374d5c7..c72258a44ba4 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -916,8 +916,10 @@ static void __init acpi_cpufreq_boost_init(void)
 {
 	int ret;
 
-	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
+	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
+		pr_debug("Boost capabilities not present in the processor\n");
 		return;
+	}
 
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
-- 
2.19.1

