Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F04C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804FD20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368154;
	bh=9sOUGrBW8kZtMKKZYoYrxbXZNrd8fQljUIMd8xx7dTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ToO+RMjjHOED1Xl++bbK7AZGmMxYX5dlcWXpk2w7NKFdZD+0uqXYW4ghs/pTYVG6D
	 D1szF2na3jQl17fy1slmJExUvjgGk9ZhbTnKJjr1mXoVtKqbTHPAJuYHKk0toeP5/L
	 hyzs+PYUFrIvmi9v+FlAh6/wNnN2RV34W2GWXCZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfDDIzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730344AbfDDIzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0DE20693;
        Thu,  4 Apr 2019 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368144;
        bh=9sOUGrBW8kZtMKKZYoYrxbXZNrd8fQljUIMd8xx7dTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igF8CgRZmpa6PX6CafbQoQElmI+ixuBk20JHRFeu7p4+3svsVREZ02dSpoUkRLi8A
         fAatteStnLmvTQXyou1s7sN/0tMDlvfLGq4pSZ4eHJXxFkT6S5opugC8bKgModxNTn
         1ppB7GCHAwPntRNS/0iJEFZu2QGbehUuOdQTwMBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erwan Velu <e.velu@criteo.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/121] cpufreq: acpi-cpufreq: Report if CPU doesnt support boost technologies
Date:   Thu,  4 Apr 2019 10:47:21 +0200
Message-Id: <20190404084548.137690696@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index d0c34df0529c..51a3c15ace09 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -909,8 +909,10 @@ static void __init acpi_cpufreq_boost_init(void)
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



