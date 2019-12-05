Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9DC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F0206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gopFO7C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfLEPkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:40:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34734 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:40:03 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1440355qvf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 07:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqt17/O8Y7rvBVYZ7o7fDZNIdNzlEfuRTH0+EnFXCwc=;
        b=gopFO7C09s5VI0YWLdHIV8Et9ssr/FP3k+hUed9ePI3ydQFxj2sbiOyXu7BNb/9GXO
         mc8y1s7KCJZbosyl9HU/Ukd40/bYXZG4l6/1Gqq2Y4Trs00I2z0GA+A/cVU8AipuMyVV
         oTKmV9MXE37xTST6BT5C50yi2iaIWXiMMIjhAnajHSaKi2Fs6CSTh2w1M5QtzkHEFF9C
         TLytajpjsKROHrfy3GwelE5y0dt0mUUhKpmSuh5an5XpeFjpXmZsRKgmLjDoa1Jh7wzo
         ZmdNRdwOy8aCjVeNYrEtzEFfHU92q7Cf4xL+6Wus2vy61eEQ7vwSGrzjSmTKT3Ec7nD3
         d1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqt17/O8Y7rvBVYZ7o7fDZNIdNzlEfuRTH0+EnFXCwc=;
        b=mvv9/FWQEdVwiR7YSXsohkv0/3Y6x0xmE+Ns56TqX6fSUNNkBxw2hEAy+PmIs/lRkP
         nz9hblyUXtabY+AN0OB9x7f1OI0Sf0I/SqbjWyaAHn6QFVeL9SJGV8Ryufn9671GOAhY
         WjmifW+awYmAwlMb/1LhprGOnrwSdgbt04Ue7+vukk14liBd6P87H5dUWQ23F3ZaioTs
         XuTRuZXMiJCkZD3vB82o1kK1ser/DKQHc6nUICZdAVd040aQ+JpHvpewZi8Cyn4ikMgY
         XmUVrYSVyQ19l6yDMGg7R41QL7eJ37Wi8iJhX3VbPUe+LxZ5WEFEZbjoZhbmO+DinnAo
         jSUg==
X-Gm-Message-State: APjAAAWxTt4gaAbC/89o813KUms9wZjZ/PTfmuaxV/OxESI0KJlNiE7g
        JGLZAuPSE7STxuNTNZpJSp9JTyYM9WDzlmMQ8vt2U8Vj
X-Google-Smtp-Source: APXvYqw7pKP51QHv5qfyJoXAWmeiOhvK5wu56QeojXDhUoeQ4qy/Kt9deCH0CgldhMqOAPD53VYluObFAqXUqNCU5gk=
X-Received: by 2002:ad4:4364:: with SMTP id u4mr8094171qvt.27.1575560401814;
 Thu, 05 Dec 2019 07:40:01 -0800 (PST)
MIME-Version: 1.0
References: <174DB3D9-8C97-4022-A5B5-6A3E007440AF@oracle.com>
In-Reply-To: <174DB3D9-8C97-4022-A5B5-6A3E007440AF@oracle.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Thu, 5 Dec 2019 10:39:50 -0500
Message-ID: <CAGF4SLgoWVwRJaV4PhjzNM0jhg+6bTSEW21o75J74DD4ziOmYA@mail.gmail.com>
Subject: Re: [PATCH ] kernel/crash_core.c - Add crashkernel=auto for x86 and Arm
To:     John Donnelly <john.p.donnelly@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This generally depends on what goes into initrd. Kernel can't know
upfront how big is kdump's initrd going to be. For example, I have
systems with <1TB RAM and 750MB reserved for crashkernel.

Don't think crashkernel=auto can be generalized. RHEL can implement
=auto, because this is a controlled environment (well, in most cases).

On Wed, Dec 4, 2019 at 11:21 AM John Donnelly
<john.p.donnelly@oracle.com> wrote:
>
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation to both x86 and Arm platform as implemenented in
> RH 4.18.0-147.el8 kernels. The values have been adjusted for x86 and
> Arm based from 5.4.0 kernel crash testing.
>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst | 12 ++++++++++
>  kernel/crash_core.c                       | 28 +++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index ac7e131d2935..7635bbb4ab34 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -285,6 +285,18 @@ This would mean:
>      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>      3) if the RAM size is larger than 2G, then reserve 128M
>
> +Or you can use crashkernel=auto if you have enough memory.  The threshold
> +is 1G on x86_64, 2G on arm64, ppc64 and ppc64le. The threshold is 4G for s390x.
> +If your system memory is less than the threshold crashkernel=auto will not
> +reserve memory.
> +
> +The automatically reserved memory size varies based on architecture.
> +The size changes according to system memory size like below:
> +    x86_64: 1G-64G:160M,64G-1T:280M,1T-:512M
> +    s390x:  4G-64G:160M,64G-1T:256M,1T-:512M
> +    arm64:  2G-:768M
> +    ppc64:  2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
> +
>
>
>  Boot into System Kernel
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 9f1557b98468..564aca60e57f 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -7,6 +7,7 @@
>  #include <linux/crash_core.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kexec.h>
>
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -39,6 +40,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
>                                         unsigned long long *crash_base)
>  {
>         char *cur = cmdline, *tmp;
> +       unsigned long long total_mem = system_ram;
> +
> +       /*
> +        * Firmware sometimes reserves some memory regions for it's own use.
> +        * so we get less than actual system memory size.
> +        * Workaround this by round up the total size to 128M which is
> +        * enough for most test cases.
> +        */
> +       total_mem = roundup(total_mem, SZ_128M);
>
>         /* for each entry of the comma-separated list */
>         do {
> @@ -83,13 +93,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
>                         return -EINVAL;
>                 }
>                 cur = tmp;
> -               if (size >= system_ram) {
> +               if (size >= total_mem) {
>                         pr_warn("crashkernel: invalid size\n");
>                         return -EINVAL;
>                 }
>
>                 /* match ? */
> -               if (system_ram >= start && system_ram < end) {
> +               if (total_mem >= start && total_mem < end) {
>                         *crash_size = size;
>                         break;
>                 }
> @@ -248,6 +258,20 @@ static int __init __parse_crashkernel(char *cmdline,
>         if (suffix)
>                 return parse_crashkernel_suffix(ck_cmdline, crash_size,
>                                 suffix);
> +
> +       if (strncmp(ck_cmdline, "auto", 4) == 0) {
> +#ifdef CONFIG_X86_64
> +               ck_cmdline = "1G-64G:160M,64G-1T:280M,1T-:512M";
> +#elif defined(CONFIG_S390)
> +               ck_cmdline = "4G-64G:160M,64G-1T:256M,1T-:512M";
> +#elif defined(CONFIG_ARM64)
> +               ck_cmdline = "2G-:768M";
> +#elif defined(CONFIG_PPC64)
> +               ck_cmdline = "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
> +#endif
> +               pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> +       }
> +
>         /*
>          * if the commandline contains a ':', then that's the extended
>          * syntax -- if not, it must be the classic syntax
> --
> 2.20.1
>
>


-- 
wbr, Vitaly
