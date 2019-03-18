Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7345EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JOuFAqfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfCRDDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:03:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37186 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRDDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:03:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so2602641wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 20:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TAiXdoCs8qghvuz4sYi+xTo3LDM0q7EKdHUQZzCQKD0=;
        b=JOuFAqfrtPgPb9upPW9fngQEknEHZVnQRB78OpDoL9QoiTCGal17v+iK/1dAaEgX64
         BPbwTlpCIf5p4xDcJVETM0kF0npq4Woo9ECsWvk1roeLsaom9g4mTbhTjducQ5gbGt5Z
         7ZOAaeKsPZLHPETkpZIX1OfCfGF0Vbrs3t1VkYNC/5i8Jx4XmcSyqttvIbWKTbYP9hlv
         VOtHIS17SxhEbA62J9aeE6N1pVMs5QxF1gY2VsYVy6yWEzirNQYiaTkE2GQLPKEsTun9
         EQopOrLO2/zRMYZf/G3VamyJBKvsGiJ+BAPQRlhRXHe5qfbeaM+9ebgK/3FRK4DSm1+D
         2XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TAiXdoCs8qghvuz4sYi+xTo3LDM0q7EKdHUQZzCQKD0=;
        b=WEgAjb7FCo95E8SfFGh7oVnHjvglQWfeAaUvPu6GAOSkL23YS8zs8Vq5uuDhnNOTl6
         y0KyE8XjfJCnrjSBiJmVhFCCrpwFVIQ6Jt00eXakR7zVm19IxMHJzFVMHjrXhTbzAC/D
         Ajw/xT0L9AyVCMvuyLTv7euqz95N7GycUHemOwcqGcEffvUDm6pNoZ8RYrVwyGNEJ+Rp
         KNQAtMSS0ltcKzJDtipschOo7WhfBU4vc95H3OP2jQ4Bl0QBcyOYRihKID6wrFkjxgpC
         anKlZQNylbVddlVxKz6HLc/eYxutp2GaV1t8bg9DNCiU7LgeGstjpWUmEMSjdpKnd+r5
         gt0w==
X-Gm-Message-State: APjAAAVCwC5miS5oxGs1L1b680yIyhpwVcZ4eGKkmp0Dbo/tFh2z6I3u
        BVwh2XS301ZfrkoYnjdj1/Tvtw==
X-Google-Smtp-Source: APXvYqx3F1Q9lg4kU1mer3Pnu+62sQa7Kn2wfqzhzU2T3nyxLPsSZOtdi7W94UErExtNU6UkNxK5vA==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr8989973wmb.48.1552878218630;
        Sun, 17 Mar 2019 20:03:38 -0700 (PDT)
Received: from oak.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 16sm32280508wrb.19.2019.03.17.20.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 20:03:37 -0700 (PDT)
Date:   Mon, 18 Mar 2019 03:03:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tracing: kdb: The skip_lines parameter should
 have been skip_entries
Message-ID: <20190318030336.GE27232@oak.lan>
References: <20190315230906.250598-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315230906.250598-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 04:09:04PM -0700, Douglas Anderson wrote:
> The things skipped by kdb's "ftdump" command when you pass it a
> parameter has always been entries, not lines.  The difference usually
> doesn't matter but when the trace buffer has multi-line entries (like
> a stack dump) it can matter.
> 
> Let's fix this both in the help text for ftdump and also in the local
> variable names.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> Changes in v4:
> - skip_lines => skip_entries new for v4.
> 
> Changes in v3: None
> 
>  kernel/trace/trace_kdb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 810d78a8d14c..4b666643d69f 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -17,7 +17,7 @@
>  #include "trace.h"
>  #include "trace_output.h"
>  
> -static void ftrace_dump_buf(int skip_lines, long cpu_file)
> +static void ftrace_dump_buf(int skip_entries, long cpu_file)
>  {
>  	/* use static because iter can be a bit big for the stack */
>  	static struct trace_iterator iter;
> @@ -70,11 +70,11 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>  			kdb_printf("---------------------------------\n");
>  		cnt++;
>  
> -		if (!skip_lines) {
> +		if (!skip_entries) {
>  			print_trace_line(&iter);
>  			trace_printk_seq(&iter.seq);
>  		} else {
> -			skip_lines--;
> +			skip_entries--;
>  		}
>  
>  		if (KDB_FLAG(CMD_INTERRUPT))
> @@ -106,7 +106,7 @@ static void ftrace_dump_buf(int skip_lines, long cpu_file)
>   */
>  static int kdb_ftdump(int argc, const char **argv)
>  {
> -	int skip_lines = 0;
> +	int skip_entries = 0;
>  	long cpu_file;
>  	char *cp;
>  
> @@ -114,9 +114,9 @@ static int kdb_ftdump(int argc, const char **argv)
>  		return KDB_ARGCOUNT;
>  
>  	if (argc) {
> -		skip_lines = simple_strtol(argv[1], &cp, 0);
> +		skip_entries = simple_strtol(argv[1], &cp, 0);
>  		if (*cp)
> -			skip_lines = 0;
> +			skip_entries = 0;
>  	}
>  
>  	if (argc == 2) {
> @@ -129,7 +129,7 @@ static int kdb_ftdump(int argc, const char **argv)
>  	}
>  
>  	kdb_trap_printk++;
> -	ftrace_dump_buf(skip_lines, cpu_file);
> +	ftrace_dump_buf(skip_entries, cpu_file);
>  	kdb_trap_printk--;
>  
>  	return 0;
> @@ -137,7 +137,7 @@ static int kdb_ftdump(int argc, const char **argv)
>  
>  static __init int kdb_ftrace_register(void)
>  {
> -	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#lines] [cpu]",
> +	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
>  			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
>  	return 0;
>  }
> -- 
> 2.21.0.360.g471c308f928-goog
> 
