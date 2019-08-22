Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A092A233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NaXy/4yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfHVVL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:11:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfHVVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:11:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7ML8wCQ066920;
        Thu, 22 Aug 2019 21:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=BSgF3dcZ1Zww3m+mRQs7kxx7hplXe0cPCO1EsVNkNIk=;
 b=NaXy/4ydMECJhD2+36YRQL7cteuWgTIvvU6BaTbWOXenbdywpBzAibb7ENnmVe5j4nke
 EU5F71G7T55p5gp9TUeFllkmkLG1ykJNPQsYN9HoWoVijT4Gr5jI6lQvZZzRROS69+Rh
 h1CL8o/fH3EzcyJIf+jDCBffdbAHrJ31c3MXEo77kPjfI6oMXd4SvTqWQ2g4h1bdqZrh
 jZgXu+U8DMt1Y1e++cx9NZfNVCrIV658uUfLh7KRHjE8ZxpZ9oJVhsBK7vWOe3xQ+PfM
 PW1KVYbJKdWfZbW3TyafqCG30YLfurnLZypJUs+GS1QVZW3GyiExdDnG3iMXAy21OYGG HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uea7r8mkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 21:11:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7ML8vpB039193;
        Thu, 22 Aug 2019 21:11:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uj1xys8ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 21:11:11 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7MLB9as024180;
        Thu, 22 Aug 2019 21:11:10 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 14:11:09 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, ashok.raj@intel.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com, mihai.carabas@oracle.com
Subject: [PATCH] x86/microcode: Update microcode for all cores in parallel
Date:   Thu, 22 Aug 2019 23:43:47 +0300
Message-Id: <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9357 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9357 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

Microcode update was changed to be serialized due to restrictions after
Spectre days. Updating serially on a large multi-socket system can be
painful since we do this one CPU at a time. Cloud customers have expressed
discontent as services disappear for a prolonged time. The restriction is
that only one core goes through the update while other cores are quiesced.
The update is now done only on the first thread of each core while other
siblings simply wait for this to complete.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/microcode/core.c  | 44 ++++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/microcode/intel.c | 14 ++++-------
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index cb0fdca..577b223 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -63,11 +63,6 @@
  */
 static DEFINE_MUTEX(microcode_mutex);
 
-/*
- * Serialize late loading so that CPUs get updated one-by-one.
- */
-static DEFINE_RAW_SPINLOCK(update_lock);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -566,9 +561,23 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
-	raw_spin_lock(&update_lock);
-	apply_microcode_local(&err);
-	raw_spin_unlock(&update_lock);
+	/*
+	 * Update just on the first CPU in the core. Other siblings
+	 * get the update automatically according to Intel SDM 9.11.6.3
+	 * Update in a System Supporting Intel Hyper-Threading Technology
+	 * Intel Hyper-Threading Technology has implications on the loading of the
+	 * microcode update. The update must be loaded for each core in a physical
+	 * processor. Thus, for a processor supporting Intel Hyper-Threading
+	 * Technology, only one logical processor per core is required to load the
+	 * microcode update. Each individual logical processor can independently
+	 * load the update. However, MP initialization must provide some mechanism
+	 * (e.g. a software semaphore) to force serialization of microcode update
+	 * loads and to prevent simultaneous load attempts to the same core.
+	 */
+	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+		apply_microcode_local(&err);
+	else
+		goto wait_for_siblings;
 
 	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
@@ -578,15 +587,24 @@ static int __reload_late(void *info)
 		ret = 1;
 	}
 
+wait_for_siblings:
 	/*
-	 * Increase the wait timeout to a safe value here since we're
-	 * serializing the microcode update and that could take a while on a
-	 * large number of CPUs. And that is fine as the *actual* timeout will
-	 * be determined by the last CPU finished updating and thus cut short.
+	 * Since we are doing all cores in parallel, and the other
+	 * sibling threads just do a rev update, there is no need to
+	 * increase the timeout
 	 */
-	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC * num_online_cpus()))
+	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
 		panic("Timeout during microcode update!\n");
 
+	/*
+	 * At least one thread has completed update in each core.
+	 * For others, simply call the update to make sure the
+	 * per-cpu cpuinfo can be updated with right microcode
+	 * revision.
+	 */
+	 if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
+		apply_microcode_local(&err);
+
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index ce799cf..884d02d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -793,7 +793,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_intel *mc;
 	enum ucode_state ret;
-	static int prev_rev;
 	u32 rev;
 
 	/* We should bind the task to the CPU */
@@ -836,14 +835,11 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 	}
 
-	if (rev != prev_rev) {
-		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
-			rev,
-			mc->hdr.date & 0xffff,
-			mc->hdr.date >> 24,
-			(mc->hdr.date >> 16) & 0xff);
-		prev_rev = rev;
-	}
+	pr_info_once("updated to revision 0x%x, date = %04x-%02x-%02x\n",
+		rev,
+		mc->hdr.date & 0xffff,
+		mc->hdr.date >> 24,
+		(mc->hdr.date >> 16) & 0xff);
 
 	ret = UCODE_UPDATED;
 
-- 
1.8.3.1

