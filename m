Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0209C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8235020665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444906;
	bh=qAYDbmo5GSkt6P45VK56ffd5K+x/m0Bf2WnZOUTj41o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e9DJH56rU97B7npqmkhDpPc6ZjswyUozPdrM5k6PCrFbpFnV6Keh/uIls6ujaTq+p
	 EWz++WqVse7fyXhiO5xkmX/5jL7Ja0j25nwVvm+p+tD/XFzCwcqqvb0k/Ui7T/is1G
	 WdpDrMPtdQ2OXofdDyJf9B6n+t/Jvs6yb1+PhF0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404474AbfFMQzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbfFMCVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:21:23 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7A0215EA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560392482;
        bh=qAYDbmo5GSkt6P45VK56ffd5K+x/m0Bf2WnZOUTj41o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B0oSkS1nau3KbJs9s1BlVMymB0oU5z6LBFvXi7AmzqcDqbqiql8cIrApRudhi/8Fv
         IaqV1Hx4mg+q2gAktaWuZM8wKJKuFhmaqxKi6avqPBMLyLLIGJwpz/gndsPGwhVjD7
         Wg4j+edIkhWxovILadUF7gmAnAKoGL2EpRp8eRHU=
Received: by mail-wr1-f52.google.com with SMTP id p13so8834669wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 19:21:22 -0700 (PDT)
X-Gm-Message-State: APjAAAWAVKGas2TLoamUfL8d3sQnuIKcPz+zr3gQWjoetkK2veIU7/FJ
        lPpkDqlIlOUhJ+zLgBVPU2MDaaR5NmGZ5bBX13U=
X-Google-Smtp-Source: APXvYqxCYvITU0+WPoOCo/kazowUtg08ZPEP+lqPBoMvS8i7cR55wCnGk5GmKac1Kru/rSifI8QEsT22zfEzpZQ45Co=
X-Received: by 2002:adf:eb45:: with SMTP id u5mr39733289wrn.38.1560392481321;
 Wed, 12 Jun 2019 19:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190612111611.13058-1-tklauser@distanz.ch>
In-Reply-To: <20190612111611.13058-1-tklauser@distanz.ch>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 13 Jun 2019 10:21:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjMamzRO81MmRAkgwu+uF3nHsDiync13MWpsLZRLT7FQ@mail.gmail.com>
Message-ID: <CAJF2gTTjMamzRO81MmRAkgwu+uF3nHsDiync13MWpsLZRLT7FQ@mail.gmail.com>
Subject: Re: [PATCH] csky: remove unsued thread_saved_pc and *_segments functions/macros
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <ren_guo@c-sky.com>

thread_saved_pc should be used in unwind stack and I'll give another
patch to optimize the unwind flow for csky.

On Wed, Jun 12, 2019 at 7:22 PM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> These are used nowhere in the tree (except for some architectures which
> define them for their own use) and were already removed in:
>
> commit 6474924e2b5d ("arch: remove unused macro/function thread_saved_pc()")
> commit c17c02040bf0 ("arch: remove unused *_segments() macros/functions")
>
> Remove them from arch/csky as well.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/csky/include/asm/processor.h |  6 ------
>  arch/csky/kernel/process.c        | 10 ----------
>  2 files changed, 16 deletions(-)
>
> diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
> index 21e0bd5293dd..464575156f0f 100644
> --- a/arch/csky/include/asm/processor.h
> +++ b/arch/csky/include/asm/processor.h
> @@ -83,12 +83,6 @@ static inline void release_thread(struct task_struct *dead_task)
>
>  extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>
> -#define copy_segments(tsk, mm)         do { } while (0)
> -#define release_segments(mm)           do { } while (0)
> -#define forget_segments()              do { } while (0)
> -
> -extern unsigned long thread_saved_pc(struct task_struct *tsk);
> -
>  unsigned long get_wchan(struct task_struct *p);
>
>  #define KSTK_EIP(tsk)          (task_pt_regs(tsk)->pc)
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index e555740c0be5..adeb6b1bdb42 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -24,16 +24,6 @@ asmlinkage void ret_from_kernel_thread(void);
>   */
>  void flush_thread(void){}
>
> -/*
> - * Return saved PC from a blocked thread
> - */
> -unsigned long thread_saved_pc(struct task_struct *tsk)
> -{
> -       struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
> -
> -       return sw->r15;
> -}
> -
>  int copy_thread(unsigned long clone_flags,
>                 unsigned long usp,
>                 unsigned long kthread_arg,
> --
> 2.20.0
>
