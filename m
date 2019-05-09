Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE72173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557393462;
	bh=QmrOw/+9fYVhsuhdU01m+VCaK4njighxHAAyVj1/RD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufLRlDQ64Jl15R/zJnI2m+y4TvTtGWkQjX/y2XR2Vo+KxjGoeQH4M3NHc94+tfDlS
	 mV1s+Qa4G/k/1VirRXqmrG28DYeYKdu9LVIHrLkesbS3b/5rqS1/B6U9sSWqTXUKxo
	 sNQI5tU55TFL/GsdULFJF1FZnlhTipvTfAnl4pcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEIJRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:17:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37185 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfEIJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:17:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id a12so1968757wrn.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a8yCx23bC4qR+YYAySNjCSKEzt5DfYtT59DtoTr9Wiw=;
        b=mbMASDFpiMy6gJoqlE2guVeoMnjsDo+wI5wsC1k1xOqM/ofhOgBZj80er0rASdo5Ao
         X8eu+oIFhk2AXfaIWp7MAfPDD1/ZlvXhopwBfgzumx5vmtWGwhT3CpreF+rBwKJJLSxv
         sE4qY6+dBeKzNByMp9wbSQ5vu+udWNFVmCPpwzxCnW2RfzFgFRwfziPUkGvijQNTaDpR
         Kz9dtXFOgBpLhNDICsDQ1AoN0QHgAnYxgqWmC+uRvPt2ij82SOmlyFoILDg6+U7ymiSs
         IyydEOqi4NHUzOfN2RpKEMKQU4QvuYPkARa/zVv1clrR919h7w0KfXS9Ge/d4zqbWIot
         odog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8yCx23bC4qR+YYAySNjCSKEzt5DfYtT59DtoTr9Wiw=;
        b=te9RwbI3oIUxo0eTfk1iGPXPnUMxeBY69wd2FgCBvV1jc+hDDmCoGEbHAXAaLNXfo7
         i95ioy7+O64KPjZOW92me3BywgnEm63uoOH5vHR6JuqdyJZ5X3hROKB6jrJvgcikcLSI
         it39kD+o4iCo6Xg3Vu6Jnm1007MQFh7QR3lcZYAwMxhHULTLrY+Dy9ZB8GCEMXEv7G2e
         SIfZg2oVgr0oF2K+bRCCk3dVikpflHkxpECabXQS3VzG25BONOuew1xeG/odpD7R8XgC
         MDZ2Lq/SmBhNI9lX9uAY0M2W9SNeqvXyZd77oSRENLT28vXfHmqDmrFztniw/d/mYKuL
         82mQ==
X-Gm-Message-State: APjAAAV9A/9km7XG0NHRYcmDJbFO2conpA/YGbNO+zjyRWPE63x3AMzJ
        qdlmKPfNcy/U1W6Sj4o50XA=
X-Google-Smtp-Source: APXvYqweRQrplvnXBE+GMnZQ/r7kG8NbCpD7vmS2mSwptLgDf4MJ4sSGtBEA+YIANFAk5vzrj9Kiiw==
X-Received: by 2002:a5d:448e:: with SMTP id j14mr2254307wrq.158.1557393459062;
        Thu, 09 May 2019 02:17:39 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v189sm2814646wma.3.2019.05.09.02.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:17:38 -0700 (PDT)
Date:   Thu, 9 May 2019 11:17:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH v7 6/6] perf-probe: Add user memory access attribute
 support
Message-ID: <20190509091735.GC90202@gmail.com>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
 <155732238071.12756.3969249515654160948.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155732238071.12756.3969249515654160948.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -37,6 +37,7 @@ struct probe_trace_point {
>  struct probe_trace_arg_ref {
>  	struct probe_trace_arg_ref	*next;	/* Next reference */
>  	long				offset;	/* Offset value */
> +	bool				user;	/* User-memory access */
>  };
>  
>  /* kprobe-tracer and uprobe-tracer tracing argument */
> @@ -82,6 +83,7 @@ struct perf_probe_arg {
>  	char				*var;	/* Variable name */
>  	char				*type;	/* Type name */
>  	struct perf_probe_arg_field	*field;	/* Structure fields */
> +	bool				user;	/* User-memory */

Why did the 'access' qualifier get dropped from the second comment?

Also, please name it and related parameters and local variables 
'user_access' - in that case no comments are needed and it's all super 
clear. Only 'user' is ambiguous really.

Thanks,

	ngo
