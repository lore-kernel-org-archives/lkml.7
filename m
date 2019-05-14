Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027E5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B82208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfENM6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B17F5945C;
        Tue, 14 May 2019 12:58:45 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25D1660BCF;
        Tue, 14 May 2019 12:58:39 +0000 (UTC)
Date:   Tue, 14 May 2019 20:58:35 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        j-nomura@ce.jp.nec.com, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
References: <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514113826.GM2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 14 May 2019 12:58:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/19 at 01:38pm, Peter Zijlstra wrote:
> On Tue, May 14, 2019 at 04:48:41PM +0800, Dave Young wrote:
> 
> > > I did some tests on the laptop,  thing is:
> > > 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
> > >    on latest Linus master branch, everything works fine.
> > > 
> > > 2. build and test the tip/next-merge-window branch, kernel hangs early
> > > without output, (both 1st boot and kexec boot)
> > 
> > Update about 2.  It should be not early rsdp related, I got the boot log
> > Since can not reproduce with Linus master branch it may have been fixed.
> 
> Nothing was changed here since PTI.
> 
> > [    0.685374][    T1] rcu: Hierarchical SRCU implementation.
> > [    0.686414][    T1] general protection fault: 0000 [#1] SMP PTI
> > [    0.687328][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc6+ #877
> > [    0.687328][    T1] Hardware name: LENOVO 4236NUC/4236NUC, BIOS 83ET82WW (1.52 ) 06/04/2018
> > [    0.687328][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450
> 
> > [    0.687328][    T1] Call Trace:
> > [    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
> > [    0.687328][    T1]  x86_reserve_hardware+0x173/0x180
> > [    0.687328][    T1]  x86_pmu_event_init+0x39/0x220
> 
> The DS buffers are special in that they're part of cpu_entrt_area. If
> this comes apart it might mean your pagetables are dodgy.

Hmm, it seems caused by some WIP branch patches, I suspect below:
commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
x86/paravirt: Standardize 'insn_buff' variable names

The suspicious line is "per_cpu(insn_buff, cpu) = insn_buff;"

I can help to test if need to try anything, eg. debug patch.

I do not know anything of the pti and ds buffer logic, but below chunk
make the next-merge-window branch booting fine on the laptop.
---
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ad47f6415b17..fa254c576032 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -337,7 +337,7 @@ static int alloc_pebs_buffer(int cpu)
 	struct debug_store *ds = hwev->ds;
 	size_t bsiz = x86_pmu.pebs_buffer_size;
 	int max, node = cpu_to_node(cpu);
-	void *buffer, *insn_buff, *cea;
+	void *buffer, *ibuff, *cea;
 
 	if (!x86_pmu.pebs)
 		return 0;
@@ -351,12 +351,12 @@ static int alloc_pebs_buffer(int cpu)
 	 * buffer then.
 	 */
 	if (x86_pmu.intel_cap.pebs_format < 2) {
-		insn_buff = kzalloc_node(PEBS_FIXUP_SIZE, GFP_KERNEL, node);
-		if (!insn_buff) {
+		ibuff = kzalloc_node(PEBS_FIXUP_SIZE, GFP_KERNEL, node);
+		if (!ibuff) {
 			dsfree_pages(buffer, bsiz);
 			return -ENOMEM;
 		}
-		per_cpu(insn_buff, cpu) = insn_buff;
+		per_cpu(insn_buff, cpu) = ibuff;
 	}
 	hwev->ds_pebs_vaddr = buffer;
 	/* Update the cpu entry area mapping */
