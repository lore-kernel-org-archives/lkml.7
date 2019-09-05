Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD7CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8337E2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIC37gy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbfIERjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:39:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39058 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfIERjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:39:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id q12so4080136wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHaIgZ+QyOTSQuPWv07Wdi8uuPiW8MfzbAABFbSnd3w=;
        b=HIC37gy16K0TPOUajtDzmEc5zZSn8ifcV0CdwZEt2UG2lAt1BDvAx2vslZsVJVs9ch
         YE3q79onfyftOBvNiJ9wSZLbRYg01lgsdj6JvQGP/bxsVqTC9DgPtE1RXmYViynnQBPd
         9xjzb5Z/rxvZdep6cgKBDS3876jQQz6xqTsOe7jbcPYdBcM9AIJJlAYnZHBGUw4MuX5K
         XwgHXQORth3+vMh0B5gQC5bopaOCzM/zRdRHfwLv2eGgYxixfNVWXCpgjyBBFaWA3OO2
         r0eSUbfDeZ6k8biG/IbGzkfPisoVtsFqk0+RazXoRzClIidmdbfFzSMZe5joiGjIa9KV
         x2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHaIgZ+QyOTSQuPWv07Wdi8uuPiW8MfzbAABFbSnd3w=;
        b=HS5YcuouJwy3oStyssYnyRs2VoL/faX+FWpmt0ASglXiAdH+PRettcJBIh9EPlzCPq
         TPrqKwNNYhY8kQADpbnMvi2WfrThvQinrUANDL5cV2ZDgdrx7Q5VL39ma6lpVKNh7hXD
         Q72PXh/2evxJeHMDELyGEqSeYqE0FEEHZnB3qLc18N/eoWEPhxO5S+6R/d2MMavAxz3x
         8l0wUG7597d5A/UcjraTxW9YTkHR9Iv36eAQhkIEzbRECU+AQMO2oygXq36j+UuBjRQ0
         45kTTBqianlAH5Eo58Z/NLCiLZLuCXIqGFxkgmaezJ+KUR/xC8hHFm1vxYvJANFllDPl
         LNhQ==
X-Gm-Message-State: APjAAAVMJHF6jNg496craEsEFeH8cpSKuLH5+uFZCtisPTgELMktU6vy
        wZNwhIxuNDzjIvFbOvp08pOm+xv6nX7wnTFMtjds8w==
X-Google-Smtp-Source: APXvYqwnk9SZLeXmt0DPPOvUyd0JD3bs5o/I4Q4Vf+1BPtPTSwu/Y4O3dmRg/1fFeKJx7zcWFuuR/SIyEVpqKh7SHf8=
X-Received: by 2002:a1c:f417:: with SMTP id z23mr1878827wma.77.1567705191475;
 Thu, 05 Sep 2019 10:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz> <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz> <20190904162808.GO240514@google.com>
 <20190905144310.GA14491@dhcp22.suse.cz> <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
 <20190905133507.783c6c61@oasis.local.home>
In-Reply-To: <20190905133507.783c6c61@oasis.local.home>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Sep 2019 10:39:40 -0700
Message-ID: <CAJuCfpH42yDwf8HzM-2Wt=sUQc3qhro2yXdRvQXEqengh0ZvNQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:35 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
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
> changed since the last time the trace was hit?

Almost... I mean emit a trace if a field has changed by more than X
amount since the last time the trace was hit.

> Hmm, I think we could
> possibly do that. Perhaps even now with histogram triggers?
>
> -- Steve
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
