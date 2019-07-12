Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D34C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFurjCS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfGLWKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:10:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34675 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfGLWKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:10:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id b13so4891669pfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 15:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zuU348vMM9aXraE4ccy+eAHv0CShi7BKwdNOAqDmvDI=;
        b=NFurjCS4ooi0Fvo+RA6fYOmAV3aI9uoCXtAdcbExWzcIftI8DfV9JB8MhRl69Nkd12
         WJlgvG6DaRBT85EjBYvmNsJOMUBjLpOwKA8/MF6ehv7mq7G2SQDEX+RScKErCld4Oh9n
         lx5EEDhrlZvfID2u1YwWjPNskhw8Msgc1X2OpGnLqrmXlt123SbRgZQKprlIhWhxHowA
         TFO95zYgyxnLNE1dsmf/IhAx9WFRQHstemWHiXAeZf3/oQbfFufly73Y48mzb1yXanjg
         PtQD6sHac7/JTOtjepbHEuZ7hG6AzXCbirlxWuFgsUgBTQe5LnVv2jdiqCqZ0ALh3FsT
         nm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=zuU348vMM9aXraE4ccy+eAHv0CShi7BKwdNOAqDmvDI=;
        b=YTgqQx42OYTMchr19sVhZJS1bYMlEGc5bCRuc0GpOtMVTpjYIH2SjxgayFGDFet9DZ
         oVZDRjFM5HzXnolOc1r0DcCEQsxDC70TahO9ClghOEKqgyu4h4dkpfZY7oN+Uk9I+jlo
         2ZOpvQkvvcRgQ96aTKMpnC53KjwvpRd6b7sbayzKUK7kXEbsolYAIQ71gxpfdTC0LkHR
         rgaSc9Oew4cFo2BXZSVyzCeBMi6aGzIr+tkMiyXd/8/qajO5MB0BknnjqownWDOcESYT
         fZcecVdxpYoWqgt6JxwrJDwwc/lBNWtShLEb+ngbTkZxEqBPSMkc6SP+ArvKD88JdYAJ
         53mw==
X-Gm-Message-State: APjAAAXXwAXfvP5Du1oNmUpIGKUVa9V/5DrH7q2WuurMfhTBiO8oZacw
        KGJCe/mLcMlvYx0iwJsNkcDlbg==
X-Google-Smtp-Source: APXvYqwtSX+yfy8odN8PRwvf2FSTIt4YJkTQBI3CdsfQxFtcWWA+E8aK56vQe+awruZFmyJt1JcKhg==
X-Received: by 2002:a63:231c:: with SMTP id j28mr13362263pgj.430.1562969399631;
        Fri, 12 Jul 2019 15:09:59 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id f7sm9398759pfd.43.2019.07.12.15.09.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 15:09:58 -0700 (PDT)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
        <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com>
        <20190711095102.GX3402@hirez.programming.kicks-ass.net>
        <xm26v9w8jwgl.fsf@bsegall-linux.svl.corp.google.com>
        <CAC=E7cV4sO50NpYOZ06n_BkZTcBqf1KQp83prc+oave3ircBrw@mail.gmail.com>
Date:   Fri, 12 Jul 2019 15:09:57 -0700
In-Reply-To: <CAC=E7cV4sO50NpYOZ06n_BkZTcBqf1KQp83prc+oave3ircBrw@mail.gmail.com>
        (Dave Chiluk's message of "Thu, 11 Jul 2019 18:48:24 -0500")
Message-ID: <xm26muhikiq2.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chiluk <chiluk+linux@indeed.com> writes:

> So I spent some more time testing this new patch as is *(interrupts disabled).  I know I probably should have fixed the patch, but it's hard to get time on big test hardware sometimes, and I was already well along my way with testing.
>
> In regards to the quota usage overage I was seeing earlier: I have a theory as to what might be happening here, and I'm pretty sure it's related to the IRQs being disabled during the rq->lock walk.  I think that the main fast thread was able to use an excess amount
> of quota because the timer interrupt meant to stop it wasn't being handled timely due to the interrupts being disabled.  On my 8 core machine this resulted in a what looked like simply improved usage of the quota, but when I ran the test on an 80 core machine I
> saw a massive overage of cpu usage when running fibtest.  Specifically when running fibtest for 5 seconds with 50ms quota/100ms period expecting ~2500ms of quota usage; I got 3731 ms of cpu usage which was an unexpected overage of 1231ms. Is that a
> reasonable theory?

I think I've figured out what's going on here (and a related issue
that gave me some inconsistency when trying to debug it): other "slow"
threads can wake up while the slack timer is in distribute and
double-spend some runtime. Since we lsub_positive rather than allow
cfs_b->runtime to be negative this double-spending is permanent, and can
go on indefinitely.

In addition, if things fall out in a slightly different way, all the
"slow" threads can wind up getting on cpu and claiming slices of runtime
before the "fast" thread, and then it just has to wait another slack
period to hope that the ordering winds up better that time. This just
depends on things like IPI latency and maybe what order things happened
to happen at the start of the period.

Ugh. Maybe we /do/ just give up and say that most people don't seem to
be using cfs_b in a way that expiration of the leftover 1ms matters.
