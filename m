Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146CECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ECA21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 19:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXbco3b/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440703AbfJQTvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:51:47 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:43965 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387813AbfJQTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 15:51:46 -0400
Received: by mail-qt1-f181.google.com with SMTP id t20so5368394qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nwb+TLGvaK5abbl4c2O/7USzkNsNwN9gnqMgo5pwQ7A=;
        b=TXbco3b/mPY+0lWIgFIOKODiAkRkW4s2OyVS9oVCx85mR0ouxw0YXVrvqSE5V9tGfB
         KpAi0KI1G9ogfHvML3vmxoYQKdhzkje7+WDpgQzBAEQR6WDL76DWY41wQZebckl4N+9K
         8effqyTjLyNPFvGxeORwRozecikvflrJ+mIA/KdKT61wKxQmpcB6s/VKS007iCet2M0m
         bOhYOhPM/NF3mcEehM5bA8MX/6h/lGxsiQQYMbbOIhq9Nj8a26EdzOJslqbBWnLrRvuJ
         6m5a7xFwlH65YomolsQ+O6Y/KkgPHLLLKcKeK/CV96UEl/O9tE7nNaVae6/2k450hRZf
         115g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nwb+TLGvaK5abbl4c2O/7USzkNsNwN9gnqMgo5pwQ7A=;
        b=GoNrdgeqWapidLaiB2KnAiuAXP4urJvX+AA10y8Els6ma1PUQ8djsaQbaQYRekpLjy
         iA0XDXut6loLTslq8zBwbWg+3B+eRul5LWTtNxVYaBH2/debZr06jOPm6p39UgOx5OVi
         pGhL5eFPTCGjB6KyZvJkfrfOW6MyvXZf1ruf7+XRudj3+RcDZ+W6jK6AeokNzmoKmjZ/
         7vvzvClE3RnejiK+anABlumCSdN98jHJH0ZOklqEmrwcM+cge81uBeGxK01Osp4O/hBs
         uncQ+00ON9q9228Hw9yIHsRY9zD2MG2XwJyagaYnZGs8FYfLRmm1NQHOElLez9UJn8jZ
         Akog==
X-Gm-Message-State: APjAAAX6WnegSUYtaLhCgc6/n8VBy9nbYt3qSXL8tNuRsw3iKXkEo4TS
        zDQcPjbU1gdd9f0ngcB2m+M=
X-Google-Smtp-Source: APXvYqwWP+JoNTwvarM+RIuNuh95kaaHRw1v880pgYlwH7Qyobqhkj7rJq6EVY6k48sSY+mmsIhNrw==
X-Received: by 2002:ac8:2ccc:: with SMTP id 12mr5922846qtx.49.1571341903800;
        Thu, 17 Oct 2019 12:51:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.211.77])
        by smtp.gmail.com with ESMTPSA id a190sm1924312qkf.118.2019.10.17.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:51:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B51B4DD66; Thu, 17 Oct 2019 16:51:40 -0300 (-03)
Date:   Thu, 17 Oct 2019 16:51:40 -0300
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] libtraceevent: perf script -g python segfaults
Message-ID: <20191017195140.GD3600@kernel.org>
References: <20191017154205.GC8974@kernel.org>
 <20191017143841.317b26b5@gandalf.local.home>
 <20191017144114.48e25298@gandalf.local.home>
 <20191017192832.GB3600@kernel.org>
 <20191017153733.630cd5eb@gandalf.local.home>
 <20191017194907.GC3600@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017194907.GC3600@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 04:49:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Oct 17, 2019 at 03:37:33PM -0400, Steven Rostedt escreveu:
> > On Thu, 17 Oct 2019 16:28:32 -0300
> > Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > > Em Thu, Oct 17, 2019 at 02:41:14PM -0400, Steven Rostedt escreveu:
> > > > On Thu, 17 Oct 2019 14:38:41 -0400
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >   
> > > > >  struct tep_event *trace_find_next_event(struct tep_handle *pevent,
> > > > >  					struct tep_event *event)
> > > > >  {
> > > > > +	static struct tep_event **all_events;
> > > > >  	static int idx;
> > > > >  	int events_count;
> > > > > -	struct tep_event *all_events;  
> > > > 
> > > > If we are going to use static variables, let's make them all static and
> > > > optimize it a little more...  
> > > 
> > > I'll test it, but can't you have this somewhere else, i.e. at
> > > tep_handle perhaps?
> > > 
> > >
> > 
> > Or we can nuke the function entirely, it's a rather silly helper
> > anyway. Just do this:
> 
> I like it, that is a good nuke use, nice button to press! :-)
> 
> Testing it now...

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Works like a charm, thanks!

- Arnaldo
