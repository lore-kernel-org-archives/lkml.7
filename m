Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C417C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AE92171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564637681;
	bh=HrxXpiw3LkZQVE8e0ZTsuPfAdvYomc3P/3Iwf2HWM78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yz0AWMMxogsIRNjkijnJHREkt2dMhG1DwKFpQmE7kZcnkvqi5RcYhUo5SiU+1v5+S
	 G0r1qKj5e7/kBtTMBrFsXertKXkFXAHAeSIXl1pv38fApYqQrygKyYa7vgdQRfzd15
	 2+ONi2r++LJE0wH+hJD3af8ZPQQdRe8okxG1vX+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfHAFek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHAFek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:34:40 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90982182B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564637679;
        bh=HrxXpiw3LkZQVE8e0ZTsuPfAdvYomc3P/3Iwf2HWM78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nNupNBovkhscHiDgWVbbCg0LDDOb5JkbKeRM1UpBIVzZemFuiV3y940pJ/Y+s7F4T
         RVp0kshd5mQ5SjYQWwfZpVdYt0eQJiLV05dztLUjqqehwsWIkMkKCfu/+GeIXJVMoB
         fABhIvoJS5naQIMQ5SOE9eKhaf458LJ5De5eIdLk=
Received: by mail-wr1-f46.google.com with SMTP id x1so22206148wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:34:38 -0700 (PDT)
X-Gm-Message-State: APjAAAW7nNzAzhYCHrCTL0GeS6bvr+TQyS6rDiLqS3siYTwNgmonHFs2
        3VnQM4CNF1vzadURyY2RLD8FQaxWGx9CmUMzdQ9Avg==
X-Google-Smtp-Source: APXvYqx9zbupszGMOuu4tkZ/G09clcPNyUxpoySIadp3yoAa9h3SwqTOS6ZQE9j4ym1f+H9vYJGnx6jogN3n0v0lAKg=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr61034365wro.343.1564637677248;
 Wed, 31 Jul 2019 22:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-26-dima@arista.com>
In-Reply-To: <20190729215758.28405-26-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:34:26 -0700
X-Gmail-Original-Message-ID: <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com>
Message-ID: <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com>
Subject: Re: [PATCHv5 25/37] x86/vdso: Switch image on setns()/clone()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.


>
> +#ifdef CONFIG_TIME_NS
> +int vdso_join_timens(struct task_struct *task)
> +{
> +       struct mm_struct *mm = task->mm;
> +       struct vm_area_struct *vma;
> +
> +       if (down_write_killable(&mm->mmap_sem))
> +               return -EINTR;
> +
> +       for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +               unsigned long size = vma->vm_end - vma->vm_start;
> +
> +               if (vma_is_special_mapping(vma, &vvar_mapping) ||
> +                   vma_is_special_mapping(vma, &vdso_mapping))
> +                       zap_page_range(vma, vma->vm_start, size);
> +       }

This is, unfortunately, fundamentally buggy.  If any thread is in the
vDSO or has the vDSO on the stack (due to a signal, for example), this
will crash it.  I can think of three solutions:

1. Say that you can't setns() if you have other mms and ignore the
signal issue.  Anything with green threads will disapprove.  It's also
rather gross.

2. Make it so that you can flip the static branch safely.  As in my
other email, you'll need to deal with CoW somehow,

3. Make it so that you can't change timens, or at least that you can't
turn timens on or off, without execve() or fork().

BTW, that static branch probably needs to be aligned to a cache line
or something similar to avoid all the nastiness with trying to poke
text that might be concurrently executing.  This will be a mess.
