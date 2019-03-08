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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F22C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9CE20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0I1LqZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfCHSiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:38:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37213 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCHSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:38:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so22318116qtb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YD4hLLJNzfkMMszmwe2C7MGgQqiEqyDhADhoNIFPY7w=;
        b=e0I1LqZnWOYyEou5qixt396x+T66hJsRRo//Wb9NrrQyv7DPF39PwAzQPyM5ORJeH2
         af2iPw8vdhSRRyJWewCHfWaJC5OJVXHHGxc0Iok9syBD1JyOuEhFiV5fgeIywmZQacLx
         oi6W/31mMnP5IRLp9Nk2+503YP0kW2rg9wfBwroT7BQcCyX6/sdp4NrPcDek54rQAEJZ
         RxCjmXGiUxaFbQ6rZkBe0XdkZ886dUZTcHKYjyby2cmVo2Ut4iAcokptVcCzK1Y8Uq8H
         hjNv/Nlu+eet2CyIFY8jjbPPrBq/0S5+Q9g7ySzI8cTZ829xoDkRodAPnSMnP+lK63GS
         uucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YD4hLLJNzfkMMszmwe2C7MGgQqiEqyDhADhoNIFPY7w=;
        b=CtHbgvHtu0+cP5Ez6nOzBiY4OqZ+Vd8zyYbGpXKT7BmjEJ6IhTOnY4WowwKnsN9kCb
         1J+J4QTNana6AK2//SuaVrTG87wJHZGyZmHDWKeKG2/kUJLHflbcXo9nViJioAuFn58o
         SmAQNvOeqrb7l0DdYrl+/gB6UtSu+xYTlVRZI1u9DmWGYkitIGtoQ4WC8+sy31U4KL66
         BSiKD2rXvnGv/SkTdunVeA6wJM0t89hyid3JLLK+VRjYKELm+IfMP6shWIMaqUfBQ3ME
         JsJ3cKyxe2Xs+CEFGafqce5CtMs8SyaXGo3e0E42UPnFQBA1F5NCpCA67qzdF1+YiEl9
         OViQ==
X-Gm-Message-State: APjAAAV4Lro4HmO4r2b7ifyzdS3Hv8dSi8gJhMtUPKi+06+MNReyIq9a
        siTFtzXj16wmfzRfvMXVAFp5pZE0YJo=
X-Google-Smtp-Source: APXvYqzQiJyz9KYovG5bI5vpc16zQl+spUvyYwtTji3RBC0x6ZEmcn8MgNqX5qIJtEnkhC0uIZHpLg==
X-Received: by 2002:aed:2515:: with SMTP id v21mr15782811qtc.191.1552070290131;
        Fri, 08 Mar 2019 10:38:10 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id p67sm4599524qkd.39.2019.03.08.10.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:38:08 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC2054039C; Fri,  8 Mar 2019 15:38:05 -0300 (-03)
Date:   Fri, 8 Mar 2019 15:38:05 -0300
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
Subject: Re: [PATCH 07/11] perf session: Add
 __perf_session__process_dir_events function
Message-ID: <20190308183805.GG10690@kernel.org>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308134745.5057-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 02:47:41PM +0100, Jiri Olsa escreveu:
> Adding __perf_session__process_dir_events function
> to process events over the directory data.
> 
> All directory events are pushed into sessions ordered
> data and flushed for processing.
> 
> Link: http://lkml.kernel.org/n/tip-n3zl0wo3z18tatv5x7epmjrh@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/session.c | 88 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0ec34227bd60..b55f4281b1da 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1876,8 +1876,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	file_offset = page_offset;
>  	head = rd->data_offset - page_offset;
>  
> -	ui_progress__init_size(prog, data_size, "Processing events...");
> -
>  	data_size += rd->data_offset;
>  
>  	mmap_size = MMAP_SIZE;
> @@ -2006,6 +2004,89 @@ static int __perf_session__process_events(struct perf_session *session)
>  	return err;
>  }
>  
> +static s64 process_index(struct perf_session *session,
> +			 union perf_event *event,
> +			 u64 file_offset)
> +{
> +	struct perf_evlist *evlist = session->evlist;
> +	u64 timestamp;
> +	s64 ret;
> +
> +	if (session->header.needs_swap)
> +		event_swap(event, perf_evlist__sample_id_all(evlist));
> +
> +	if (event->header.type >= PERF_RECORD_HEADER_MAX)
> +		return -EINVAL;
> +
> +	events_stats__inc(&evlist->stats, event->header.type);
> +
> +	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
> +		return perf_session__process_user_event(session, event, file_offset);
> +
> +	ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
> +	if (ret)
> +		return ret;
> +
> +	return ordered_events__queue(&session->ordered_events, event,
> +				     timestamp, file_offset);
> +}
> +
> +static int __perf_session__process_dir_events(struct perf_session *session)
> +{
> +	struct perf_data *data = session->data;
> +	struct perf_tool *tool = session->tool;
> +	struct reader rd = {
> +		.fd		= perf_data__fd(session->data),
> +		.data_size	= session->header.data_size,
> +		.data_offset	= session->header.data_offset,
> +		.process	= process_simple,
> +	};
> +	int i, ret = 0;
> +	struct ui_progress prog;
> +	u64 total_size = perf_data__size(session->data);
> +
> +	perf_tool__fill_defaults(tool);
> +
> +	ui_progress__init_size(&prog, total_size, "Processing events...");
> +
> +	/* Read data from the header file.. */
> +	ret = reader__process_events(&rd, session, &prog);
> +	if (ret)
> +		goto out_err;
> +
> +	/* ... and continue with data files. */
> +	for (i = 0; i < data->dir.nr ; i++) {
> +		struct perf_data_file *file = &data->dir.files[i];
> +
> +		if (file->size == 0)
> +			continue;
> +
> +		rd = (struct reader) {
> +			.fd		= file->fd,
> +			.data_size	= file->size,
> +			.data_offset	= 0,
> +			.process	= process_index,
> +		};
> +
> +		ret = reader__process_events(&rd, session, &prog);
> +		if (ret)
> +			goto out_err;

Don't we have to have some handling of PERF_RECORD_FINISHED_ROUND here?
I.e. what happens if we fill th ordered events with just the contents
of, say, the first CPU and then have those events flushed and processed
before we start even looking at the events in the other CPUs?

I think some detailed explanation of what happens here is in need, no?

- Arnaldo

> +	}
> +
> +	ret = ordered_events__flush(&session->ordered_events, OE_FLUSH__FINAL);
> +
> +out_err:
> +	if (!tool->no_warn)
> +		perf_session__warn_about_errors(session);
> +
> +	/*
> +	 * We may switching perf.data output, make ordered_events
> +	 * reusable.
> +	 */
> +	ordered_events__reinit(&session->ordered_events);
> +	return ret;
> +}
> +
>  int perf_session__process_events(struct perf_session *session)
>  {
>  	if (perf_session__register_idle_thread(session) < 0)
> @@ -2014,6 +2095,9 @@ int perf_session__process_events(struct perf_session *session)
>  	if (perf_data__is_pipe(session->data))
>  		return __perf_session__process_pipe_events(session);
>  
> +	if (perf_data__is_dir(session->data))
> +		return __perf_session__process_dir_events(session);
> +
>  	return __perf_session__process_events(session);
>  }
>  
> -- 
> 2.17.2

-- 

- Arnaldo
