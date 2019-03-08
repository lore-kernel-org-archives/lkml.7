Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A324820851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAur1/pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCHR0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:26:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38816 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfCHR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:26:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id s1so22058482qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 09:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcGHyoSBkDlaHDjX3n8fFCusOFhph1UT3j5e0gXUhWo=;
        b=AAur1/pDo5ZiD6QJZxCGOnHx+TkMsiRd6K9OyLnMU8FW2+vUc22FBlDXTAqwZa/gsU
         DNv26iVirzVdcDvQ6TUsw+RSEIPwJWPyZ4wuqLvXNlSp+7ZzRUgCw3i425zPRY/KikyD
         nMdIWOWecXWvV+YbbMEau7AEcHN2wPe5CodQ6zlZEie/S0Xd7Zdosvz7/bKwI4sWb3ov
         Debg/kSB9mQE7vGePIwnbjGhYoOAGKsrL2NJAOydAzk1l2Nr9TdNpIW8DxmQT3QhUpBX
         bbThrTrgtY2M5WBvX9iLBn5uNsJuKfF7hTY47ge0ufK513tMtts1ZiI2tKD7Jp9efO9h
         PCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcGHyoSBkDlaHDjX3n8fFCusOFhph1UT3j5e0gXUhWo=;
        b=K7n0t66kSSAL7/BXH79MKDl5wN5b7HxHYpoe2BGB+mXqEsGcXLp7AVOgSmxEIWxHm2
         J2XyjoEyhWg8JmfOrMmXDygIMb5IGuE+YX49TgoKp745eLfPAwcfdRw8+ZZWL08mT+md
         uy1t24vlyL/tno6sXgok4Y7MHnzDw4O3J87Ii2eK76NU75Ies7b3A8++aqzXB7oDpflY
         YsKXFIfromU1M+jGhDJ/SlymX421y2xPle01A24IZ7jxGNrjf5lPpuJfB9RZ9+zVr5ko
         uzuf1FMx6XU17B+lhpbYcbfqI5z2Zqt/gk0QrOBZreK77gPngKkRsGQ51Ign7zyCxhJT
         s9NQ==
X-Gm-Message-State: APjAAAX9XVgUrnI+WG1eF5Kuj9sCsyqpFeLQBXOrX5tS0bSAXBZlEqcd
        8gz313jWR+fCY+ssrrmmf8E=
X-Google-Smtp-Source: APXvYqxY8Pc1W7VeQPQ44hlhAnE20joSx+cbD5PslbU019EpG01Q/JRvK2/Eevk3Jr+tOLDeLPIv+A==
X-Received: by 2002:a0c:b88d:: with SMTP id y13mr15862895qvf.202.1552065999147;
        Fri, 08 Mar 2019 09:26:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t20sm5075509qtb.58.2019.03.08.09.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 09:26:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 992564039C; Fri,  8 Mar 2019 14:26:22 -0300 (-03)
Date:   Fri, 8 Mar 2019 14:26:22 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 01/11] perf data: Add directory support
Message-ID: <20190308172622.GD10690@kernel.org>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308134745.5057-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 02:47:35PM +0100, Jiri Olsa escreveu:
> Adding support to have directory as perf.data.
> 
> The caller needs to set 'struct perf_data::is_dir flag
> and the path will be treated as directory.
> 
> The 'struct perf_data::file' is initialized and open
> as 'path/header' file.
> 
> Adding check to direcory interface functions to check
> on is_dir flag.
> 
> Link: http://lkml.kernel.org/n/tip-pvot1aywiem9epgqpfi1agaj@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/data.c    | 49 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/data.h    |  6 +++++
>  tools/perf/util/session.c |  4 ++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index e098e189f93e..e28fd0fde5e0 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -34,6 +34,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  	struct perf_data_file *files = NULL;
>  	int i, ret = -1;
>  
> +	if (WARN_ON(!data->is_dir))
> +		return -EINVAL;
> +
>  	files = zalloc(nr * sizeof(*files));
>  	if (!files)
>  		return -ENOMEM;
> @@ -69,6 +72,9 @@ int perf_data__open_dir(struct perf_data *data)
>  	DIR *dir;
>  	int nr = 0;
>  
> +	if (WARN_ON(!data->is_dir))
> +		return -EINVAL;
> +
>  	dir = opendir(data->path);
>  	if (!dir)
>  		return -EINVAL;
> @@ -173,6 +179,16 @@ static int check_backup(struct perf_data *data)
>  	return 0;
>  }
>  
> +static bool is_dir(struct perf_data *data)
> +{
> +	struct stat st;
> +
> +	if (stat(data->path, &st))
> +		return false;
> +
> +	return (st.st_mode & S_IFMT) == S_IFDIR;
> +}
> +
>  static int open_file_read(struct perf_data *data)
>  {
>  	struct stat st;
> @@ -254,6 +270,30 @@ static int open_file_dup(struct perf_data *data)
>  	return open_file(data);
>  }
>  
> +static int open_dir(struct perf_data *data)
> +{
> +	int ret;
> +
> +	/*
> +	 * So far we open only the header, so we
> +	 * can read the data version and layout.
> +	 */
> +	if (asprintf(&data->file.path, "%s/header", data->path) < 0)
> +		return -ENOMEM;
> +
> +	if (perf_data__is_write(data) &&
> +	    mkdir(data->path, S_IRWXU) < 0)
> +		return -1;

Please be consistent, either -ESOMETHING or -1, I think returning -1 and
letting the caller look at errno should be enough, as asprintf() returns
straight away if the malloc it does fail, leaving errno set to ENOMEM.

I'm doing this change here.

> +
> +	ret = open_file(data);
> +
> +	/* Cleanup whatever we managed to create so far. */
> +	if (ret && perf_data__is_write(data))
> +		rm_rf_perf_data(data->path);
> +
> +	return ret;
> +}
> +
>  int perf_data__open(struct perf_data *data)
>  {
>  	if (check_pipe(data))
> @@ -265,11 +305,18 @@ int perf_data__open(struct perf_data *data)
>  	if (check_backup(data))
>  		return -1;
>  
> -	return open_file_dup(data);
> +	if (perf_data__is_read(data))
> +		data->is_dir = is_dir(data);
> +
> +	return perf_data__is_dir(data) ?
> +	       open_dir(data) : open_file_dup(data);
>  }
>  
>  void perf_data__close(struct perf_data *data)
>  {
> +	if (perf_data__is_dir(data))
> +		perf_data__close_dir(data);
> +
>  	zfree(&data->file.path);
>  	close(data->file.fd);
>  }
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index 14b47be2bd69..06aefeda311f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -19,6 +19,7 @@ struct perf_data {
>  	const char		*path;
>  	struct perf_data_file	 file;
>  	bool			 is_pipe;
> +	bool			 is_dir;
>  	bool			 force;
>  	enum perf_data_mode	 mode;
>  
> @@ -43,6 +44,11 @@ static inline int perf_data__is_pipe(struct perf_data *data)
>  	return data->is_pipe;
>  }
>  
> +static inline bool perf_data__is_dir(struct perf_data *data)
> +{
> +	return data->is_dir;
> +}
> +
>  static inline int perf_data__fd(struct perf_data *data)
>  {
>  	return data->file.fd;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index db643f3c2b95..de777bdc0ed3 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -152,6 +152,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
>  			}
>  
>  			perf_evlist__init_trace_event_sample_raw(session->evlist);
> +
> +			/* Open the directory data. */
> +			if (data->is_dir && perf_data__open_dir(data))
> +				goto out_delete;
>  		}
>  	} else  {
>  		session->machines.host.env = &perf_env;
> -- 
> 2.17.2

-- 

- Arnaldo
