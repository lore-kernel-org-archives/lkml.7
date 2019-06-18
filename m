Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7CAC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECD9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 00:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560817158;
	bh=emBFR810hp3SdoDRl85fM81N2uJI+UNKI09ElJ11fYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iNHObvcB8TPJR8LJPOJP6A8oz3GKD0mkWWZMGJkT2FtjD7lAg1F++8PSZUeuCEWqV
	 uPuA3I/5vLRo2WnuOxNPSmfcK6x0VSnaBdaamy/jDcMYBrMs1cPa7vrv6BmkU4EzrJ
	 LzKvsPfpb2v8XfOvCclWrYtpX3AAEl5fSBoLTyjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfFRATQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 20:19:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFRATQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 20:19:16 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E022133F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560817155;
        bh=emBFR810hp3SdoDRl85fM81N2uJI+UNKI09ElJ11fYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O8E4vzUooetRcDTK9GEYl1AU1c1+sC++kFa4mf30RKjtzlu4ML7kREFuZuR6YYhrP
         /5lbe6HzVMp+PGLalTH0nY2BD/HYSv4cma0yVD7ZbRHLf/mvugWIb+tpY8juK3aij0
         Y4+9cpEq5Uw2Hq7v+O1jKL3nfMmP4sIHXKmGH1Qg=
Received: by mail-wm1-f46.google.com with SMTP id c66so1259441wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 17:19:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWmXyDkjFx+DUDxp8Y6Von/xlis+vNOOMgR0+VGPeGhTxYe1AJy
        oqvBIHJiV0Tf69jMfBIwAJ5/wsDipvBbKU0mPJtxWg==
X-Google-Smtp-Source: APXvYqxssiaT6y6ydBqGT1ZopQUqHrOBUKtIRwlrT7UMiwb/bA0F4Sdg/siRvhPKE1Mgsv17XevB74WYwiTA3D0s7Lo=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr758418wmj.79.1560817153878;
 Mon, 17 Jun 2019 17:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
 <20190610035302.GA162238@romley-ivt3.sc.intel.com> <CALCETrUSpk+_FDaPpA3a-duajUdF8kOK64AQJjsr7Pm0Gi04OA@mail.gmail.com>
 <20190610060234.GD162238@romley-ivt3.sc.intel.com> <F021B947-90E9-450A-9196-531B7EE965F1@amacapital.net>
 <20190617202702.GB217081@romley-ivt3.sc.intel.com> <CALCETrVENokx8VUCxdUzGeMA2oMOZ0kHRiP_O0KygyrAhf07Rg@mail.gmail.com>
 <20190617231104.GF217081@romley-ivt3.sc.intel.com> <CALCETrXpB+3TjHacjfUZK6pu_L54upe+JHKKRs4x1HaHOeGbzA@mail.gmail.com>
 <20190618000014.GH217081@romley-ivt3.sc.intel.com>
In-Reply-To: <20190618000014.GH217081@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Jun 2019 17:19:02 -0700
X-Gmail-Original-Message-ID: <CALCETrUqPC5wzg9vUUHuUCYv-FeJdxPbe2t2F4_-9jauijeT1Q@mail.gmail.com>
Message-ID: <CALCETrUqPC5wzg9vUUHuUCYv-FeJdxPbe2t2F4_-9jauijeT1Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 5:09 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Mon, Jun 17, 2019 at 04:41:38PM -0700, Andy Lutomirski wrote:
> > On Mon, Jun 17, 2019 at 4:20 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 04:02:50PM -0700, Andy Lutomirski wrote:
> > > > On Mon, Jun 17, 2019 at 1:36 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > > >
> > > > > On Mon, Jun 10, 2019 at 06:41:31AM -0700, Andy Lutomirski wrote:
> > > > > >
> > > > > >
> > > > > > > On Jun 9, 2019, at 11:02 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > > > > >
> > > > > > >> On Sun, Jun 09, 2019 at 09:24:18PM -0700, Andy Lutomirski wrote:
> > > > > > >>> On Sun, Jun 9, 2019 at 9:02 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > > > > >>>
> > > > > > >>>> On Sat, Jun 08, 2019 at 03:50:32PM -0700, Andy Lutomirski wrote:
> > > > > > >>>>> On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > > > > >>>>>
> > > > > > >>>>> C0.2 state in umwait and tpause instructions can be enabled or disabled
> > > > > > >>>>> on a processor through IA32_UMWAIT_CONTROL MSR register.
> > > > > > >>>>>
> > > > > > >>>>> By default, C0.2 is enabled and the user wait instructions result in
> > > > > > >>>>> lower power consumption with slower wakeup time.
> > > > > > >>>>>
> > > > > > >>>>> But in real time systems which require faster wakeup time although power
> > > > > > >>>>> savings could be smaller, the administrator needs to disable C0.2 and all
> > > > > > >>>>> C0.2 requests from user applications revert to C0.1.
> > > > > > >>>>>
> > > > > > >>>>> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> > > > > > >>>>> created to allow the administrator to control C0.2 state during run time.
> > > > > > >>>>
> > > > > > >>>> This looks better than the previous version.  I think the locking is
> > > > > > >>>> still rather confused.  You have a mutex that you hold while changing
> > > > > > >>>> the value, which is entirely reasonable.  But, of the code paths that
> > > > > > >>>> write the MSR, only one takes the mutex.
> > > > > > >>>>
> > > > > > >>>> I think you should consider making a function that just does:
> > > > > > >>>>
> > > > > > >>>> wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> > > > > > >>>>
> > > > > > >>>> and using it in all the places that update the MSR.  The only thing
> > > > > > >>>> that should need the lock is the sysfs code to avoid accidentally
> > > > > > >>>> corrupting the value, but that code should also use WRITE_ONCE to do
> > > > > > >>>> its update.
> > > > > > >>>
> > > > > > >>> Based on the comment, the illustrative CPU online and enable_c02 store
> > > > > > >>> functions would be:
> > > > > > >>>
> > > > > > >>> umwait_cpu_online()
> > > > > > >>> {
> > > > > > >>>        wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> > > > > > >>>        return 0;
> > > > > > >>> }
> > > > > > >>>
> > > > > > >>> enable_c02_store()
> > > > > > >>> {
> > > > > > >>>       mutex_lock(&umwait_lock);
> > > > > > >>>       umwait_control_c02 = (u32)!c02_enabled;
> > > > > > >>>       WRITE_ONCE(umwait_control_cached, 2 | get_umwait_control_max_time());
> > > > > > >>>       on_each_cpu(umwait_control_msr_update, NULL, 1);
> > > > > > >>>       mutex_unlock(&umwait_lock);
> > > > > > >>> }
> > > > > > >>>
> > > > > > >>> Then suppose umwait_control_cached = 100000 initially and only CPU0 is
> > > > > > >>> running. Admin change bit 0 in MSR from 0 to 1 to disable C0.2 and is
> > > > > > >>> onlining CPU1 in the same time:
> > > > > > >>>
> > > > > > >>> 1. On CPU1, read umwait_control_cached to eax as 100000 in
> > > > > > >>> umwait_cpu_online()
> > > > > > >>> 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> > > > > > >>> 3. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
> > > > > > >>> 4. On CPU0, wrmsr with 100001 in enabled_c02_store()
> > > > > > >>>
> > > > > > >>> The result is CPU0 and CPU1 have different MSR values.
> > > > > > >>
> > > > > > >> Yes, but only transiently, because you didn't finish your example.
> > > > > > >>
> > > > > > >> Step 5: enable_c02_store() does on_each_cpu(), and CPU 1 gets updated.
> > > > > > >
> > > > > > > There is no sync on wrmsr on CPU0 and CPU1.
> > > > > >
> > > > > > What do you mean by sync?
> > > > > >
> > > > > > > So a better sequence to
> > > > > > > describe the problem is changing the order of wrmsr:
> > > > > > >
> > > > > > > 1. On CPU1, read umwait_control_cached to eax as 100000 in
> > > > > > > umwait_cpu_online()
> > > > > > > 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> > > > > > > 3. On CPU0, wrmsr with 100001 in on_each_cpu() in enabled_c02_store()
> > > > > > > 4. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
> > > > > > >
> > > > > > > So CPU1 and CPU0 have different MSR values. This won't be transient.
> > > > > >
> > > > > > You are still ignoring the wrmsr on CPU1 due to on_each_cpu().
> > > > > >
> > > > >
> > > > > Initially umwait_control_cached is 100000 and CPU0 is online while CPU1
> > > > > is going to be online:
> > > > >
> > > > > 1. On CPU1, cpu_online_mask=0x3 in start_secondary()
> > > > > 2. On CPU1, read umwait_control_cached to eax as 100000 in umwait_cpu_online()
> > > > > 3. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> > > > > 4. On CPU0, execute one_each_cpu() in enabled_c02_store():
> > > > >     wrmsr with 100001 on CPU0
> > > > >     wrmsr with 100001 on CPU1
> > > > > 5. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
> > > > >
> > > > > So the MSR is 100000 on CPU1 and 100001 on CPU0. The MSRs are different on
> > > > > the CPUs.
> > > > >
> > > > > Is this a right sequence to demonstrate locking issue without the mutex
> > > > > locking?
> > > > >
> > > >
> > > > Fair enough.  I would fix it differently, though:
> > > >
> > > > static void update_this_cpu_umwait_msr(void)
> > > > {
> > > >   WARN_ON_ONCE(!irqs_disabled());  /* or local_irq_save() */
> > > >
> > > >   /* We need to prevent umwait_control from being changed *and*
> > > > completing its WRMSR between our read and our WRMSR.  By turning IRQs
> > > > off here, we ensure that no sysfs write happens on this CPU and we
> > > > also make sure that any concurrent sysfs write from a different CPU
> > > > will not finish updating us via IPI until we're done. */
> > > >   wrmsrl(MSR_..., READ_ONCE(umwait_control), 0);
> > > > }
> > >
> > > If no other objections, then I will keep the current mutex lock/unlock to
> > > protect wrmsr and the umwait_control_cached variable.
> > >
> >
> > I don't think that's sufficient.  In your current code, you hold the
> > mutex in some places and not in others, and there's no explanation.
>
> The mutex is used in sysfs writing and cpu online.
>
> But it's not used in syscore resume because only BP is running syscore
> resume.
>
> > And I think you're relying on the IRQs-off protection in at least one
> > code path already, so you're not gaining any simplicity.
>
> I don't rely on IRQs-off protection. I only use mutex to protect.

You're relying on being single-threaded in umwait_syscore_resume().
Do you actually know that's safe?  You say it's because you're single
threaded, but what if you were suspended in the middle of a sysfs
operation?  I think it's fine, but it needs an argument along the
lines of the argument for why the irqs disabled case is okay.

>
> > At the very
> > least, you need to add some extensive comments everywhere if you want
> > to keep the mutex,
>
> I have comment on why no need for mutex protection in syscore resume. But
> I can add more comments on the locking.
>
> > but I think it's simpler and clearer if you just
> > use the same logic everywhere, for example, as I proposed above.
>
> But using irqs_disabled() before wrmsr() and READ_ONCE/WRITE_ONCE for
> umwait_control_cached alone are not sufficient. The mutex is still needed
> to protect sysfs writing, is that right? Without mutex, one_each_cpu()
> can write different values on CPUs, right?

Yes, you probably need a mutex to prevent two sysfs writers from
clobbering each other.

>
> If irqs disabling, READ_ONCE/WRITE_ONCE, and mutex are all used to protect,
> isn't that more complex than just using mutex?

But you're already using a mutex and a comment.  And you're hoping
that the syscore resume callback reads something sensible despite the
lack of READ_ONCE / WRITE_ONCE.  The compiler is unlikely to butcher
this too badly, but still.

--Andy
