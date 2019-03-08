Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0480C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A812085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgEz4Ng9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfCHSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:25:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39153 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:25:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id i14so180964qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9ZUurLKrsIUxaUYaVPpPE0VafdzlzaQCOROaotSdAo=;
        b=QgEz4Ng9p0FYmL8Eopn4Ym6Pd+HOQozC3G9Hr4rU+E+fxVbQkZ+HIwUVoKF5GZMtML
         9iYC/4oIXNcHd8PzNptsDk6wNPMV8GSLHK7HbHSSc6oM+jrPmm8z9FM9fpD+eqokIKm0
         BeGZHkzu4nSfu5qAJJcazZmPSBbtFWzlPLlB+20Zz9ZmmOSw+UZQuMK52sHwlSO4W+pU
         vfRkGKLKNvyLDAqYmjvzs2uDrYY+i4vbXGsBNNoL7XUQifX+PEOlDwJ4BW770u+7IqmM
         TwWzmA0ED5j285tP1+Tt3vpYjt8iknaG3vPXRRnMGF1TtyPkRMrQC40vQOr/xfdTl6gC
         NWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9ZUurLKrsIUxaUYaVPpPE0VafdzlzaQCOROaotSdAo=;
        b=UuRcYTbAR7ZY80mQ/YDkGVO8ijVBoVGA0LeOihcvotHb7jsi/yEjBZzWh/rM2c+xUL
         xz0CpzuakDr88ktXC+fkgbYhWr4BC89+/wdXTme0T97z7Odzip+Mo6/usykS0p18j3kP
         PpAPdf96kreV7erTvsacFPARUqbLIODFdA6rtDy9dusG+96SqpoEYZUb5ZZrTvrpLMX8
         c7Y0l12FVIx7icWbI1L+1fof+/BxZ2OG6XlokbiRWsDelRaMWZo5OaUFToy925rguCm4
         QidAwTcL5VpWtbtynKYFaH2uwto+G7gEuUdR6VBMwcYyD9H8Px12NlmDA+SDThFDK5yD
         55Dg==
X-Gm-Message-State: APjAAAXdoUfpElN8BhP1KmUGlP6f5M0BHYmHu4ouA7k5sqWXNQj3fNRj
        +ZMp6hpaDa6UvtL+ZOs1C6E=
X-Google-Smtp-Source: APXvYqwF1vX/OgrZDKXgNTEBdObqXhV7Oic+KpTR+2PKl/zce9nCsbxcTkmXP49oQTV7UbXeQQfsig==
X-Received: by 2002:ac8:3481:: with SMTP id w1mr16287599qtb.224.1552069513415;
        Fri, 08 Mar 2019 10:25:13 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id o26sm4307961qkk.51.2019.03.08.10.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:25:11 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B79F4039C; Fri,  8 Mar 2019 15:24:35 -0300 (-03)
Date:   Fri, 8 Mar 2019 15:24:35 -0300
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
Subject: Re: [PATCH 05/11] perf header: Add DIR_FORMAT feature to describe
 directory data
Message-ID: <20190308182435.GF10690@kernel.org>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308134745.5057-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 02:47:39PM +0100, Jiri Olsa escreveu:
> The data files layout is described by HEADER_DIR_FORMAT
> feature.  Currently it holds only version number (1):
> 
>      uint64_t version;
> 
> The current version holds only version value (1) means
> that data files:
>   - follow the 'data.*' name format
>   - contain raw events data in standard perf format as
>     read from kernel (and need to be sorted)

and need to be sorted when multiple files are processed, right?

- Arnaldo
 
> Future versions are expected to describe different data
> files layout according to special needs.
> 
> Link: http://lkml.kernel.org/n/tip-6l53s3oabwr1r4n6wke21d8g@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-record.c |  2 ++
>  tools/perf/util/data.c      | 10 +++++++--
>  tools/perf/util/data.h      |  1 +
>  tools/perf/util/header.c    | 44 ++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.h    |  5 +++++
>  5 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e983c8d71a79..a468d882e74f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -837,6 +837,8 @@ static void record__init_features(struct record *rec)
>  	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
>  		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
>  
> +	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
> +
>  	perf_header__clear_feat(&session->header, HEADER_STAT);
>  }
>  
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 498c531e2cb9..41a9f478f0f0 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -14,6 +14,7 @@
>  #include "data.h"
>  #include "util.h"
>  #include "debug.h"
> +#include "header.h"
>  
>  static void close_dir(struct perf_data_file *files, int nr)
>  {
> @@ -41,8 +42,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
>  	if (!files)
>  		return -ENOMEM;
>  
> -	data->dir.files = files;
> -	data->dir.nr    = nr;
> +	data->dir.version = PERF_DIR_VERSION;
> +	data->dir.files   = files;
> +	data->dir.nr      = nr;
>  
>  	for (i = 0; i < nr; i++) {
>  		struct perf_data_file *file = &files[i];
> @@ -75,6 +77,10 @@ int perf_data__open_dir(struct perf_data *data)
>  	if (WARN_ON(!data->is_dir))
>  		return -EINVAL;
>  
> +	/* The version is provided by DIR_FORMAT feature. */
> +	if (WARN_ON(data->dir.version != PERF_DIR_VERSION))
> +		return -1;
> +
>  	dir = opendir(data->path);
>  	if (!dir)
>  		return -EINVAL;
> diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
> index d342469bdfda..6aef8746469f 100644
> --- a/tools/perf/util/data.h
> +++ b/tools/perf/util/data.h
> @@ -24,6 +24,7 @@ struct perf_data {
>  	enum perf_data_mode	 mode;
>  
>  	struct {
> +		u64			 version;
>  		struct perf_data_file	*files;
>  		int			 nr;
>  	} dir;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 01b324c275b9..b0683bf4d9f3 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -861,6 +861,21 @@ static int write_clockid(struct feat_fd *ff,
>  			sizeof(ff->ph->env.clockid_res_ns));
>  }
>  
> +static int write_dir_format(struct feat_fd *ff,
> +			    struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_session *session;
> +	struct perf_data *data;
> +
> +	session = container_of(ff->ph, struct perf_session, header);
> +	data = session->data;
> +
> +	if (WARN_ON(!perf_data__is_dir(data)))
> +		return -1;
> +
> +	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
> +}
> +
>  static int cpu_cache_level__sort(const void *a, const void *b)
>  {
>  	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
> @@ -1341,6 +1356,17 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
>  		ff->ph->env.clockid_res_ns * 1000);
>  }
>  
> +static void print_dir_format(struct feat_fd *ff, FILE *fp)
> +{
> +	struct perf_session *session;
> +	struct perf_data *data;
> +
> +	session = container_of(ff->ph, struct perf_session, header);
> +	data = session->data;
> +
> +	fprintf(fp, "# directory data version : %"PRIu64"\n", data->dir.version);
> +}
> +
>  static void free_event_desc(struct perf_evsel *events)
>  {
>  	struct perf_evsel *evsel;
> @@ -2373,6 +2399,21 @@ static int process_clockid(struct feat_fd *ff,
>  	return 0;
>  }
>  
> +static int process_dir_format(struct feat_fd *ff,
> +			      void *_data __maybe_unused)
> +{
> +	struct perf_session *session;
> +	struct perf_data *data;
> +
> +	session = container_of(ff->ph, struct perf_session, header);
> +	data = session->data;
> +
> +	if (WARN_ON(!perf_data__is_dir(data)))
> +		return -1;
> +
> +	return do_read_u64(ff, &data->dir.version);
> +}
> +
>  struct feature_ops {
>  	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
>  	void (*print)(struct feat_fd *ff, FILE *fp);
> @@ -2432,7 +2473,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPN(CACHE,		cache,		true),
>  	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
>  	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
> -	FEAT_OPR(CLOCKID,       clockid,        false)
> +	FEAT_OPR(CLOCKID,	clockid,	false),
> +	FEAT_OPN(DIR_FORMAT,	dir_format,	false)
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 0d553ddca0a3..6a231340238d 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -39,6 +39,7 @@ enum {
>  	HEADER_SAMPLE_TIME,
>  	HEADER_MEM_TOPOLOGY,
>  	HEADER_CLOCKID,
> +	HEADER_DIR_FORMAT,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> @@ -48,6 +49,10 @@ enum perf_header_version {
>  	PERF_HEADER_VERSION_2,
>  };
>  
> +enum perf_dir_version {
> +	PERF_DIR_VERSION	= 1,
> +};
> +
>  struct perf_file_section {
>  	u64 offset;
>  	u64 size;
> -- 
> 2.17.2

-- 

- Arnaldo
