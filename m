Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC9ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D3B21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhfOYzof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503531AbfJQT2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:28:37 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45321 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436801AbfJQT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:28:37 -0400
Received: by mail-qt1-f172.google.com with SMTP id c21so5247776qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tK1v9bYMKo3whEtgKiY8+zOouzhqxmcJPQaP+EKutFo=;
        b=LhfOYzofpZClHW2OCGDvLTzToOKy2MtT+19GEsek1N/ALfMmdPHrZjmYclWHfghsro
         Elz/4LP43sJo/9WzB4qZTMTaTcheoZnf8/kldJtHJLtEDGbfkDoiuT1qRdn8NAFs8mau
         OJthmpwcewt21LBd3AiuakE03CqeLFQEN6CKHQpoYeefzHgDGA6xDpWWS5SfWPMe87Fb
         IFnlpqOZMmcwIxyQJhHTmgVBuf+VbLOjk7r41q1oY+MLqllwtVmljr1lK60Ld/iVmq20
         B7RPLdgD+SLykxmeVB59+8zKgkTfH+c0urhWtX887EQHc/daQF1qOXffWnllWheJiaSR
         6oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tK1v9bYMKo3whEtgKiY8+zOouzhqxmcJPQaP+EKutFo=;
        b=SZDS5c1nYhhL/kxUQ20TfOOoUJi7nufkCGM1AnytO51eobN/Wx5PA2JJEsWLIU4lWK
         9nZkPkQ+zirlhhaCQNhL0gO9PbTgzEtcr/360cvfQLgnYSX4I8tTapU/LSZ31i3dB2We
         zY2OVdU5hhnx7sPrHYwdiJG2vpTJSwuX9qNzHH6F1iZfFmBCZnhZjtR6/OxXzm6j2n2p
         GgESYgoMUozUxRM/LSzF5vZMPkKBUNtYi8o2jrpeO/w4/KKTnovN0cflh8rP1u1lAOSm
         f/ZwTKDhkCzrlmo3bbVFbm7CmjV1ngzqhfZmHhg3LVpcQm0RQ/LFJ9iIDskb4Wt7xuzP
         cOuA==
X-Gm-Message-State: APjAAAVAvOzRCb5uweEagFsLbzjd8YT15EBuf2eHDTr9tzG3amwI0raI
        JBjLtzb1xMZRkq2kAqzw5rY=
X-Google-Smtp-Source: APXvYqy855AfsM2j0sPU4Kw8rpPha73PXTS/pgm5x2JP8TDZnISK7Q9zCZbubwGtzbvKQ3HiQ9v8rA==
X-Received: by 2002:ad4:4348:: with SMTP id q8mr5801492qvs.68.1571340516264;
        Thu, 17 Oct 2019 12:28:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.211.77])
        by smtp.gmail.com with ESMTPSA id q64sm1750153qkb.32.2019.10.17.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:28:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D3D844DD66; Thu, 17 Oct 2019 16:28:32 -0300 (-03)
Date:   Thu, 17 Oct 2019 16:28:32 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017192832.GB3600@kernel.org>
References: <20191017154205.GC8974@kernel.org>
 <20191017143841.317b26b5@gandalf.local.home>
 <20191017144114.48e25298@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017144114.48e25298@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 02:41:14PM -0400, Steven Rostedt escreveu:
> On Thu, 17 Oct 2019 14:38:41 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> >  struct tep_event *trace_find_next_event(struct tep_handle *pevent,
> >  					struct tep_event *event)
> >  {
> > +	static struct tep_event **all_events;
> >  	static int idx;
> >  	int events_count;
> > -	struct tep_event *all_events;
> 
> If we are going to use static variables, let's make them all static and
> optimize it a little more...

I'll test it, but can't you have this somewhere else, i.e. at
tep_handle perhaps?

- Arnaldo
 
> -- Steve
> 
> diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> index ad74be1f0e42..3f23462517a3 100644
> --- a/tools/perf/util/trace-event-parse.c
> +++ b/tools/perf/util/trace-event-parse.c
> @@ -193,30 +193,35 @@ int parse_event_file(struct tep_handle *pevent,
>  struct tep_event *trace_find_next_event(struct tep_handle *pevent,
>  					struct tep_event *event)
>  {
> +	static struct tep_event **all_events;
> +	static int events_count;
>  	static int idx;
> -	int events_count;
> -	struct tep_event *all_events;
>  
> -	all_events = tep_get_first_event(pevent);
> -	events_count = tep_get_events_count(pevent);
> -	if (!pevent || !all_events || events_count < 1)
> +	if (!pevent || !all_events)
>  		return NULL;
>  
>  	if (!event) {
>  		idx = 0;
> -		return all_events;
> +		events_count = tep_get_events_count(pevent);
> +		if (events_count < 1)
> +			return NULL;
> +
> +		all_events = tep_list_events(pevent, TEP_EVENT_SORT_ID);
> +		if (all_events)
> +			return all_events[0];
> +		return NULL;
>  	}
>  
> -	if (idx < events_count && event == (all_events + idx)) {
> +	if (idx < events_count && event == all_events[idx]) {
>  		idx++;
>  		if (idx == events_count)
>  			return NULL;
> -		return (all_events + idx);
> +		return all_events[idx];
>  	}
>  
>  	for (idx = 1; idx < events_count; idx++) {
> -		if (event == (all_events + (idx - 1)))
> -			return (all_events + idx);
> +		if (event == all_events[idx - 1])
> +			return all_events[idx];
>  	}
>  	return NULL;
>  }

-- 

- Arnaldo
