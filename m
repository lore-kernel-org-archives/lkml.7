Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371C421473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGnG3dqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfEVSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:08:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39894 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfEVSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:08:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id z128so2085824qkb.6;
        Wed, 22 May 2019 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lw0iZ9kTw0XT77ikY7Cp2uTJzjLqXJ9dw6o+6pGjSF0=;
        b=hGnG3dqRhg+Op2wa7vYnQJIjpJp5Xo47yB3Kr+EkpDEWtyrGPeF3bB7WrHJnWrqbXE
         5Ws0PTCpV1w2bI+unzWwgOENKU2yhLYihw4L9edjMC4OefQjNL7Dsfw9+MbLY+A60a8S
         N/PoR2yyA6LWLIIaKiAc9mMOSx6I72Td1TG4enlQTnf/rkFQnjfoxXuedAbLXWpa7qNG
         i66x3J/Ehv65L9iEqG9zkG+qU/ANNHTNCnjRnnzaddW2BQRNiiGHri1cdV47M8cPJXTR
         u2I9NIU3jShBx/QlUMvp9iJt735DeczwaOgz2zmaKXEXtb1/DNMdxi8VKIgGW7poazom
         jwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lw0iZ9kTw0XT77ikY7Cp2uTJzjLqXJ9dw6o+6pGjSF0=;
        b=SUOh8v6pAE2HgEyjnrS3d/TVUtYYMn3xCfuNhvkRUu59y7zdKN8QUdcSYd/sYm6neN
         wq+nyvrZi+qKu4rba1Siw4pHi8obVsCPPMXn0XNS4dW8F4AuE+QHYRayCHU+5Aks5CoV
         EFZqz+MPXFYS2DFstBuNgGrSo3zw76lcZ65JRyr+E4m/ZD9v06DrTZOuR7DDS6nWdmbn
         lbqvlV/upiwpUuWesNcWSB9FGDHujnECesRsZRPoBZMPtMzcKIyxrVI95/Kh3Pymg25H
         XU1FSG91TGLSS6iNoJw4290XTRkgEBnFkaDPgXrbBVqU54z1kRj0kblUWBNlcMonqVY6
         f1bg==
X-Gm-Message-State: APjAAAVzdmojUCvk76WBne1DK/CuwX+8KOPJiniuJ7XtMQAzgEGQVl2c
        6wsaHsii+ZxfKtr19e7evrE=
X-Google-Smtp-Source: APXvYqwKExPk2+WgRuKH4TKPmtpskm9c44dayHqMh9lwb6iea/cI9NgyVDIyaGvCeth4jGjfsu6YHg==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr63149060qkk.184.1558548498683;
        Wed, 22 May 2019 11:08:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id x126sm12400784qkd.34.2019.05.22.11.08.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 11:08:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F2CD7404A1; Wed, 22 May 2019 15:08:12 -0300 (-03)
Date:   Wed, 22 May 2019 15:08:12 -0300
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/3] perf report: Fix OOM error in TUI mode on s390
Message-ID: <20190522180812.GI30271@kernel.org>
References: <20190522144601.50763-1-tmricht@linux.ibm.com>
 <20190522144601.50763-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522144601.50763-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 04:45:59PM +0200, Thomas Richter escreveu:
> Debugging a OOM error using the TUI interface revealed this issue
> on s390:
> 
> [tmricht@m83lp54 perf]$ cat /proc/kallsyms |sort
> ....
> 00000001119b7158 B radix_tree_node_cachep
> 00000001119b8000 B __bss_stop
> 00000001119b8000 B _end
> 000003ff80002850 t autofs_mount	[autofs4]
> 000003ff80002868 t autofs_show_options	[autofs4]
> 000003ff80002a98 t autofs_evict_inode	[autofs4]
> ....
> 
> There is a huge gap between the last kernel symbol
> __bss_stop/_end and the first kernel module symbol
> autofs_mount (from autofs4 module).
> 
> After reading the kernel symbol table via functions:
> 
>  dso__load()
>  +--> dso__load_kernel_sym()
>       +--> dso__load_kallsyms()
> 	   +--> __dso_load_kallsyms()
> 	        +--> symbols__fixup_end()
> 
> the symbol __bss_stop has a start address of 1119b8000 and
> an end address of 3ff80002850, as can be seen by this debug statement:
> 
>   symbols__fixup_end __bss_stop start:0x1119b8000 end:0x3ff80002850
> 
> The size of symbol __bss_stop is 0x3fe6e64a850 bytes!
> It is the last kernel symbol and fills up the space until
> the first kernel module symbol.
> 
> This size kills the TUI interface when executing the following
> code:
> 
>   process_sample_event()
>     hist_entry_iter__add()
>       hist_iter__report_callback()
>         hist_entry__inc_addr_samples()
>           symbol__inc_addr_samples(symbol = __bss_stop)
>             symbol__cycles_hist()
>                annotated_source__alloc_histograms(...,
> 				                symbol__size(sym),
> 		                                ...)
> 
> This function allocates memory to save sample histograms.
> The symbol_size() marco is defined as sym->end - sym->start, which
> results in above value of 0x3fe6e64a850 bytes and
> the call to calloc() in annotated_source__alloc_histograms() fails.

Humm, why are we getting samples in that area? Is it some JITted thing
like BPF? What is it?

Why not just not consider the calloc failure as fatal, and when/if the
user asks for annotation on such symbol, tell the user that it wasn't
possible to allocate N bytes for it?

- Arnaldo
 
> Samples are generated when functions execute.
> To fix this I suggest to allow histogram entries only for functions.
> Therefore ignore symbol entries which are not of type STT_FUNC.
> 
> Output before:
> [tmricht@m83lp54 perf]$ ./perf --debug stderr=1 report -vvvvv \
> 					      -i ~/slow.data 2>/tmp/2
> [tmricht@m83lp54 perf]$ tail -5 /tmp/2
>   __symbol__inc_addr_samples(875): ENOMEM! sym->name=__bss_stop,
> 		start=0x1119b8000, addr=0x2aa0005eb08, end=0x3ff80002850,
> 		func: 0
> problem adding hist entry, skipping event
> 0x938b8 [0x8]: failed to process type: 68 [Cannot allocate memory]
> [tmricht@m83lp54 perf]$
> 
> Output after:
> [tmricht@m83lp54 perf]$ ./perf --debug stderr=1 report -vvvvv \
> 					      -i ~/slow.data 2>/tmp/2
> [tmricht@m83lp54 perf]$ tail -5 /tmp/2
>    symbol__inc_addr_samples map:0x1597830 start:0x110730000 end:0x3ff80002850
>    symbol__hists notes->src:0x2aa2a70 nr_hists:1
>    symbol__inc_addr_samples sym:unlink_anon_vmas src:0x2aa2a70
>    __symbol__inc_addr_samples: addr=0x11094c69e
>    0x11094c670 unlink_anon_vmas: period++ [addr: 0x11094c69e, 0x2e, evidx=0]
>    	=> nr_samples: 1, period: 526008
> [tmricht@m83lp54 perf]$
> 
> There is no error about failed memory allocation and the TUI interface
> shows all entries.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0b8573fd9b05..005cad111586 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -929,7 +929,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
>  {
>  	struct annotated_source *src;
>  
> -	if (sym == NULL)
> +	if (sym == NULL || sym->type != STT_FUNC)
>  		return 0;
>  	src = symbol__hists(sym, evsel->evlist->nr_entries);
>  	if (src == NULL)
> -- 
> 2.19.1

-- 

- Arnaldo
