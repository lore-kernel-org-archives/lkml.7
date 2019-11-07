Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD44C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69382214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="v20R4Qvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbfKGJAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:00:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40195 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733290AbfKGJAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:00:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id f3so1449495wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=6/Dn38AHuTTqzHYmM8d85ghJi9EkAoLDo1fx1CJYtJQ=;
        b=v20R4QvpzFz1C4Gj2P+w54EU/62JG91sF5VhOXvcom3pGDmnGL+eupMYKo1xiI3uem
         K7XULOh2ncLxyoFncLMknJRrB2RfFTmSPjekkfordENXeYTEtImy0H/FymvJwS2L5ZVF
         SI+enH3PRpAFUL5zxDGNquMTvs/w/zcJgKioy48WA6Oi7e8lfqtftrU7UvhwREdrdWA2
         r+vf6nBq3EKdOoGmA15wQAfu6t+3U2keSj4LSfte/LtGtrkx0R8KlIeXqaeYlMV/Xerq
         IaKUniXGpy3a9pwDN2Y7IBRJqf8tkTgPpLXpicX0yRBRAP2Rux6KQz9viWys1+IiLeRv
         wMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=6/Dn38AHuTTqzHYmM8d85ghJi9EkAoLDo1fx1CJYtJQ=;
        b=HJdKDLPq+aF2RikJhsv7kFkt5xyhsa377QH3LADodZe/y15JQtd19tTb30fQm4Cbwh
         rxXJ+5rLyAeqIEzMrSt+XX5B/WQzscXMcl0QWSHXbhTE7qBn4uHTnIEzP4Jzyo1Bg+up
         dDHxKTnyK6p9wSD3zk9oK/MqNPc+gQWxlfKHdtUKdY79OxrMiOjwlOt6EvGruRogqB7c
         JDOVfrQDNgMPQb48x1IcZb/6z2WYkk+0OMYqkI7gRlCGtMzFwhpHTEkv10aiPpZaQyxc
         xYMXjQiKt+xUU5CLx8+2hdTMM0kF8R6pp36ZOtRhnZ4vGQLDGH0XVjBK9Nc91Hdu2w8O
         741g==
X-Gm-Message-State: APjAAAWojsiVwyia96N2F+OlCPA445yUnujF6GHzHIK74dtdYGwXPTmc
        fXiogKb0v5wylAk8V1WC+VfpLA==
X-Google-Smtp-Source: APXvYqypSHnXw+XpHdI9iFvGtIpd69Oo0Z2ibvsXCWccs7oGE+dkr9eQ0yoyiKuF9YZ+We3gJeAjmQ==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr1606821wmg.148.1573117201050;
        Thu, 07 Nov 2019 01:00:01 -0800 (PST)
Received: from [173.194.76.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id z189sm1674369wmc.25.2019.11.07.00.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 01:00:00 -0800 (PST)
Subject: Re: [PATCH 18/50] microblaze: Add loglvl to microblaze_unwind_inner()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-19-dima@arista.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
Message-ID: <be4908df-1af7-fe00-9824-e54b9b97f433@monstr.eu>
Date:   Thu, 7 Nov 2019 09:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106030542.868541-19-dima@arista.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mfk3GpJJGkDZD5QO2VkBCLlyhXHUpXo43"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mfk3GpJJGkDZD5QO2VkBCLlyhXHUpXo43
Content-Type: multipart/mixed; boundary="uP9y87WU2pqIVTsChg0LLqTMaE7Kh7U3l";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
 Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <be4908df-1af7-fe00-9824-e54b9b97f433@monstr.eu>
Subject: Re: [PATCH 18/50] microblaze: Add loglvl to microblaze_unwind_inner()
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-19-dima@arista.com>
In-Reply-To: <20191106030542.868541-19-dima@arista.com>

--uP9y87WU2pqIVTsChg0LLqTMaE7Kh7U3l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06. 11. 19 4:05, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
>=20
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
>=20
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
>=20
> Add log level argument to microblaze_unwind_inner() as a preparation fo=
r
> introducing show_stack_loglvl().
>=20
> Cc: Michal Simek <monstr@monstr.eu>
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com=
/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/microblaze/kernel/unwind.c | 35 ++++++++++++++++++++-------------=

>  1 file changed, 21 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/microblaze/kernel/unwind.c b/arch/microblaze/kernel/u=
nwind.c
> index 4241cdd28ee7..9a7343feadf5 100644
> --- a/arch/microblaze/kernel/unwind.c
> +++ b/arch/microblaze/kernel/unwind.c
> @@ -162,16 +162,18 @@ static void microblaze_unwind_inner(struct task_s=
truct *task,
>   */
>  #ifdef CONFIG_MMU
>  static inline void unwind_trap(struct task_struct *task, unsigned long=
 pc,
> -				unsigned long fp, struct stack_trace *trace)
> +				unsigned long fp, struct stack_trace *trace,
> +				const char *loglvl)
>  {
>  	/* To be implemented */
>  }
>  #else
>  static inline void unwind_trap(struct task_struct *task, unsigned long=
 pc,
> -				unsigned long fp, struct stack_trace *trace)
> +				unsigned long fp, struct stack_trace *trace,
> +				const char *loglvl)
>  {
>  	const struct pt_regs *regs =3D (const struct pt_regs *) fp;
> -	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace);
> +	microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trace, l=
oglvl);
>  }
>  #endif
> =20
> @@ -184,11 +186,13 @@ static inline void unwind_trap(struct task_struct=
 *task, unsigned long pc,
>   *				  the caller's return address.
>   * @trace : Where to store stack backtrace (PC values).
>   *	    NULL =3D=3D print backtrace to kernel log
> + * @loglvl : Used for printk log level if (trace =3D=3D NULL).
>   */
>  static void microblaze_unwind_inner(struct task_struct *task,
>  			     unsigned long pc, unsigned long fp,
>  			     unsigned long leaf_return,
> -			     struct stack_trace *trace)
> +			     struct stack_trace *trace,
> +			     const char *loglvl)
>  {
>  	int ofs =3D 0;
> =20
> @@ -214,11 +218,11 @@ static void microblaze_unwind_inner(struct task_s=
truct *task,
>  			const struct pt_regs *regs =3D
>  				(const struct pt_regs *) fp;
>  #endif
> -			pr_info("HW EXCEPTION\n");
> +			printk("%sHW EXCEPTION\n", loglvl);
>  #ifndef CONFIG_MMU
>  			microblaze_unwind_inner(task, regs->r17 - 4,
>  						fp + EX_HANDLER_STACK_SIZ,
> -						regs->r15, trace);
> +						regs->r15, trace, loglvl);
>  #endif
>  			return;
>  		}
> @@ -228,8 +232,8 @@ static void microblaze_unwind_inner(struct task_str=
uct *task,
>  			if ((return_to >=3D handler->start_addr)
>  			    && (return_to <=3D handler->end_addr)) {
>  				if (!trace)
> -					pr_info("%s\n", handler->trap_name);
> -				unwind_trap(task, pc, fp, trace);
> +					printk("%s%s\n", loglvl, handler->trap_name);
> +				unwind_trap(task, pc, fp, trace, loglvl);
>  				return;
>  			}
>  		}
> @@ -248,13 +252,13 @@ static void microblaze_unwind_inner(struct task_s=
truct *task,
>  		} else {
>  			/* Have we reached userland? */
>  			if (unlikely(pc =3D=3D task_pt_regs(task)->pc)) {
> -				pr_info("[<%p>] PID %lu [%s]\n",
> -					(void *) pc,
> +				printk("%s[<%p>] PID %lu [%s]\n",
> +					loglvl, (void *) pc,
>  					(unsigned long) task->pid,
>  					task->comm);
>  				break;
>  			} else
> -				print_ip_sym(KERN_INFO, pc);
> +				print_ip_sym(loglvl, pc);
>  		}
> =20
>  		/* Stop when we reach anything not part of the kernel */
> @@ -285,11 +289,13 @@ static void microblaze_unwind_inner(struct task_s=
truct *task,
>   */
>  void microblaze_unwind(struct task_struct *task, struct stack_trace *t=
race)
>  {
> +	const char *loglvl =3D KERN_INFO;
> +
>  	if (task) {
>  		if (task =3D=3D current) {
>  			const struct pt_regs *regs =3D task_pt_regs(task);
>  			microblaze_unwind_inner(task, regs->pc, regs->r1,
> -						regs->r15, trace);
> +						regs->r15, trace, loglvl);
>  		} else {
>  			struct thread_info *thread_info =3D
>  				(struct thread_info *)(task->stack);
> @@ -299,7 +305,8 @@ void microblaze_unwind(struct task_struct *task, st=
ruct stack_trace *trace)
>  			microblaze_unwind_inner(task,
>  						(unsigned long) &_switch_to,
>  						cpu_context->r1,
> -						cpu_context->r15, trace);
> +						cpu_context->r15,
> +						trace, loglvl);
>  		}
>  	} else {
>  		unsigned long pc, fp;
> @@ -314,7 +321,7 @@ void microblaze_unwind(struct task_struct *task, st=
ruct stack_trace *trace)
>  		);
> =20
>  		/* Since we are not a leaf function, use leaf_return =3D 0 */
> -		microblaze_unwind_inner(current, pc, fp, 0, trace);
> +		microblaze_unwind_inner(current, pc, fp, 0, trace, loglvl);
>  	}
>  }
> =20
>=20

I can't see any reaction from bots but you forget to update function
declaration there which is causing build issue.

here is c&p patch.
Other then this it looks good to me.

diff --git a/arch/microblaze/kernel/unwind.c
b/arch/microblaze/kernel/unwind.c
index 74dded96c10a..778a761af0a7 100644
--- a/arch/microblaze/kernel/unwind.c
+++ b/arch/microblaze/kernel/unwind.c
@@ -154,7 +154,8 @@ static int lookup_prev_stack_frame(unsigned long fp,
unsigned long pc,
 static void microblaze_unwind_inner(struct task_struct *task,
                                    unsigned long pc, unsigned long fp,
                                    unsigned long leaf_return,
-                                   struct stack_trace *trace);
+                                   struct stack_trace *trace,
+                                   const char *loglvl);

 /**
  * unwind_trap - Unwind through a system trap, that stored previous stat=
e

Thanks,
Michal




--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--uP9y87WU2pqIVTsChg0LLqTMaE7Kh7U3l--

--mfk3GpJJGkDZD5QO2VkBCLlyhXHUpXo43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXcPdBQAKCRDKSWXLKUoM
IVtkAJ96N0fqDzzAfqmKPGpKK7ey5vKeJgCfUIAP0VCByRa5UFS0QsO+RAgxYsk=
=DuX0
-----END PGP SIGNATURE-----

--mfk3GpJJGkDZD5QO2VkBCLlyhXHUpXo43--
