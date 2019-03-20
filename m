Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB61218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCTSRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:17:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCTSRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:17:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE9A8A78;
        Wed, 20 Mar 2019 11:17:01 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F723F59C;
        Wed, 20 Mar 2019 11:16:59 -0700 (PDT)
Date:   Wed, 20 Mar 2019 18:16:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        paulus@ozlabs.org, benh@kernel.crashing.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
Message-ID: <20190320181656.GB38229@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw>
 <20190319115747.GB59586@arrakis.emea.arm.com>
 <87lg19y9dp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg19y9dp.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 12:15:46AM +1100, Michael Ellerman wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Wed, Mar 13, 2019 at 10:57:17AM -0400, Qian Cai wrote:
> >> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
> >>  
> >>  	/* data/bss scanning */
> >>  	scan_large_block(_sdata, _edata);
> >> -	scan_large_block(__bss_start, __bss_stop);
> >> +
> >> +	if (bss_hole_start) {
> >> +		scan_large_block(__bss_start, bss_hole_start);
> >> +		scan_large_block(bss_hole_stop, __bss_stop);
> >> +	} else {
> >> +		scan_large_block(__bss_start, __bss_stop);
> >> +	}
> >> +
> >>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);
> >
> > I'm not a fan of this approach but I couldn't come up with anything
> > better. I was hoping we could check for PageReserved() in scan_block()
> > but on arm64 it ends up not scanning the .bss at all.
> >
> > Until another user appears, I'm ok with this patch.
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> I actually would like to rework this kvm_tmp thing to not be in bss at
> all. It's a bit of a hack and is incompatible with strict RWX.
> 
> If we size it a bit more conservatively we can hopefully just reserve
> some space in the text section for it.
> 
> I'm not going to have time to work on that immediately though, so if
> people want this fixed now then this patch could go in as a temporary
> solution.

I think I have a simpler idea. Kmemleak allows punching holes in
allocated objects, so just turn the data/bss sections into dedicated
kmemleak objects. This happens when kmemleak is initialised, before the
initcalls are invoked. The kvm_free_tmp() would just free the
corresponding part of the bss.

Patch below, only tested briefly on arm64. Qian, could you give it a try
on powerpc? Thanks.

--------8<------------------------------
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 683b5b3805bd..c4b8cb3c298d 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -712,6 +712,8 @@ static void kvm_use_magic_page(void)
 
 static __init void kvm_free_tmp(void)
 {
+	kmemleak_free_part(&kvm_tmp[kvm_tmp_index],
+			   ARRAY_SIZE(kvm_tmp) - kvm_tmp_index);
 	free_reserved_area(&kvm_tmp[kvm_tmp_index],
 			   &kvm_tmp[ARRAY_SIZE(kvm_tmp)], -1, NULL);
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 707fa5579f66..0f6adcbfc2c7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1529,11 +1529,6 @@ static void kmemleak_scan(void)
 	}
 	rcu_read_unlock();
 
-	/* data/bss scanning */
-	scan_large_block(_sdata, _edata);
-	scan_large_block(__bss_start, __bss_stop);
-	scan_large_block(__start_ro_after_init, __end_ro_after_init);
-
 #ifdef CONFIG_SMP
 	/* per-cpu sections scanning */
 	for_each_possible_cpu(i)
@@ -2071,6 +2066,15 @@ void __init kmemleak_init(void)
 	}
 	local_irq_restore(flags);
 
+	/* register the data/bss sections */
+	create_object((unsigned long)_sdata, _edata - _sdata,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+	create_object((unsigned long)__start_ro_after_init,
+		      __end_ro_after_init - __start_ro_after_init,
+		      KMEMLEAK_GREY, GFP_ATOMIC);
+
 	/*
 	 * This is the point where tracking allocations is safe. Automatic
 	 * scanning is started during the late initcall. Add the early logged
