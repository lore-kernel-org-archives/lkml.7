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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAAECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0F206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaNXE4RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439750AbfJYOfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:35:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40884 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfJYOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:35:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id o49so3526128qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lXPA/LtMnA7aSw5n8YP7FVXNorxbEcaJTv2YJu2OC/k=;
        b=UaNXE4RG0wIiCPJHcPiTca9OIdeFgR+pMc/VggkinIBBFt3kBYPNsZF6dWynAKJXfF
         OiwIuGByps9gwriU2jGT172hgMrZxjOK4NslnpADvu5+b/mdp+Q74194LRhWTA5szIGj
         6zZ2k98vDPZ30MUBnKp+mOVv5CxgqYD4Il7valmfEu6eZN/J8hrlCDRLoYRYjyAxEM3A
         Z0y0CsmFQL3pPsRd9xgW38obOhyJW9KrWIu6L9ZHkorO9WVCdvqrt6feQW6XoRhHeVtm
         OxNuIMYvmUc1cxPci0ESPuKOx59Vrv8KR0kSTkTU6uLNJMSNwLxhuKW3v2UW4saOJ4cF
         B2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXPA/LtMnA7aSw5n8YP7FVXNorxbEcaJTv2YJu2OC/k=;
        b=q17dC+ANkgo2kW7C4nYCc9TEUcS7nNlDrijBh0ERGzWU7lKuGl4vmYY5PCzKEwMdjm
         /PBSdCBXXUsoeu9FtV0wKQiKEmw44YDMMJvDNX9fsz7rIQ85X2GWx2qUuASMFppoOW3Z
         Jiy4VV9yZUplNOY4SiS3iORKmNQWMDZg6bk/yZDW+lZorYaofZPwiyTbyZpVDlFTrUB7
         FzJ1mcBSa4H+NiaP5z0sAshVXTpWKNygDtuyK8BrsrqUu11yCPzC/nJ0lfrgNr1OImuf
         yGV+FUMcCp8edxbFehS2WYpKXcMCBe+bYOKuyVJQsn9PS8D/SCE0qqq26bahNt+Mm4Qq
         fX+A==
X-Gm-Message-State: APjAAAVM6kFe29h1kG/SC4uwTUQcLmQVNvvv7CFr1O7Ap5DHNF2i2Nc8
        t3BMYwsvCE4qzSbibA8jNxo=
X-Google-Smtp-Source: APXvYqy8Hzz7lpHQK2U/jo/PBxIApeo+yUgVwegKzHDhb2zNk/PDBdgi9h+GYIc8i/WLuGqFNC5Ddw==
X-Received: by 2002:aed:3225:: with SMTP id y34mr3310196qtd.353.1572014116754;
        Fri, 25 Oct 2019 07:35:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i185sm1260948qkc.129.2019.10.25.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:35:15 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD44541199; Fri, 25 Oct 2019 11:35:13 -0300 (-03)
Date:   Fri, 25 Oct 2019 11:35:13 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 3/6] perf/probe: Fix to probe an inline function
 which has no entry pc
Message-ID: <20191025143513.GB15617@kernel.org>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
 <157199320336.8075.16189530425277588587.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157199320336.8075.16189530425277588587.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 05:46:43PM +0900, Masami Hiramatsu escreveu:
> Fix perf probe to probe an inlne function which has no entry pc
> or low pc but only has ranges attribute.
> 
> This seems very rare case, but I could find a few examples, as
> same as probe_point_search_cb(), use die_entrypc() to get the
> entry address in probe_point_inline_cb() too.
> 
> Without this patch,
>   # tools/perf/perf probe -D __amd_put_nb_event_constraints
>   Failed to get entry address of __amd_put_nb_event_constraints.
>   Probe point '__amd_put_nb_event_constraints' not found.
>     Error: Failed to add events.
> 
> With this patch,
>   # tools/perf/perf probe -D __amd_put_nb_event_constraints
>   p:probe/__amd_put_nb_event_constraints amd_put_event_constraints+43

Here I got it slightly different:

Before:

  [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
  Failed to get entry address of __amd_put_nb_event_constraints.
  Probe point '__amd_put_nb_event_constraints' not found.
    Error: Failed to add events.
  [root@quaco ~]#

After:

  [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
  p:probe/__amd_put_nb_event_constraints _text+33789
  [root@quaco ~]#


----

I'm now checking if this is because I applied patch 4/6 before 3/6
 
> Fixes: 4ea42b181434 ("perf: Add perf probe subcommand, a kprobe-event setup helper")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-finder.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 71633f55f045..2fa932bcf960 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -930,7 +930,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
>  		ret = find_probe_point_lazy(in_die, pf);
>  	else {
>  		/* Get probe address */
> -		if (dwarf_entrypc(in_die, &addr) != 0) {
> +		if (die_entrypc(in_die, &addr) != 0) {
>  			pr_warning("Failed to get entry address of %s.\n",
>  				   dwarf_diename(in_die));
>  			return -ENOENT;

-- 

- Arnaldo
