Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A3A206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d97dQHyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfCFQ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:26:24 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40477 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCFQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:26:23 -0500
Received: by mail-vk1-f195.google.com with SMTP id d84so2955593vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOmhbkbDb9nmgxY5MIrOXAc6gEQuMCb0zk4aZvHNhe8=;
        b=d97dQHyB425y3xtdXvgO0a3N2EycPCSeE3gXI3z7xTQrWYvUPsRUqRBBxyJos3UTho
         ta3bJrkpf/8527kR547m/10EtLymEFSuYL/BIpM5DLjIgtWpUDIxHKVmiBn/MfCGKNaO
         9qhjjzQiWBG0zaptEARAD65ilky4PP1pdCk14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOmhbkbDb9nmgxY5MIrOXAc6gEQuMCb0zk4aZvHNhe8=;
        b=B9KJmTuy1t33nsGrnyU5aJQKtjf1uVi6hc5JI+AfPNLptDZgOXz8E96So0a2nqm3U0
         KWhaNRLf6ECcjgPhjbU1CpICrFWG9FktNcvwbxFWkP+28PoCk75/HsILn/s5g4oCjbxT
         Up3OOfec/mfhAAAHVZKuIayBXlFFpjkvneJauOZ6GFp3yBBDnUk5zTejm98uJTLhdcsZ
         vtWoOVfcygDwyfrOnaFINiyZXoGsj91yjzDhExHrs0o+4pXJxyBfInLTmKJLS5Q3KomA
         OLks7cUwrltOx7DPCc2QIBEc3Xs6ZeYC/zYzJQnOwuxAdQoCeilTz0eqhtvnj5Kop3wJ
         +oug==
X-Gm-Message-State: APjAAAX46KvEkiyKunPEOEs7E2lF4mYM7oj1Hs4EXyK3as3p0uvxHVqI
        YY43/XU1kZkdbJEFAzIvyOck8dUN4bw=
X-Google-Smtp-Source: APXvYqxEHlr2fbjJORI1JGyCbNVPmdq5EMonxQDHTxO0OG2yB/IAY5jnsvX+osBfkX0Wd4ltG7URJQ==
X-Received: by 2002:a1f:a295:: with SMTP id l143mr3536067vke.66.1551889581388;
        Wed, 06 Mar 2019 08:26:21 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id f13sm366995vso.19.2019.03.06.08.26.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 08:26:20 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id y19so2577603vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:26:20 -0800 (PST)
X-Received: by 2002:a67:6983:: with SMTP id e125mr4195030vsc.222.1551889579612;
 Wed, 06 Mar 2019 08:26:19 -0800 (PST)
MIME-Version: 1.0
References: <201903061919.b2BJj7iX%fengguang.wu@intel.com>
In-Reply-To: <201903061919.b2BJj7iX%fengguang.wu@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 6 Mar 2019 08:26:07 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKiW9-pnKbRh05_SmYm8TwjoRpsrA8472+Gct_YjVr+Jw@mail.gmail.com>
Message-ID: <CAGXu5jKiW9-pnKbRh05_SmYm8TwjoRpsrA8472+Gct_YjVr+Jw@mail.gmail.com>
Subject: Re: [tip:x86/asm 2/4] arch/x86/include/asm/special_insns.h:31:9:
 error: 'X86_CR0_WP' undeclared
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:43 AM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
> head:   a0bf7fc24303a538396aa8d32450d05c1929b9f0
> commit: d309ba034fac1a149d00cac79318973e9ba81848 [2/4] x86/asm: Pin sensitive CR0 bits
> config: um-x86_64_defconfig (attached as .config)
> compiler: gcc-8 (Debian 8.3.0-2) 8.3.0
> reproduce:
>         git checkout d309ba034fac1a149d00cac79318973e9ba81848
>         # save the attached .config to linux build tree
>         make ARCH=um SUBARCH=x86_64

Gah, I did not build-test um. :(

>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/x86/include/asm/cacheflush.h:7,
>                     from include/linux/highmem.h:12,
>                     from net//core/sock.c:117:
>    arch/x86/include/asm/special_insns.h: In function 'native_write_cr0':
> >> arch/x86/include/asm/special_insns.h:31:9: error: 'X86_CR0_WP' undeclared (first use in this function)
>      val |= X86_CR0_WP;
>             ^~~~~~~~~~

Should I just add something like:

#ifdef __arch_um__
# define X86_CR0_WP 0
#endif

?


-- 
Kees Cook
