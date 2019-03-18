Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA682086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUl8BYH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfCRDCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:02:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39249 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRDCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:02:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id t124so11098550wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 20:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fZnDLc28KwM4M8LbQEF8uqIX16CVSEwDbjI+S4Ud2PA=;
        b=UUl8BYH4blelcEBifxiXclFdhpoM8CBjGOsgR2N75p2EVcoU+0mJ0zG3wjLW2ydjVi
         nWwspEUJcqK18egd0+KsEdcIERt1tWk2VshIlxwuMq/pgYKtg5+oKCMEE3ZTNLhvDzxz
         m8XtBaZb/B8SnJ3Cwq+t/+X7CxbRMqxcS1xqRU71xnOeDaJ/LP9KDwRYLTkPPTJt4tk5
         fL0KVw3cPibAybm8Va77pH3NPZGCm1wJNDqCR7/kCnB2WouzXK2+FtRlTPOO+OEMb531
         kdAj+EL9ufY47G3lZ63W1Yf369OqqTwN6Hv2EmPnM4lBBKPgCjvdwA0d6k5RchhYUqKy
         yu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fZnDLc28KwM4M8LbQEF8uqIX16CVSEwDbjI+S4Ud2PA=;
        b=bb8uI5/881dlxCQKvV1Yge/MipnI73SzlcQxmpvWdZ4go7FIw1dP7BkYluhcesXINN
         uDHaZYFAgzgIsJUTfwEhHK6WVnNZDQTHpICgjxnlPi4I9CBCLX0rv0cPMiBk2uKw2/n9
         l2UP5X3r5o/scD5T++Qt4iOKqXCziv7O0UKpHDo2l7Jp+XRE1uawgekMsgzMla3dSqYw
         4imZLqlI8Q5hBPk+hfPcCpg0ab+Cee+OV7E1JokpYfzCn6S+PkZGwOF57c3/QX3B3FKA
         7Hj9ljxhScuoaluyfm+OZYNmTfAqlQ7liLMPgYKEt+ncWpVgJY5iRUwEj5ZVsjZWzq/9
         VyVw==
X-Gm-Message-State: APjAAAW1g97cpaoM5ukWiyX9qGNcFQ8xuIOQUyn0euDHZK4Pnz2nii+Z
        TeXkdAy57mCojUCx39HqwFHvAQ==
X-Google-Smtp-Source: APXvYqz30bwTOSk5dsEdGMHkMfB2EweGTVyjQLxxYvqMwwUp8qfKxNurGzwSTRwrPLfeegSsj0Bbbw==
X-Received: by 2002:a7b:c34d:: with SMTP id l13mr9131538wmj.37.1552878161077;
        Sun, 17 Mar 2019 20:02:41 -0700 (PDT)
Received: from oak.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c10sm1380953wrt.65.2019.03.17.20.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 20:02:40 -0700 (PDT)
Date:   Mon, 18 Mar 2019 03:02:38 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] tracing: kdb: Allow ftdump to skip all but the
 last few entries
Message-ID: <20190318030238.GD27232@oak.lan>
References: <20190315230906.250598-1-dianders@chromium.org>
 <20190315230906.250598-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315230906.250598-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 04:09:06PM -0700, Douglas Anderson wrote:
> The 'ftdump' command in kdb is currently a bit of a last resort, at
> least if you have lots of traces turned on.  It's going to print a
> whole boatload of data out your serial port which is probably running
> at 115200.  This could easily take many, many minutes.
> 
> Usually you're most interested in what's at the _end_ of the ftrace
> buffer, AKA what happened most recently.  That means you've got to
> wait the full time for the dump.  The 'ftdump' command does attempt to
> help you a little bit by allowing you to skip a fixed number of
> entries.  Unfortunately it provides no way for you to know how many
> entries you should skip.
> 
> Let's do similar to python and allow you to use a negative number to
> indicate that you want to skip all entries except the last few.  This
> allows you to quickly see what you want.
> 
> Note that we also change the printout in ftdump to print the
> (positive) number of entries actually skipped since that could be
> helpful to know when you've specified a negative skip count.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

There's a small nitpick below but otherwise:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> 
> Changes in v4:
> - Now uses trace_total_entries() / trace_total_entries_cpu().
> - Based upon new patch that renames "lines" to "entries".
> 
> Changes in v3:
> - Optimize counting as per Steven Rostedt.
> - Down to 1 patch since patch #1 from v2 landed.
> 
>  kernel/trace/trace_kdb.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 4b666643d69f..996e1e9cd9a6 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -39,7 +39,8 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
>  	/* don't look at user memory in panic mode */
>  	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
>  
> -	kdb_printf("Dumping ftrace buffer:\n");
> +	kdb_printf("Dumping ftrace buffer (skipping %d entries):\n",
> +		   skip_entries);

If someone *doesn't* need to skip any entries I'm not a fan of telling
them we are "skipping 0 entries"; it is more unnerving than helpful
("huh? what does it need to tell me that no entried were skipped?
what makes the tracer skip entries?... Doh... I get it").


Daniel.


>  
>  	/* reset all but tr, trace, and overruns */
>  	memset(&iter.seq, 0,
> @@ -109,6 +110,7 @@ static int kdb_ftdump(int argc, const char **argv)
>  	int skip_entries = 0;
>  	long cpu_file;
>  	char *cp;
> +	int cnt;
>  
>  	if (argc > 2)
>  		return KDB_ARGCOUNT;
> @@ -129,6 +131,16 @@ static int kdb_ftdump(int argc, const char **argv)
>  	}
>  
>  	kdb_trap_printk++;
> +
> +	/* A negative skip_entries means skip all but the last entries */
> +	if (skip_entries < 0) {
> +		if (cpu_file == RING_BUFFER_ALL_CPUS)
> +			cnt = trace_total_entries(NULL);
> +		else
> +			cnt = trace_total_entries_cpu(NULL, cpu_file);
> +		skip_entries = max(cnt + skip_entries, 0);
> +	}
> +
>  	ftrace_dump_buf(skip_entries, cpu_file);
>  	kdb_trap_printk--;
>  
> @@ -138,7 +150,8 @@ static int kdb_ftdump(int argc, const char **argv)
>  static __init int kdb_ftrace_register(void)
>  {
>  	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
> -			    "Dump ftrace log", 0, KDB_ENABLE_ALWAYS_SAFE);
> +			    "Dump ftrace log; -skip dumps last #entries", 0,
> +			    KDB_ENABLE_ALWAYS_SAFE);
>  	return 0;
>  }
>  
> -- 
> 2.21.0.360.g471c308f928-goog
> 
