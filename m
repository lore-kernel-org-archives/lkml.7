Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E59CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290802075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgYOR77C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfDVWJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:09:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39423 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbfDVWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:09:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so16068784wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8XMOAbFPcRWzCl5EAqV4Jxp+w9p90qZdgQkYs5X0YU=;
        b=cgYOR77CmJ0Bo4MI2S8GjtP3DUSrs2t0/2VYAe7eX6U+aL7e1226i7xtpzsRaNvJHF
         lIJIW1KGyOD1OHROFf7Cr+RMuzEWAYN9qF8ST6bf94qL+LNTFiYV7mMXi1yMeuXIeECa
         pZ9rJ0oEQZfwGV35RvV7IHvzlT1nmVpLWlIeILCejvTTcw8lp43WqnyqjAscysW1KXEf
         oSRGb0r0pETy71sm4RkfkjJMcYYNrqG3MZ+UQ1iKKCp5n2TLuVBun2hHo7va9DyYuC7r
         B0rHzcHY+nJHOpgPzkVAIW5QzKuhlq31b+KfFslNsqe5QMARPJa1aNTg891NGy3VinnR
         V2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8XMOAbFPcRWzCl5EAqV4Jxp+w9p90qZdgQkYs5X0YU=;
        b=NM+IyLKIYYB81Jf8Gc6OI+pQOjKYchBN16HkVPl2Ss5Kl/9IEulIhqEExOiUOA0DxA
         gWV8t0mFgFD3GnA7tVqdk9WAVm61oj8832Hyhs0YYZfNchbpVSNhUY6+woILiYlxShES
         Tw3CNQEY9lbdr7XnwqTkAZ4dWtN3OxlSKuOvucTceAx15ZE2SfXxIO0WbDSofw4HFTzc
         F++xzX4FRZ3iXelKAqGxvZtCUMv0Exhqcg+myPtT+BM6yBZx+Ra6TIUtMtMEYXPMsyK9
         DuD2h660sm1lQq0qHNVb5V6RKYON3ygWq1EPgx3usnZw/JzN7hRfGC1hUVwNfHaFkqJQ
         QAIw==
X-Gm-Message-State: APjAAAUT7RIyJvIiXGSS+GJ6PqA82/x1XGZwNwZE/4uekltdN/8/zt/x
        7RXZDhQ5aFoTla2StoZ1/Q==
X-Google-Smtp-Source: APXvYqy8u/0Zkm4u4hsZuMeFgpRIy4ca+vuYS+YFw+Qr+Guvl2O4HaGMnIs9fmterjGK+1QFRB+dfw==
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr230795wmb.65.1555970991210;
        Mon, 22 Apr 2019 15:09:51 -0700 (PDT)
Received: from avx2 ([46.53.240.81])
        by smtp.gmail.com with ESMTPSA id l19sm26366288wrf.35.2019.04.22.15.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:09:50 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:09:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190422220948.GB26031@avx2>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
 <20190421211007.GA30444@avx2>
 <20190422103449.GA75723@gmail.com>
 <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 07:30:40AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Apr 22, 2019, at 3:34 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > 
> > * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 
> >>>>> +++ b/arch/x86/kernel/task_size_64.c
> >>>>> @@ -0,0 +1,9 @@
> >>>>> +#include <linux/export.h>
> >>>>> +#include <linux/sched.h>
> >>>>> +#include <linux/thread_info.h>
> >>>>> +
> >>>>> +unsigned long _task_size(void)
> >>>>> +{
> >>>>> +    return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET :
> >>>> TASK_SIZE_MAX;
> >>>>> +}
> >>>>> +EXPORT_SYMBOL(_task_size);
> >>>> 
> >>>> Good idea - but instead of adding yet another compilation unit, why not
> >>>> 
> >>>> stick _task_size() into arch/x86/kernel/process_64.c, which is the 
> >>>> canonical place for process management related arch functions?
> >>>> 
> >>>> Thanks,
> >>>> 
> >>>>    Ingo
> >>> 
> >>> Better yet... since TIF_ADDR32 isn't something that changes randomly, 
> >>> perhaps this should be a separate variable?
> >> 
> >> Maybe. I only thought about putting every 32-bit related flag under 
> >> CONFIG_COMPAT to further eradicate bloat (and force everyone else to 
> >> keep an eye on it, ha-ha).
> > 
> > Basically TIF_ADDR32 is only set for a task if set_personality_ia32() is 
> > called, which function is called in the following circumstances:
> > 
> > - arch/x86/ia32/ia32_aout.c:load_aout_binary()
> > 
> >   This is in exec(), when a new binary is loaded for the current task, 
> >   via search_binary_handler() and exec_binprm(). Ordering is 
> >   synchronous, AFAICS there can be no race between TASK_SIZE users and 
> >   the set_personality_ia32() call which is always for the current task.
> > 
> > - in COMPAT_SET_PERSONALITY(), which through macro detours ends up being 
> >   in SET_PERSONALITY2(), which is used in fs/compat_binfmt_elf.c's 
> >   load_elf_binary(), used in a similar fashion in exec() as the AOUT 
> >   case above. One particular macro detour of note is that 
> >   fs/compat_binfmt_elf.c #includes fs/binfmt_elf.c and re-defines the 
> >   personality setting method to map to set_personality_ia32().
> > 
> > When set_personality_ia32() is called then TIF_ADDR32 is set 
> > unconditionally, without any Kconfig variations.
> > 
> > TIF_ADDR32 is cleared:
> > 
> > - In set_personality_64bit(), when a 64-bit binary is loaded via 
> >   fs/binfmt_elf.c.
> > 
> > - It also defaults to clear in the init task, which is inherited by the 
> >   initial kernel threads and any user-space task they might end up 
> >   executing.
> > 
> > So the conclusion is that IMO we can safely put TASK_SIZE into a new 
> > thread_info()->task_size field, and:
> > 
> > - change ->task_size to the 32-bit address space in 
> >   set_personality_ia32()
> > 
> > - change ->task_size to teh 64-bit address space in the init task and in 
> >   set_personality_64bit().
> > 
> > This should cover it I think, unless I missed something.
> > 
> 
> Are there really enough TASK_SIZE users to justify any of this?

Saving 2KB on a defconfig is quite a lot.
If put into thread_info, ->task_size can be pulled using just RAX which
in turn allows to do

	asm volatile "call %P" ...  "=a" (...)

saving even more space.

But it is late here so don't quote me.
