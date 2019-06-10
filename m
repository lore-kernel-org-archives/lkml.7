Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8DDC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1E920820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560140674;
	bh=EGbpm2FlzOHNWVYlrQW0pWEde4YMYQg12Rsn/hOXDUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JU6dYfpFHoZxUNmK1aZeIORRH9ZHKf6Knl9uJRVVUWef196w4l1q0hY0M63oX8AMl
	 XJnIo6vgRN9/PQWkEN2yBHJ2blpJ6jbon0mF8+Ka7LRcCljjSIGNj+deVaIo0PxuZD
	 HGN5FNAq1bcgmUNf7FCJy2eN5lNCJsoRvJbsffy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfFJEYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfFJEYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:24:33 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50E3208C0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 04:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560140672;
        bh=EGbpm2FlzOHNWVYlrQW0pWEde4YMYQg12Rsn/hOXDUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YHtiZYZOrNDYinwCn6pmq1We6Z/3llAWGwjoeL2R10wNM4iXMqPEURMaCyKSES64C
         lpUYUAkq/DdFQ2VDyyN5AyngOn78tvOPKH66pq+DlKBMAwzEF6dCmbZR+ZCL8hg6Dv
         pdtoCY76qouJpf0UwgwrGFrK7FAxhmM3GPKVCtGQ=
Received: by mail-wr1-f45.google.com with SMTP id r18so7642736wrm.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 21:24:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWU1OZ711tY5x5unLBmtS8oXwG/0wkST2C20wStiYOYY6JPOpyO
        Wj+Hl1fTsIyd6we88+BoxfJaJAeHI9nEKd1Mimie/w==
X-Google-Smtp-Source: APXvYqzCHziFyfg2RnWySM5Fkbt4F2iDFfx4Kwq0Gg3v4ijP9MpMwj169RT/Nktt7IbzoHYD7xhO2kx/bMVGuVX8Mxk=
X-Received: by 2002:adf:f2c8:: with SMTP id d8mr16284427wrp.221.1560140670218;
 Sun, 09 Jun 2019 21:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com> <CALCETrXEqqc3cKyJ5guRV3T6LP9dpSExk3a7dvR4PF8TDgD_OA@mail.gmail.com>
 <20190610035302.GA162238@romley-ivt3.sc.intel.com>
In-Reply-To: <20190610035302.GA162238@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 9 Jun 2019 21:24:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUSpk+_FDaPpA3a-duajUdF8kOK64AQJjsr7Pm0Gi04OA@mail.gmail.com>
Message-ID: <CALCETrUSpk+_FDaPpA3a-duajUdF8kOK64AQJjsr7Pm0Gi04OA@mail.gmail.com>
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

On Sun, Jun 9, 2019 at 9:02 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Sat, Jun 08, 2019 at 03:50:32PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > >
> > > C0.2 state in umwait and tpause instructions can be enabled or disabled
> > > on a processor through IA32_UMWAIT_CONTROL MSR register.
> > >
> > > By default, C0.2 is enabled and the user wait instructions result in
> > > lower power consumption with slower wakeup time.
> > >
> > > But in real time systems which require faster wakeup time although power
> > > savings could be smaller, the administrator needs to disable C0.2 and all
> > > C0.2 requests from user applications revert to C0.1.
> > >
> > > A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> > > created to allow the administrator to control C0.2 state during run time.
> >
> > This looks better than the previous version.  I think the locking is
> > still rather confused.  You have a mutex that you hold while changing
> > the value, which is entirely reasonable.  But, of the code paths that
> > write the MSR, only one takes the mutex.
> >
> > I think you should consider making a function that just does:
> >
> > wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
> >
> > and using it in all the places that update the MSR.  The only thing
> > that should need the lock is the sysfs code to avoid accidentally
> > corrupting the value, but that code should also use WRITE_ONCE to do
> > its update.
>
> Based on the comment, the illustrative CPU online and enable_c02 store
> functions would be:
>
> umwait_cpu_online()
> {
>         wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
>         return 0;
> }
>
> enable_c02_store()
> {
>        mutex_lock(&umwait_lock);
>        umwait_control_c02 = (u32)!c02_enabled;
>        WRITE_ONCE(umwait_control_cached, 2 | get_umwait_control_max_time());
>        on_each_cpu(umwait_control_msr_update, NULL, 1);
>        mutex_unlock(&umwait_lock);
> }
>
> Then suppose umwait_control_cached = 100000 initially and only CPU0 is
> running. Admin change bit 0 in MSR from 0 to 1 to disable C0.2 and is
> onlining CPU1 in the same time:
>
> 1. On CPU1, read umwait_control_cached to eax as 100000 in
> umwait_cpu_online()
> 2. On CPU0, write 100001 to umwait_control_cached in enable_c02_store()
> 3. On CPU1, wrmsr with eax=100000 in umwaint_cpu_online()
> 4. On CPU0, wrmsr with 100001 in enabled_c02_store()
>
> The result is CPU0 and CPU1 have different MSR values.

Yes, but only transiently, because you didn't finish your example.

Step 5: enable_c02_store() does on_each_cpu(), and CPU 1 gets updated.
