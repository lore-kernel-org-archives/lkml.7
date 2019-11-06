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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2046C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E385217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axB5r95L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfKFTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:51:12 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46798 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKFTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:51:12 -0500
Received: by mail-qv1-f65.google.com with SMTP id w11so1949690qvu.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QUexYIr7U1f0T7OEMqRu9Rc2egqJY5ncikGiJvvPwrM=;
        b=axB5r95L9TEm5yr7yYSgL4ztMoOEZEDHQrKDUCo7kjUCWPK7p9X+fek6UONuuFViue
         wHae2fQkj8WcA1juTHQl8wt+h9/xhegTvIXS62YtExB5TAHNZfUvJA53AMQfcQkp/Cgf
         zX5UMrGuVPHzBuqpNs7CW0kxhu/uckef0qRok93K7pT60zpXWtTHS20KANfsGy02FZAk
         puZGN8DJR44QwfX/fNLFnv87dg0Z8HzQvBe4vXiCU+m0Z9iNKSSKM2cGLmrp5mgzrW9L
         oR2OznSyWUcoBCbGHzl8e0az0fUJjG3BOPRHV4sYSydxmlSznaCv+y6VzVR+QXxKz9AD
         kPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QUexYIr7U1f0T7OEMqRu9Rc2egqJY5ncikGiJvvPwrM=;
        b=US7ER/Y+/cg2MRQTe5tMuuKFZqRTNTNdWptyl+qd46u+5QM97gxrUQ1NekKnuo5gtr
         BTpu1+iWAky7lhkUXFhVlLhjQ8+obOdrAReisoZQ1BFePQv14xCEh2BAGJpReXB2DWJJ
         f+FWazXCwQyHi5EvaggZMfzYNhzLf40VjxUOB8IFc/jgJpQtNd0wU5E17v4V8kp8Yq6b
         E4erenKoGs2bimHBK5YORnUwUS/BxByjwAwxG5+zdjno+FK8KNi94LfkxzNkF0k9Z8kB
         DWfKzZHAb5nJBF6TVEaEr6Z3O8D+ex1/QtFEtsdNc6bgbzG8cj8IRAH2QYKi1BkFxadd
         P/AQ==
X-Gm-Message-State: APjAAAXDund8W4lS8V/D8ymR01XPXCSi8kH1/SfKGFqdvbiKDmQr+dWA
        xwJS4mHk/Fu8S9+dJtsc8rM=
X-Google-Smtp-Source: APXvYqxUonsghRGGWNzRADBiBLoWRBK21351QxH8L62n2WIERJI0CNIXF/eawfE8lAtTLUnmN5Warg==
X-Received: by 2002:a0c:ee49:: with SMTP id m9mr4094467qvs.118.1573069871037;
        Wed, 06 Nov 2019 11:51:11 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id z70sm13269083qkb.60.2019.11.06.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:51:10 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6715140B1D; Wed,  6 Nov 2019 16:51:05 -0300 (-03)
Date:   Wed, 6 Nov 2019 16:51:05 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/5] perf probe: Return a better scope DIE if there is no
 best scope
Message-ID: <20191106195105.GA11935@kernel.org>
References: <157291299825.19771.5190465639558208592.stgit@devnote2>
 <157291300887.19771.14936015360963292236.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157291300887.19771.14936015360963292236.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 09:16:49AM +0900, Masami Hiramatsu escreveu:
> Make find_best_scope() returns innermost DIE at given address if
> there is no best matched scope DIE. Since Gcc sometimes generates
> intuitively strange line info which is out of inlined function
> address range, we need this fixup.
> 
> Without this, sometimes perf probe failed to probe on a line
> inside an inlined function.
>   # perf probe -D ksys_open:3
>   Failed to find scope of probe point.
>     Error: Failed to add events.
> 
> With this fix, perf probe can probe it.
>   # perf probe -D ksys_open:3
>   p:probe/ksys_open _text+25707308
>   p:probe/ksys_open_1 _text+25710596
>   p:probe/ksys_open_2 _text+25711114
>   p:probe/ksys_open_3 _text+25711343
>   p:probe/ksys_open_4 _text+25714058
>   p:probe/ksys_open_5 _text+2819653
>   p:probe/ksys_open_6 _text+2819701

Thanks, tested before and after and applied,

- Arnaldo
 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index f441e0174334..9ecea45da4ca 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -744,6 +744,16 @@ static int find_best_scope_cb(Dwarf_Die *fn_die, void *data)
>  	return 0;
>  }
>  
> +/* Return innermost DIE */
> +static int find_inner_scope_cb(Dwarf_Die *fn_die, void *data)
> +{
> +	struct find_scope_param *fsp = data;
> +
> +	memcpy(fsp->die_mem, fn_die, sizeof(Dwarf_Die));
> +	fsp->found = true;
> +	return 1;
> +}
> +
>  /* Find an appropriate scope fits to given conditions */
>  static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
>  {
> @@ -755,8 +765,13 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
>  		.die_mem = die_mem,
>  		.found = false,
>  	};
> +	int ret;
>  
> -	cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb, &fsp);
> +	ret = cu_walk_functions_at(&pf->cu_die, pf->addr, find_best_scope_cb,
> +				   &fsp);
> +	if (!ret && !fsp.found)
> +		cu_walk_functions_at(&pf->cu_die, pf->addr,
> +				     find_inner_scope_cb, &fsp);
>  
>  	return fsp.found ? die_mem : NULL;
>  }

-- 

- Arnaldo
