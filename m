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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC51C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DF42075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzJh+LvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfKFT5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:57:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35797 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:57:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id r22so24989324qtt.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h6UbIbVlfISuIvel0Iqu/1JQlf1OlTg/l5tLHla0gWA=;
        b=hzJh+LvMcsj6qZ6/Eq+oOdNhECLwQc4ziSD8lz//LKJ7+5IbIT9c7EIK08plXD+Wy7
         wUIUmdfRVq042/avlzDgkTu6Jo+B/OyxEgasnlW2WTFXKndW0sMepFZxHj4xqQWA1Kng
         RejA7+Ewr1e8eyQpl6DtFHQWFXn5MzEIbKy0MZeWLq0VZOHZ/dnI7k+q+cfGVKhqGYz9
         hY/uGPO4NuWEJM3f/4M5/Sl86CETKRwGjezOJxqaC/j1h7hynOAKaRpSoa327E4ZGNil
         XihKJsKew5WqO6QjTRm/bGPNSZPUFOR1kBfrA0gl3tXq7BB64foUCZd343yaTDK7/xsv
         aEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h6UbIbVlfISuIvel0Iqu/1JQlf1OlTg/l5tLHla0gWA=;
        b=I4es7OECf/Xa6HNoBX6cfCN99SSw6vNKQnze2sik4bhMOqNy/IHz4iFNUdaJebUduA
         N20t+jY8GkOYDWqd9F8uimVe7nXOea+AOq7SC0xAs5vsAjnLcWz7ZLlDVRyK+gSom5Ao
         HmhmY8JFCgcs0z56FZ+EmiIBsMhEZuX2PwRRVrK1whlcJ3Jl1G7RfvzWYotEwxsY8oGO
         bXriYp4Ap2AqeVVOj75W4KAPJjXmD9lwwSXKz/suEg48FeV13lTVhQPtcImtGpsgxCCB
         bm/y+UUikrRek+yEWhzn1d9SxNXuhNRjQ6agnzKL+TE52SYKkwresFHOpQ7BRBwvAxtL
         aEbg==
X-Gm-Message-State: APjAAAWqdj/1r5xoF115Qcm/ZdJ8Q/rmrsiHW+vyKZ+/QR4wpRcWA8vh
        aTAj02uGic7L/gGPnfkYujc=
X-Google-Smtp-Source: APXvYqwm/z4N6f36Lb6K0uirXf1izF1DzNR2l9jPG1Uc7kpcqu32KlYejlHJE4RTmRrasbO+zpnA/w==
X-Received: by 2002:aed:224f:: with SMTP id o15mr4382638qtc.86.1573070225181;
        Wed, 06 Nov 2019 11:57:05 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id h44sm12291549qtc.1.2019.11.06.11.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:57:04 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBEC840B1D; Wed,  6 Nov 2019 16:56:59 -0300 (-03)
Date:   Wed, 6 Nov 2019 16:56:59 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/5] perf probe: Support DW_AT_const_value constant value
Message-ID: <20191106195659.GD11935@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
 <157291303888.19771.11876536314853955934.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157291303888.19771.11876536314853955934.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 09:17:19AM +0900, Masami Hiramatsu escreveu:
> Support DW_AT_const_value for variable assignment instead of location.
> Note that this requires ftrace supporting immediate value.

This one could have come before the other two, depends on the previous
two being applied.

- Arnaldo
 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-file.c   |    7 +++++++
>  tools/perf/util/probe-file.h   |    1 +
>  tools/perf/util/probe-finder.c |   11 +++++++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index a63f1a19b0e8..5003ba403345 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -1008,6 +1008,7 @@ enum ftrace_readme {
>  	FTRACE_README_UPROBE_REF_CTR,
>  	FTRACE_README_USER_ACCESS,
>  	FTRACE_README_MULTIPROBE_EVENT,
> +	FTRACE_README_IMMEDIATE_VALUE,
>  	FTRACE_README_END,
>  };
>  
> @@ -1022,6 +1023,7 @@ static struct {
>  	DEFINE_TYPE(FTRACE_README_UPROBE_REF_CTR, "*ref_ctr_offset*"),
>  	DEFINE_TYPE(FTRACE_README_USER_ACCESS, "*[u]<offset>*"),
>  	DEFINE_TYPE(FTRACE_README_MULTIPROBE_EVENT, "*Create/append/*"),
> +	DEFINE_TYPE(FTRACE_README_IMMEDIATE_VALUE, "*\\imm-value,*"),
>  };
>  
>  static bool scan_ftrace_readme(enum ftrace_readme type)
> @@ -1092,3 +1094,8 @@ bool multiprobe_event_is_supported(void)
>  {
>  	return scan_ftrace_readme(FTRACE_README_MULTIPROBE_EVENT);
>  }
> +
> +bool immediate_value_is_supported(void)
> +{
> +	return scan_ftrace_readme(FTRACE_README_IMMEDIATE_VALUE);
> +}
> diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
> index 850d1b52d60a..0dba88c0f5f0 100644
> --- a/tools/perf/util/probe-file.h
> +++ b/tools/perf/util/probe-file.h
> @@ -72,6 +72,7 @@ bool kretprobe_offset_is_supported(void);
>  bool uprobe_ref_ctr_is_supported(void);
>  bool user_access_is_supported(void);
>  bool multiprobe_event_is_supported(void);
> +bool immediate_value_is_supported(void);
>  #else	/* ! HAVE_LIBELF_SUPPORT */
>  static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
>  {
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 9ecea45da4ca..2e3a468c8350 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -177,6 +177,17 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
>  	if (dwarf_attr(vr_die, DW_AT_external, &attr) != NULL)
>  		goto static_var;
>  
> +	/* Constant value */
> +	if (dwarf_attr(vr_die, DW_AT_const_value, &attr) &&
> +	    immediate_value_is_supported()) {
> +		Dwarf_Sword snum;
> +
> +		dwarf_formsdata(&attr, &snum);
> +		ret = asprintf(&tvar->value, "\\%ld", (long)snum);
> +
> +		return ret < 0 ? -ENOMEM : 0;
> +	}
> +
>  	/* TODO: handle more than 1 exprs */
>  	if (dwarf_attr(vr_die, DW_AT_location, &attr) == NULL)
>  		return -EINVAL;	/* Broken DIE ? */

-- 

- Arnaldo
