Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3784C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712AF206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoH/vqG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKLLFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:05:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33854 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKLLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:05:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id 205so14043125qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1qAe80a/Aw51odzHBaIn/JKMcateknemSaOG5ZLUFg=;
        b=CoH/vqG+LxUWAJoiJWVgqhgH/opviPNBNWm5SBttWtXw2kpHLm9RcuZ2aC0fKyHmXv
         vj1U//vgv8Pj+WnzUP1yzBryFxDuLlEXIFxnVdcd5V5rQu6Ir5691Jr/bmW3fuf7/URz
         ZxrXYoTm8nici+4jiOi0n18IG0YHfp2l0eytxCQ6hX8cpw1v3NFE7tl2GA5xqTHh8aIL
         xoQN9iJUzKolU9vUryJftPB25eHKdMRFhtOnr9Rb8A8QwDCjRxWa2Y30+ryy/Nqo/z/b
         kBXWMyyBcdPS5vNxGiFXuumzeesaJ5k8LRgFWYWlGc5Ltp6abBroFxbXx43mXn+Ui9B5
         D12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1qAe80a/Aw51odzHBaIn/JKMcateknemSaOG5ZLUFg=;
        b=BLQ1FBe7WkERanNhvFAmN3h9UB4vGwyVwOedYXf08ETdducT/SSaacK7J8oxR/gwWY
         r2Zfn0viVMcytoB5eljJN9OoW4dWomDlpg3/8lUad1hw9pOOdPHcTBKegmSaMjizlSSS
         uckNP8+xjRy4HwYW/o3wN2aQHn1799JoUgvOm7G2E4ZvxbrNPu4ZsfTHLs3TbLLK/jA5
         OLEFO01M1HkC/c9wzsSjXmAYAGWAtNnyhSsT9C5ZWtaBrhJFCTieBhYE/WHaDi8e8iQA
         XUTrDHBZ7LJo3cM1BWoEvu/PFMlfVR4zn0J92WdHRgl0F3DKJGgpBdYOnqsynNzgxn8S
         vW+Q==
X-Gm-Message-State: APjAAAU21P7zp80UK6+G++/BKp4gsLHuNGZJy7+I7odXDfi5khjFIOk9
        ADU+LCCMxlPM0bOkvfrYSGA=
X-Google-Smtp-Source: APXvYqxkwz0X6ndgsu9+5eEErv1BFjStHc2HScG+XGY9Skxo3XGFy4TAAVjRT3lj2V+fIq2d7hU5tA==
X-Received: by 2002:a37:9d0:: with SMTP id 199mr14884770qkj.356.1573556709800;
        Tue, 12 Nov 2019 03:05:09 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.182.211.47])
        by smtp.gmail.com with ESMTPSA id n21sm12520160qtn.33.2019.11.12.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:05:09 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38F97411B3; Tue, 12 Nov 2019 08:05:06 -0300 (-03)
Date:   Tue, 12 Nov 2019 08:05:06 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, He Kuang <hekuang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: avoid reading out of scope array
Message-ID: <20191112110506.GI9365@kernel.org>
References: <20191017170531.171244-1-irogers@google.com>
 <20191023082912.GB22919@krava>
 <20191111142511.GF9365@kernel.org>
 <CAP-5=fUB-FddKaKOCYfU2Zu+AX88U9dFFmZ4Fdv146vKvQSr1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUB-FddKaKOCYfU2Zu+AX88U9dFFmZ4Fdv146vKvQSr1g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 11, 2019 at 12:34:23PM -0800, Ian Rogers escreveu:
> Thanks Arnaldo, this patch shouldn't be added. It was replaced with
> the longer v2 patch that addressed the memory issues properly. That
> was followed by a number of improved versions.

Thanks for checking,

- Arnaldo
 
> Ian
> 
> On Mon, Nov 11, 2019 at 6:25 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Wed, Oct 23, 2019 at 10:29:12AM +0200, Jiri Olsa escreveu:
> > > On Thu, Oct 17, 2019 at 10:05:31AM -0700, Ian Rogers wrote:
> > > > Modify tracepoint name into 2 sys components and assemble at use. This
> > > > avoids the sys_name array being out of scope at the point of use.
> > > > Bug caught with LLVM's address sanitizer with fuzz generated input of
> > > > ":cs\1" to parse_events.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/parse-events.y | 36 +++++++++++++++++++++++-----------
> > > >  1 file changed, 25 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > > index 48126ae4cd13..28be39a703c9 100644
> > > > --- a/tools/perf/util/parse-events.y
> > > > +++ b/tools/perf/util/parse-events.y
> > > > @@ -104,7 +104,8 @@ static void inc_group_count(struct list_head *list,
> > > >     struct list_head *head;
> > > >     struct parse_events_term *term;
> > > >     struct tracepoint_name {
> > > > -           char *sys;
> > > > +           char *sys1;
> > > > +           char *sys2;
> > > >             char *event;
> > > >     } tracepoint_name;
> > > >     struct parse_events_array array;
> > > > @@ -425,9 +426,19 @@ tracepoint_name opt_event_config
> > > >     if (error)
> > > >             error->idx = @1.first_column;
> > > >
> > > > -   if (parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
> > > > -                                   error, $2))
> > > > -           return -1;
> > > > +        if ($1.sys2) {
> > > > +           char sys_name[128];
> > > > +           snprintf(&sys_name, sizeof(sys_name), "%s-%s",
> > > > +                   $1.sys1, $1.sys2);
> > > > +           if (parse_events_add_tracepoint(list, &parse_state->idx,
> > > > +                                           sys_name, $1.event,
> > > > +                                           error, $2))
> > > > +                   return -1;
> > > > +        } else
> > > > +           if (parse_events_add_tracepoint(list, &parse_state->idx,
> > > > +                                           $1.sys1, $1.event,
> > > > +                                           error, $2))
> > > > +                   return -1;
> > >
> > > nice catch, please enclose all multiline condition legs with {}
> > >
> > > other than that
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Ian, this one isn't applying to my perf/core branch, can you please
> > address Jiri's comment and resubmit?
> >
> > - arnaldo

-- 

- Arnaldo
