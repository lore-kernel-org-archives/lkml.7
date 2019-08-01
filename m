Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D87C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ECE2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564695610;
	bh=gHeVvR22yg/BEAVWLA5zkJGRlEoRdzJ5A+Yzt/2dnxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rNBpcAWOxjl1F/ZPBMLIN66G1Zs5jSOd0juR8M7fpotDOeNG9jMbNPiEP5r9tnYaR
	 WlE9rme3vY8AMFPoKw71KoUGP7XogtsjTnst3hJf0qca8YAiLMu1c0zeaGjlQwpgpL
	 jkVfacBGode+xc473Kb5ygGcruxHD/9hplC9klBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbfHAVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbfHAVkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:40:07 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D554217D4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564695605;
        bh=gHeVvR22yg/BEAVWLA5zkJGRlEoRdzJ5A+Yzt/2dnxc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WOvxb0/qC/fA+zskPassO/yOlfOY7EnXCS3QAMKfImgnKo2bvlppC1c7A3uIhqYY5
         LSuTvWMIYfxSK1BC5+t+uQWTEJFqyN+fQU20ZdSAwSEcP2EAcy/0VSVf5yohlZAlv4
         Oc7BCZSKhKussZZOEXYcPGJDf9mcKH3B/UyNuzNI=
Received: by mail-wr1-f48.google.com with SMTP id x1so25181195wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 14:40:05 -0700 (PDT)
X-Gm-Message-State: APjAAAVVhK72ys2xVoymBaI0Dw2CB6cCT0WZG695kLiIT9h4Y6fND+DN
        4H+wVqMdlttBvPhMJGOIvhnIAeu6ZtJBRJkPoqpRtg==
X-Google-Smtp-Source: APXvYqzRdGfLbWWwLeGDFVSRIa19VFXJT9LM81VsTWCkFZlOUlj7YmlSRI4JMEXaM3T3twojRBcPU0Iog/L8Gh39gHU=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr45723172wrp.221.1564695603860;
 Thu, 01 Aug 2019 14:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-26-dima@arista.com>
 <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com> <4D0E6734-066D-4A72-A119-2FD6482F857D@zytor.com>
In-Reply-To: <4D0E6734-066D-4A72-A119-2FD6482F857D@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Aug 2019 14:39:51 -0700
X-Gmail-Original-Message-ID: <CALCETrUfGb8VcgdyCme=n755OB_qaGqS9QATpn8wqQ3XCqUgAA@mail.gmail.com>
Message-ID: <CALCETrUfGb8VcgdyCme=n755OB_qaGqS9QATpn8wqQ3XCqUgAA@mail.gmail.com>
Subject: Re: [PATCHv5 25/37] x86/vdso: Switch image on setns()/clone()
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:09 PM <hpa@zytor.com> wrote:
>
> On July 31, 2019 10:34:26 PM PDT, Andy Lutomirski <luto@kernel.org> wrote=
:
> >On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
> >>
> >> As it has been discussed on timens RFC, adding a new conditional
> >branch
> >> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> >> It will add a penalty for everybody as branch predictor may
> >mispredict
> >> the jump. Also there are instruction cache lines wasted on cmp/jmp.
> >
> >
> >>
> >> +#ifdef CONFIG_TIME_NS
> >> +int vdso_join_timens(struct task_struct *task)
> >> +{
> >> +       struct mm_struct *mm =3D task->mm;
> >> +       struct vm_area_struct *vma;
> >> +
> >> +       if (down_write_killable(&mm->mmap_sem))
> >> +               return -EINTR;
> >> +
> >> +       for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> >> +               unsigned long size =3D vma->vm_end - vma->vm_start;
> >> +
> >> +               if (vma_is_special_mapping(vma, &vvar_mapping) ||
> >> +                   vma_is_special_mapping(vma, &vdso_mapping))
> >> +                       zap_page_range(vma, vma->vm_start, size);
> >> +       }
> >
> >This is, unfortunately, fundamentally buggy.  If any thread is in the
> >vDSO or has the vDSO on the stack (due to a signal, for example), this
> >will crash it.  I can think of three solutions:
> >
> >1. Say that you can't setns() if you have other mms and ignore the
> >signal issue.  Anything with green threads will disapprove.  It's also
> >rather gross.
> >
> >2. Make it so that you can flip the static branch safely.  As in my
> >other email, you'll need to deal with CoW somehow,
> >
> >3. Make it so that you can't change timens, or at least that you can't
> >turn timens on or off, without execve() or fork().
> >
> >BTW, that static branch probably needs to be aligned to a cache line
> >or something similar to avoid all the nastiness with trying to poke
> >text that might be concurrently executing.  This will be a mess.
>
> Since we are talking about different physical addresses I believe we shou=
ld be okay as long as they don't cross page boundaries, and even if they do=
 it can be managed with proper page invalidation sequencing =E2=80=93 it's =
not like the problems of having to deal with XMC on live pages like in the =
kernel.
>
> Still, you really need each instruction sequence to be present, with the =
only difference being specific patch sites.
>
> Any fundamental reason this can't be strictly data driven? Seems odd to m=
e if it couldn't, but I might be missing something obvious.

I think it can be.  There are at least two places where vDSO slow
paths could hook without affecting fast paths: vclock_mode and the low
bit of the sequence number.
