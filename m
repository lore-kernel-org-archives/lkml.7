Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C5820833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxk9dQmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDIPBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:01:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46055 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDIPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:01:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so20069365qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KGCLS1/Mdh0CKtBo2RIDljEgFQe9uGR7+t/tNnMwvHI=;
        b=kxk9dQmZIPojrJl4f+dCYF6p1hMWVhfwa/97VrSuM2USSLxZjz6WtYehmvF/5ropby
         kNCQH/AEHnQTwKnn+4CUeJf6bA+VftpCMzii2CA4RKS6HuxmkgkS/w5Plj9vjISqraBB
         Wbxb8c7yu3DJKsNRiBWKLD708gydnAhSkOfEw7ZByualKz1jQzFbZxrlP09R5IwVYmTg
         8/fE5MWmjZilkKa96c3o0llx4ZMABMwlA7OoehEYAsVKTI8fD5ik5R/MACexnt8NuzC0
         nn63bQgooT0J0lyX5HVy9b6BzfSdnBjzIKRuH67FUWyvQ/x0ptvkGOE1Bm0VK2KLDWvF
         5TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGCLS1/Mdh0CKtBo2RIDljEgFQe9uGR7+t/tNnMwvHI=;
        b=jndiG7OkNmi0YH+YrUPI4BFK8FMZVW1JK2C2yic0WkWyinYAPppoPWPpjK0gOicek3
         4/IZMs+Rl/eguzHF66mvmVsQPybArLgWxf5Iz0IFr0TqEp/x/+74x8mDFEjTyXgb94M4
         Umf6vub5xtiLM5iWLN61IsHRV0I5LeQUj2SVuVUuSr7hT3VAT0H5LQQ/Fqn2FMJXNwtx
         zN316MamLXyTXEH1D7NisDghH7KECcFL1FBoMf49Q0gVrZvejAmmCAiAEE23N8ZWszUy
         SRHluqpIg18Ckp9O/vP6QAxG7CwhbW1b6gzww8EvxdnsSOQN9l7HolnQ2buUNJepDPow
         29hw==
X-Gm-Message-State: APjAAAXa/tUhwYeHA2Aty/SJHdDs1iBrH7q/z0Vh4g0GnV4LsvpFViOb
        Kx2DziQE5/ib3iwaecjDPmE=
X-Google-Smtp-Source: APXvYqyoPDQW3lUCcygasUk6/ghw/DUQoFWJc5g6xkgph7BHk9N0EeKrEx6iTvUufzRwf7MCHBueYw==
X-Received: by 2002:a0c:897b:: with SMTP id 56mr29395631qvq.55.1554822101737;
        Tue, 09 Apr 2019 08:01:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id g12sm18063260qkk.85.2019.04.09.08.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:01:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C4BCB4039C; Tue,  9 Apr 2019 12:01:38 -0300 (-03)
Date:   Tue, 9 Apr 2019 12:01:38 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: export-to-sqlite.py: Fix use of
 parent_id in calls_view
Message-ID: <20190409150138.GC31835@kernel.org>
References: <20190409062557.26138-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409062557.26138-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 09, 2019 at 09:25:57AM +0300, Adrian Hunter escreveu:
> Fix following error using calls_view:
>  Query failed: ambiguous column name: parent_id Unable to execute statement
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied, and thanks for the Fixes tag, appreciated,

- Arnaldo

> Fixes: 8ce9a7251d11 ("perf scripts python: export-to-sqlite.py: Export calls parent_id")
> ---
>  tools/perf/scripts/python/export-to-sqlite.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
> index 3b71902a5a21..bf271fbc3a88 100644
> --- a/tools/perf/scripts/python/export-to-sqlite.py
> +++ b/tools/perf/scripts/python/export-to-sqlite.py
> @@ -331,7 +331,7 @@ if perf_db_export_calls:
>  			'return_id,'
>  			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
>  			'parent_call_path_id,'
> -			'parent_id'
> +			'calls.parent_id'
>  		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
>  
>  do_query(query, 'CREATE VIEW samples_view AS '
> -- 
> 2.17.1

-- 

- Arnaldo
