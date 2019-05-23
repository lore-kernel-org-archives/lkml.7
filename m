Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863D1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B7C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RjDTA3w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfEWJYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:24:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfEWJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:24:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9O6Qo4040002
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:24:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9O6Qo4040002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603447;
        bh=IzhC8+GAMc/UbDs0JRk7sqe8QZCdglI5SAz1/Q8QIoA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RjDTA3w1rSow9e+De2mH2+MEGYpt2CUPOM1KXDc74Jfdj4iDxHOKAFq0GB/JXmME4
         MQly/Hm29DPcnbbNsHlOgBfyC+HPJTY0QCPot4AxEkzWJXQ+eh87WP4w6V7NWqqFat
         gN8sFAHuX69nd0oHA/C1hqBpfcwina/GPVeqEc6KKnmroAy7zDuMax5hMcjHeicN6u
         SvP+4H1luxdRtRs0aCMvItlEEScP/Y6WRZjIBhjQXPgNr2YHuJDwNaVDxyU+2RS6Md
         8QpLteRo42x/yMDl7vBVeOaQONZ1QWljs0pveUYmj58XaHb9yU0pIzCjDsS2x3+xYm
         zFEBUr89wTBxw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9O50D4039998;
        Thu, 23 May 2019 02:24:05 -0700
Date:   Thu, 23 May 2019 02:24:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-0e344d8c709fe01d882fc0fb5452bedfe5eba67a@git.kernel.org>
Cc:     len.brown@intel.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: len.brown@intel.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org
In-Reply-To: <e7d1caaf4fbd24ee40db6d557ab28d7d83298900.1557769318.git.len.brown@intel.com>
References: <e7d1caaf4fbd24ee40db6d557ab28d7d83298900.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] cpu/topology: Export die_id
Git-Commit-ID: 0e344d8c709fe01d882fc0fb5452bedfe5eba67a
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

Commit-ID:  0e344d8c709fe01d882fc0fb5452bedfe5eba67a
Gitweb:     https://git.kernel.org/tip/0e344d8c709fe01d882fc0fb5452bedfe5eba67a
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:47 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:31 +0200

cpu/topology: Export die_id

Export die_id in cpu topology, for the benefit of hardware that has
multiple-die/package.

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org
Link: https://lkml.kernel.org/r/e7d1caaf4fbd24ee40db6d557ab28d7d83298900.1557769318.git.len.brown@intel.com

---
 Documentation/cputopology.txt | 15 ++++++++++++---
 drivers/base/topology.c       |  4 ++++
 include/linux/topology.h      |  3 +++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index cb61277e2308..2ff8a1e9a2db 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -12,6 +12,12 @@ physical_package_id:
 	socket number, but the actual value is architecture and platform
 	dependent.
 
+die_id:
+
+	the CPU die ID of cpuX. Typically it is the hardware platform's
+	identifier (rather than the kernel's).  The actual value is
+	architecture and platform dependent.
+
 core_id:
 
 	the CPU core ID of cpuX. Typically it is the hardware platform's
@@ -81,6 +87,7 @@ For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
 
 	#define topology_physical_package_id(cpu)
+	#define topology_die_id(cpu)
 	#define topology_core_id(cpu)
 	#define topology_book_id(cpu)
 	#define topology_drawer_id(cpu)
@@ -99,9 +106,11 @@ provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
 1) topology_physical_package_id: -1
-2) topology_core_id: 0
-3) topology_sibling_cpumask: just the given CPU
-4) topology_core_cpumask: just the given CPU
+2) topology_die_id: -1
+3) topology_core_id: 0
+4) topology_sibling_cpumask: just the given CPU
+5) topology_core_cpumask: just the given CPU
+6) topology_die_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 5fd9f167ecc1..50352cf96f85 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -43,6 +43,9 @@ static ssize_t name##_list_show(struct device *dev,			\
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
+define_id_show_func(die_id);
+static DEVICE_ATTR_RO(die_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
@@ -72,6 +75,7 @@ static DEVICE_ATTR_RO(drawer_siblings_list);
 
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
+	&dev_attr_die_id.attr,
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..5cc8595dd0e4 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -184,6 +184,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
+#ifndef topology_die_id
+#define topology_die_id(cpu)			((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
