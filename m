Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2363C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7898F2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pse7AIJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAGUl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:41:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41729 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgAGUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:41:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so433567pfw.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=elgI3vKe52VBb1amGoNs0niUYR4aSQmTxfCO3jOaCgQ=;
        b=pse7AIJXvWQEE1UrVGW8LJRquTGP8AhP+gp8sQ/BNXrJJHXyEyupgeEYOjvJqHIhEs
         PSGCWfQo2WPn485ZKM4yX7WYtk4J6xSk95atY/62GyVK95SX1OVTRBaqZavBrIq4lqfF
         WPq1xB6Kcv6KzUX2ZOPIbCXF0n3D+IsA6MQ/mOaTfoHOM+Dh6Gj1xb9pRB5I48FbOZ3T
         W4f3Uyk7fw0/WxpSbeioFR3mqbt2WPHs89j/WtgyN3VbpUEQiHla1UB+xXFGtdGRtsDq
         V50EqoaH2IyLzX4rXIfHZ2frmNfSmvUxLhgmR3KY0+ZzjLFeOJ4CZmw28hltvQwaz4uL
         siUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=elgI3vKe52VBb1amGoNs0niUYR4aSQmTxfCO3jOaCgQ=;
        b=LwZ4Tt0JJYiIuvbgIicADceaxBvwaoBFNyqkbYcy9WHJBfb2H6dmGYguXxTTKGkTqg
         39I9Gx+P2wUESi58PH0zBIHwGYMLJ8Zj++GTuf+74lUf/i9fCrh/OJ6CYBOexYDeT16f
         iKhuJfEhJSneUre99p+XwcTYZyzI3nb/roG/HSXCYXomQNjT+xvd1IB/HCk3pYAfuPw5
         k9u6fe+Uc3ldrI8sobPqsWr85jMsZirqkvYV8i49TZxEibH1CEj0UvmgSBIsFEYgFXqd
         Gca1FFLrpBcTNW0WctCrBnUImCZaLk5Y3GShXz/pLqkVMMlJePLDG33jh66VkbdudeYz
         96Cg==
X-Gm-Message-State: APjAAAVOdf8j6PSxQ+AsztjvEqElt9Zti8DRkQr3OgRMR8lFL/ao/gHo
        tpl/9wvVB+1iTO/M3g7w6V4IcQ==
X-Google-Smtp-Source: APXvYqwvP/NWGZr0X6kWP6rcKHpWUCX+DPRDpUq3Wph/gVXd7pxhhiPaSwalQ7F38GwxCKXEHkuQtw==
X-Received: by 2002:a63:eb15:: with SMTP id t21mr1414307pgh.365.1578429716604;
        Tue, 07 Jan 2020 12:41:56 -0800 (PST)
Received: from [10.197.24.59] ([139.104.2.60])
        by smtp.gmail.com with ESMTPSA id y62sm475499pfg.45.2020.01.07.12.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 12:41:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [tip: x86/fpu] x86/fpu: Deactivate FPU state after failure during state load
Date:   Tue, 7 Jan 2020 10:41:52 -1000
Message-Id: <FA0D2929-63D0-4473-A492-42227D7A5D98@amacapital.net>
References: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
Cc:     linux-tip-commits@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>
In-Reply-To: <157840155965.30329.313988118654552721.tip-bot2@tip-bot2>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 7, 2020, at 2:52 AM, tip-bot2 for Sebastian Andrzej Siewior <tip-bo=
t2@linutronix.de> wrote:
>=20
> =EF=BB=BFThe following commit has been merged into the x86/fpu branch of t=
ip:
>=20
> Commit-ID:     bbc55341b9c67645d1a5471506370caf7dd4a203
> Gitweb:        https://git.kernel.org/tip/bbc55341b9c67645d1a5471506370caf=
7dd4a203
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Fri, 20 Dec 2019 20:59:06 +01:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Tue, 07 Jan 2020 13:44:42 +01:00
>=20
> x86/fpu: Deactivate FPU state after failure during state load
>=20
> In __fpu__restore_sig(), fpu_fpregs_owner_ctx needs to be reset if the
> FPU state was not fully restored. Otherwise the following may happen (on
> the same CPU):
>=20
>  Task A                     Task B               fpu_fpregs_owner_ctx
>  *active*                                        A.fpu
>  __fpu__restore_sig()
>                             ctx switch           load B.fpu
>                             *active*             B.fpu
>  fpregs_lock()
>  copy_user_to_fpregs_zeroing()
>    copy_kernel_to_xregs() *modify*
>    copy_user_to_xregs() *fails*
>  fpregs_unlock()
>                            ctx switch            skip loading B.fpu,
>                            *active*              B.fpu
>=20
> In the success case, fpu_fpregs_owner_ctx is set to the current task.
>=20
> In the failure case, the FPU state might have been modified by loading
> the init state.
>=20
> In this case, fpu_fpregs_owner_ctx needs to be reset in order to ensure
> that the FPU state of the following task is loaded from saved state (and
> not skipped because it was the previous state).
>=20
> Reset fpu_fpregs_owner_ctx after a failure during restore occurred, to
> ensure that the FPU state for the next task is always loaded.
>=20
> The problem was debugged-by Yu-cheng Yu <yu-cheng.yu@intel.com>.

Wow, __fpu__restore_sig is a mess. We have __copy_from... that is Obviously I=
ncorrect (tm) even though it=E2=80=99s not obviously exploitable. (It=E2=80=99=
s wrong because the *wrong pointer* is checked with access_ok().). We have a=
 fast path that will execute just enough of the time to make debugging the s=
low path really annoying. (We should probably delete the fast path.)  There a=
re pagefault_disable() call in there mostly to confuse people. (So we take a=
 fault and sleep =E2=80=94 big deal.  We have temporarily corrupt state, but=
 no one will ever read it.  The retry after sleeping will clobber xstate, bu=
t lazy save is long gone and this should be fine now.  The real issue is tha=
t, if we=E2=80=99re preempted after a successful a successful restore, then t=
he new state will get lost.)

So either we should delete the fast path or we should make it work reliably a=
nd delete the slow path.  And we should get rid of the __copy. And we should=
 have some test cases.

BTW, how was the bug in here discovered?  It looks like it only affects sign=
al restore failure, which is usually not survivable unless the user program i=
s really trying.

>=20
> [ bp: Massage commit message. ]
>=20
> Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to users=
pace")
> Reported-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20191220195906.plk6kpmsrikvbcfn@linutronix=
.de
> ---
> arch/x86/kernel/fpu/signal.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 0071b79..400a05e 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -352,6 +352,7 @@ static int __fpu__restore_sig(void __user *buf, void _=
_user *buf_fx, int size)
>            fpregs_unlock();
>            return 0;
>        }
> +        fpregs_deactivate(fpu);
>        fpregs_unlock();
>    }
>=20
> @@ -403,6 +404,8 @@ static int __fpu__restore_sig(void __user *buf, void _=
_user *buf_fx, int size)
>    }
>    if (!ret)
>        fpregs_mark_activate();
> +    else
> +        fpregs_deactivate(fpu);
>    fpregs_unlock();
>=20
> err_out:
