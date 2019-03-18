Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE402085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfCRObz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:31:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42854 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfCRObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:31:51 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EA69172CC8C;
        Mon, 18 Mar 2019 17:31:47 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C662E7CC74C; Mon, 18 Mar 2019 17:31:47 +0300 (MSK)
Date:   Mon, 18 Mar 2019 17:31:47 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190318143147.GB27941@altlinux.org>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20190318104925.16600-3-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 10:49:21AM +0000, Sudeep Holla wrote:
> Currently each architecture handles PTRACE_SYSEMU in very similar way.
> It's completely arch independent and can be handled in the code helping
> to consolidate PTRACE_SYSEMU handling.
>=20
> Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
> entry code can call.
>=20
> Cc: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/ptrace.h |  1 +
>  kernel/ptrace.c        | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index edb9b040c94c..e30f51e3363e 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -407,6 +407,7 @@ static inline void user_single_step_report(struct pt_=
regs *regs)
>  #define current_user_stack_pointer() user_stack_pointer(current_pt_regs(=
))
>  #endif
> =20
> +extern long ptrace_syscall_enter(struct pt_regs *regs);
>  extern int task_current_syscall(struct task_struct *target, long *callno,
>  				unsigned long args[6], unsigned int maxargs,
>  				unsigned long *sp, unsigned long *pc);
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 4fa3b7f4c3c7..c9c505c483df 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -29,6 +29,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/cn_proc.h>
>  #include <linux/compat.h>
> +#include <linux/tracehook.h>
> =20
>  /*
>   * Access another process' address space via ptrace.
> @@ -557,6 +558,27 @@ static int ptrace_detach(struct task_struct *child, =
unsigned int data)
>  	return 0;
>  }
> =20
> +/*
> + * Hook to check and report for PTRACE_SYSEMU, can be called from arch
> + * arch syscall entry code
> + */
> +long ptrace_syscall_enter(struct pt_regs *regs)
> +{
> +#ifdef TIF_SYSCALL_EMU
> +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> +		if (tracehook_report_syscall_entry(regs))
> +			/*
> +			 * We can ignore the return code here as we need
> +			 * return -1 always for syscall emulation irrespective
> +			 * of whether the tracehook report fails or succeed.
> +			 */
> +			;

This is problematic as it causes build errors with -Werror=3Dempty-body,
see https://lore.kernel.org/lkml/20181218205305.26647-1-malat@debian.org/


--=20
ldv

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcj6vTAAoJEAVFT+BVnCUIZdoQAMNcDIAbaXHLJT0H192POtdF
rRwlBaKZeLHo9YKsCNI0YJWD5L6mrw6pzKrIb+O7w3fkel4k/BYhKJj0VKMriGWv
ZhB0qOsRMRj8ytIGzBP+g0EjB+OVO0KBDrR9aKa1Kh3lRIL95sECaoZkcI4xv3dw
5Gs46YNIHaKzXg/0kdAmKb6/FmTqC+0x7dB1KdvuIP8uKFNKOAaLwopTS6fmTVvd
SZPBuzeOhTvSvm73avmwwsLf2agniq9nFRiw1Q/3JWPxoRcJToRSozwudkm64z7J
OClyRZiOsFTvtXd/tiPZVPr17YhNR2f6XQYtqpWCMzSsbLpvO86cTFJcFIzpWfJr
ly+oeURC24KQK2jPjVLBeisugW074Kva0CqGYu/tKAUScWcvoXs6miNYv5/VoiIe
yZWr4WlJ5God4Tnk5Y/BFvm3fhwShy+u56VpLy1hX8QaEZUC+jSp0N9YrS5ufx7U
WMhdEHfXwfuoMtyAUSINxINFabH15RfC9P818lXmBs4tbKJs51OUQZ5OsyPF0MQn
+iPj1Ups+D+1m788lrQE6RsyC4/3piJNehIt7S+5K73UeMek/f2LA5rq+BSjjzBO
iJD6xpWwvqLg5mpAAn7Jdq0Wzz7g16auC2m+6F5pXeTA/a5Ju7qrPh1i1Xwx6qqH
osPsh+YtCIqvfsZn9TSQ
=fKg4
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
