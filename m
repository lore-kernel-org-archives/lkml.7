Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40121C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10092206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy6f+zUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKMMPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:15:20 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41727 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfKMMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:15:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id o3so2288135qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YXyTDHSg6OgdYMbOy53VYBj8wreM6uDoc+5p6fz5/5M=;
        b=cy6f+zUbS0ORo715saINOa66Q8gS1bflxSTiXk5oDos+obXWH5VE0n4t9UpoRWMeaG
         hJz6LyFVv7RoO3xlVD/38N36js7bAkG4jL7gVL6bwUfRtJSTIBlR5FE/yBcZg4kHknjP
         QBo8rbGPnvIgX5VmeoqyoFaDg9vOY1FI5iFKuMaxUJXX2l9CG7WJDl5q3SaTVJaFEdPV
         W8Y5K8+YiNvcLLv3Gr2XOddKeyiSfyGEP+2euChXtdENvRIPEKiR7A8yDKEXo0XFeV7t
         95pPSN14IZLmD5GVTzOTs3YGQpVm3uaQ+HdfMS4AUGj+mzPdm0FlkkEj2INMb8xNctO3
         OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXyTDHSg6OgdYMbOy53VYBj8wreM6uDoc+5p6fz5/5M=;
        b=M/vjSVmngKhT0clc2blmsXgNCqkGPd6aAMYnTls+CaEPba05d/1ps5/rdlrHgngsfD
         zj/Wi1QDMFLl6/FH3rBVTJuMBsFzLeRqbRWOttdQFKrrjlisR0+IBaBDDPNA+sUUoRNg
         uWsDLNPjQwmPQmAxeC9xZqcfiHUHLLpHmv9oGhX+kgaypIbeWJg77TMBw/2wBsWUyCSf
         yNjlwYZpiLECgt3UMRQrVz2/RtKvsdjVTGQofFowIoXrDzWfJXJDqM75gmM+yrpwDWCa
         n2QCtn4klXHWfM4qa48RqIXDo0mklUvq1ak7G7rjIkVeg39YSBZdCVaAXdNxMg1ELRdy
         nnug==
X-Gm-Message-State: APjAAAUwgwMp+EwtfhfvvB+ICW22soudgMrqVxIt0JTse5ngFPJoL6cS
        u4pzyNoinbOQLT4o1ldaxBZpAa/b4GU=
X-Google-Smtp-Source: APXvYqwz34LzK08XVeS4QktZR5WTmjBQNenXmGNnHl2Z1j6iYeM9e3QXNynWzlsgHo87RLJ0f1ntcw==
X-Received: by 2002:aed:3282:: with SMTP id z2mr2276532qtd.221.1573647318470;
        Wed, 13 Nov 2019 04:15:18 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 134sm380684qkn.24.2019.11.13.04.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 04:15:17 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B39EE40D3E; Wed, 13 Nov 2019 09:15:15 -0300 (-03)
Date:   Wed, 13 Nov 2019 09:15:15 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: exported-sql-viewer.py: Fix use of
 TRUE with SQLite
Message-ID: <20191113121515.GC14646@kernel.org>
References: <20191113120206.26957-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113120206.26957-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 13, 2019 at 02:02:06PM +0200, Adrian Hunter escreveu:
> Prior to version 3.23 SQLite does not support TRUE or FALSE, so always use
> 1 and 0 for SQLite.
> 
> Fixes: 26c11206f433 ("perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Thanks, applied and added the first tag with that fixed cset:

Cc: stable@vger.kernel.org # v5.3+

[acme@quaco perf]$ git tag --contains 26c11206f433 | grep ^v[3-9] | head
v5.3
v5.3-rc1
v5.3-rc2
v5.3-rc3
v5.3-rc4
v5.3-rc5
v5.3-rc6
v5.3-rc7
v5.3-rc8
v5.4-rc1
[acme@quaco perf]$

- Arnaldo

> ---
>  tools/perf/scripts/python/exported-sql-viewer.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index ebc6a2e5eae9..26d7be785288 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -637,7 +637,7 @@ class CallGraphRootItem(CallGraphLevelItemBase):
>  		self.query_done = True
>  		if_has_calls = ""
>  		if IsSelectable(glb.db, "comms", columns = "has_calls"):
> -			if_has_calls = " WHERE has_calls = TRUE"
> +			if_has_calls = " WHERE has_calls = " + glb.dbref.TRUE
>  		query = QSqlQuery(glb.db)
>  		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
>  		while query.next():
> @@ -918,7 +918,7 @@ class CallTreeRootItem(CallGraphLevelItemBase):
>  		self.query_done = True
>  		if_has_calls = ""
>  		if IsSelectable(glb.db, "comms", columns = "has_calls"):
> -			if_has_calls = " WHERE has_calls = TRUE"
> +			if_has_calls = " WHERE has_calls = " + glb.dbref.TRUE
>  		query = QSqlQuery(glb.db)
>  		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
>  		while query.next():
> @@ -1290,7 +1290,7 @@ class SwitchGraphData(GraphData):
>  		QueryExec(query, "SELECT id, c_time"
>  					" FROM comms"
>  					" WHERE c_thread_id = " + str(thread_id) +
> -					"   AND exec_flag = TRUE"
> +					"   AND exec_flag = " + self.collection.glb.dbref.TRUE +
>  					"   AND c_time >= " + str(start_time) +
>  					"   AND c_time <= " + str(end_time) +
>  					" ORDER BY c_time, id")
> @@ -5016,6 +5016,12 @@ class DBRef():
>  	def __init__(self, is_sqlite3, dbname):
>  		self.is_sqlite3 = is_sqlite3
>  		self.dbname = dbname
> +		self.TRUE = "TRUE"
> +		self.FALSE = "FALSE"
> +		# SQLite prior to version 3.23 does not support TRUE and FALSE
> +		if self.is_sqlite3:
> +			self.TRUE = "1"
> +			self.FALSE = "0"
>  
>  	def Open(self, connection_name):
>  		dbname = self.dbname
> -- 
> 2.17.1

-- 

- Arnaldo
