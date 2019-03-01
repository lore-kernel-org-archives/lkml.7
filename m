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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5320857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRxGH8xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfCARw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:52:28 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42786 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfCARw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:52:27 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so14781272qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TNM7RlCJD4dz+UKPJ69MxHoZn1qJEAEdRDdt3icJc7w=;
        b=cRxGH8xaIFlwKcW2ck1vHa2CiLOD3x4n28Ue/I2bmvtp9y1C012AEPZjhcQsi4UXxx
         XncISWIEJ5Ynm6Uyl9Hd2JTP0lAFQRpHofYfotiI1piwBCP2peg1jgrDC959luFXZNJv
         SJLXXYt4CRKcdahNrlTTG4vQ7vj2uuBm68MMFic3JBoPzPWrmHfhJ+CEIzuOkTA98rfp
         LQN1NWyB6nr+18TYxWwACB8eh2ZhvlXh9WfEkIHZgU/AaA5fKDloN+zSi7ct6ZkABaVq
         erWDCT/fFBmvLN5sVeMkDQ6RUeqooQIS5121DFgvvcSS53eNnLI1FiGzZnmRKrswklCD
         aORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TNM7RlCJD4dz+UKPJ69MxHoZn1qJEAEdRDdt3icJc7w=;
        b=l59TYzD46VC07zJ3sTqWs184DV02X+zZIOnI5jbeyyE4HyRgMA/IDFF0FYraNbR/pv
         kTkLC6i0TbvIvphTL9cZnF0a8qB4Y7cC+xYw6nvos+uciNsfv9W2yvG45+QJ4KGjiket
         l8bYPbYcYHEqwmvyMIpVTKNSr+kiz8Y17lCUh2V5DXN76itPOzRURWoaJtSaxarR38f7
         lvV+efoQm1Hr5xT2ywFmd8/wMAoM7IsuNyjI9dw6gTyj73xoggMI6fM0piJHso3mWHzA
         By5oHZ/qTUjAqM2Qv8RkbI+XXqpiqygko2DoHFS4VR4cCocUfOYtfq+P2+Yzm/HLB0UU
         CYZw==
X-Gm-Message-State: APjAAAWi/AZCfcpOvULZZUsDCf5umsDsjSX7iXehBEEsVlj+vTA0kVtk
        rHz6stImuQ+y/g7jdEikXscN9kIWxEg=
X-Google-Smtp-Source: APXvYqxqgxrV8sTHCPToRHmQYFCoK1g3a/oVtmJxRQwWrsINsMl71+NxZ5jaTRH9B+HoWfvlICvZeA==
X-Received: by 2002:a37:4d57:: with SMTP id a84mr4744422qkb.35.1551462745687;
        Fri, 01 Mar 2019 09:52:25 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id i33sm16183338qti.74.2019.03.01.09.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:52:24 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AB534039C; Fri,  1 Mar 2019 14:52:21 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:52:21 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] perf scripts python: export-to-sqlite.py: Export
 calls parent_id
Message-ID: <20190301175221.GM13100@kernel.org>
References: <20190228130031.23064-1-adrian.hunter@intel.com>
 <20190228130031.23064-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228130031.23064-3-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 03:00:25PM +0200, Adrian Hunter escreveu:
> Export to the 'calls' table the newly created 'parent_id'.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/scripts/python/export-to-sqlite.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
> index ed237f2ed03f..eb63e6c7107f 100644
> --- a/tools/perf/scripts/python/export-to-sqlite.py
> +++ b/tools/perf/scripts/python/export-to-sqlite.py
> @@ -222,7 +222,8 @@ if perf_db_export_calls:
>  		'call_id	bigint,'
>  		'return_id	bigint,'
>  		'parent_call_path_id	bigint,'
> -		'flags		integer)')
> +		'flags		integer,'
> +		'parent_id	bigint)')
>  
>  # printf was added to sqlite in version 3.8.3
>  sqlite_has_printf = False
> @@ -321,7 +322,8 @@ if perf_db_export_calls:
>  			'call_id,'
>  			'return_id,'
>  			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
> -			'parent_call_path_id'
> +			'parent_call_path_id,'
> +			'parent_id'
>  		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
>  
>  do_query(query, 'CREATE VIEW samples_view AS '
> @@ -373,7 +375,7 @@ if perf_db_export_calls or perf_db_export_callchains:
>  	call_path_query.prepare("INSERT INTO call_paths VALUES (?, ?, ?, ?)")
>  if perf_db_export_calls:
>  	call_query = QSqlQuery(db)
> -	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
> +	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
>  
>  def trace_begin():
>  	print datetime.datetime.today(), "Writing records..."
> @@ -388,6 +390,7 @@ def trace_begin():
>  	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
>  	if perf_db_export_calls or perf_db_export_callchains:
>  		call_path_table(0, 0, 0, 0)
> +		call_return_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
>  
>  unhandled_count = 0
>  
> @@ -397,6 +400,7 @@ def trace_end():
>  	print datetime.datetime.today(), "Adding indexes"
>  	if perf_db_export_calls:
>  		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
> +		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
>  
>  	if (unhandled_count):
>  		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
> @@ -452,4 +456,4 @@ def call_path_table(*x):
>  	bind_exec(call_path_query, 4, x)
>  
>  def call_return_table(*x):
> -	bind_exec(call_query, 11, x)
> +	bind_exec(call_query, 12, x)
> -- 
> 2.17.1

-- 

- Arnaldo
