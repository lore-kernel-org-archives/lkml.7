Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A1C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD452075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th3sImOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfKFT4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:56:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41227 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFT4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:56:40 -0500
Received: by mail-qk1-f195.google.com with SMTP id m125so25747628qkd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSI+knl1WngmugFoon7ucX6pKtsOrycaNoy3g/S6pq0=;
        b=Th3sImOHk3spOId8E6NibX3D2HGyzJpUt+kq88e6tcUV3CcSC9/D9gyHfDmJCtQJD6
         SrEhJO6+fNqmPSlPaxxVD4EfAUIVgQqWa6lTehY1vnrAQz0jwQiKx/3FIQa/HwsqAj3V
         shiePPVzQxarGPeRcfTofXD927J8GDjL8i1ypbb2ZoMS1gSrCnTddHHnY+2dwfEkiye+
         EeHpDXJzDHGIilgE7lI2wB5zMDe3Hwb4bk828DGtQ0kNzcIifVyWD2k5xJ3lQLAbDJ/K
         gb7CNt/2wiDdWEa1ktZfTr2xxhWFdAIImsshIiXYr0A77XHYHSoFAFo+0JRlkTCpPoHl
         JUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSI+knl1WngmugFoon7ucX6pKtsOrycaNoy3g/S6pq0=;
        b=lRliwxdBb+jBks/cOdja1QczL9QZwjH3OZN1iBA/PzCkKOgjf3dpLzBgoljnz/X04c
         jJySL6kRx2WwWg9PJpubx6t+II4f4PKivOsKFcq8VKEeR0kOiyNyC6r7YyhXN8Dp97Yc
         LCuGwr/NU5oR3zco7fpw8g6EhiDwHbnDqgb4BlptdyVPYSeHKo/FK9VaU3AubhJrRg2x
         lWwprmz2RP3Kbr6dnpPmd/E1z3XdwTBEfbyhlmPwDlYOTQV4CfLh9bnDyyZcHkzpUbZ2
         /6L1EZ4WymfbdcL3mg9k9wxX0QUJxtClKvmighv9WEyRSIKbG9kx7zqQ18B094CMkBic
         VO/Q==
X-Gm-Message-State: APjAAAXUyGtJPisS+4EPaIF4q/6ZvafhQyndggpeDwjDdNue/tGrLepW
        jLt85rUd0PLRxKrTPMckoAk=
X-Google-Smtp-Source: APXvYqyOga5xl8ODma1VC/pxTZqQyjD2uTA0C6z+rM39/cfzKsqiw2zkaUMMIdJEk3BMBWyxxM6YcQ==
X-Received: by 2002:a37:7c42:: with SMTP id x63mr3749198qkc.134.1573070198747;
        Wed, 06 Nov 2019 11:56:38 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id e17sm14320542qtk.65.2019.11.06.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:56:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E066F40B1D; Wed,  6 Nov 2019 16:56:30 -0300 (-03)
Date:   Wed, 6 Nov 2019 16:56:30 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/5] perf probe: Support multiprobe event
Message-ID: <20191106195630.GC11935@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
 <157291302895.19771.12251353345858434064.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157291302895.19771.12251353345858434064.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 09:17:09AM +0900, Masami Hiramatsu escreveu:
> Support multiprobe event if the event is based on function
> and lines and kernel supports it. In this case, perf probe
> creates the first probe with an event, and tries to append
> following probes on that event, since those probes must be
> on the same source code line.
> 
> Before this patch;
>   # perf probe -a vfs_read:18
>   Added new events:
>     probe:vfs_read_L18   (on vfs_read:18)
>     probe:vfs_read_L18_1 (on vfs_read:18)

So this seems to depend on the previous one, I'll leave it for later,
till we figure that one out,

- Arnaldo
 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:vfs_read_L18_1 -aR sleep 1
> 
>   #
> 
> After this patch (on multiprobe supported kernel)
>   # perf probe -a vfs_read:18
>   Added new events:
>     probe:vfs_read_L18   (on vfs_read:18)
>     probe:vfs_read_L18   (on vfs_read:18)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:vfs_read_L18 -aR sleep 1
> 
>   #
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |    9 +++++++--
>  tools/perf/util/probe-file.c  |    7 +++++++
>  tools/perf/util/probe-file.h  |    1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index d14b970a6461..23db6786c3ea 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2738,8 +2738,13 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
>  	if (tev->event == NULL || tev->group == NULL)
>  		return -ENOMEM;
>  
> -	/* Add added event name to namelist */
> -	strlist__add(namelist, event);
> +	/*
> +	 * Add new event name to namelist if multiprobe event is NOT
> +	 * supported, since we have to use new event name for following
> +	 * probes in that case.
> +	 */
> +	if (!multiprobe_event_is_supported())
> +		strlist__add(namelist, event);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index b659466ea498..a63f1a19b0e8 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -1007,6 +1007,7 @@ enum ftrace_readme {
>  	FTRACE_README_KRETPROBE_OFFSET,
>  	FTRACE_README_UPROBE_REF_CTR,
>  	FTRACE_README_USER_ACCESS,
> +	FTRACE_README_MULTIPROBE_EVENT,
>  	FTRACE_README_END,
>  };
>  
> @@ -1020,6 +1021,7 @@ static struct {
>  	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
>  	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
>  	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
> +	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
>  };
>  
>  static bool scan_ftrace_readme(enum ftrace_readme type)
> @@ -1085,3 +1087,8 @@ bool user_access_is_supported(void)
>  {
>  	return scan_ftrace_readme(FTRACE_README_USER_ACCESS);
>  }
> +
> +bool multiprobe_event_is_supported(void)
> +{
> +	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
> +}
> diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
> index 986c1c94f64f..850d1b52d60a 100644
> --- a/tools/perf/util/probe-file.h
> +++ b/tools/perf/util/probe-file.h
> @@ -71,6 +71,7 @@ bool probe_type_is_available(enum probe_type type);
>  bool kretprobe_offset_is_supported(void);
>  bool uprobe_ref_ctr_is_supported(void);
>  bool user_access_is_supported(void);
> +bool multiprobe_event_is_supported(void);
>  #else	/* ! HAVE_LIBELF_SUPPORT */
>  static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
>  {

-- 

- Arnaldo
