Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C653BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A837222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4tH4icM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKRV7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:59:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32812 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRV7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:59:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so15963681qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnsiPIOUwOvqWa5Srxl7+59yhHLK4miFuzoyun3dJnk=;
        b=p4tH4icM8LpvPvKVzzRkBo64+dKNwZcsVns6n6q4nuCS+6QFUCaOpW6xLyau2EXf1k
         ZbLNfiyTduuT9WRZDQ2AW6/7n+2OfxrD3+DQqO/HDkC410//4C3Fr+yKDdxUQbaXUtNh
         mHAq1vho1v0vwHA/mKUMpjIGHSaLmcY0mT8kLnK8bGOIrwInzimoEIuPT1ILNB7K8w1h
         gGQroW3JGfUbmjw/NW1XpfYhYt2VPsBsViONh6W/nHZ1ctvaQxnjM5hwwCpxmH0lutC+
         LZLS0u54lsURbH6+c784KX0grCRaiGUJCJxUYqnIRJI9iEYmbUFQBHc+RETIhYfK2GYT
         xqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnsiPIOUwOvqWa5Srxl7+59yhHLK4miFuzoyun3dJnk=;
        b=Cuzh36Ri7D8xQ47ga/6QR1Hi38o3hf6MBgGwZcf1f/LSgb/36eDrIwN7UJQ7WcfSV9
         P2ue2c+QmqLa19MuxuP5YZ58cCi71aSzE3GAx30DZ+V4/DiE13zplQVwvld//hQcj+Tk
         LxqJkHtdq0YKMheXyGZ9Vp4nEYAkAIasgyd1XoGatci9/xMDOjZj6M+ej+8aKFkjCAMB
         sehrcA3JAzCC4pCkkJ4MTe26x4mrZe7X1e3yFTpzRHrD90GIDJNZLbGGHSX9iW4vOTOA
         gtWNzAOR+PmtfM06fjTq3VRA1sZmqYTr3IKzKGFjyeDxfaYlL4QsmIE96tcuIGCRQ9MM
         sUvA==
X-Gm-Message-State: APjAAAXA6W/v2rYij1YOeopin7ZenMOyrHqkgENhXQPz2NCorCYaU84C
        +Ffl45eq455x+PYNlsNBUqg=
X-Google-Smtp-Source: APXvYqwgFvaxcLCm6lhuXYWJix3n9Ed2okqjaJsJM+qra4B0a74jbIeCua7Wt2A2lH8mKgk+U4LbhQ==
X-Received: by 2002:a37:4cc5:: with SMTP id z188mr26551760qka.300.1574114352231;
        Mon, 18 Nov 2019 13:59:12 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r8sm10736177qti.6.2019.11.18.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:59:11 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCDB640D3E; Mon, 18 Nov 2019 18:59:09 -0300 (-03)
Date:   Mon, 18 Nov 2019 18:59:09 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 2/7] perf probe: Verify given line is a representive
 line
Message-ID: <20191118215909.GC20465@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
 <157406472071.24476.14915451439785001021.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157406472071.24476.14915451439785001021.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 05:12:00PM +0900, Masami Hiramatsu escreveu:
> Verify user given probe line is a representive line (which doesn't
> share the address with other lines or the line is the least line
> among the lines which shares same address), and if not, it shows
> what is the representive line.
> 
> Without this fix, user can put a probe on the lines which is not a
> a representive line. But since this is not a representive line,
> perf probe -l shows a representive line number instead of user given
> line number. e.g. (put kernel_read:3, but listed as kernel_read:2)
> 
>   # perf probe -a kernel_read:3
>   Added new event:
>     probe:kernel_read    (on kernel_read:3)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:kernel_read -aR sleep 1
> 
>   # perf probe -l
>     probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)
> 
> With this fix, perf probe doesn't allow user to put a probe on
> a representive line, and tell what is the representive line.
> 
>   # perf probe -a kernel_read:3
>   This line is sharing the addrees with other lines.
>   Please try to probe at kernel_read:2 instead.
>     Error: Failed to add events.

Thanks, this fixes the problem I reported, applied.

- Arnaldo
 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 9ecea45da4ca..ef1b320cedf8 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -776,6 +776,39 @@ static Dwarf_Die *find_best_scope(struct probe_finder *pf, Dwarf_Die *die_mem)
>  	return fsp.found ? die_mem : NULL;
>  }
>  
> +static int verify_representive_line(struct probe_finder *pf, const char *fname,
> +				int lineno, Dwarf_Addr addr)
> +{
> +	const char *__fname, *__func = NULL;
> +	Dwarf_Die die_mem;
> +	int __lineno;
> +
> +	/* Verify line number and address by reverse search */
> +	if (cu_find_lineinfo(&pf->cu_die, addr, &__fname, &__lineno) < 0)
> +		return 0;
> +
> +	pr_debug2("Reversed line: %s:%d\n", __fname, __lineno);
> +	if (strcmp(fname, __fname) || lineno == __lineno)
> +		return 0;
> +
> +	pr_warning("This line is sharing the addrees with other lines.\n");
> +
> +	if (pf->pev->point.function) {
> +		/* Find best match function name and lines */
> +		pf->addr = addr;
> +		if (find_best_scope(pf, &die_mem)
> +		    && die_match_name(&die_mem, pf->pev->point.function)
> +		    && dwarf_decl_line(&die_mem, &lineno) == 0) {
> +			__func = dwarf_diename(&die_mem);
> +			__lineno -= lineno;
> +		}
> +	}
> +	pr_warning("Please try to probe at %s:%d instead.\n",
> +		   __func ? : __fname, __lineno);
> +
> +	return -ENOENT;
> +}
> +
>  static int probe_point_line_walker(const char *fname, int lineno,
>  				   Dwarf_Addr addr, void *data)
>  {
> @@ -786,6 +819,9 @@ static int probe_point_line_walker(const char *fname, int lineno,
>  	if (lineno != pf->lno || strtailcmp(fname, pf->fname) != 0)
>  		return 0;
>  
> +	if (verify_representive_line(pf, fname, lineno, addr))
> +		return -ENOENT;
> +
>  	pf->addr = addr;
>  	sc_die = find_best_scope(pf, &die_mem);
>  	if (!sc_die) {

-- 

- Arnaldo
