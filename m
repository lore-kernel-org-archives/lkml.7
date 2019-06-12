Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC1820874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TyEyvxw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407654AbfFLMe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:34:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbfFLMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:34:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCY8Vp686254
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:34:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCY8Vp686254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342849;
        bh=i8E3Pjz132lVE/zyO3itgO5Jj7nZ1IpdYVG2JGHWWAE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TyEyvxw2ds5wYz0DLZh2WakXDjqXhWWBkiIPtAB8sy6OaSNJcORxqpRwSTOR59rYB
         Yl+m5Zn5JmVuFlgnzDGdpeZt+uIhFdYsdQIJUyDwMTLP6RkJF0XE4AoVFda8TJleqw
         6R6969Jp+XEU64YQoaVoBNhNrUYCzTEBw/51YTJybTp9SwOpL5E1+p1e5CD3iNAGLE
         v/EqD7nOr4qhj3ZvIcj/ch01jmPn8Zi437j+QaqXuRApzMRmlUewBcb3cpCdhAfNkE
         NwXHRGx90oj0QsnA/OTu1sM2006fVYRkeFgXynYQyEphNfcxI1jB3pf8XrORUie1AD
         nuFp29VMkv9Ag==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCY8Zv686251;
        Wed, 12 Jun 2019 05:34:08 -0700
Date:   Wed, 12 Jun 2019 05:34:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavankumar Kondeti <tipbot@zytor.com>
Message-ID: <tip-a66d955e910ab0e598d7a7450cbe6139f52befe7@git.kernel.org>
Cc:     konrad.wilk@oracle.com, mojha@codeaurora.org, jkosina@suse.cz,
        mingo@kernel.org, hpa@zytor.com, rjw@rjwysocki.net,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        pkondeti@codeaurora.org, jpoimboe@redhat.com, pavel@ucw.cz
Reply-To: tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, len.brown@intel.com,
          pkondeti@codeaurora.org, jpoimboe@redhat.com, pavel@ucw.cz,
          konrad.wilk@oracle.com, mojha@codeaurora.org, jkosina@suse.cz,
          mingo@kernel.org, hpa@zytor.com, rjw@rjwysocki.net
In-Reply-To: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
References: <1559536263-16472-1-git-send-email-pkondeti@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/hotplug] cpu/hotplug: Abort disabling secondary CPUs if
 wakeup is pending
Git-Commit-ID: a66d955e910ab0e598d7a7450cbe6139f52befe7
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

Commit-ID:  a66d955e910ab0e598d7a7450cbe6139f52befe7
Gitweb:     https://git.kernel.org/tip/a66d955e910ab0e598d7a7450cbe6139f52befe7
Author:     Pavankumar Kondeti <pkondeti@codeaurora.org>
AuthorDate: Mon, 3 Jun 2019 10:01:03 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 11:03:05 +0200

cpu/hotplug: Abort disabling secondary CPUs if wakeup is pending

When "deep" suspend is enabled, all CPUs except the primary CPU are frozen
via CPU hotplug one by one. After all secondary CPUs are unplugged the
wakeup pending condition is evaluated and if pending the suspend operation
is aborted and the secondary CPUs are brought up again.

CPU hotplug is a slow operation, so it makes sense to check for wakeup
pending in the freezer loop before bringing down the next CPU. This
improves the system suspend abort latency significantly.

[ tglx: Massaged changelog and improved printk message ]

Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iri Kosina <jkosina@suse.cz>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/1559536263-16472-1-git-send-email-pkondeti@codeaurora.org

---
 kernel/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index be82cbc11a8a..0778249cd49d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1221,6 +1221,13 @@ int freeze_secondary_cpus(int primary)
 	for_each_online_cpu(cpu) {
 		if (cpu == primary)
 			continue;
+
+		if (pm_wakeup_pending()) {
+			pr_info("Wakeup pending. Abort CPU freeze\n");
+			error = -EBUSY;
+			break;
+		}
+
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
 		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
