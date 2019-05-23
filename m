Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35686C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F8B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fX+2OgK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfEWJaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:30:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:30:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9TmPj4042301
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:29:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9TmPj4042301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558603789;
        bh=qgM6/UiOOJV7ufSHfkgzdvkTUZg0ZjkUNWfAxuSX/R0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fX+2OgK6C+zjN00IXJiml5ZfXURx7bTkG/ed+Q7T24AU/rdBBFcHJxJXYhDPfElvm
         sfWf8PeANgo4m69awrWtorgilrxmauJbrZ+ix/i0r6Mmh1ma+Hzy4dtDXQ6IkXf85A
         /uNvmRFl5D0ymUOQZZ9vdguSVbgawpBdQM3U93li+vKMJDTPBrhCNmdBZabAbambWz
         XEoozbWuyp2X85x1Vb1CQ/8RTcoazFwbbJPgWMjKPdFIT2/TnwMw3iKrXyUOjBPPaN
         0kMA6t4IUjlT/seqscX2Vsht70awAy4XL1XVmyOv4DXoqUfIlwfpUxnaHd7W4q4urX
         P/tLkDJQOSr9g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9TlsP4042284;
        Thu, 23 May 2019 02:29:47 -0700
Date:   Thu, 23 May 2019 02:29:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Len Brown <tipbot@zytor.com>
Message-ID: <tip-b73ed8dc0597c11ec5064d06b9bbd4e541b6d4e7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, Brice.Goglin@inria.fr,
        peterz@infradead.org, tglx@linutronix.de, len.brown@intel.com,
        mingo@kernel.org
Reply-To: mingo@kernel.org, len.brown@intel.com, tglx@linutronix.de,
          Brice.Goglin@inria.fr, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org
In-Reply-To: <d9d3228b82fb5665e6f93a0ccd033fe022558521.1557769318.git.len.brown@intel.com>
References: <d9d3228b82fb5665e6f93a0ccd033fe022558521.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] topology: Create package_cpus sysfs attribute
Git-Commit-ID: b73ed8dc0597c11ec5064d06b9bbd4e541b6d4e7
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

Commit-ID:  b73ed8dc0597c11ec5064d06b9bbd4e541b6d4e7
Gitweb:     https://git.kernel.org/tip/b73ed8dc0597c11ec5064d06b9bbd4e541b6d4e7
Author:     Len Brown <len.brown@intel.com>
AuthorDate: Mon, 13 May 2019 13:58:55 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:34 +0200

topology: Create package_cpus sysfs attribute

The existing sysfs cpu/topology/core_siblings (and core_siblings_list)
attributes are documented, implemented, and used by programs to represent
set of logical CPUs sharing the same package.

This makes sense if the next topology level above a core is always a
package.  But on systems where there is a die topology level between a core
and a package, the name and its definition become inconsistent.

So without changing its function, add a name for this map that describes
what it actually is -- package CPUs -- the set of CPUs that share the same
package.

This new name will be immune to changes in topology, since it describes
threads at the current level, not siblings at a contained level.

Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d9d3228b82fb5665e6f93a0ccd033fe022558521.1557769318.git.len.brown@intel.com

---
 Documentation/cputopology.txt | 12 ++++++------
 drivers/base/topology.c       |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 2ff8a1e9a2db..48af5c290e20 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -46,15 +46,15 @@ thread_siblings_list:
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-core_siblings:
+package_cpus:
 
-	internal kernel map of cpuX's hardware threads within the same
-	physical_package_id.
+	internal kernel map of the CPUs sharing the same physical_package_id.
+	(deprecated name: "core_siblings")
 
-core_siblings_list:
+package_cpus_list:
 
-	human-readable list of cpuX's hardware threads within the same
-	physical_package_id.
+	human-readable list of CPUs sharing the same physical_package_id.
+	(deprecated name: "core_siblings_list")
 
 book_siblings:
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 50352cf96f85..dc3c19b482f3 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(package_cpus, core_cpumask);
+static DEVICE_ATTR_RO(package_cpus);
+static DEVICE_ATTR_RO(package_cpus_list);
+
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
@@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_thread_siblings_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_package_cpus.attr,
+	&dev_attr_package_cpus_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
 	&dev_attr_book_siblings.attr,
