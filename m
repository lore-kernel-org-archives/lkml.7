Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE71C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9584B21902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfDXPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:25:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38272 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfDXPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:25:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id v1so2553752lfg.5;
        Wed, 24 Apr 2019 08:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nKE/xyq4imc55KQfJ9wehrfi/E+X6DNeYp3aVRnme5Q=;
        b=FKk4zyLzQ7H6ikaMj8GxU8oy1OVIvRFV2oaVehYi0qhMWBRQZsLenj0CAGc5ymABGq
         LwcqFVJ/1PBI64atxM2rkLdGKfDcU7CXiIHP47iAOKEAWdTGCJT+WbKr58Jjg8QBydrX
         SFLd02A6ULeM2iLASEPUWJc9d9kkfPFQB12l5QNVnANGe1TDOEiK0LbnCetIZ7njNvn0
         CQ+kOldUfM6PM157eW66zKnwHf7EoF/g7IwBuLIxIGJSJPOdlmH8u4VpYU04q4+qpF1Y
         uc4Wz5XpGJq46F7MEeqjy0zChxs3D9S8XEnnjrDPcajp59wU+juEI8IGpACFPhEnU5Q+
         BXsw==
X-Gm-Message-State: APjAAAU3/KemJCJAgpR0icArQEw4LkD+7kpBvXnxyBVXtJgXihEKgRWa
        9edKyIzDrr41OX/6LVb7MbyQik9j
X-Google-Smtp-Source: APXvYqycMvsfU0Yy0POsr+lKHb0Fg84V3epzIvyE4SNRIp0Ee9Wq4yxNkk8EtJV2i5FeCIUACl/4zg==
X-Received: by 2002:a19:6619:: with SMTP id a25mr17514901lfc.21.1556119550508;
        Wed, 24 Apr 2019 08:25:50 -0700 (PDT)
Received: from [192.168.42.211] ([213.87.153.202])
        by smtp.gmail.com with ESMTPSA id s16sm3911082lji.61.2019.04.24.08.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:25:48 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v3 2/3] security: Move stackleak config to
 Kconfig.hardening
To:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190423194925.32151-1-keescook@chromium.org>
 <20190423194925.32151-3-keescook@chromium.org>
From:   Alexander Popov <alex.popov@linux.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 jXz/74kjFsyRgZA+d6a1pGtOwITEBxtxxg==
Message-ID: <84ed0a4b-b1e5-ae86-56c1-40a212734667@linux.com>
Date:   Wed, 24 Apr 2019 18:25:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423194925.32151-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.04.2019 22:49, Kees Cook wrote:
> This moves the stackleak plugin options to Kconfig.hardening's memory
> initialization menu.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hello Kees,

I see the changes in STACKLEAK help, looks good to me.
For this patch -
  Reviewed-by: Alexander Popov <alex.popov@linux.com>


By the way, for your information, GCC_PLUGIN_STRUCTLEAK help is now unreachable
from 'make menuconfig'.

Best regards,
Alexander


> ---
>  scripts/gcc-plugins/Kconfig | 51 ---------------------------------
>  security/Kconfig.hardening  | 57 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 51 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index 352f03878a1e..80220ed26a35 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -108,57 +108,6 @@ config GCC_PLUGIN_RANDSTRUCT_PERFORMANCE
>  	  in structures.  This reduces the performance hit of RANDSTRUCT
>  	  at the cost of weakened randomization.
>  
> -config GCC_PLUGIN_STACKLEAK
> -	bool "Erase the kernel stack before returning from syscalls"
> -	depends on GCC_PLUGINS
> -	depends on HAVE_ARCH_STACKLEAK
> -	help
> -	  This option makes the kernel erase the kernel stack before
> -	  returning from system calls. That reduces the information which
> -	  kernel stack leak bugs can reveal and blocks some uninitialized
> -	  stack variable attacks.
> -
> -	  The tradeoff is the performance impact: on a single CPU system kernel
> -	  compilation sees a 1% slowdown, other systems and workloads may vary
> -	  and you are advised to test this feature on your expected workload
> -	  before deploying it.
> -
> -	  This plugin was ported from grsecurity/PaX. More information at:
> -	   * https://grsecurity.net/
> -	   * https://pax.grsecurity.net/
> -
> -config STACKLEAK_TRACK_MIN_SIZE
> -	int "Minimum stack frame size of functions tracked by STACKLEAK"
> -	default 100
> -	range 0 4096
> -	depends on GCC_PLUGIN_STACKLEAK
> -	help
> -	  The STACKLEAK gcc plugin instruments the kernel code for tracking
> -	  the lowest border of the kernel stack (and for some other purposes).
> -	  It inserts the stackleak_track_stack() call for the functions with
> -	  a stack frame size greater than or equal to this parameter.
> -	  If unsure, leave the default value 100.
> -
> -config STACKLEAK_METRICS
> -	bool "Show STACKLEAK metrics in the /proc file system"
> -	depends on GCC_PLUGIN_STACKLEAK
> -	depends on PROC_FS
> -	help
> -	  If this is set, STACKLEAK metrics for every task are available in
> -	  the /proc file system. In particular, /proc/<pid>/stack_depth
> -	  shows the maximum kernel stack consumption for the current and
> -	  previous syscalls. Although this information is not precise, it
> -	  can be useful for estimating the STACKLEAK performance impact for
> -	  your workloads.
> -
> -config STACKLEAK_RUNTIME_DISABLE
> -	bool "Allow runtime disabling of kernel stack erasing"
> -	depends on GCC_PLUGIN_STACKLEAK
> -	help
> -	  This option provides 'stack_erasing' sysctl, which can be used in
> -	  runtime to control kernel stack erasing for kernels built with
> -	  CONFIG_GCC_PLUGIN_STACKLEAK.
> -
>  config GCC_PLUGIN_ARM_SSP_PER_TASK
>  	bool
>  	depends on GCC_PLUGINS && ARM
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 19881341f1c2..a96d4a43ca65 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -88,6 +88,63 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>  	  initialized. Since not all existing initializers are detected
>  	  by the plugin, this can produce false positive warnings.
>  
> +config GCC_PLUGIN_STACKLEAK
> +	bool "Poison kernel stack before returning from syscalls"
> +	depends on GCC_PLUGINS
> +	depends on HAVE_ARCH_STACKLEAK
> +	help
> +	  This option makes the kernel erase the kernel stack before
> +	  returning from system calls. This has the effect of leaving
> +	  the stack initialized to the poison value, which both reduces
> +	  the lifetime of any sensitive stack contents and reduces
> +	  potential for uninitialized stack variable exploits or information
> +	  exposures (it does not cover functions reaching the same stack
> +	  depth as prior functions during the same syscall). This blocks
> +	  most uninitialized stack variable attacks, with the performance
> +	  impact being driven by the depth of the stack usage, rather than
> +	  the function calling complexity.
> +
> +	  The performance impact on a single CPU system kernel compilation
> +	  sees a 1% slowdown, other systems and workloads may vary and you
> +	  are advised to test this feature on your expected workload before
> +	  deploying it.
> +
> +	  This plugin was ported from grsecurity/PaX. More information at:
> +	   * https://grsecurity.net/
> +	   * https://pax.grsecurity.net/
> +
> +config STACKLEAK_TRACK_MIN_SIZE
> +	int "Minimum stack frame size of functions tracked by STACKLEAK"
> +	default 100
> +	range 0 4096
> +	depends on GCC_PLUGIN_STACKLEAK
> +	help
> +	  The STACKLEAK gcc plugin instruments the kernel code for tracking
> +	  the lowest border of the kernel stack (and for some other purposes).
> +	  It inserts the stackleak_track_stack() call for the functions with
> +	  a stack frame size greater than or equal to this parameter.
> +	  If unsure, leave the default value 100.
> +
> +config STACKLEAK_METRICS
> +	bool "Show STACKLEAK metrics in the /proc file system"
> +	depends on GCC_PLUGIN_STACKLEAK
> +	depends on PROC_FS
> +	help
> +	  If this is set, STACKLEAK metrics for every task are available in
> +	  the /proc file system. In particular, /proc/<pid>/stack_depth
> +	  shows the maximum kernel stack consumption for the current and
> +	  previous syscalls. Although this information is not precise, it
> +	  can be useful for estimating the STACKLEAK performance impact for
> +	  your workloads.
> +
> +config STACKLEAK_RUNTIME_DISABLE
> +	bool "Allow runtime disabling of kernel stack erasing"
> +	depends on GCC_PLUGIN_STACKLEAK
> +	help
> +	  This option provides 'stack_erasing' sysctl, which can be used in
> +	  runtime to control kernel stack erasing for kernels built with
> +	  CONFIG_GCC_PLUGIN_STACKLEAK.
> +
>  endmenu
>  
>  endmenu
> 

