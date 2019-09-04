Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912EFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EE22089F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqFGqfbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfIDFnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:43:32 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45538 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIDFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:43:31 -0400
Received: by mail-vs1-f67.google.com with SMTP id j25so12920303vsq.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 22:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnRNNgV0YhAL6zDufOYnxx16nsh9d1vYCiomDUcaQzQ=;
        b=RqFGqfbZDZiAsCUpWiNxYO5pmn2x9w0/Zvk8sQAl2V9qUSyuDZlgKa6QeoZU+D2pNv
         bs3KZ1L49lefsiL2PWQHlG/LpXLNTQQ+pmDWVRTsWxS8zrQLdZlGW0paddD74QYIKRJN
         aURn8PGPDYOMHm3g31y+5fkF3Uj6ZXYd8v4IHMXpfh2kjCm+dMX5XaKvVryFFOBsSyWl
         Qt7DNTBYRDB1beJ4wYqZIIYEL44JTc2fuja8HsD/z6eEBnX3CtkHd058k0AyPf8AgyOi
         YCLaXcWiDZ3psUkjYa3D5Nm+krvlWmvf1O1f0YEda0pyMgxZOPKkhwLc+5lKomde3HFS
         08YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnRNNgV0YhAL6zDufOYnxx16nsh9d1vYCiomDUcaQzQ=;
        b=AfpqDy7pnYCHueqJel4QQAbVjdjeMwHQP3xjlPc9+KTVefC6m57v/IncVqCbrFIJUy
         aS2yaaFPw/hyrVuUfj9HUMPlblpNAS25q8URpb6eR6RwsQQ6F1qOERqTw45fA8qM/H1S
         1jV4M+Df5D6/S2rDKUQGHJsQab9LlZGzeztAA9sjA8ufNBPlXCO+3FRaOVSeRG1fawAX
         wBxNI+p3VPvNFKyb2cCDxoc/N8XL/bvSdYs5Ct5eJllYM26d1l418WqOngnES6KqIgJ3
         N2S7b+jr+hInykqFWO/aF9ZO4nHV5TBOnmjZLij/YK1rieJm6MYJZ+wpmoKgPLIgeLdE
         inbg==
X-Gm-Message-State: APjAAAXLInHykTlVdppYMKr96C6OkgguZTctgl4GzO2FWtziBlyE/xer
        +rtKFAnTNqa8kJGtOZkImMgmjOWToz3n776VERqIUw==
X-Google-Smtp-Source: APXvYqy4TvaH76qmxeF5BmdOmJixuaYWpdfghYQi0jQADchL6HvuGRcDluiwa8aCHLdmq8mHdR0nieBZ+2g67xGlwWc=
X-Received: by 2002:a67:f606:: with SMTP id k6mr21358828vso.114.1567575810342;
 Tue, 03 Sep 2019 22:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <CAJuCfpEXpYq2i3zNbJ3w+R+QXTuMyzwL6S9UpiGEDvTioKORhQ@mail.gmail.com>
 <CAKOZuesWV9yxbS9+T5+p1Ty1-=vFeYcHuO=6MgzTY8akMhbFbQ@mail.gmail.com> <20190904051549.GB256568@google.com>
In-Reply-To: <20190904051549.GB256568@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 3 Sep 2019 22:42:53 -0700
Message-ID: <CAKOZuet_M7nu5PYQj1iZErXV8hSZnjv4kMokVyumixVXibveoQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Carmen Jackson <carmenjackson@google.com>,
        Mayank Gupta <mayankgupta@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@android.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.cz>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 10:15 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Sep 03, 2019 at 09:51:20PM -0700, Daniel Colascione wrote:
> > On Tue, Sep 3, 2019 at 9:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Tue, Sep 3, 2019 at 1:09 PM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > > > memory hogs. Several Android teams have been using this patch in various
> > > > kernel trees for half a year now. Many reported to me it is really
> > > > useful so I'm posting it upstream.
> >
> > It's also worth being able to turn off the per-task memory counter
> > caching, otherwise you'll have two levels of batching before the
> > counter gets updated, IIUC.
>
> I prefer to keep split RSS accounting turned on if it is available.

Why? AFAIK, nobody's produced numbers showing that split accounting
has a real benefit.

> I think
> discussing split RSS accounting is a bit out of scope of this patch as well.

It's in-scope, because with split RSS accounting, allocated memory can
stay accumulated in task structs for an indefinite time without being
flushed to the mm. As a result, if you take the stream of virtual
memory management system calls that  program makes on one hand, and VM
counter values on the other, the two don't add up. For various kinds
of robustness (trace self-checking, say) it's important that various
sources of data add up.

If we're adding a configuration knob that controls how often VM
counters get reflected in system trace points, we should also have a
knob to control delayed VM counter operations. The whole point is for
users to be able to specify how precisely they want VM counter changes
reported to analysis tools.

> Any improvements on that front can be a follow-up.
>
> Curious, has split RSS accounting shown you any issue with this patch?

Split accounting has been a source of confusion for a while now: it
causes that numbers-don't-add-up problem even when sampling from
procfs instead of reading memory tracepoint data.
