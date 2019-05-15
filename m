Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FCC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B220862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEOBJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfEOBJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 59797308FC5E;
        Wed, 15 May 2019 01:09:03 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5442260166;
        Wed, 15 May 2019 01:08:57 +0000 (UTC)
Date:   Wed, 15 May 2019 09:08:50 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, j-nomura@ce.jp.nec.com,
        kasong@redhat.com, fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190515010850.GA9159@dhcp-128-65.nay.redhat.com>
References: <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
 <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
 <20190514140916.GA90245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514140916.GA90245@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 15 May 2019 01:09:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/19 at 04:09pm, Ingo Molnar wrote:
> 
> * Dave Young <dyoung@redhat.com> wrote:
> 
> > On 05/14/19 at 01:38pm, Peter Zijlstra wrote:
> > > On Tue, May 14, 2019 at 04:48:41PM +0800, Dave Young wrote:
> > > 
> > > > > I did some tests on the laptop,  thing is:
> > > > > 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
> > > > >    on latest Linus master branch, everything works fine.
> > > > > 
> > > > > 2. build and test the tip/next-merge-window branch, kernel hangs early
> > > > > without output, (both 1st boot and kexec boot)
> > > > 
> > > > Update about 2.  It should be not early rsdp related, I got the boot log
> > > > Since can not reproduce with Linus master branch it may have been fixed.
> > > 
> > > Nothing was changed here since PTI.
> > > 
> > > > [    0.685374][    T1] rcu: Hierarchical SRCU implementation.
> > > > [    0.686414][    T1] general protection fault: 0000 [#1] SMP PTI
> > > > [    0.687328][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc6+ #877
> > > > [    0.687328][    T1] Hardware name: LENOVO 4236NUC/4236NUC, BIOS 83ET82WW (1.52 ) 06/04/2018
> > > > [    0.687328][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450
> > > 
> > > > [    0.687328][    T1] Call Trace:
> > > > [    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
> > > > [    0.687328][    T1]  x86_reserve_hardware+0x173/0x180
> > > > [    0.687328][    T1]  x86_pmu_event_init+0x39/0x220
> > > 
> > > The DS buffers are special in that they're part of cpu_entrt_area. If
> > > this comes apart it might mean your pagetables are dodgy.
> > 
> > Hmm, it seems caused by some WIP branch patches, I suspect below:
> > commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
> > x86/paravirt: Standardize 'insn_buff' variable names
> 
> This commit had a bug which I fixed - could you try the latest -tip?

Will do, but I do not use tip tree often, not sure which branch includes
the fix.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/
Is it tip/master or tip/tip?

Thanks
Dave
