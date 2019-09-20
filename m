Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252F1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CD2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJQ6pdk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436496AbfITSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:31:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33048 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406515AbfITSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:31:22 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so8320127qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lNQY02XZiW/7zD9ydR22Y5cya+wo/HYqbRdJENNudM=;
        b=gJQ6pdk6pcIK4nCkT47MTAb09/eCw09Bp1OhrPNM6/ftlDmZ2qGPjsvuQydmTYBfaJ
         s+eOHbu3mDTyC4LNoSCa9Kl/hPoA1/FoCY6uOosKKCbrOCcTPfOcz/pe0P/T4TD9EqHW
         K0hFWM23r7R4+91Jme2Tenrt7/AsjOZIrgjxfD4MMDD1xlc+jzBPPzg8+W8BfrCJLloZ
         dX2sAlWMb4pEs9fHr0GcMDCvS+Aarlioeh/1E2NggQO4BVeghiPsqo3Wlc3NC7/TiG/p
         +krLd3llJa2M63pVp+EylZpSZWLdSAyPXKeWrnO+0cw+XMSU3fzqO2jidzpcUTbn0NAC
         7p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lNQY02XZiW/7zD9ydR22Y5cya+wo/HYqbRdJENNudM=;
        b=HwbgkZnK4aBhystG2SqI2KZAhCOAzImuGZskbK1yVwbEt1VIi76p3nzHRI3TOrbPHP
         QxOKm9rz+ssHOcpv/fkbItU4V+LnwNLVJu3jiKo6zSlRYu3VEHDB27NAZtbQXqNL95Xl
         ZX6Q9Yop9N/JBb0DQjFOrPXrZI73H0WV7U6vHS7+AW+kmDNq47PT/NNoHteK86XW+RoZ
         +CQnyDvwYSCIUZEFF2QQAbcgawtS+6Z42DWtxUXj/BIDGdqPrhXIC0xhFrfTGp0jkCBx
         9yqyQedZVq5+hU6wAzcsOpUMgzWHd0WbttREWOSq+qbHv5sB6XKnvdG+exgPA6tLOydn
         PNqg==
X-Gm-Message-State: APjAAAX1/AEkk+h/o7p6fkMtn8oNmNL9Z2u6UkG/EmwuVKN3hgBdvT9/
        2cxOb77pGjTldIMgt72WP+4=
X-Google-Smtp-Source: APXvYqzB3AHLJb66GsMnakU04sDD3acLCTO8gwpALfVh3f4VaE9KcyDTGwD7tuCjQODybA6EikL7Pg==
X-Received: by 2002:ae9:e411:: with SMTP id q17mr5175888qkc.494.1569004281965;
        Fri, 20 Sep 2019 11:31:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.7.29])
        by smtp.gmail.com with ESMTPSA id l129sm1358303qkd.84.2019.09.20.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:31:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2CFDD40340; Fri, 20 Sep 2019 15:31:18 -0300 (-03)
Date:   Fri, 20 Sep 2019 15:31:18 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH] perf/probe: Fix to clear tev->nargs in
 clear_probe_trace_event()
Message-ID: <20190920183118.GE4865@kernel.org>
References: <156856587999.25775.5145779959474477595.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156856587999.25775.5145779959474477595.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 16, 2019 at 01:44:40AM +0900, Masami Hiramatsu escreveu:
> Since add_probe_trace_event() can reuse tf->tevs[i] after
> calling clear_probe_trace_event(), this can make perf-probe
> crash if the 1st attempt of probe event finding fails to find
> an event argument, and the 2nd attempt fails to find probe point.
> 
> E.g.
>   $ perf probe -D "task_pid_nr tsk"
>   Failed to find 'tsk' in this function.
>   Failed to get entry address of warn_bad_vsyscall
>   Segmentation fault (core dumped)

Thanks, tested and applied!

- Arnaldo
 
> 
> Fixes: 092b1f0b5f9f ("perf probe: Clear probe_trace_event when add_probe_trace_event() fails")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> ---
>  tools/perf/util/probe-event.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index b8e0967c5c21..91cab5f669d2 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2331,6 +2331,7 @@ void clear_probe_trace_event(struct probe_trace_event *tev)
>  		}
>  	}
>  	zfree(&tev->args);
> +	tev->nargs = 0;
>  }
>  
>  struct kprobe_blacklist_node {

-- 

- Arnaldo
