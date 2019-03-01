Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2787E2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551470380;
	bh=KQoQlydgbnJEhwe6xSFRI9D3gi8ShQe1rnF0AanqJvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G0GTZEXu6hNkmZ+RyKBTXiTrsnu5H6BG6RQukBqQkVursNxZPmI7TBx1JRBGGsfpx
	 Q4zmNfJlYjv8fZYwIo3+a5YmMd9ti16M0Sms6PkPNGKc90s1ygTRV5d0F6CZLwvPX6
	 p+K1eSl4HziWFtNHsy2tgZ18SvSqVhTdIfpf7ONg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCAT7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfCAT7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:59:38 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14C642087E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2019 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551470377;
        bh=KQoQlydgbnJEhwe6xSFRI9D3gi8ShQe1rnF0AanqJvA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U1/ptRAzGXpfk0E66aa8M2mPVw8Zn0gDjLLQnsV2ePAaDqmZJXxZlnLbXnjHRM3Md
         eSuvz5s2v9tQLUhBQMOADiHwgiAtlvlhvJp1JOd8N2gCam9j/kPPBDwkEjdSNYZUAQ
         Nj4qgHZinaDh5w5bPPKGkmvmv95Ofkj9su6WF11g=
Received: by mail-wm1-f44.google.com with SMTP id z84so13348566wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:59:37 -0800 (PST)
X-Gm-Message-State: APjAAAUDj+Nctkz1lHHEfTAQadwh9dwREwv4oIr4l9l6VVeHa3+/st8/
        VJRwwyaIOD4uzqIb8AfftoMVuZJjRoTfOC7ERMk7Qg==
X-Google-Smtp-Source: AHgI3IaeCSVAag+Tz/Ir1U2mdb7RP8IOk0JUl5UlcKX8glgJmdebKrPAMU1EwdnrXZlyUIeHf3zsb6EBnY/oUkDDawk=
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr4502373wmh.32.1551470375493;
 Fri, 01 Mar 2019 11:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20190301001806.154271-1-smuckle@google.com>
In-Reply-To: <20190301001806.154271-1-smuckle@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Mar 2019 11:59:24 -0800
X-Gmail-Original-Message-ID: <CALCETrUcH9R62gDdiG-EGTfSt2kQktv-0+bYmPcLn4PWNMrHSQ@mail.gmail.com>
Message-ID: <CALCETrUcH9R62gDdiG-EGTfSt2kQktv-0+bYmPcLn4PWNMrHSQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: x86: add version check in test_syscall_vdso
To:     Steve Muckle <smuckle@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 28, 2019, at 4:18 PM, Steve Muckle <smuckle@google.com> wrote:
>
> Since 4.17 registers r8-r11 are not clobbered/zeroed by a 64-bit kernel
> handling a 32-bit syscall and this behavior is enforced by the
> test_syscall_vdso testcase. See commit 8bb2610bc496
> ("x86/entry/64/compat: Preserve r8-r11 in int $0x80").
>
> Permit the old behavior in the testcase for kernels prior to 4.17.

NAK.  If you want an old buggy kernel to pass a test, please either
patch the kernel or run an old test.


>
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
> .../testing/selftests/x86/test_syscall_vdso.c | 30 +++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/x86/test_syscall_vdso.c b/tools/testing/selftests/x86/test_syscall_vdso.c
> index c9c3281077bc..f7284dc4c32b 100644
> --- a/tools/testing/selftests/x86/test_syscall_vdso.c
> +++ b/tools/testing/selftests/x86/test_syscall_vdso.c
> @@ -30,6 +30,7 @@
> #include <sys/time.h>
> #include <elf.h>
> #include <sys/ptrace.h>
> +#include <sys/utsname.h>
> #include <sys/wait.h>
>
> #if !defined(__i386__)
> @@ -71,6 +72,7 @@ struct regs64 {
> };
> struct regs64 regs64;
> int kernel_is_64bit;
> +int clobber_ok;
>
> asm (
>    "    .pushsection .text\n"
> @@ -130,6 +132,28 @@ void print_regs64(void)
>    printf("12:%016llx 13:%016llx 14:%016llx 15:%016llx\n", regs64.r12,  regs64.r13,  regs64.r14,  regs64.r15);
> }
>
> +static void get_kernel_version(int *version, int *patchlevel)
> +{
> +    int ret, sublevel;
> +    struct utsname utsname;
> +
> +    ret = uname(&utsname);
> +    if (ret) {
> +        perror("uname");
> +        exit(1);
> +    }
> +
> +    ret = sscanf(utsname.release, "%d.%d.%d", version, patchlevel,
> +             &sublevel);
> +    if (ret < 0) {
> +        perror("sscanf");
> +        exit(1);
> +    } else if (ret != 3) {
> +        printf("Malformed kernel version %s\n", &utsname.release);
> +        exit(1);
> +    }
> +}
> +
> int check_regs64(void)
> {
>    int err = 0;
> @@ -166,6 +190,8 @@ int check_regs64(void)
>             * Historically (and probably unintentionally), they
>             * were clobbered or zeroed.
>             */
> +            if (clobber_ok && *r64 == 0 && num <= 11)
> +                continue;
>        }
>        printf("[FAIL]\tR%d has changed:%016llx\n", num, *r64);
>        err++;
> @@ -385,6 +411,7 @@ int main(int argc, char **argv, char **envp)
> {
>    int exitcode = 0;
>    int cs;
> +    int version, patchlevel;
>
>    asm("\n"
>    "    movl    %%cs, %%eax\n"
> @@ -394,6 +421,9 @@ int main(int argc, char **argv, char **envp)
>    if (!kernel_is_64bit)
>        printf("[NOTE]\tNot a 64-bit kernel, won't test R8..R15 leaks\n");
>
> +    get_kernel_version(&version, &patchlevel);
> +    clobber_ok = version < 4 || (version == 4 && patchlevel < 17);
> +
>    /* This only works for non-static builds:
>     * syscall_addr = dlsym(dlopen("linux-gate.so.1", RTLD_NOW), "__kernel_vsyscall");
>     */
> --
> 2.21.0.352.gf09ad66450-goog
>
