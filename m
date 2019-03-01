Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01907C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2412084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6AaQnDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbfCARyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:54:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39901 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfCARyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:54:15 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so28736444qtk.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lBH4Ydigs2bWU7WqTFcY8LV1XYbSgo9zlNdv0ERAU2Y=;
        b=W6AaQnDvR59Vg4MCOhQtpb4Fu715hKb8akF4wdINKRYTM3GreCx2ePCMezTk+Jiwqg
         B7vhhQlySMN05Fpb7UfzwK0kNvWqaqmKc1SEa/R457sMKXzAa3T2NFVXxU3owBKnFFif
         YgfDHjxhnXZfKuEjYoBXYivYfpjm37lxls5IvYum79qVWeYlo1xgNhrKNCJ3AinnIMyQ
         RaHd3xLkRGYTHUz24LOBe5UMv+mjXl4IARPNfVqGwq7NvU1r1wsedSl1fskA5kBHDZ2g
         v6rK6c0K4phhpoRtRAWBg8egMuZDWo7rq8DKE1VVEonVeK+HjbadyZxlb1zKfSBoBMcZ
         9v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lBH4Ydigs2bWU7WqTFcY8LV1XYbSgo9zlNdv0ERAU2Y=;
        b=GW66/kWqcXHbo9Wy3drArz4wERS4oIyXgWxwiSiDLuQysu2lm/431vvFp8ZPNnPuuX
         uZxLFYImzBAZESpnoik5ZEcnZ/tqghGPh5hX+yx+cCgdc+JpArINd9sdQurvONx5K1XT
         BQQ4oXzVhkkTwcwOI81W46jxOor+UZjFboLnjXktdkjhHVxn2BjerE7Kwqa7M9OcBy9X
         WQzLStWMTlAEdCmrHZHVKmMbAjn+H9y1CszJRoPOLIPGU5LTlQg0Gh/gtJqVTqZzqWsb
         FNXiNfn5dCPugRb7uQXbHcQO+EBVXrhcZYDwBPKdD/VReT5lhbISTfyvt+7MwkLjvWOX
         lc8Q==
X-Gm-Message-State: APjAAAWQ2G+Go4PFQwOhiv5yqYoumDgi0fK4YpwZVpUdVbGmpNXwPYrb
        3QVzyiXltdp213nURlcdlxo=
X-Google-Smtp-Source: APXvYqzWrlXwnp5ALmYz4rxiHv3jf8gKCrnbHYHdbtncvCqlafbtacIIAct2ALrMg4GznNFs9ymM3w==
X-Received: by 2002:ac8:17e7:: with SMTP id r36mr4918002qtk.104.1551462853751;
        Fri, 01 Mar 2019 09:54:13 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id v83sm2530244qkb.18.2019.03.01.09.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:54:12 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B1B84039C; Fri,  1 Mar 2019 14:54:09 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:54:09 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] perf scripts python: export-to-postgresql.py: Export
 calls parent_id
Message-ID: <20190301175409.GN13100@kernel.org>
References: <20190228130031.23064-1-adrian.hunter@intel.com>
 <20190228130031.23064-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228130031.23064-5-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:00:27PM +0200, Adrian Hunter escreveu:
> Export to the 'calls' table the newly created 'parent_id' and create an
> index for it.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/scripts/python/export-to-postgresql.py | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> index 6358522a69f6..390a351d15ea 100644
> --- a/tools/perf/scripts/python/export-to-postgresql.py
> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> @@ -394,7 +394,8 @@ if perf_db_export_calls:
>  		'call_id	bigint,'
>  		'return_id	bigint,'
>  		'parent_call_path_id	bigint,'
> -		'flags		integer)')
> +		'flags		integer,'
> +		'parent_id	bigint)')
>  
>  do_query(query, 'CREATE VIEW machines_view AS '
>  	'SELECT '
> @@ -479,7 +480,8 @@ if perf_db_export_calls:
>  			'call_id,'
>  			'return_id,'
>  			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
> -			'parent_call_path_id'
> +			'parent_call_path_id,'
> +			'calls.parent_id'
>  		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
>  
>  do_query(query, 'CREATE VIEW samples_view AS '
> @@ -575,6 +577,7 @@ def trace_begin():
>  	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
>  	if perf_db_export_calls or perf_db_export_callchains:
>  		call_path_table(0, 0, 0, 0)
> +		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
>  
>  unhandled_count = 0
>  
> @@ -657,6 +660,7 @@ def trace_end():
>  					'ADD CONSTRAINT returnfk    FOREIGN KEY (return_id)    REFERENCES samples    (id),'
>  					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
>  		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
> +		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
>  
>  	if (unhandled_count):
>  		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
> @@ -728,7 +732,7 @@ def call_path_table(cp_id, parent_id, symbol_id, ip, *x):
>  	value = struct.pack(fmt, 4, 8, cp_id, 8, parent_id, 8, symbol_id, 8, ip)
>  	call_path_file.write(value)
>  
> -def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, *x):
> -	fmt = "!hiqiqiqiqiqiqiqiqiqiqii"
> -	value = struct.pack(fmt, 11, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags)
> +def call_return_table(cr_id, thread_id, comm_id, call_path_id, call_time, return_time, branch_count, call_id, return_id, parent_call_path_id, flags, parent_id, *x):
> +	fmt = "!hiqiqiqiqiqiqiqiqiqiqiiiq"
> +	value = struct.pack(fmt, 12, 8, cr_id, 8, thread_id, 8, comm_id, 8, call_path_id, 8, call_time, 8, return_time, 8, branch_count, 8, call_id, 8, return_id, 8, parent_call_path_id, 4, flags, 8, parent_id)
>  	call_file.write(value)
> -- 
> 2.17.1

-- 

- Arnaldo
