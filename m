Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4159B20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHKZVe9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbfCARyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:54:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40700 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfCARyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:54:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id h28so14792588qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOo9SeiQkoMjNKr8qPPJ64K4tDsxnbFa8N5q6JiAYDE=;
        b=EHKZVe9TdyME0Hh60DvQhGJtSP3/SnrjK4UVUJxSfbfLhmvAJY9p57WkTNGe7cYRT5
         85jSvQ0QURil190WcoRgWLn2tF/qjKvjc4HHl4zwHr2WuCEckeQwEFuRaNjuHUpO7RGP
         UFFDMYqgcEz91kL1ytBBdLnrZSUWf04xDU3n/G9CSE9xHoQMB3hpofQ0430c8t27CJks
         3JTjIhsri21vPe0UbatKfY6lBe0e+HZzsz80jqfgbHAvVTZj1e65AboQNx/UiZUa9XGJ
         52pWYE3Fkm9ufHrCouRd7/pLevopPcoHNaQEUigFBkYIT1oO1ODVU3JZJvNWzFEnCeRg
         xAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOo9SeiQkoMjNKr8qPPJ64K4tDsxnbFa8N5q6JiAYDE=;
        b=NTBx+mkFdmTwdSPdbEF/x1+SCH4tdgIIturVbw+vHUccf0XiipY0gE9NJH7lI02Wap
         rwUxP9vHtzM0RzkTHFR80oAblvsVsKHeHo7DrNaSqflN/OFReQx7EDlnhYDWQ98m2xGd
         IQzWIP+OqDzuaGLl9Jv94EIv+psa+ZoVe/NAEyFPJtKAktPQRTJdwDofMRca+h6WWH2q
         ZjK+2gSM33F3DM2hW5cZQ1hTHrSiRUNWPSQ/ts6mOUD13/ZdGDA9i0H80OB5VPR+o9n+
         bXJB3OXIyPXZggWZwatXsXYc7zbX8plbEOwjpc45r0BQ3b3DCcHrBnnsyzFeGD+a6T/z
         Pagw==
X-Gm-Message-State: APjAAAWncs/DbS8xiUdcIcpnZLhWvL9/QgC6GE+5KRPUYo0rqyB2rF4U
        s9nV3UJo5ybXByZsi7GGPAn23VHefSM=
X-Google-Smtp-Source: APXvYqyTdTdiEsL+zPLn9bB/d6JFckujNqKPUcFGVxxNi3X/fYCKW6wFni+wMYn2Ecv2SPS7GM6xRg==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr1737512qkf.249.1551462870645;
        Fri, 01 Mar 2019 09:54:30 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id t55sm15492089qtt.57.2019.03.01.09.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:54:29 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 893104039C; Fri,  1 Mar 2019 14:54:26 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:54:26 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] perf scripts python: export-to-postgresql.py: Fix
 invalid input syntax for integer error
Message-ID: <20190301175426.GO13100@kernel.org>
References: <20190228130031.23064-1-adrian.hunter@intel.com>
 <20190228130031.23064-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228130031.23064-4-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:00:26PM +0200, Adrian Hunter escreveu:
> Fix SQL query error "invalid input syntax for integer":
> 
>   Traceback (most recent call last):
>     File "tools/perf/scripts/python/export-to-postgresql.py", line 465, in <module>
>       do_query(query, 'CREATE VIEW calls_view AS '
>     File "tools/perf/scripts/python/export-to-postgresql.py", line 274, in do_query
>       raise Exception("Query failed: " + q.lastError().text())
>   Exception: Query failed: ERROR:  invalid input syntax for integer: ""
>   LINE 1: ...ch_count,call_id,return_id,CASE WHEN flags=0 THEN '' WHEN fl...
>                                                                ^
>   (22P02) QPSQL: Unable to create query
>   Error running python script tools/perf/scripts/python/export-to-postgresql.py

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: f08046cb3082 ("perf thread-stack: Represent jmps to the start of a different symbol")
> ---
>  tools/perf/scripts/python/export-to-postgresql.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> index 30130213da7e..6358522a69f6 100644
> --- a/tools/perf/scripts/python/export-to-postgresql.py
> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> @@ -478,7 +478,7 @@ if perf_db_export_calls:
>  			'branch_count,'
>  			'call_id,'
>  			'return_id,'
> -			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
> +			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
>  			'parent_call_path_id'
>  		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
>  
> -- 
> 2.17.1

-- 

- Arnaldo
