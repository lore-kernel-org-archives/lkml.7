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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38F6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EFA208CE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEQ7yx0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfKRV5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:57:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44288 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:57:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id m16so15921344qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IM1gLD1e4p629izbR1cZgpx+N4ZaaE9XGSuaZUMB0Dw=;
        b=uEQ7yx0rQI2NcL5WVUDRY+4c1n9zz+tBBh3yFj7DaRCwmNZ7FndG6uBAvvVEF24PjO
         g7q6kib6qvcybP+jr5q7M2vKnoe/JA0MdS7qr9HFBIrf9JXhPcjG1thV/1vnYdvVEAun
         y9rMPUHo9WrThhIebyzRx7HWfW8TYl8jLxW67ORZN7ZJ5IYpXYm89BqM6JV9FqsvHgX1
         Foyw+P3DSqGJGKU1iXw4J8JlDRG9aJvBtkp+UA/tWOymo+fuBRBfruQGlPPDCvCM1VJ4
         1yRBFz7ZuPeS6JG9L7aTknQeleTPgTNl+chZyqCkkM9CQ5WfNexzdkYRpq+jP70YtjpA
         bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IM1gLD1e4p629izbR1cZgpx+N4ZaaE9XGSuaZUMB0Dw=;
        b=VbtOZoCvwHYQb8bWStq20jKuf//GwJ0j+pn9stHAd/fwzOOhmliMsBdwZsasVWgUpM
         DbitWcnRBy9vN3nEIlDcFRNZFoO+FWxzNI2in6l8yjOwa5UbYwW0T+5jRzujQ7Aknu6r
         g1cila0Cqk4JWccHs4zwqKNc/R2D12tISXRNoz+1jbwAsf1zrIa9sEVpWAg+b48bkyhL
         mIOokVKICCrOUx0IHtG7z13Y9f1wKEYxGS68v7uccnl0iBNKJcKZgklaC6R1fJNCStw8
         hlAD40I1cDXRAxk7mz8uC57ytgOCq3RsNo3bh/VWGDApRVikLosYD9XruoaANsEIxFJU
         AKXQ==
X-Gm-Message-State: APjAAAW7XO4Bmr2S+LnJ163kQF63zkCKB8Q4c7HwvcXU7u2TTG5wV3Hx
        DKaXTTOD6ce7CGOppYic354=
X-Google-Smtp-Source: APXvYqwrWRfITgwzEsoraj1VaOrzmkHIHQgCLQm9Am30pj9qpUK+4oqywWRNQCL3Du72M4G+wjuFEQ==
X-Received: by 2002:a37:6c7:: with SMTP id 190mr16705466qkg.429.1574114256219;
        Mon, 18 Nov 2019 13:57:36 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i4sm10650949qtp.57.2019.11.18.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:57:35 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6898A40D3E; Mon, 18 Nov 2019 18:57:33 -0300 (-03)
Date:   Mon, 18 Nov 2019 18:57:33 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 1/7] perf probe: Show correct statement line number by
 perf probe -l
Message-ID: <20191118215733.GB20465@kernel.org>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
 <157406471067.24476.17463149618465494448.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157406471067.24476.17463149618465494448.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2019 at 05:11:50PM +0900, Masami Hiramatsu escreveu:
> The dwarf_getsrc_die() can return the line which is not a statement
> nor the least line number among the lines which shares same address.
> This can lead perf probe --list shows incorrect line number for
> probed address.
> To fix this, this introduces cu_getsrc_die() which returns only a
> statement line and which is the least line number (we call it
> the representive line for an address), and use it in cu_find_lineinfo().
> 
> Also, if the given address is the entry address of a real function,
> cu_find_lineinfo() returns the function declared line number instead
> of the start line number of the function body.
> 
> For example, without this change perf probe -l shows incorrect line
> as below.
> 
>   # perf probe -a kernel_read:2
>   Added new event:
>     probe:kernel_read    (on kernel_read:2)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe:kernel_read -aR sleep 1
> 
>   # perf probe -l
>     probe:kernel_read    (on kernel_read:1@linux-5.0.0/fs/read_write.c)
> 
> With this fix, it shows correct line number as below;
> 
>   # perf probe -l
>     probe:kernel_read    (on kernel_read:2@linux-5.0.0/fs/read_write.c)

Thanks, this fixes the problem I reported, applied.

- Arnaldo
 
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/dwarf-aux.c |   62 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 5544bfbd0f6c..aa898014ad12 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -59,6 +59,51 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
>  	return dwarf_formstring(&attr);
>  }
>  
> +/* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
> +static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
> +{
> +	Dwarf_Addr laddr;
> +	Dwarf_Lines *lines;
> +	Dwarf_Line *line;
> +	size_t nlines, l, u, n;
> +	bool flag;
> +
> +	if (dwarf_getsrclines(cu_die, &lines, &nlines) != 0 ||
> +	    nlines == 0)
> +		return NULL;
> +
> +	/* Lines are sorted by address, use binary search */
> +	l = 0; u = nlines - 1;
> +	while (l < u) {
> +		n = u - (u - l) / 2;
> +		line = dwarf_onesrcline(lines, n);
> +		if (!line || dwarf_lineaddr(line, &laddr) != 0)
> +			return NULL;
> +		if (addr < laddr)
> +			u = n - 1;
> +		else
> +			l = n;
> +	}
> +	/* Going backward to find the lowest line */
> +	do {
> +		line = dwarf_onesrcline(lines, --l);
> +		if (!line || dwarf_lineaddr(line, &laddr) != 0)
> +			return NULL;
> +	} while (laddr == addr);
> +	l++;
> +	/* Going foward to find the statement line */
> +	do {
> +		line = dwarf_onesrcline(lines, l++);
> +		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
> +		    dwarf_linebeginstatement(line, &flag) != 0)
> +			return NULL;
> +		if (laddr > addr)
> +			return NULL;
> +	} while (!flag);
> +
> +	return line;
> +}
> +
>  /**
>   * cu_find_lineinfo - Get a line number and file name for given address
>   * @cu_die: a CU DIE
> @@ -72,17 +117,26 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
>  		    const char **fname, int *lineno)
>  {
>  	Dwarf_Line *line;
> -	Dwarf_Addr laddr;
> +	Dwarf_Die die_mem;
> +	Dwarf_Addr faddr;
>  
> -	line = dwarf_getsrc_die(cu_die, (Dwarf_Addr)addr);
> -	if (line && dwarf_lineaddr(line, &laddr) == 0 &&
> -	    addr == (unsigned long)laddr && dwarf_lineno(line, lineno) == 0) {
> +	if (die_find_realfunc(cu_die, (Dwarf_Addr)addr, &die_mem)
> +	    && die_entrypc(&die_mem, &faddr) == 0 &&
> +	    faddr == addr) {
> +		*fname = dwarf_decl_file(&die_mem);
> +		dwarf_decl_line(&die_mem, lineno);
> +		goto out;
> +	}
> +
> +	line = cu_getsrc_die(cu_die, (Dwarf_Addr)addr);
> +	if (line && dwarf_lineno(line, lineno) == 0) {
>  		*fname = dwarf_linesrc(line, NULL, NULL);
>  		if (!*fname)
>  			/* line number is useless without filename */
>  			*lineno = 0;
>  	}
>  
> +out:
>  	return *lineno ?: -ENOENT;
>  }
>  

-- 

- Arnaldo
