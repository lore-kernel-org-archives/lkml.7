Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764A0C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EFF206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnqr57/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfDYRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:53:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43244 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfDYRxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:53:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so740712oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9qLug75eCqanUiaGqzm+mHAapGaNlxsUMfe82uh5HQ=;
        b=hnqr57/loN1crKYWPcX3hFH596sHdsOXxDyMbZotyCTigk1WoeSZOwrE0ei/UapYxp
         ud7+Nn2ZGsD+Kav99e5RpCpzqbcFP0iNvDPH9gZAWyLaWBmAuoLV02R0a8PnKvvlV2W1
         MWG2xaFDn51nXR1JuLD7Bg7bUZnyXH1+umUmIOl/wwTzAZ3l/5UMelL275RObExupOvE
         MhyNN2qx5Zz3BLwCuD73tBb1U5kvDezD8Ecs4MVTQjNq2PyLUJ0+SEXYC61rkjb8koBi
         9FzRfZfCVSd7YKWaQB+/f9SIjGgw4uegQzOft0gZbdoX9UIOBpw9eilvvWumqscwAHxz
         MpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9qLug75eCqanUiaGqzm+mHAapGaNlxsUMfe82uh5HQ=;
        b=i7NQCV9DQg+SaEbNt9pqmiZzk60cXtNVQKLhBWgMVZL1dBG/XMTVxuL3Dl2mABJDow
         8cm4bTMnDxIjTOY8o4b79qvxojbARTYAbIWDP6IIuKOk3EWeWZpaPgIgmBc5qaEeOkkT
         bq5uwpY0awDXq4B8V2W/CzL5dEvTBJbNGID4UPYEoWvfGVuIUyom5c7lHBHH9SoGT3Xo
         /IUJwe362YhcbZhsTgrJxnCRK0AWmVobAKyqvFLN7NcSHSjHuUgCGl0LkRZigYYB/EfJ
         fr5g8mZtcsJ/LKn/JCNCMfJ92NZxg1e4EUEw5FkXt/5dx3fD+gwypiyry3CkJ9yYFtpd
         XKkw==
X-Gm-Message-State: APjAAAXi5MOEg/YtGn6LE6CgFWn+yq8eHpH04JqRyre/KKN7myUhgChU
        vlYJW9phopk/iCiA4VpkSQ7h/Ba7vqRS6on2FrplrGBSMdWK3Q==
X-Google-Smtp-Source: APXvYqyaVHjhed48qkxTGrIUA67AWtjqLg5sOT1DLNDNPuJcjam2N+oOhdZOZVbC0v7H0NTOjeCFPStBf8GMWBtI8aM=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr4079086oih.39.1556214814617;
 Thu, 25 Apr 2019 10:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190425161416.26600-1-dima@arista.com> <20190425161416.26600-17-dima@arista.com>
In-Reply-To: <20190425161416.26600-17-dima@arista.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 25 Apr 2019 19:53:08 +0200
Message-ID: <CAG48ez3M6aLNda+dmviba4CVDBSx0nTknp4JiophDKmqpHYh_A@mail.gmail.com>
Subject: Re: [PATCHv3 16/27] x86/vdso: Switch image on setns()/unshare()/clone()
To:     Dmitry Safonov <dima@arista.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:15 PM Dmitry Safonov <dima@arista.com> wrote:
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.
>
> Those effects of introducing time namespace are very much unwanted
> having in mind how much work have been spent on micro-optimisation
> vdso code.
>
> Addressing those problems, there are two versions of VDSO's .so:
> for host tasks (without any penalty) and for processes inside of time
> namespace with clk_to_ns() that subtracts offsets from host's time.
>
> Whenever a user does setns()/unshare() or clone() with CLONE_TIMENS,
> change VDSO image in mm and zap existing VVAR/VDSO page tables.
> They will be re-faulted with corresponding image and VVAR offsets.
[...]
> +#ifdef CONFIG_TIME_NS
> +int vdso_join_timens(struct task_struct *task, bool inside_ns)

The parameter "inside_ns" is never used, right?

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
> +               if (vma_is_special_mapping(vma, &vvar_mapping))
> +                       zap_page_range(vma, vma->vm_start, size);
> +               if (vma_is_special_mapping(vma, &vdso_mapping))
> +                       zap_page_range(vma, vma->vm_start, size);

Nit: This could be rewritten as:

if (vma_is_special_mapping(vma, &vvar_mapping) ||
    vma_is_special_mapping(vma, &vdso_mapping))
        zap_page_range(vma, vma->vm_start, size);

> +       }
> +
> +       up_write(&mm->mmap_sem);
> +       return 0;
> +}
[...]
