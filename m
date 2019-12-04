Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E3C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99FA20803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5Y4qMl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfLDT2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:28:50 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44183 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbfLDT2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:28:50 -0500
Received: by mail-vk1-f196.google.com with SMTP id u189so311556vkf.11;
        Wed, 04 Dec 2019 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U48Nsp+iuLn/a6IVMZqwHN50uHWNqwUuuVCArBdZ0cI=;
        b=r5Y4qMl19yS/UMe3oUk9+919vbZH+VLUeaPtfi+M/iI8V39a4AaUWiPLzmgP0TaJ3S
         gidLJMOjtjtSxUqwg+Typnq4ZNlAskBeNYdkp3KCt/AAz5YLJ1QaKFeZIumn0g8l1ftc
         9SVcaf61ND7oghu+m8G0BD0kwM3T0LxALDcH8I68OOLNYzD+pnpOUCWE1NfjSbsZMPlR
         LQf5SkJZhpR16oSDCsqlxXyZkv9LiMVS/6/d5C0A4b2xBrJ7acXA4qrEWDbkBw4+4Iiq
         Aq6Okgg8g5zjoreXo+VK7pJsr2NS2YsIly1T1HXFCQzoNT+8s0DismK11G6AZZ1iE+pw
         kQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U48Nsp+iuLn/a6IVMZqwHN50uHWNqwUuuVCArBdZ0cI=;
        b=H86cYzw5J3iKHFAL4nCMcT6z+wdT8+rmXgbA9gKtWwFX6ehTEowQGmTYYMnCpPkAdN
         a0Kd1nYWVb83wQR0u3mObvDvxzyms6nsYOpKOrYm5Nj69CJjr5vF8vsvMO4nLoc5Joc6
         PhFcJP9YtayfFEY//j8MJ0016uRcz49UDtXhvss5/iRAoYu43/etUuohsd4XetnnrJuj
         W42HT+AWMpk5FkB3MOXzc7lscHoOu3ZDIp509vztoyba8wa9Ld/MWSWnR9r9chkPM7oJ
         iZ+JtYU3q+/kRCNXdxQoRVE3kv0+cGr9fS/FTM+EpAY8d8oT1xN4/lgBxp/5ulAQtt/S
         qy9Q==
X-Gm-Message-State: APjAAAWuzfR+aoeHxcV9tj8TaVGh8mKVo4c1foQuDX75R1b+1VcbzzKd
        x8JFptkG1XX1ErMUJUY1XrA=
X-Google-Smtp-Source: APXvYqz1rYriR9n/y/r9Ws786faGQYqDA2rlVeNDvdbHTvsGTPatNI4kXnLbBhUOpzawnGtBx73Dwg==
X-Received: by 2002:a1f:a752:: with SMTP id q79mr3329251vke.67.1575487729110;
        Wed, 04 Dec 2019 11:28:49 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.214.134])
        by smtp.gmail.com with ESMTPSA id h4sm2311054vkg.23.2019.12.04.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:28:48 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12D1D405E2; Wed,  4 Dec 2019 16:28:45 -0300 (-03)
Date:   Wed, 4 Dec 2019 16:28:44 -0300
To:     David Ahern <dsahern@kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH] perf sched timehist: Add support for filtering on CPU
Message-ID: <20191204192844.GA8535@kernel.org>
References: <20191204173925.66976-1-dsahern@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204173925.66976-1-dsahern@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 04, 2019 at 10:39:25AM -0700, David Ahern escreveu:
> From: David Ahern <dsahern@gmail.com>
> 
> Allow user to limit output to one or more CPUs. Really helpful on systems
> with a large number of cpus.

Thanks, tested and applied to perf/core, for 5.6.

- Arnaldo

> Signed-off-by: David Ahern <dsahern@gmail.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  4 ++++
>  tools/perf/builtin-sched.c              | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 63f938b887dd..5fbe42bd599b 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -110,6 +110,10 @@ OPTIONS for 'perf sched timehist'
>  --max-stack::
>  	Maximum number of functions to display in backtrace, default 5.
>  
> +-C=::
> +--cpu=::
> +	Only show events for the given CPU(s) (comma separated list).
> +
>  -p=::
>  --pid=::
>  	Only show events for given process ID (comma separated list).
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8a12d71364c3..82fcc2c15fe4 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -51,6 +51,9 @@
>  #define SYM_LEN			129
>  #define MAX_PID			1024000
>  
> +static const char *cpu_list;
> +static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> +
>  struct sched_atom;
>  
>  struct task_desc {
> @@ -2008,6 +2011,9 @@ static void timehist_print_sample(struct perf_sched *sched,
>  	char nstr[30];
>  	u64 wait_time;
>  
> +	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +		return;
> +
>  	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
>  	printf("%15s [%04d] ", tstr, sample->cpu);
>  
> @@ -2994,6 +3000,12 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
>  
> +	if (cpu_list) {
> +		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
> +		if (err < 0)
> +			goto out;
> +	}
> +
>  	evlist = session->evlist;
>  
>  	symbol__init(&session->header.env);
> @@ -3429,6 +3441,7 @@ int cmd_sched(int argc, const char **argv)
>  		   "analyze events only for given process id(s)"),
>  	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
>  		   "analyze events only for given thread id(s)"),
> +	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
>  	OPT_PARENT(sched_options)
>  	};
>  
> -- 
> 2.20.1

-- 

- Arnaldo
