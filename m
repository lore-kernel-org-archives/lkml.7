Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EFEC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031A21855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368584;
	bh=aRygrkTRpNOj80+8d7E0sHx+5RlqO6UClzeir1+cF74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxaCbn6wzXN9+c9HzBZIckMZQQAp9D6NSUKoXQwcQQMnRAJBSkZpooDHnCAMMSlEQ
	 sureUUFUi0x2CfaVBGkLYxqC52CrW2UHerOHWnXbDhYiJjgdKRP/jNzWLYBO43HleT
	 D8TZaoHA2UglK+e47G+tVrWeSWMlVO/3ttxrhXjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfDDJDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbfDDJC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:02:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E4521741;
        Thu,  4 Apr 2019 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368576;
        bh=aRygrkTRpNOj80+8d7E0sHx+5RlqO6UClzeir1+cF74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT1EbXkxx0clAywahT7lruFM900eGi8CSawyo9a8Yo2ZQ47f42smIKGEmCOZSAcSc
         aTGX1nb/cFQVEeJ7W8MzVUk/qBEslm4Yx8qfFrCs0MG4b0+Z3DkXQrDOiVHxQVInnw
         w2UMQ0FKIMBDtQQ29O8wHt7zZ0n++P0CGf3uFq7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erwan Velu <e.velu@criteo.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/187] cpufreq: acpi-cpufreq: Report if CPU doesnt support boost technologies
Date:   Thu,  4 Apr 2019 10:46:51 +0200
Message-Id: <20190404084606.532165443@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b61f4ec43e06..aca30f45172e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -911,8 +911,10 @@ static void __init acpi_cpufreq_boost_init(void)
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



