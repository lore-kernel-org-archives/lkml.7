Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCB0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ECC2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ls9bUNqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfH0TmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:42:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0TmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:42:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RJfTsZ160446;
        Tue, 27 Aug 2019 19:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=5pTe5hwZBp9UUTRDjtksI3USOQH0EX9HvbdnP3Njpi0=;
 b=ls9bUNqSBZHptv1oMPA+ONJdYmZKTNSGI9sWZUwNSX6fmb/OsV7RSok4Ucw0oS87bdfd
 XKIq2bR3D8tGJRFE66RFA6JYzRQLo/LS1LqV/AVnWW4/B5vNtGlwOesH9kf7+bhafXZt
 PV408rG2KBLqHwyWNCBs26WynqvFHbKh5DiMb1WvRBjul2X/ZMyRaHPvzaiTZ11whPPW
 pwMmnEMovBSicYUH+MdFz3a7cvb+oqykYMt3b6zBQVEbWLqqLL10ySdJmS2ZKv4TYKSn
 g7aCgLnwKUgwtBbKsqTtWKNaZUtDkV+4qSrp3ANCZdT7SDKRh/s/t9FU4XzlaOtvr5dw fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2unav6r08f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 19:41:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RJbQdI096178;
        Tue, 27 Aug 2019 19:41:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2un5rjxptk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 19:41:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7RJfkUp011441;
        Tue, 27 Aug 2019 19:41:46 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 12:41:46 -0700
Date:   Tue, 27 Aug 2019 15:43:44 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190827194344.GA15361@bostrovs-us.us.oracle.com>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <2242cc6c-720d-e1bc-817b-c4bb7fddd420@oracle.com>
 <20190826203248.GB49895@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826203248.GB49895@otc-nc-03>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 01:32:48PM -0700, Raj, Ashok wrote:
> On Mon, Aug 26, 2019 at 08:53:05AM -0400, Boris Ostrovsky wrote:
> > On 8/24/19 4:53 AM, Borislav Petkov wrote:
> > >  
> > > +wait_for_siblings:
> > > +	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
> > > +		panic("Timeout during microcode update!\n");
> > > +
> > >  	/*
> > > -	 * Increase the wait timeout to a safe value here since we're
> > > -	 * serializing the microcode update and that could take a while on a
> > > -	 * large number of CPUs. And that is fine as the *actual* timeout will
> > > -	 * be determined by the last CPU finished updating and thus cut short.
> > > +	 * At least one thread has completed update on each core.
> > > +	 * For others, simply call the update to make sure the
> > > +	 * per-cpu cpuinfo can be updated with right microcode
> > > +	 * revision.
> > 
> > 
> > What is the advantage of having those other threads go through
> > find_patch() and (in Intel case) intel_get_microcode_revision() (which
> > involves two MSR accesses) vs. having the master sibling update slaves'
> > microcode revisions? There are only two things that need to be updated,
> > uci->cpu_sig.rev and c->microcode.
> > 
> 
> True, yes we could do that. But there is some warm and comfy feeling
> that you really read the revision from the thread local copy of the revision
> and it matches what was updated in the other thread sibling rather than
> just hardcoding the fixup's. The code looks clean in the sense it looks like
> you are attempting to upgrade but the new revision is reflected correctly
> and you skip the update.
> 
> But if you feel complelled, i'm not opposed to it as long as Boris is 
> happy with the changes :-).



Something like this. I only lightly tested this but if there is interest
I can test it more.



From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date: Tue, 27 Aug 2019 08:26:08 -0400
Subject: [PATCH 2/2] x86/microcode: Have master sibling update slaves' data

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kernel/cpu/microcode/amd.c   | 21 ++++--------------
 arch/x86/kernel/cpu/microcode/core.c  | 40 ++++++++++++++++++++---------------
 arch/x86/kernel/cpu/microcode/intel.c | 18 +++-------------
 3 files changed, 30 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a0e52bd..a365f72 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -668,11 +668,9 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 
 static enum ucode_state apply_microcode_amd(int cpu)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_amd *mc_amd;
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
-	enum ucode_state ret;
 	u32 rev, dummy;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
@@ -689,10 +687,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
-		ret = UCODE_OK;
-		goto out;
-	}
+	if (rev >= mc_amd->hdr.patch_id)
+		return UCODE_OK;
 
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
@@ -700,20 +696,11 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		return UCODE_ERROR;
 	}
 
-	rev = mc_amd->hdr.patch_id;
-	ret = UCODE_UPDATED;
-
-	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
-
-out:
 	uci->cpu_sig.rev = rev;
-	c->microcode	 = rev;
 
-	/* Update boot_cpu_data's revision too, if we're on the BSP: */
-	if (c->cpu_index == boot_cpu_data.cpu_index)
-		boot_cpu_data.microcode = rev;
+	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
 
-	return ret;
+	return UCODE_UPDATED;
 }
 
 static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b..09643c6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -551,6 +551,8 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 static int __reload_late(void *info)
 {
 	int cpu = smp_processor_id();
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool bsp = (c->cpu_index == boot_cpu_data.cpu_index);
 	enum ucode_state err;
 	int ret = 0;
 
@@ -568,30 +570,34 @@ static int __reload_late(void *info)
 	 * loading attempts happen on multiple threads of an SMT core. See
 	 * below.
 	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu) {
 		apply_microcode_local(&err);
-	else
-		goto wait_for_siblings;
 
-	if (err > UCODE_NFOUND) {
-		pr_warn("Error reloading microcode on CPU %d\n", cpu);
-		ret = -1;
-	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
-		ret = 1;
+		if (err > UCODE_NFOUND) {
+			pr_warn("Error reloading microcode on CPU %d\n", cpu);
+			ret = -1;
+		} else if (err == UCODE_UPDATED || err == UCODE_OK) {
+			struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+			int sibling, rev = uci->cpu_sig.rev;
+
+			/* All siblings have same revision */
+			for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
+				c = &cpu_data(sibling);
+				uci = ucode_cpu_info + sibling;
+
+				uci->cpu_sig.rev = rev;
+				c->microcode     = rev;
+			}
+
+			ret = 1;
+		}
 	}
 
-wait_for_siblings:
 	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
 		panic("Timeout during microcode update!\n");
 
-	/*
-	 * At least one thread has completed update on each core.
-	 * For others, simply call the update to make sure the
-	 * per-cpu cpuinfo can be updated with right microcode
-	 * revision.
-	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		apply_microcode_local(&err);
+	if (bsp)
+		boot_cpu_data.microcode = c->microcode;
 
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index ce799cf..04e9aa2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -790,9 +790,7 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct microcode_intel *mc;
-	enum ucode_state ret;
 	static int prev_rev;
 	u32 rev;
 
@@ -814,10 +812,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	 * already.
 	 */
 	rev = intel_get_microcode_revision();
-	if (rev >= mc->hdr.rev) {
-		ret = UCODE_OK;
-		goto out;
-	}
+	if (rev >= mc->hdr.rev)
+		return  UCODE_OK;
 
 	/*
 	 * Writeback and invalidate caches before updating microcode to avoid
@@ -845,17 +841,9 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
-	ret = UCODE_UPDATED;
-
-out:
 	uci->cpu_sig.rev = rev;
-	c->microcode	 = rev;
-
-	/* Update boot_cpu_data's revision too, if we're on the BSP: */
-	if (c->cpu_index == boot_cpu_data.cpu_index)
-		boot_cpu_data.microcode = rev;
 
-	return ret;
+	return UCODE_UPDATED;
 }
 
 static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
-- 
1.8.3.1



