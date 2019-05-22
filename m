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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A029521473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I43GncLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfEVNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:25:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43550 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfEVNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:24:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id z6so1407236qkl.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBm7CzoksUwyOFgIhlh2koB6RWJMt3y60LWutVLCKxc=;
        b=I43GncLOsLgZZ6Z1ceTPPeqMRHXX+uuAHOUdNgwg9ZyDkQxweuC+B0L7vn1B7kzrKd
         HvYuxpvaezwbXoF/gDivh3iaYlL9tJu2IFLJ5S2xJ/SxieX2R6nPGq3fEyO5RpHs5nFS
         BCOHkQZHlqd7XWOugTfU/EKqFAJ6PB7zpbAxOLsRpgmTczdbCJj1p1PWCRhTT1rgBYtH
         hE24D42VO7T679/WFvIvSJM8zc3CdYJ11RoYW4Y4QeKnENMVngI4NUX0c0eZf/neKOK6
         4ZmmU1gx5jly/IeqH9p6GBtmVQCKOjLdMlpQRSuSJPatoVvQ+OP7fnQ4RrARX8m4/Ghk
         nbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBm7CzoksUwyOFgIhlh2koB6RWJMt3y60LWutVLCKxc=;
        b=oZLuRRRZKA7bR0+bEQd4zST4a1OIV1nq4mrPebCnZpCPvpJ7hkrpOT+UuIv81fVQdw
         HuTxHHXbayRFWw92pRU7IX5A/1wtreQribyR1+Ud6YZz1KpvXNMTA2GR9Jrj4LjGbPNg
         3fdRdrXeVxeaj1i5/gkw1NUBaCxSy3CFuVEtoEe0KFWkJCBCN5/DB2KBfOaA8YXt5rL4
         CICeIARywvG3UoyCpNcUcFib0UL9SzIk0k7kOEOWlUtweUq2zXJfuxgI/IEs3KXDbsbw
         uFtPyw+8Y/qJL/Sx9DqJho5Vvrm1qTROC3MBJZFSBh+Wlxl/CX5FWX+wbVRcL478pBnR
         xhpA==
X-Gm-Message-State: APjAAAW6ce+etxrI1suFqCRURf7yU41kmv0k2vkLEiQA4dmI6o9ac5Sy
        VVGeU1UBzwCNTHYYY/F2lY4=
X-Google-Smtp-Source: APXvYqwaP+YaiqTZzXCKMt+W599TEAO/X6CAT7WEP5gJqWc91DYoxg7JjJevu0P4/Itqx/eONuRqXw==
X-Received: by 2002:ae9:ed45:: with SMTP id c66mr65795054qkg.86.1558531497138;
        Wed, 22 May 2019 06:24:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.65.94.38])
        by smtp.gmail.com with ESMTPSA id q10sm10938442qkm.12.2019.05.22.06.24.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 06:24:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7754C404A1; Wed, 22 May 2019 10:24:24 -0300 (-03)
Date:   Wed, 22 May 2019 10:24:24 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf top: Enable --namespaces option
Message-ID: <20190522132424.GD30271@kernel.org>
References: <20190522053250.207156-1-namhyung@kernel.org>
 <20190522053250.207156-4-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522053250.207156-4-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 22, 2019 at 02:32:50PM +0900, Namhyung Kim escreveu:
> Since perf record already have the option, let's have it for perf top
> as well.

I'm applying, but I wonder if this shouldn't be the default...

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-top.txt | 5 +++++
>  tools/perf/builtin-top.c              | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 44d89fb9c788..cfea87c6f38e 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -262,6 +262,11 @@ Default is to monitor all CPUS.
>  	The number of threads to run when synthesizing events for existing processes.
>  	By default, the number of threads equals to the number of online CPUs.
>  
> +--namespaces::
> +	Record events of type PERF_RECORD_NAMESPACES and display it with the
> +	'cgroup_id' sort key.
> +
> +
>  INTERACTIVE PROMPTING KEYS
>  --------------------------
>  
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 3648ef576996..6651377fd762 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1208,6 +1208,9 @@ static int __cmd_top(struct perf_top *top)
>  
>  	init_process_thread(top);
>  
> +	if (opts->record_namespaces)
> +		top->tool.namespace_events = true;
> +
>  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
>  						&top->session->machines.host,
>  						&top->record_opts);
> @@ -1500,6 +1503,8 @@ int cmd_top(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
>  			"number of thread to run event synthesize"),
> +	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
> +		    "Record namespaces events"),
>  	OPT_END()
>  	};
>  	struct perf_evlist *sb_evlist = NULL;
> -- 
> 2.21.0.1020.gf2820cf01a-goog

-- 

- Arnaldo
