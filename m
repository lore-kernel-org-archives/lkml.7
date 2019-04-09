Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BCDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFE220651
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7RAFvGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDIH6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:58:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41317 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDIH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:58:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id u2so9635117eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=itUqf9sL4jUs+pnvSGFSY8JHcKNj1W1FWjfPm0Z+eaY=;
        b=V7RAFvGcdu6yyEz0tSZYX7+mu5wz6+MYVotZitLbKITWG8vKAq98ktL3O6m9EizMT2
         dow3vzUqViCly/onhCb5OHAhWz32+M4W8f/8d4gsGu7AQGwCliJlgA0quO7v5oR8oR9p
         ojIW91h+JYlDKYf00CU/TrHVvSxQwtOHksdnLivdRUh2M2UTD5YXcIvK3a8jnpoyedc+
         Xm7nuJGMTwui5aLX30cxhh43Cgkag61vBKWz81mchg4Ra1EncoZ5tvFEafMx81HyX3RV
         1wdRTLhvtFUrXSCyMC0qeJwQWb9OsKNpdD4nSpUOUhHjO+fWOl2siOJ9rBYDZX1lHTI1
         sKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=itUqf9sL4jUs+pnvSGFSY8JHcKNj1W1FWjfPm0Z+eaY=;
        b=NAyeoHPxWlKSl1RfM5VoFPZNZxDwyi4KJ+eAdXUtn2uIg5CmpiOZ8KHqa7iYWHViMW
         ZqhZ1pvij7ai5rv0mlOaXlvdrfuxruH1DC9eLuujrucEHHEes3wCfVZe735eKKlAm3F+
         kwettuOichKwJM9Wg+DElIh7x5fWePWw4eSxt0+ZhEBvkHQU01ueaSRE+p9ddbm1oVSF
         2NXNfg5WvlL5urL3Lc26Cn+w4gMYQ17Ixmh0kQaB9IcDzbCGBn/TKLUFDVb3+xBD2Hs3
         u7XACaKRXZGOdqKGTjooMvWXSyO4cYEIDau/CGXMb9oZeMfx3GN/FOnIfp/oFq+33Jnh
         8lAA==
X-Gm-Message-State: APjAAAXCeSb+ZbLRxhfoWk0ob8ZEsEKO1nO3EceS3t7BG1KfPRpsPGN5
        ywPQoJeE/UtnO4ksRG/pZcfISNFaAyzMrbpQnX4=
X-Google-Smtp-Source: APXvYqxeqZRk1pLL2fwFpzqe7/AMcPmAR+aw8erQ6jsKtBMqGfxedtP9x6QgYpPT9MykB/bKg78qxdc82uTzKfs8gaI=
X-Received: by 2002:a50:8854:: with SMTP id c20mr21654324edc.167.1554796692690;
 Tue, 09 Apr 2019 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190408174036.GA11889@altlinux.org> <20190408174127.GB11889@altlinux.org>
In-Reply-To: <20190408174127.GB11889@altlinux.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 9 Apr 2019 15:57:36 +0800
Message-ID: <CAEbi=3dzY7ihDLu=LFnHs_2_5BdAFyi4663W5g1JC+=QaiR7kQ@mail.gmail.com>
Subject: Re: [PATCH linux-next v9 1/7] nds32: fix asm/syscall.h
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Vincent Chen <deanbo422@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry V. Levin <ldv@altlinux.org> =E6=96=BC 2019=E5=B9=B44=E6=9C=889=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> All syscall_get_*() and syscall_set_*() functions must be defined
> as static inline as on all other architectures, otherwise asm/syscall.h
> cannot be included in more than one compilation unit.
>
> This bug has to be fixed in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 1932fbe36e02 ("nds32: System calls handling")
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Dear nds32 maintainers, this fix is waiting for ACK since early January.
>
> Notes:
>     v9: rebased to linux-next again due to syscall_get_arguments() signat=
ure change
>     v8: unchanged
>     v7: initial revision
>
>  arch/nds32/include/asm/syscall.h | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/sy=
scall.h
> index 174b8571d362..d08439a54034 100644
> --- a/arch/nds32/include/asm/syscall.h
> +++ b/arch/nds32/include/asm/syscall.h
> @@ -26,7 +26,8 @@ struct pt_regs;
>   *
>   * It's only valid to call this when @task is known to be blocked.
>   */
> -int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
> +static inline int
> +syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
>  {
>         return regs->syscallno;
>  }
> @@ -47,7 +48,8 @@ int syscall_get_nr(struct task_struct *task, struct pt_=
regs *regs)
>   * system call instruction.  This may not be the same as what the
>   * register state looked like at system call entry tracing.
>   */
> -void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
> +static inline void
> +syscall_rollback(struct task_struct *task, struct pt_regs *regs)
>  {
>         regs->uregs[0] =3D regs->orig_r0;
>  }
> @@ -62,7 +64,8 @@ void syscall_rollback(struct task_struct *task, struct =
pt_regs *regs)
>   * It's only valid to call this when @task is stopped for tracing on exi=
t
>   * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
>   */
> -long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
> +static inline long
> +syscall_get_error(struct task_struct *task, struct pt_regs *regs)
>  {
>         unsigned long error =3D regs->uregs[0];
>         return IS_ERR_VALUE(error) ? error : 0;
> @@ -79,7 +82,8 @@ long syscall_get_error(struct task_struct *task, struct=
 pt_regs *regs)
>   * It's only valid to call this when @task is stopped for tracing on exi=
t
>   * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
>   */
> -long syscall_get_return_value(struct task_struct *task, struct pt_regs *=
regs)
> +static inline long
> +syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
>  {
>         return regs->uregs[0];
>  }
> @@ -99,8 +103,9 @@ long syscall_get_return_value(struct task_struct *task=
, struct pt_regs *regs)
>   * It's only valid to call this when @task is stopped for tracing on exi=
t
>   * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
>   */
> -void syscall_set_return_value(struct task_struct *task, struct pt_regs *=
regs,
> -                             int error, long val)
> +static inline void
> +syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
> +                        int error, long val)
>  {
>         regs->uregs[0] =3D (long)error ? error : val;
>  }
> @@ -118,8 +123,9 @@ void syscall_set_return_value(struct task_struct *tas=
k, struct pt_regs *regs,
>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUD=
IT.
>   */
>  #define SYSCALL_MAX_ARGS 6
> -void syscall_get_arguments(struct task_struct *task, struct pt_regs *reg=
s,
> -                          unsigned long *args)
> +static inline void
> +syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
> +                     unsigned long *args)
>  {
>         args[0] =3D regs->orig_r0;
>         args++;
> @@ -138,8 +144,9 @@ void syscall_get_arguments(struct task_struct *task, =
struct pt_regs *regs,
>   * It's only valid to call this when @task is stopped for tracing on
>   * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUD=
IT.
>   */
> -void syscall_set_arguments(struct task_struct *task, struct pt_regs *reg=
s,
> -                          const unsigned long *args)
> +static inline void
> +syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> +                     const unsigned long *args)
>  {
>         regs->orig_r0 =3D args[0];
>         args++;

Sorry for late.
Acked-by: Greentime Hu <greentime@andestech.com>
