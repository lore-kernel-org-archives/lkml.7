Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B09BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00BD2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK4eE8D9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfJUNqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:46:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42539 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfJUNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:46:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id w14so21047194qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KsMgkVOfmmLlJCIDA1Q9ys97yl0kKqBswtLB0uarrZ0=;
        b=PK4eE8D9S/c/PrcX+YaNeZhzT9QPfc9LciZb4m1QvW32t9Y7JJPz7ww8brrT/C0rsB
         gbk8tuVzMZcac3nfi8hExP3fZTSXO2HcyGwULZ4VMgFhVJQuHJol04DQIB7TV8CuWKPI
         NksYu0xq4Vk+0caMsJjDQSWjK055AC4PYcOGFTYx9jm2sETg5KgEd8hD7oQHgS+hNXZF
         qzgY1et7R5o7xi5OQDnBvgqKpPlJX6Xb4FXnlL4LPEpswFYjjtx1bY6JE3QZ79+ZEkYQ
         PuESr5/tutu6CHexyfcsyVm4OJw1hy5K1mq8QFqiAzkBBSD5iXa1SZ592v4Ckt8SK2nJ
         LMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsMgkVOfmmLlJCIDA1Q9ys97yl0kKqBswtLB0uarrZ0=;
        b=adD0jvAJjvRC6GXT6v8dHqVm8EHXfbRSIEcUeFI0dhXSO5VkxhwoZVZGgLFEIakiIE
         IpwazmBQ+krqIiH86aZTOo4IKHaiWyqyRKhFyUjIHiQLXwC3upgqmMbSjjC/QQM87KMh
         8xV9tfjy01M/AvT7/B7XoPzTUwyhKrm5ou4JJuZj5c1ErwTiPL+l/e0A6I/yUihHQhMu
         U4FTEywg2BD8d29C8gCSaP5y25wMNxTqOAiek/5wl1hrenC1z7qWHECk6ke5rTxy/fxP
         ePuDTgxiV/0UPlSSZTKLhJa/QOHQkyViU/yRRePlaLngkcKjJt9W0RsqamxdaD52Kk/I
         p+tg==
X-Gm-Message-State: APjAAAUPZQqq1uZj41wP2zE4YUW8oYhw22tM/qUcBCOlfHUD2NpUKO3Z
        54jnzoCawDWFHavohhpocA0=
X-Google-Smtp-Source: APXvYqyF745M2pOc4vWu/qe6aRTWu8CNdlE2MApjb97jVkhRUwcAoBAB7WMl0kZk/KDV9OZqRbUPAw==
X-Received: by 2002:ac8:614a:: with SMTP id d10mr24341830qtm.250.1571665574067;
        Mon, 21 Oct 2019 06:46:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o13sm1431056qto.96.2019.10.21.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 06:46:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A855A4035B; Mon, 21 Oct 2019 10:46:11 -0300 (-03)
Date:   Mon, 21 Oct 2019 10:46:11 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf tools: Support single perf.data file directory
Message-ID: <20191021134611.GB10039@kernel.org>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-5-adrian.hunter@intel.com>
 <20191007112027.GD6919@krava>
 <2340d60c-e8a6-2333-06ce-77076c912a1c@intel.com>
 <a2853fa8-a2e8-8e17-132c-0d47b8129eff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2853fa8-a2e8-8e17-132c-0d47b8129eff@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 21, 2019 at 03:42:39PM +0300, Adrian Hunter escreveu:
> On 7/10/19 3:06 PM, Adrian Hunter wrote:
> > On 7/10/19 2:20 PM, Jiri Olsa wrote:
> >> On Fri, Oct 04, 2019 at 11:31:20AM +0300, Adrian Hunter wrote:
> >>
> >> SNIP
> >>
> >>>  	u8 pad[8] = {0};
> >>>  
> >>> -	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
> >>> +	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
> >>>  		off_t file_offset;
> >>>  		int fd = perf_data__fd(data);
> >>>  		int err;
> >>> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> >>> index df173f0bf654..964ea101dba6 100644
> >>> --- a/tools/perf/util/data.c
> >>> +++ b/tools/perf/util/data.c
> >>> @@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
> >>>  	DIR *dir;
> >>>  	int nr = 0;
> >>>  
> >>> +	/*
> >>> +	 * Directory containing a single regular perf data file which is already
> >>> +	 * open, means there is nothing more to do here.
> >>> +	 */
> >>> +	if (perf_data__is_single_file(data))
> >>> +		return 0;
> >>> +
> >>
> >> cool, I like this approach much more than the previous flag
> > 
> > Yes it is much nicer.  Thanks for your direction on that.
> > 
> >>
> >> any change you (if there's repost) or Arnaldo
> >> could squeeze in indent change below?
> > 
> > Sent a patch, to be applied before these.
> > 
> 
> That is:
> 
> "[PATCH] perf session: Fix indent in perf_session__new()"
> 
> Any comments on this patch set Arnaldo?

I'll take a look at it later, I think Jiri is ok with it already?

- Arnaldo
