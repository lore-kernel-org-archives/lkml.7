Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE70C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C52067B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VDz8Kuxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391109AbfIERrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:47:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391023AbfIERrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:47:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id r12so2248052pfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L0yxMS8awoipeDwdf1A0RDx7mrx0qsFewJw5udlcjE0=;
        b=VDz8KuxxOFhSaup/dLZF8x5dBpItImu1WkBoxBRD6KvP8kAZ+So4Oo8WjfVj0eMWWq
         EyZA807Xzti8qe7xRQAVFIPxKpboqYtQFgwPPEAqCbgI1CmPlAvasSxI+qtqUisStn93
         SBQYyNqYhhOuJiPxyLP3AD/vRvXjNqwUlJRTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L0yxMS8awoipeDwdf1A0RDx7mrx0qsFewJw5udlcjE0=;
        b=lClPpFw0Tpr8WW09PXwvpIjGH8+NggGjx3iDRFQqcUAufd7hG97Nw2h10MSF/QWfbc
         hNaW4tt/vICFgh7OGlfmdE6Sml0NqM8nfh8PN+7OF5Z4zG9BuyooYozVmmAeZdvHFOot
         k4tsJ4de8Qo8qECfB33S/DSEx+eL5/OvsPwZKUTIShcyG/ZNyP0E1rMavj8a6HyOU0hD
         0vTBl+7RbgCd6Xr2mqIbsFC4eFgbLiPg3toTqLWCsQpWtWNubBklHL/+GU3TII9gnl2d
         9ehSXW63iK4eObVqLKrD7Kt9nR0VbNRT4CUebQ8TBgWIHfG1ku3D9aMQuF9e3rhfxPqa
         Z9aw==
X-Gm-Message-State: APjAAAWnD8DFSlO5w//wCh/oxuLCUzhxqqvB+UCuI4VAKTogKYi15iWv
        5MMLZsyRcQjsRXoXonsMW5yPcw==
X-Google-Smtp-Source: APXvYqxVIo7kRJdPE7HT3tpYs82K7ajzP2dzkrQYf56rpA+IdBv/GwtAGkegMDX93wa4zumv8i+ksw==
X-Received: by 2002:a62:2603:: with SMTP id m3mr5527620pfm.163.1567705627472;
        Thu, 05 Sep 2019 10:47:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t125sm4118861pfc.80.2019.09.05.10.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 10:47:06 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:47:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Daniel Colascione <dancol@google.com>,
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
Message-ID: <20190905174705.GA106117@google.com>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz>
 <20190904162808.GO240514@google.com>
 <20190905144310.GA14491@dhcp22.suse.cz>
 <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
 <20190905133507.783c6c61@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905133507.783c6c61@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 01:35:07PM -0400, Steven Rostedt wrote:
> 
> 
> [ Added Tom ]
> 
> On Thu, 5 Sep 2019 09:03:01 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > On Thu, Sep 5, 2019 at 7:43 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > [Add Steven]
> > >
> > > On Wed 04-09-19 12:28:08, Joel Fernandes wrote:  
> > > > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:  
> > > > >
> > > > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:  
> > > [...]  
> > > > > > but also for reducing
> > > > > > tracing noise. Flooding the traces makes it less useful for long traces and
> > > > > > post-processing of traces. IOW, the overhead reduction is a bonus.  
> > > > >
> > > > > This is not really anything special for this tracepoint though.
> > > > > Basically any tracepoint in a hot path is in the same situation and I do
> > > > > not see a point why each of them should really invent its own way to
> > > > > throttle. Maybe there is some way to do that in the tracing subsystem
> > > > > directly.  
> > > >
> > > > I am not sure if there is a way to do this easily. Add to that, the fact that
> > > > you still have to call into trace events. Why call into it at all, if you can
> > > > filter in advance and have a sane filtering default?
> > > >
> > > > The bigger improvement with the threshold is the number of trace records are
> > > > almost halved by using a threshold. The number of records went from 4.6K to
> > > > 2.6K.  
> > >
> > > Steven, would it be feasible to add a generic tracepoint throttling?  
> > 
> > I might misunderstand this but is the issue here actually throttling
> > of the sheer number of trace records or tracing large enough changes
> > to RSS that user might care about? Small changes happen all the time
> > but we are likely not interested in those. Surely we could postprocess
> > the traces to extract changes large enough to be interesting but why
> > capture uninteresting information in the first place? IOW the
> > throttling here should be based not on the time between traces but on
> > the amount of change of the traced signal. Maybe a generic facility
> > like that would be a good idea?
> 
> You mean like add a trigger (or filter) that only traces if a field has
> changed since the last time the trace was hit? Hmm, I think we could
> possibly do that. Perhaps even now with histogram triggers?


Hey Steve,

Something like an analog to digitial coversion function where you lose the
granularity of the signal depending on how much trace data:
https://www.globalspec.com/ImageRepository/LearnMore/20142/9ee38d1a85d37fa23f86a14d3a9776ff67b0ec0f3b.gif

so like, if you had a counter incrementing with values after the increments
as:  1,3,4,8,12,14,30 and say 5 is the threshold at which to emit a trace,
then you would get 1,8,12,30.

So I guess what is need is a way to reduce the quantiy of trace data this
way. For this usecase, the user mostly cares about spikes in the counter
changing that accurate values of the different points.

thanks,

 - Joel

