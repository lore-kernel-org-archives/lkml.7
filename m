Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3168CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DFE207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wonuGwVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbfIFA7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:59:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34736 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387908AbfIFA7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:59:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so2265586plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TmV1LoZm0dueIxfpGTuco3s5i09fedqQ9LvJDU+DD/k=;
        b=wonuGwVVxxQX5ovy7PsPBul4VqqNeDjDgJgFjChMt5Z98RqN2M/WGL3JOHCCmm07Kt
         vE1Drt0ItxpPGb7Wt0GoncH4bfEtTL9oM28/hGMi23N/4+nYzKpof7lpKT4jLlQc0P7H
         6EoPsoCrNH4Ed4031JH2ZnYARGy89wZJYDCCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TmV1LoZm0dueIxfpGTuco3s5i09fedqQ9LvJDU+DD/k=;
        b=PoNzYoIAoih5XIKE1DDfosJ7477FwdlxuJ34vGuKNhK4zJwxhmfm1obSg3hOZy2Gqm
         3hH5ZVB8n9k8iitOXWq3I/lqfnieT6xj8fTMwMtQtFjgDYsfUy4bVTcGn+RxAZa+1WH3
         jF34uXucb81sLh4q24awXhTr0mkwzZBVlwcUpFZziLXh2plT4f0RYBPH+3w5kqD+9x5w
         A1UnrxhVu7k5i8ec4hZY/TQtuy/z4485BbzPy7I7LbCGAwS5Glwer5w0T5PVzoWN6pv4
         /MK8RTDaXEXIjn1MkQ/MCMkWh4msC03XN5hwcmAZWqA9i5PZB7N4VDiCwk8MdLm7xrD1
         vobQ==
X-Gm-Message-State: APjAAAVVNyyG9YlfnxI2zLvMvyWOg4TkXKER68beziqABP5+dfQDahIC
        uQGM6K2xo6JLW/eC3MtjVh9A5A==
X-Google-Smtp-Source: APXvYqzKnRKXTbSewo9g+sqatp0lpebbLQ+O5ZjVk6KyfUgoEx1mnZrToEnmEzWYMkrlV8PzqqfD7w==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr6800014plp.14.1567731546601;
        Thu, 05 Sep 2019 17:59:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i14sm4188593pfo.50.2019.09.05.17.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:59:05 -0700 (PDT)
Date:   Thu, 5 Sep 2019 20:59:04 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190906005904.GC224720@google.com>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz>
 <20190904162808.GO240514@google.com>
 <20190905144310.GA14491@dhcp22.suse.cz>
 <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
 <20190905133507.783c6c61@oasis.local.home>
 <CAKOZueuQpHDnk-3GrLdXH_N_5Z7FRSJu+cwKhHNMUyKRqvkzjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuQpHDnk-3GrLdXH_N_5Z7FRSJu+cwKhHNMUyKRqvkzjA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:50:27AM -0700, Daniel Colascione wrote:
> On Thu, Sep 5, 2019 at 10:35 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 5 Sep 2019 09:03:01 -0700
> > Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > On Thu, Sep 5, 2019 at 7:43 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > [Add Steven]
> > > >
> > > > On Wed 04-09-19 12:28:08, Joel Fernandes wrote:
> > > > > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
> > > > [...]
> > > > > > > but also for reducing
> > > > > > > tracing noise. Flooding the traces makes it less useful for long traces and
> > > > > > > post-processing of traces. IOW, the overhead reduction is a bonus.
> > > > > >
> > > > > > This is not really anything special for this tracepoint though.
> > > > > > Basically any tracepoint in a hot path is in the same situation and I do
> > > > > > not see a point why each of them should really invent its own way to
> > > > > > throttle. Maybe there is some way to do that in the tracing subsystem
> > > > > > directly.
> > > > >
> > > > > I am not sure if there is a way to do this easily. Add to that, the fact that
> > > > > you still have to call into trace events. Why call into it at all, if you can
> > > > > filter in advance and have a sane filtering default?
> > > > >
> > > > > The bigger improvement with the threshold is the number of trace records are
> > > > > almost halved by using a threshold. The number of records went from 4.6K to
> > > > > 2.6K.
> > > >
> > > > Steven, would it be feasible to add a generic tracepoint throttling?
> > >
> > > I might misunderstand this but is the issue here actually throttling
> > > of the sheer number of trace records or tracing large enough changes
> > > to RSS that user might care about? Small changes happen all the time
> > > but we are likely not interested in those. Surely we could postprocess
> > > the traces to extract changes large enough to be interesting but why
> > > capture uninteresting information in the first place? IOW the
> > > throttling here should be based not on the time between traces but on
> > > the amount of change of the traced signal. Maybe a generic facility
> > > like that would be a good idea?
> >
> > You mean like add a trigger (or filter) that only traces if a field has
> > changed since the last time the trace was hit? Hmm, I think we could
> > possibly do that. Perhaps even now with histogram triggers?
> 
> I was thinking along the same lines. The histogram subsystem seems
> like a very good fit here. Histogram triggers already let users talk
> about specific fields of trace events, aggregate them in configurable
> ways, and (importantly, IMHO) create synthetic new trace events that
> the kernel emits under configurable conditions.

Hmm, I think this tracing feature will be a good idea. But in order not to
gate this patch, can we agree on keeping a temporary threshold for this
patch? Once such idea is implemented in trace subsystem, then we can remove
the temporary filter.

As Tim said, we don't want our traces flooded and this is a very useful
tracepoint as proven in our internal usage at Android. The threshold filter
is just few lines of code.

thanks,

 - Joel

