Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34969C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ADA20828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tm3lWKag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfIERnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:43:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45238 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfIERnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:43:41 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so6603099iog.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rc/+YGfLUH9jkcuM4RyWN0/LC7MBLhEbb07n7jnHO2w=;
        b=tm3lWKagI89vD+eLi7AXE8oD+HI62AAnfaWnXsUq9NyLp5VlO2gP+7z0HI8FIMTtI6
         sKzk+mOcSfwqJbuyTG1BKDzHx4w5qzzjmNvzjjGGht2pEOPADoMAOobLKh+2Fso4bGF6
         LToEQee7VsrLi2YWLJ5FlwEzxZRSSkXwDJMuWf51o++bndrEm0NoZbMFkljKB5o+yYMe
         NPyWpU0Zn1CGHTGXE3PFhBlso3mA9QmaAiVF4zoiIGTaD4dHWxtX1T68njZ+N+HEPnM5
         MFIBf55iiiyOoB4fdquLw+XijgdWREOtGC1GD97Nt8kItvLcexGylq5cB+/8uvKqaPKx
         tKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rc/+YGfLUH9jkcuM4RyWN0/LC7MBLhEbb07n7jnHO2w=;
        b=dMHJbHqGYg8VlN8J9IA+WOJvk76rRNHd3Uos7q5m7N6XPDPYDLldS7FcERtDFRVLzX
         ORPLd67zGqBH87l7pJygvvk8YhVUIFduRUvJkG41adruIxDw6U5iSQa7blWgZg/PoZda
         4XQHuns6NTzfCxDTI0tCA8RmWlASSrS7R0cMS/ICZudt7XzpETwPh++qJiGpZIPqbp8Q
         NTRXPqcKWK1EtGT7evK92wfKHcAplUzbs2WX15rCMVLAEy5oMptM2AZxcOfGxim7p4A5
         3BYBOu8U+74nHP8eQw/1ia1EMs0M5Gijd8SbW1l2yOgkf2Wkq0F8N73ArDaIFssxqvWW
         kAHQ==
X-Gm-Message-State: APjAAAUAsReDXgWZ3pNia3Eo1k86+nMusLsmFAiWV/TxJ+f8MJY+Y5TT
        sfLBYSlRzxFZhq9jrf25vl58IzHQI0jGaG4/CiOemhQDXhE=
X-Google-Smtp-Source: APXvYqwhnxgpgM61no8/EsHbUjHOlH+IoePtyBgQYgqo09A3H0gvTrKuRdjYc0u2d24lPAWQr0rRZBdB9G1xOjZY9YU=
X-Received: by 2002:a6b:bc47:: with SMTP id m68mr5651748iof.70.1567705420697;
 Thu, 05 Sep 2019 10:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz> <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz> <20190904162808.GO240514@google.com>
 <20190905144310.GA14491@dhcp22.suse.cz> <CAJuCfpFve2v7d0LX20btk4kAjEpgJ4zeYQQSpqYsSo__CY68xw@mail.gmail.com>
 <20190905133507.783c6c61@oasis.local.home>
In-Reply-To: <20190905133507.783c6c61@oasis.local.home>
From:   Tim Murray <timmurray@google.com>
Date:   Thu, 5 Sep 2019 10:43:28 -0700
Message-ID: <CAEe=SxmG4oUBUu88NNyOhPC5weExf=UCzLy_pzwg3+CruqO4Cw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Sep 5, 2019 at 9:03 AM Suren Baghdasaryan <surenb@google.com> wrote:
> I might misunderstand this but is the issue here actually throttling
> of the sheer number of trace records or tracing large enough changes
> to RSS that user might care about? Small changes happen all the time
> but we are likely not interested in those. Surely we could postprocess
> the traces to extract changes large enough to be interesting but why
> capture uninteresting information in the first place? IOW the
> throttling here should be based not on the time between traces but on
> the amount of change of the traced signal. Maybe a generic facility
> like that would be a good idea?

You want two properties from the tracepoint:

- Small fluctuations in the value don't flood the trace buffer. If you
get a new trace event from a process every time kswapd reclaims a
single page from that process, you're going to need an enormous trace
buffer that will have significant side effects on overall system
performance.
- Any spike in memory consumption gets a trace event, regardless of
the duration of that spike. This tracepoint has been incredibly useful
in both understanding the causes of kswapd wakeups and
lowmemorykiller/lmkd kills and evaluating the impact of memory
management changes because it guarantees that any spike appears in the
trace output.

As a result, the RSS tracepoint in particular needs to be throttled
based on the delta of the value, not time. The very first prototype of
the patch emitted a trace event per RSS counter change, and IIRC the
RSS trace events consumed significantly more room in the buffer than
sched_switch (and Android has a lot of sched_switch events). It's not
practical to trace changes in RSS without throttling. If there's a
generic throttling approach that would work here, I'm all for it; like
Dan mentioned, there are many more counters that we would like to
trace in a similar way.
