Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D8C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84082184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="3OCdb49T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfHHKyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:54:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHKyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:54:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78AsJnj3127174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:54:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78AsJnj3127174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261659;
        bh=uzbeeHqVgjUyiCK6krtHxJDeX6i1CDXl0yqQghz+kjM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=3OCdb49Td9a+imJQtwndIAYOQ9do5pxGKLFQFr8YieSBnPM2bm3DtJ3L37+gAXfV3
         KOGY3ie4uAFrrj2uaV04pgqWPa+qsuxjCwo0PpREh46PCXy8LJBxeSiTvmJ6z8kz+f
         8kU3l6rzhI0c3nikFlB9ou6qx0yEWpF05Mv24j6yI/IMPEXZRZ1tgCPfpqzwkKb83U
         Fo+HL2mQtjQVZpzunlPz0vCZyVg7p1J9uE+tO/IWkhhGbG4tjoY1IYJDoRrvvjvqzt
         8aOJVtPm674cbWqEVqDtdm54VeAzldT6W05d0CyxRVUq93J2RJjUgyLxZo1zOvrRne
         /6pl2Jo2JAErg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78AsIXA3127171;
        Thu, 8 Aug 2019 03:54:18 -0700
Date:   Thu, 8 Aug 2019 03:54:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-99d84bf8c65a7a0dbc9e166ca0a58ed949ac4f37@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, aaron.lwe@gmail.com,
        naravamudan@digitalocean.com, valentin.schneider@arm.com,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        jdesfossez@digitalocean.com, pauld@redhat.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org,
          valentin.schneider@arm.com, naravamudan@digitalocean.com,
          mingo@kernel.org, hpa@zytor.com, pauld@redhat.com,
          jdesfossez@digitalocean.com, aaron.lwe@gmail.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com>
References: <0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] stop_machine: Fix stop_cpus_in_progress ordering
Git-Commit-ID: 99d84bf8c65a7a0dbc9e166ca0a58ed949ac4f37
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

Commit-ID:  99d84bf8c65a7a0dbc9e166ca0a58ed949ac4f37
Gitweb:     https://git.kernel.org/tip/99d84bf8c65a7a0dbc9e166ca0a58ed949ac4f37
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:37 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

stop_machine: Fix stop_cpus_in_progress ordering

Make sure the entire for loop has stop_cpus_in_progress set.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com
---
 kernel/stop_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b4f83f7bdf86..c7031a22aa7b 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -383,6 +383,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 	 */
 	preempt_disable();
 	stop_cpus_in_progress = true;
+	barrier();
 	for_each_cpu(cpu, cpumask) {
 		work = &per_cpu(cpu_stopper.stop_work, cpu);
 		work->fn = fn;
@@ -391,6 +392,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
+	barrier();
 	stop_cpus_in_progress = false;
 	preempt_enable();
 
