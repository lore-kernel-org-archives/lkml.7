Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4517206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Xc2XgOoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUWKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:10:41 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34383 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKUWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:10:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id bo14so2143907pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=qcPs784CbumiKQYaUrwCzqNYc6XDhkHEE5cXJGE/TCQ=;
        b=Xc2XgOoVRPmMbOCOXl+I/uEXvTahrcCXq0PHwT7SBMOj21E7/+b2IB/xfeRvFQh4m/
         xSa08VXTH91AKvAXeNgz9r/m17LLufzO9x+frdPckIQfQpOjc10ZpFYBvIpIZEveD3VC
         gHcNCa16AhRQFCX2vUX8oqiEyINJJx0CvdogfiRn4JFy83aeHWwW0htuHIwd5VnPyAoK
         lbgbNcJ7/4NWiBAFqhFHmombMQ7yAaIq8gleaeGgZLzJZk+eMWz2ytj3QnHwR5aAZ2YH
         A3+UXOG37R5Mj7lbRPJsiUfISwucn5mCOh98XBgw1sILb07A/+kJ8iJCZcJnRyMosWR/
         itoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=qcPs784CbumiKQYaUrwCzqNYc6XDhkHEE5cXJGE/TCQ=;
        b=LJgAMiOePMIUzZiLDKz4J3U2Wb6Vuy+eW0gPIm1g9UEy09T40/BORse5WYTVPzBCCU
         jpWiPxJcIPD0V9A3xQoBpuIPdLrjDaFDjk4C19+sZQGOVeAxZ+X1N2GjyWJgjVSxmX17
         bI/OB/yD9V63FmH+56wlinBDHuAOiWuCEPmTxvH8eodkfxTwRnNH6akQeubMMZJoj4LI
         Lo90kQeD3WxAZhvO9ql2cOd1TfMZ0zf/gVbNaDWHBzPKuzNIo5ZPbKpQ8+6jq6MJGnUm
         D2pZJjoUjA6tdZHjhvCO6duScgWLetbQ6nvGkBECr8WRsG3y+UP5+gN8NtBPKooRqvbl
         SNBQ==
X-Gm-Message-State: APjAAAXjKyulaCmJQG1KeEGPkBnlu3yl4XYMQaI4FpT03dB4KujaKzsQ
        h9R/OHNDs1xUlwYGII18G7ty4cIF2Ak3TA==
X-Google-Smtp-Source: APXvYqyqDomZtopgc7SZ330pFyO+LlTyoxpUpISJ5YEQJYEsW22pDlk2n5ttCNMz4PHqETC9pLPc9w==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr14863711pjb.128.1574374240713;
        Thu, 21 Nov 2019 14:10:40 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:1956:3100:f5cd:d9bc? ([2601:646:c200:1ef2:1956:3100:f5cd:d9bc])
        by smtp.gmail.com with ESMTPSA id y4sm4455350pfn.97.2019.11.21.14.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:10:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 5/6] x86/split_lock: Handle #AC exception for split lock
Date:   Thu, 21 Nov 2019 14:10:38 -0800
Message-Id: <5BDDAE0C-2D31-4779-B3A0-5BF206FF3E50@amacapital.net>
References: <1574297603-198156-6-git-send-email-fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <1574297603-198156-6-git-send-email-fenghua.yu@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 20, 2019, at 5:45 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFCurrently Linux does not expect to see an alignment check excepti=
on in
> kernel mode (since it does not set CR4.AC). The existing #AC handlers
> will just return from exception to the faulting instruction which will
> trigger another exception.
>=20
> Add a new handler for #AC exceptions that will force a panic on split
> lock for kernel mode.
>=20
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> arch/x86/include/asm/traps.h |  3 +++
> arch/x86/kernel/cpu/intel.c  |  2 ++
> arch/x86/kernel/traps.c      | 22 +++++++++++++++++++++-
> 3 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index b25e633033c3..0fa4eef83057 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -172,4 +172,7 @@ enum x86_pf_error_code {
>    X86_PF_INSTR    =3D        1 << 4,
>    X86_PF_PK    =3D        1 << 5,
> };
> +
> +extern bool split_lock_detect_enabled;
> +
> #endif /* _ASM_X86_TRAPS_H */
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 2614616fb6d3..bc0c2f288509 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -32,6 +32,8 @@
> #include <asm/apic.h>
> #endif
>=20
> +bool split_lock_detect_enabled;
> +
> /*
>  * Just in case our CPU detection goes bad, or you have a weird system,
>  * allow a way to override the automatic disabling of MPX.
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4bb0f8447112..044033ff4326 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -293,9 +293,29 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "=
coprocessor segment overru
> DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",       =
  invalid_TSS)
> DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present"=
, segment_not_present)
> DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",     =
  stack_segment)
> -DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",  =
   alignment_check)
> #undef IP
>=20
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_co=
de)
> +{
> +    unsigned int trapnr =3D X86_TRAP_AC;
> +    char str[] =3D "alignment check";
> +    int signr =3D SIGBUS;
> +
> +    RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +    if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) =3D=3D=
 NOTIFY_STOP)
> +        return;
> +
> +    if (!user_mode(regs) && split_lock_detect_enabled)
> +        panic("Split lock detected\n");

NAK.

1. Don=E2=80=99t say =E2=80=9Csplit lock detected=E2=80=9D if you don=E2=80=99=
t know that you detected a split lock.  Or is this genuinely the only way to=
 get #AC from kernel mode?

2. Don=E2=80=99t panic. Use die() just like every other error where nothing i=
s corrupted.

And maybe instead turn off split lock detection and print a stack trace inst=
ead.  Then the kernel is even more likely to survive to log something useful=
.

