Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A54C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036B20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pS7uVPzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfEWJ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:27:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:27:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9QuRG4041804
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:26:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9QuRG4041804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603616;
        bh=PzWiXWbuZBSOSkVnmtdtZG78MA42jnTVqc1lbPq3Ihg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pS7uVPzCi1kxl2D2vUpzGbJq3p9hrXiAkIWTPsGdyZSPExwd72uNFbo5hGYhXRHOg
         o64+3ZXCUtqXhCnkicTq6n6cubVMZ8Vjt7O0cKuB3oXmCo/ChOywzuZcVH0oDBVGoI
         wXM0uVH0GNEO9fVYMqPgTk8zv1Pr2BUWdtOyjPHefBFnyWo5YS1TupwZZt/1tW0X8t
         XFxGhoFs16PwRXCnKOOYT99BqR5S7iq6feFSpHRmPb/rywjmm+c4G7FC8lIFF8m4xP
         0Ob4HK4aOtWyt8YRK5DLpxRCPQhVDHl9dqewiLet0MAN8/6meeFgc3WTRkAMgFdBkk
         VtnA6xrJgUdYA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9Qta54041801;
        Thu, 23 May 2019 02:26:55 -0700
Date:   Thu, 23 May 2019 02:26:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhang Rui <tipbot@zytor.com>
Message-ID: <tip-32fb480e0a2cf1f71e4174d6477198c94dbc746c@git.kernel.org>
Cc:     peterz@infradead.org, rafael.j.wysocki@intel.com, hpa@zytor.com,
        rui.zhang@intel.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com
Reply-To: rafael.j.wysocki@intel.com, hpa@zytor.com, peterz@infradead.org,
          len.brown@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rui.zhang@intel.com,
          tglx@linutronix.de
In-Reply-To: <9fcb4719aeb7efccf3bc75ed8dd559e46121649f.1557769318.git.len.brown@intel.com>
References: <9fcb4719aeb7efccf3bc75ed8dd559e46121649f.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] powercap/intel_rapl: Support multi-die/package
Git-Commit-ID: 32fb480e0a2cf1f71e4174d6477198c94dbc746c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  32fb480e0a2cf1f71e4174d6477198c94dbc746c
Gitweb:     https://git.kernel.org/tip/32fb480e0a2cf1f71e4174d6477198c94dbc746c
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:51 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:32 +0200

powercap/intel_rapl: Support multi-die/package

RAPL "package" domains are actually implemented in hardware per-die.
Thus, the new multi-die/package systems have mulitple domains
within each physical package.

Update the intel_rapl driver to be "die aware" -- exporting multiple
domains within a single package, when present.  No change on single
die/package systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/9fcb4719aeb7efccf3bc75ed8dd559e46121649f.1557769318.git.len.brown@intel.com

---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c3c0c23180b..9202dbcef96d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package_domain(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1459,7 +1459,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
