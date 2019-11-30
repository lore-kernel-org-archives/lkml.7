Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEF2C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 16:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCE620725
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 16:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a21HWsp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfK3Qds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 11:33:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41961 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfK3Qds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 11:33:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so2226089pgk.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sDX92yzic9awsGOt0Arz5PBB4ji0tHlZ6E3jmcXbk2o=;
        b=a21HWsp6J3y1SshPW4FZ8PHxDR2Pyb8FxKqGQ70iODLH8ogAf7us9Qf5Cc39ADneYg
         3LM8CxBarwiLUMrVp8/5zn6GYhKUKoplMx3XAwtpDgUPRhmMDwTJgWx5DaDMs5ZODCkF
         0Koqg9Z0F5fN37eiVwx6J/LVKI1L2ybp/VE3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDX92yzic9awsGOt0Arz5PBB4ji0tHlZ6E3jmcXbk2o=;
        b=pF2+FVmYlmObkOrB0wrFwMp0gpG/zOO1c+k5vk0ASJTESY2aF2uf7po01cda3iJIjJ
         YYM4/d93UBBro52OLGECf8SDCCZGNPIsSk+xTfxwA75dOq+dDXY5BfPH3trFnPqjOto/
         VVITtSDy/lGr18sP70KWesRLr52cIW7GdJkSP7j7yevYWHzvAL+RlWS/EvZRnOAffweE
         rblv99onL972CqAUPLBxDI8mNAueCf0L+1MiPd+7vtewEC4uEJoL2GBlAY10TajZVuOA
         HE8NOsSl1gfDFHZqha+2lXrTCXOKtLSSic/fvwhtc++fOZnLaKVc8en0Gl2Iti5bDkQ9
         TrXg==
X-Gm-Message-State: APjAAAWCQif3ocStwTcvmIr1VNNyxKNUwAj6BTY+B8iO4b4lZxPqugla
        dFx6XzRNGOFZRHasAeHPaAX1SQ==
X-Google-Smtp-Source: APXvYqwqTt8yof5Rq7oEfe7DA4m6uotUBzmpWAjK6VsCDn7Hg55vxGMffuwaoOmN/9h8gfJGaL3TsA==
X-Received: by 2002:a63:fa04:: with SMTP id y4mr22868658pgh.413.1575131627469;
        Sat, 30 Nov 2019 08:33:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm17769121pjc.4.2019.11.30.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 08:33:46 -0800 (PST)
Date:   Sat, 30 Nov 2019 08:33:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] kernel: add sysctl kernel.nr_taints
Message-ID: <201911300823.69EAF975E9@keescook>
References: <157503370645.8187.6335564487789994134.stgit@buzz>
 <157503370887.8187.1663761929323284758.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157503370887.8187.1663761929323284758.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 04:21:48PM +0300, Konstantin Khlebnikov wrote:
> Once taint flag is set it's never cleared. Following taint could be detected
> only via parsing kernel log messages which are different for each occasion.
> For repeatable taints like TAINT_MACHINE_CHECK, TAINT_BAD_PAGE, TAINT_DIE,
> TAINT_WARN, TAINT_LOCKUP it would be good to know count to see their rate.
> 
> This patch adds sysctl with vector of counters. One for each taint flag.
> Counters are non-atomic in favor of simplicity. Exact count doesn't matter.
> Writing vector of zeroes resets counters.
> 
> This is useful for detecting frequent problems with automatic monitoring.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

I like this, yeah. This would let LKDTM users reset taint counts to
re-check the same kernel, etc, without explicitly clearing the taint
flags which always seemed like a bad idea. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

One nit below...

> ---
>  include/linux/kernel.h |    1 +
>  kernel/panic.c         |    2 ++
>  kernel/sysctl.c        |    9 +++++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e8a6808e4f2f..900d02167bbd 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -604,6 +604,7 @@ struct taint_flag {
>  };
>  
>  extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
> +extern int sysctl_nr_taints[TAINT_FLAGS_COUNT];
>  
>  extern const char hex_asc[];
>  #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d7750a45ca8d..a3df00ebcba2 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -39,6 +39,7 @@
>  int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
>  static unsigned long tainted_mask =
>  	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
> +int sysctl_nr_taints[TAINT_FLAGS_COUNT];
>  static int pause_on_oops;
>  static int pause_on_oops_flag;
>  static DEFINE_SPINLOCK(pause_on_oops_lock);
> @@ -434,6 +435,7 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
>  		pr_warn("Disabling lock debugging due to kernel taint\n");
>  
>  	set_bit(flag, &tainted_mask);
> +	sysctl_nr_taints[flag]++;

As long as we're changing this code, how about adding an explicit check
of "flag" against either ARRAY_SIZE(sysctl_nr_tains) or TAINT_FLAGS_COUNT?

It looks like only 1 caller isn't using a static value, though:
proc_taint(), so it would catch "overflows" there (it's already bounded
to the size of tainted_mask, but proc could set "unknown" taint flags).

-Kees

>  }
>  EXPORT_SYMBOL(add_taint);
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index b6f2f35d0bcf..5d9727556cef 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -553,6 +553,15 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_taint,
>  	},
> +	{
> +		.procname	= "nr_taints",
> +		.data		= &sysctl_nr_taints,
> +		.maxlen		= sizeof(sysctl_nr_taints),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ZERO,
> +	},
>  	{
>  		.procname	= "sysctl_writes_strict",
>  		.data		= &sysctl_writes_strict,
> 

-- 
Kees Cook
