Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51898C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BF0206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="abRNK5B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388837AbfHATyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:54:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34258 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388679AbfHATyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:54:12 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so147109544iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XmcYKf0FOnxKZKxVAM5rmvyn8eXCNIHgFNUaqAnuGRo=;
        b=abRNK5B1aE6MrW/tspyrZPpLirQvMSgWAIR+DI1AqeiYYF3SyCyAIgWwaI+ePAATzB
         fgX49K6Hc2wsnRIZLOe5e4Uulv0O/OBccsU4dvBso/6EcLX0cHn0k+7Y/67JB0qxm8m0
         r/CSUPl7vhA/IOLh5WX+kPWr7eaF33PSFlZlLlwh1z0BydnNxtYSyA1nzQs/Qjn60utZ
         57d+qwlhrLQh7jQTzEM1Y1QqZRh+fhd3EJNcNbe/aLM8N3eDF/NE+D/2krKq9Mb8iKeg
         ez+PFi4KxsX9m4I307mX9xxM2+Bkp5B6EXT/QZfwM9vTmvb6leBU4XInsV2r9PkcSVOc
         p5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XmcYKf0FOnxKZKxVAM5rmvyn8eXCNIHgFNUaqAnuGRo=;
        b=PzZFe/wv6S1YvDvXXsj2FMEMy5hA/cv078WelUhytzDgLLTAeXsbJyuf/fdPymaQyn
         Jj5lNi9JkqHs9bCvvyuOlEs49TCsa5Y3PvCsPWy5EMUAgpz29B3Gy5Fn8NEzCBOtjeBE
         g8EIUVutMIf7M+1TWTvDliuwkUvATHSQicRzQCRyHtQOS6WeKgXfMu6eeMto/9GX5LO+
         fMdqOI0hdZLrnHncWesjRKka2VAASxtMVXpy/ZmNH+/vL3yy5jFP3P1YCF8tCYRXgWr5
         70/YF53soKqWFTVEF+KNPKfRn+T39/sxo4gzyLFBcyuiUr14sfZFQjZLFbOvy3XVwMRu
         Zo9g==
X-Gm-Message-State: APjAAAXFI8mkzNiYlxcG8jfqfAWUkORti83RZvOWClr6izbToSu3CfDw
        c1p+owgXqwU0EmWp3OElSWw=
X-Google-Smtp-Source: APXvYqx8pyy9L7qWBcYLFvkyFKPL5+2Xs1zY9e4EUcaktrKHsiwD/9cTRGEAG5QdssplXo9cM396Tw==
X-Received: by 2002:a02:340d:: with SMTP id x13mr135822116jae.125.1564689251354;
        Thu, 01 Aug 2019 12:54:11 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id x22sm51994857ioh.87.2019.08.01.12.54.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:54:10 -0700 (PDT)
Date:   Thu, 1 Aug 2019 21:54:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: Re: [PATCH 01/12] tools include UAPI: Sync x86's syscalls_64.tbl and
 generic unistd.h to pick up clone3 and pidfd_open
Message-ID: <20190801195407.hdek7qyrgjmaf4m5@brauner.io>
References: <20190729211456.6380-1-acme@kernel.org>
 <20190729211456.6380-2-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729211456.6380-2-acme@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:14:48PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>   05a70a8ec287 ("unistd: protect clone3 via __ARCH_WANT_SYS_CLONE3")
>   8f3220a80654 ("arch: wire-up clone3() syscall")
>   7615d9e1780e ("arch: wire-up pidfd_open()")
> 
> Silencing the following tools/perf build warnings
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
>   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
>   Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
> 
> Now 'perf trace -e pidfd*,clone*' will trace those syscalls as well as the
> others with those prefixes.
> 
>   $ diff -u /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
>   --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before	2019-07-26 12:24:55.020944201 -0300
>   +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2019-07-26 12:25:03.919047217 -0300
>   @@ -344,5 +344,7 @@
>         [431] = "fsconfig",
>         [432] = "fsmount",
>         [433] = "fspick",
>   +     [434] = "pidfd_open",
>   +     [435] = "clone3",
>    };
>   -#define SYSCALLTBL_x86_64_MAX_ID 433
>   +#define SYSCALLTBL_x86_64_MAX_ID 435
>   $
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-0isnnqxtr1ihz6p8wzjiy47d@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> ---
>  tools/include/uapi/asm-generic/unistd.h           | 8 +++++++-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> index a87904daf103..1be0e798e362 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -844,9 +844,15 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
>  __SYSCALL(__NR_fsmount, sys_fsmount)
>  #define __NR_fspick 433
>  __SYSCALL(__NR_fspick, sys_fspick)
> +#define __NR_pidfd_open 434
> +__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
> +#ifdef __ARCH_WANT_SYS_CLONE3
> +#define __NR_clone3 435
> +__SYSCALL(__NR_clone3, sys_clone3)
> +#endif
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 434
> +#define __NR_syscalls 436
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index b4e6f9e6204a..c29976eca4a8 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -355,6 +355,8 @@
>  431	common	fsconfig		__x64_sys_fsconfig
>  432	common	fsmount			__x64_sys_fsmount
>  433	common	fspick			__x64_sys_fspick
> +434	common	pidfd_open		__x64_sys_pidfd_open
> +435	common	clone3			__x64_sys_clone3/ptregs
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> -- 
> 2.21.0
> 
