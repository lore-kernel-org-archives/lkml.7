Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FC9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF55C20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6WgWhB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389538AbfCARsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:48:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35820 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfCARsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:48:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id z13so14794058qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPGXGTTj4HQLxXXXnQbWs9D97v0ekd6oTS+Y5PfbE4Q=;
        b=u6WgWhB94tJ4kfgPlCsI6iNTpf/etYeu1RfsV3mmFYT0vCNKU6hA5fjBk9Qpa8fo0x
         l9ChA5VquQU4tBsxaoltqWEpbRlnW26wpsLASEhKGpsKRB6YlUddVxlcMK07PfB2jgfk
         nu9dIBhGfLyiJua7fAFqlVa7VkgzeEnYj9TsjCh/Cl9GgkHcwBhB8OBqedAB6lPI3h7d
         f5YRcePTOubg15MWSxq1dqUVLum3R32pZoJ+R6tj2kGoATSra6wJIwYo6cZZbfpt9jVU
         LVfp4XIhr4R3DkUzHtpo7zXAlpMxSX5zHjNCDbABdxNak+4hN0//r3M7qhguIPSn68CS
         0/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPGXGTTj4HQLxXXXnQbWs9D97v0ekd6oTS+Y5PfbE4Q=;
        b=cTc+Jw0HBkYDL2aliZTBjsNe+iHKOfWzSNIqo7W4w85p/qnfbI3pJ2wH7wzrfkvxzH
         nK4YASQwiHEAyqsN9c5DyZm2dav9pkMVgHIUb748p9PDn47vwyspPIMd/lQ3TnB43wuO
         KJZ3wvybi6wPNk1j7ZZdDYWfC8A7U8fN9aaHK5/za3An1uFCAPLfirNngx5GVjeauu5J
         cfSj7LjNjn14E5jrD770yDHMIDzg73R/LYq62xBB2mZte6WR11WhzCSbNOFmVWx3QyXd
         KAH7HRf8cUei14rSETdyLfA+vvK8LkuFiUIt09woUvFB2fpgABV3+smQFU1hiK14koOw
         5Cjg==
X-Gm-Message-State: APjAAAUOny33xhWDTsx3ZoosNur7fmtNGi4VXCZh9kskFY1iDtVNezTB
        PGO09tL9igSXuEeS+xRY7E0=
X-Google-Smtp-Source: APXvYqxWoj/D1zrg4gjAIpj8d6rqMh7kONiRegbjTT9IinTgFnkPhSfU9AoPOvN/1In9VNJWWECDsw==
X-Received: by 2002:ae9:ebd5:: with SMTP id b204mr4725039qkg.37.1551462480337;
        Fri, 01 Mar 2019 09:48:00 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id i141sm10462536qke.7.2019.03.01.09.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:47:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3926F4039C; Fri,  1 Mar 2019 14:47:55 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:47:55 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf auxtrace: Improve address filter error message when
 there is no DSO
Message-ID: <20190301174755.GI13100@kernel.org>
References: <20190301122902.18707-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301122902.18707-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 02:29:02PM +0200, Adrian Hunter escreveu:
> The message does not indicate the possibility that the symbol is not
> found because the file does not exist.
> 
> Before:
> 
>   $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
>   Symbol 'strcmp' not found.
>   Note that symbols must be functions.
>   Failed to parse address filter: 'filter strcmp / strcpy @ foo '
>   Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
>   Where multiple filters are separated by space or comma.
> 
> After:
> 
>   $ perf record -e intel_pt//u --filter 'filter strcmp / strcpy @ foo ' ls
>   File 'foo' not found or has no symbols.
>   Symbol 'strcmp' not found.
>   Note that symbols must be functions.
>   Failed to parse address filter: 'filter strcmp / strcpy @ foo '
>   Filter format is: filter|start|stop|tracestop <start symbol or address> [/ <end symbol or size>] [@<file name>]
>   Where multiple filters are separated by space or comma.

Thanks, applied.

- Arnaldo
 
> Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 267e54df511b..fb76b6b232d4 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1918,7 +1918,8 @@ static struct dso *load_dso(const char *name)
>  	if (!map)
>  		return NULL;
>  
> -	map__load(map);
> +	if (map__load(map) < 0)
> +		pr_err("File '%s' not found or has no symbols.\n", name);
>  
>  	dso = dso__get(map->dso);
>  
> -- 
> 2.17.1

-- 

- Arnaldo
