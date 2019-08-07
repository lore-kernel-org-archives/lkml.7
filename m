Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB45C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD794216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHGDAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfHGDAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:00:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 533A72F3677;
        Wed,  7 Aug 2019 03:00:52 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CE575D6D0;
        Wed,  7 Aug 2019 03:00:45 +0000 (UTC)
Date:   Wed, 7 Aug 2019 11:00:41 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, tony.luck@intel.com,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: Re: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast
 mce
Message-ID: <20190807025843.GA4776@dhcp-128-65.nay.redhat.com>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 03:00:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Tony and Xunlei in cc.
On 08/05/19 at 04:58pm, Pingfan Liu wrote:
> This series include two related groups:
> [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> [4/4]: improve "kexec -l" robustness against broadcast mce
> 
> When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> to unexpected rebooting by broadcast mce. After analysis, I think only the
> following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> to fix that issue.

I did not understand and read the MCE details, but we previously had a
MCE problem, Xunlei fixed in below commit:
commit 5bc329503e8191c91c4c40836f062ef771d8ba83
Author: Xunlei Pang <xlpang@redhat.com>
Date:   Mon Mar 13 10:50:19 2017 +0100

    x86/mce: Handle broadcasted MCE gracefully with kexec

I wonder if this is same issue or not. Also the old discussion is in
below thread:
https://lore.kernel.org/patchwork/patch/753530/

Tony raised similar questions, but I'm not sure if it is still a problem
or it has been fixed.

> 
> *** Back ground ***
> 
> On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> 
> The option 'nosmt' has already complied with the above rule by Thomas's patch.
> For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
> nosmt=force")
> 
> But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
> and can be categorized into three cases.
> 
> -1. boot up by BIOS. Since no one set CR4.MCE=1, nr_cpus risks rebooting by
> broadcast MCE.
> 
> -2. boot up by "kexec -p nr_cpus=".  Since the 1st kernel has all cpus'
> CR4.MCE=1 set before kexec -p, nr_cpus is free of rebooting by broadcast MCE.
> Furthermore, the crashed kernel's wreckage, including page table and text, is
> not touched by capture kernel. Hence if MCE event happens on capped cpu,
> do_machine_check->__mc_check_crashing_cpu() runs smoothly and returns
> immediately, the capped cpu is still pinned on "halt".
> 
> -3. boot up by "kexec -l nr_cpus=". As "kexec -p", it is free of rebooting by
> broadcast MCE. But the 1st kernel's wreckage is discarded and changed.  when
> capped cpus execute do_machine_check(), they may crack the new kernel.  But
> this is not related with broadcast MCE, and need an extra fix.
> 
> *** Solution ***
> "nr_cpus" can not follow the same way as "nosmt".  Because nr_cpus limits the
> allocation of percpu area and some other kthread memory, which is critical to
> cpu hotplug framework.  Instead, developing a dedicated SIPI callback
> make_capped_cpu_stable() for capped cpu, which does not lean on percpu area to
> work.
> 
> [1]: https://lkml.org/lkml/2019/7/5/3
> 
> To: Gleixner <tglx@linutronix.de>
> To: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> To: x86@kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: kexec@lists.infradead.org
> 
> ---
> Pingfan Liu (4):
>   x86/apic: correct the ENO in generic_processor_info()
>   x86/apic: record capped cpu in generic_processor_info()
>   x86/smp: send capped cpus to a stable state when smp_init()
>   x86/smp: disallow MCE handler on rebooting AP
> 
>  arch/x86/include/asm/apic.h  |  1 +
>  arch/x86/include/asm/smp.h   |  3 ++
>  arch/x86/kernel/apic/apic.c  | 23 ++++++++----
>  arch/x86/kernel/cpu/common.c |  7 ++++
>  arch/x86/kernel/smp.c        |  8 +++++
>  arch/x86/kernel/smpboot.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/smp.c                 |  6 ++++
>  7 files changed, 124 insertions(+), 7 deletions(-)
> 
> -- 
> 2.7.5
> 

Thanks
Dave
