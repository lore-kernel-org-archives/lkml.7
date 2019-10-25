Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B9BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E695921929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmaUA1gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504368AbfJYMOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:14:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34580 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfJYMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:14:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so2909785qto.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cyTVWATXAD1GTz3AUnn5tQv0FTut9uyvNltt+XX18js=;
        b=nmaUA1gsF6D7ezChEg08adWea25Gzm0fFQ6eCFRP57NMZ55zhyxNjryHQWJkws6Nyx
         eIwLG5OxWImdNc8bJw6SDSn8v2+bFGWEB8Bv70WH8VhznPCUG7uWB7as7qhh8Hyz81wA
         U2P9JGmDjIIx+OnOuecfNr4a6TRfzqNXtoV6AWdfVz0mIsM4Ddzwz8D5onRoViUTYMf2
         mI6d4tBU0LE2rdMB4ZS0W214LObxT47/1K3yjeVaImhswhno8lrEMPt4a2InAorXeqXq
         ygwGU3AtrK3PvqWYyMDyU6uV6PwqU1dzJRItZ0Msu7NdGmyms1sVdUP3D/ogWu1Kli/Z
         v6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cyTVWATXAD1GTz3AUnn5tQv0FTut9uyvNltt+XX18js=;
        b=bCnDvUCJmFOGpTokLAiOs1QgAGayrpjFmY40oe1SY8LJqbG/Z/awNM4D9OrPjnyuvP
         tTX3nOR6rqlljfFulGSoudhul6nXPaj4Fjh2yj2d7gopDVmeAJP5VvjTF60F5u8Gx87E
         pi0Ub09ubKI9kLMz+5Tj+1PbZmgNrlFAyI3oGfcs4iNIR0knF/DdZY50ZA2d/qxwa6gZ
         vtnGTpSM9wP0tb1aOYEx/PHsb4c25DcqRr8kGoXP/5Btf2/gbVirGv0UIQW5rRzF9tq5
         DhfoaR32buAoMeecfQIqZf3wrpWLB1GCQGPuYufvq66DqN2CZvwA5bcCnPKSdlB9K9mI
         gwSQ==
X-Gm-Message-State: APjAAAVF3ZtaMwgDwOkVOPcw+YmoQqAgqjejiSkfZ26uvMbeWpxaYpmD
        HrRHM0OUDps6TAv3kpN9pvpvqDu2
X-Google-Smtp-Source: APXvYqxzdBgmr/DAUcY2v/G28RAXZxwBdhXd2heibg8q677Mn7nxKUIQ+5/h3857m/ucl4XRzwwgwQ==
X-Received: by 2002:ac8:4995:: with SMTP id f21mr2708418qtq.343.1572005691783;
        Fri, 25 Oct 2019 05:14:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.179.80.16])
        by smtp.gmail.com with ESMTPSA id u132sm1016713qka.50.2019.10.25.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:14:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C55D41199; Fri, 25 Oct 2019 09:14:48 -0300 (-03)
Date:   Fri, 25 Oct 2019 09:14:48 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 1/6] perf/probe: Fix wrong address verification
Message-ID: <20191025121448.GC23511@kernel.org>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
 <157199318513.8075.10463906803299647907.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157199318513.8075.10463906803299647907.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 05:46:25PM +0900, Masami Hiramatsu escreveu:
> Since there are some DIE which has only ranges instead of the
> combination of entrypc/highpc, address verification must use
> dwarf_haspc() instead of dwarf_entrypc/dwarf_highpc.
> 
> Also, the ranges only DIE will have a partial code in different
> section (e.g. unlikely code will be in text.unlikely as "FUNC.cold"
> symbol). In that case, we can not use dwarf_entrypc() or
> die_entrypc(), because the offset from original DIE can be
> a minus value.
> 
> Instead, this simply gets the symbol and offset from symtab.
> 
> Without this patch;
>   # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
>   Failed to get entry address of clear_tasks_mm_cpumask
>     Error: Failed to add events.
> 
> And with this patch
>   # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
>   p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0
>   p:probe/clear_tasks_mm_cpumask_1 clear_tasks_mm_cpumask+5
>   p:probe/clear_tasks_mm_cpumask_2 clear_tasks_mm_cpumask+8
>   p:probe/clear_tasks_mm_cpumask_3 clear_tasks_mm_cpumask+16
>   p:probe/clear_tasks_mm_cpumask_4 clear_tasks_mm_cpumask+82

Ok, so this just asks for the definition, but doesn't try to actually
_use_ it, which I did and it fails:

[root@quaco tracebuffer]# perf probe -D clear_tasks_mm_cpumask:1
p:probe/clear_tasks_mm_cpumask _text+919968
p:probe/clear_tasks_mm_cpumask_1 _text+919973
p:probe/clear_tasks_mm_cpumask_2 _text+919976
[root@quaco tracebuffer]#
[root@quaco tracebuffer]# perf probe clear_tasks_mm_cpumask
Probe point 'clear_tasks_mm_cpumask' not found.
  Error: Failed to add events.
[root@quaco tracebuffer]#

So I'll tentatively continue to apply the other patches in this series,
maybe one of them will fix this.

- Arnaldo
 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Fixes: 576b523721b7 ("perf probe: Fix probing symbols with optimization suffix")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |   32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index cd9f95e5044e..2b6513e5725c 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -604,38 +604,26 @@ static int convert_to_trace_point(Dwarf_Die *sp_die, Dwfl_Module *mod,
>  				  const char *function,
>  				  struct probe_trace_point *tp)
>  {
> -	Dwarf_Addr eaddr, highaddr;
> +	Dwarf_Addr eaddr;
>  	GElf_Sym sym;
>  	const char *symbol;
>  
>  	/* Verify the address is correct */
> -	if (dwarf_entrypc(sp_die, &eaddr) != 0) {
> -		pr_warning("Failed to get entry address of %s\n",
> -			   dwarf_diename(sp_die));
> -		return -ENOENT;
> -	}
> -	if (dwarf_highpc(sp_die, &highaddr) != 0) {
> -		pr_warning("Failed to get end address of %s\n",
> -			   dwarf_diename(sp_die));
> -		return -ENOENT;
> -	}
> -	if (paddr > highaddr) {
> -		pr_warning("Offset specified is greater than size of %s\n",
> +	if (!dwarf_haspc(sp_die, paddr)) {
> +		pr_warning("Specified offset is out of %s\n",
>  			   dwarf_diename(sp_die));
>  		return -EINVAL;
>  	}
>  
> -	symbol = dwarf_diename(sp_die);
> +	/* Try to get actual symbol name from symtab */
> +	symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
>  	if (!symbol) {
> -		/* Try to get the symbol name from symtab */
> -		symbol = dwfl_module_addrsym(mod, paddr, &sym, NULL);
> -		if (!symbol) {
> -			pr_warning("Failed to find symbol at 0x%lx\n",
> -				   (unsigned long)paddr);
> -			return -ENOENT;
> -		}
> -		eaddr = sym.st_value;
> +		pr_warning("Failed to find symbol at 0x%lx\n",
> +			   (unsigned long)paddr);
> +		return -ENOENT;
>  	}
> +	eaddr = sym.st_value;
> +
>  	tp->offset = (unsigned long)(paddr - eaddr);
>  	tp->address = (unsigned long)paddr;
>  	tp->symbol = strdup(symbol);

-- 

- Arnaldo
