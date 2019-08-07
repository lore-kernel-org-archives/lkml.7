Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7800DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4382E2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVkFxHfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfHGHwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:52:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39529 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfHGHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:52:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so39562654pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=raF/Gr3NmQwtZbDVxQyb2Plto7srHxl/3BURAaaT4K8=;
        b=aVkFxHfcKAx6oYT2t5Nf0i7Cb2DMbScL5DLoJlIJE/vQ/va0ExOkymjZSRsduXobJW
         +HxeBR4pidWnVBRaxINHAFo49nx2BVDvWUa1E7DBYutIhQpdDU3Gk6sTFDan6KCYnLSZ
         IRa4qpYOhzyavKRXmFfZSjGGgfxxI1PCr/G5QtTHNSFiquJF78/c7DoG91ze/f4/LwKs
         6sZcHnlIwMLCFZFfXWX2TPmdAuIQTIOe77E437ZEZe1bZnFweCoQ6AdYpIUBUcAMMwtt
         kD+21/Aa1GxBuARlgR2LCWmT6lGWc9AqsdtzwsZq8J5sGwPbOUa+GtyeCvBke0UEJmXc
         vvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=raF/Gr3NmQwtZbDVxQyb2Plto7srHxl/3BURAaaT4K8=;
        b=nxHWj/gy08qXuLLKt+0BnuL3R8q4skSbkG89s+rbxfUAgKJc8nenWGYsnVqQDCD2Cc
         sIpjzOckPxDV/qDmPFoLjSVl33xmlZpwXeq3/DXe+6y5M4z7JroCXa6DCeGKoSz2jEkQ
         hf1+NSj6Vb84mQtRFycOFeJYUr3h4bPblLD6bUduwuiD2nG93YKa5Ln7aMwWvzCenIfH
         lrEqaFhABxxTeqUurje+VFO/fCv1KYgV5qQ+5qQwRjGjjmaicwGBjM1e9J8cKyGTnk6j
         e+Anz25L1St9xcaBkpR+0jV6jKiVgCOUfPxRV3ytBJqiCQABdgV2fkZ9q/NnKfYL9B3O
         CFJQ==
X-Gm-Message-State: APjAAAUqq2FPoseKUz0JcHj/ziTUcbmiqssVifkzzBO1N/SXRXUCp+Hr
        Zbhjlt/++aTSrgL+XKsxxw==
X-Google-Smtp-Source: APXvYqxdhB04T4rZXxLUHun72aLTp35ttEb18yFqe9+qM60YtrPkUj4xXardBui+Z7JiCLnmu0lByQ==
X-Received: by 2002:a62:1515:: with SMTP id 21mr8210884pfv.100.1565164359864;
        Wed, 07 Aug 2019 00:52:39 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r6sm52948950pjb.22.2019.08.07.00.52.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 00:52:38 -0700 (PDT)
Date:   Wed, 7 Aug 2019 15:52:26 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Dave Young <dyoung@redhat.com>
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
Message-ID: <20190807075226.GA10392@mypc>
References: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
 <20190807025843.GA4776@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807025843.GA4776@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 11:00:41AM +0800, Dave Young wrote:
> Add Tony and Xunlei in cc.
> On 08/05/19 at 04:58pm, Pingfan Liu wrote:
> > This series include two related groups:
> > [1-3/4]: protect nr_cpus from rebooting by broadcast mce
> > [4/4]: improve "kexec -l" robustness against broadcast mce
> > 
> > When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
> > to unexpected rebooting by broadcast mce. After analysis, I think only the
> > following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
> > to fix that issue.
> 
> I did not understand and read the MCE details, but we previously had a
> MCE problem, Xunlei fixed in below commit:
> commit 5bc329503e8191c91c4c40836f062ef771d8ba83
> Author: Xunlei Pang <xlpang@redhat.com>
> Date:   Mon Mar 13 10:50:19 2017 +0100
> 
>     x86/mce: Handle broadcasted MCE gracefully with kexec
> 
> I wonder if this is same issue or not. Also the old discussion is in
> below thread:
> https://lore.kernel.org/patchwork/patch/753530/
> 
> Tony raised similar questions, but I'm not sure if it is still a problem
> or it has been fixed.
> 
Xunlei's patch is the precondition of the stability for the case 2: boot up by "kexec -p nr_cpus="

For case1/3, extra effort is needed.

Thanks,
	Pingfan
> > 
> > *** Back ground ***
> > 
> > On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
> > broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.
> > 
> > The option 'nosmt' has already complied with the above rule by Thomas's patch.
> > For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
> > nosmt=force")
> > 
> > But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
> > and can be categorized into three cases.
> > 
> > -1. boot up by BIOS. Since no one set CR4.MCE=1, nr_cpus risks rebooting by
> > broadcast MCE.
> > 
> > -2. boot up by "kexec -p nr_cpus=".  Since the 1st kernel has all cpus'
> > CR4.MCE=1 set before kexec -p, nr_cpus is free of rebooting by broadcast MCE.
> > Furthermore, the crashed kernel's wreckage, including page table and text, is
> > not touched by capture kernel. Hence if MCE event happens on capped cpu,
> > do_machine_check->__mc_check_crashing_cpu() runs smoothly and returns
> > immediately, the capped cpu is still pinned on "halt".
> > 
> > -3. boot up by "kexec -l nr_cpus=". As "kexec -p", it is free of rebooting by
> > broadcast MCE. But the 1st kernel's wreckage is discarded and changed.  when
> > capped cpus execute do_machine_check(), they may crack the new kernel.  But
> > this is not related with broadcast MCE, and need an extra fix.
> > 
> > *** Solution ***
> > "nr_cpus" can not follow the same way as "nosmt".  Because nr_cpus limits the
> > allocation of percpu area and some other kthread memory, which is critical to
> > cpu hotplug framework.  Instead, developing a dedicated SIPI callback
> > make_capped_cpu_stable() for capped cpu, which does not lean on percpu area to
> > work.
> > 
> > [1]: https://lkml.org/lkml/2019/7/5/3
> > 
> > To: Gleixner <tglx@linutronix.de>
> > To: Andy Lutomirski <luto@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > To: x86@kernel.org
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Qian Cai <cai@lca.pw>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Daniel Drake <drake@endlessm.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: kexec@lists.infradead.org
> > 
> > ---
> > Pingfan Liu (4):
> >   x86/apic: correct the ENO in generic_processor_info()
> >   x86/apic: record capped cpu in generic_processor_info()
> >   x86/smp: send capped cpus to a stable state when smp_init()
> >   x86/smp: disallow MCE handler on rebooting AP
> > 
> >  arch/x86/include/asm/apic.h  |  1 +
> >  arch/x86/include/asm/smp.h   |  3 ++
> >  arch/x86/kernel/apic/apic.c  | 23 ++++++++----
> >  arch/x86/kernel/cpu/common.c |  7 ++++
> >  arch/x86/kernel/smp.c        |  8 +++++
> >  arch/x86/kernel/smpboot.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/smp.c                 |  6 ++++
> >  7 files changed, 124 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.7.5
> > 
> 
> Thanks
> Dave
