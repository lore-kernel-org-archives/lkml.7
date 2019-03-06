Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A21A20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtbBLnn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfCFVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:14:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34426 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfCFVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:14:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id a15so7745678qkc.1;
        Wed, 06 Mar 2019 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6FzZwtkKGi82EwutdTnCMBrcinoMkS3faUusUIZQGWo=;
        b=TtbBLnn8J1lvwEtLFWmVglJuusQTsOy82OCH/4rfkBM9NYGPm74EyPyUGGjqRnTg0D
         QhVXuRNIxzJV2koa8VKXvf+ASw3NMXMSxdxygVlN/LANmCGAplJfvTcC8zZvgzMKU2a+
         vDav+x2M5JjKFwSkW8Ze8Nk8hj5i0eruL4VnDDmT2Oe+Y7F9CJa99cBhSr4A7IFOsEZq
         a4JctA6AsYQBLX/voSdHLzUdxeMB3FiAygHrYpO4OuMBTP5WriNDHb0mKKEHq6omYjKp
         69Vg4bVYIHTYT54CK1zOR18B1+1ke+OI3TajpDgOpjKyWZyUNd3qcfeWaBgyArtwU2EC
         usiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6FzZwtkKGi82EwutdTnCMBrcinoMkS3faUusUIZQGWo=;
        b=KgvoeBGz3tJr7qItxRmsXG0CxjJ6AkfUZ1NzEtsw7PfMfDIkvLJ6zjxRnmoN7RhvPN
         eGCtNvSpAKKKy6mnV8zkMqkJM+XEzVsFq81J2GINLpVFfTRpwezo+X3ao1/iB6q6S1vw
         s+OQlkY7+IlEZBH6PdjR3qCkX0sFDPzeINfcxCIo2ojHaqyglmLuhcBw2Qn3wnUx2rih
         WPbEZZwU1DZPfPu0vsMTzr/Ie7bi43lm42i1HN+MYXaC95kuGjqRnFlEvLmQ6Nj2gU6k
         NZW9C68CoY9aGzyJTmptjAw9v6UUX0jZIxwgjS1c6kv1bYJ0k+N+3CApO8YCXP9vFkKk
         wMSw==
X-Gm-Message-State: APjAAAUGyqlNdTCkU3mzDhvbj8mitNIgyKK7HzcKEwIhmoq1fLcFT6wJ
        VSZeKzHjo0nG/PLp7+uAc9BCAcc5
X-Google-Smtp-Source: APXvYqyGfH2KA4tCzAgicNdIlmMD0S3tBCXzotYIMWZfCQaS3pYbdf367uqS07tBVbKrolUwqOWowg==
X-Received: by 2002:a05:620a:12b3:: with SMTP id x19mr7289267qki.204.1551906841972;
        Wed, 06 Mar 2019 13:14:01 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j9sm1305636qtb.30.2019.03.06.13.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:14:01 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C5CF4039C; Wed,  6 Mar 2019 18:13:59 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:13:59 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 7/7] perf script python: add printdate function to SQL
 exporters
Message-ID: <20190306211359.GR30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-8-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-8-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 05:19:03PM -0800, Tony Jones escreveu:
> Introduce a printdate function to eliminate the repetitive use of
> datetime.datetime.today() in the SQL exporting scripts.

Seems easy enough, but since Adrian provided the Acked-by to the other
patch, can this be done this time again?

Thanks,

- Arnaldo
 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/scripts/python/export-to-postgresql.py | 19 +++++++++++--------
>  tools/perf/scripts/python/export-to-sqlite.py     | 13 ++++++++-----
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> index 439bbbf1e036..515dc5506427 100644
> --- a/tools/perf/scripts/python/export-to-postgresql.py
> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> @@ -249,6 +249,9 @@ perf_db_export_callchains = False
>  def printerr(*args, **kw_args):
>  	print(*args, file=sys.stderr, **kw_args)
>  
> +def printdate(*args, **kw_args):
> +        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
> +
>  def usage():
>  	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
>  	printerr("where:	columns		'all' or 'branches'")
> @@ -287,7 +290,7 @@ def do_query(q, s):
>  		return
>  	raise Exception("Query failed: " + q.lastError().text())
>  
> -print(datetime.datetime.today(), "Creating database...")
> +printdate("Creating database...")
>  
>  db = QSqlDatabase.addDatabase('QPSQL')
>  query = QSqlQuery(db)
> @@ -580,7 +583,7 @@ if perf_db_export_calls:
>  	call_file		= open_output_file("call_table.bin")
>  
>  def trace_begin():
> -	print(datetime.datetime.today(), "Writing to intermediate files...")
> +	printdate("Writing to intermediate files...")
>  	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
>  	evsel_table(0, "unknown")
>  	machine_table(0, 0, "unknown")
> @@ -596,7 +599,7 @@ def trace_begin():
>  unhandled_count = 0
>  
>  def trace_end():
> -	print(datetime.datetime.today(), "Copying to database...")
> +	printdate("Copying to database...")
>  	copy_output_file(evsel_file,		"selected_events")
>  	copy_output_file(machine_file,		"machines")
>  	copy_output_file(thread_file,		"threads")
> @@ -611,7 +614,7 @@ def trace_end():
>  	if perf_db_export_calls:
>  		copy_output_file(call_file,		"calls")
>  
> -	print(datetime.datetime.today(), "Removing intermediate files...")
> +	printdate("Removing intermediate files...")
>  	remove_output_file(evsel_file)
>  	remove_output_file(machine_file)
>  	remove_output_file(thread_file)
> @@ -626,7 +629,7 @@ def trace_end():
>  	if perf_db_export_calls:
>  		remove_output_file(call_file)
>  	os.rmdir(output_dir_name)
> -	print(datetime.datetime.today(), "Adding primary keys")
> +	printdate("Adding primary keys")
>  	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
>  	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
>  	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
> @@ -641,7 +644,7 @@ def trace_end():
>  	if perf_db_export_calls:
>  		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
>  
> -	print(datetime.datetime.today(), "Adding foreign keys")
> +	printdate("Adding foreign keys")
>  	do_query(query, 'ALTER TABLE threads '
>  					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
>  					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
> @@ -677,8 +680,8 @@ def trace_end():
>  		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
>  
>  	if (unhandled_count):
> -		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
> -	print(datetime.datetime.today(), "Done")
> +		printdate("Warning: ", unhandled_count, " unhandled events")
> +	printdate("Done")
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
>  	global unhandled_count
> diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
> index 3da338243aed..3b71902a5a21 100644
> --- a/tools/perf/scripts/python/export-to-sqlite.py
> +++ b/tools/perf/scripts/python/export-to-sqlite.py
> @@ -65,6 +65,9 @@ perf_db_export_callchains = False
>  def printerr(*args, **keyword_args):
>  	print(*args, file=sys.stderr, **keyword_args)
>  
> +def printdate(*args, **kw_args):
> +        print(datetime.datetime.today(), *args, sep=' ', **kw_args)
> +
>  def usage():
>  	printerr("Usage is: export-to-sqlite.py <database name> [<columns>] [<calls>] [<callchains>]");
>  	printerr("where:	columns		'all' or 'branches'");
> @@ -105,7 +108,7 @@ def do_query_(q):
>  		return
>  	raise Exception("Query failed: " + q.lastError().text())
>  
> -print(datetime.datetime.today(), "Creating database ...")
> +printdate("Creating database ...")
>  
>  db_exists = False
>  try:
> @@ -383,7 +386,7 @@ if perf_db_export_calls:
>  	call_query.prepare("INSERT INTO calls VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")
>  
>  def trace_begin():
> -	print(datetime.datetime.today(), "Writing records...")
> +	printdate("Writing records...")
>  	do_query(query, 'BEGIN TRANSACTION')
>  	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
>  	evsel_table(0, "unknown")
> @@ -402,14 +405,14 @@ unhandled_count = 0
>  def trace_end():
>  	do_query(query, 'END TRANSACTION')
>  
> -	print(datetime.datetime.today(), "Adding indexes")
> +	printdate("Adding indexes")
>  	if perf_db_export_calls:
>  		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
>  		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
>  
>  	if (unhandled_count):
> -		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
> -	print(datetime.datetime.today(), "Done")
> +		printdate("Warning: ", unhandled_count, " unhandled events")
> +	printdate("Done")
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
>  	global unhandled_count
> -- 
> 2.16.4

-- 

- Arnaldo
