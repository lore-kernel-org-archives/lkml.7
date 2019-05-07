Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D3920675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8dO8ROD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfEGGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:06:25 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38702 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfEGGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:06:23 -0400
Received: by mail-ed1-f47.google.com with SMTP id w11so17545123edl.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZm07w2nSCiVVM+WjYPWUvz7wW+nL7XT9qvn8eYdy3A=;
        b=s8dO8RODm3uMkCQw7BIWmMyABI0C1pYr2apMhdPiSkFP6bbNhtgHKr3/jYpzpeh4JJ
         qwhI+K6TykibR4CMsBrAXVJTbJKuBZJxieq+hk0SBdOWQh30lWltBeOlxCAYN3W3G5kf
         lHJxVYgKUtWlZNbmP/kBOLWFozOI16ok5/HpgPqAspD1694ZK8lLWKY32QBFhOlFJ5Gb
         Z5Gp7Uaf0qpz+W5mdgvizxUtiDNUVZP1LP2Du8LolUcjwpIkcJe0gm2itU6o2ojjsTz/
         k52m2uroKyHEfQtmox/LagM79E84Bwt57rIT8sBl8XjO3UfftnHVGgavNSvDjJoN0lP5
         5gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZm07w2nSCiVVM+WjYPWUvz7wW+nL7XT9qvn8eYdy3A=;
        b=FIa5T/Lw9UDTZQ9SM/ACk2fZ0pcaDSlGTtuRmaBlNXmLhipod6WuT45vudGoEyuZC+
         WfxYLSLLECQjE+NXjCNGKY9W/yCXXA8pzwNOX7FwW1nA4aAhnfCXM+QrCeRu71ktSLdP
         zgGp5he7OC/wkmeEgT7kJaS9pW3tujlZ20E7SXNFeK/tWEtNX3UsOsYcx2cU7pXZg0CH
         FggZt3PRo012DBqTLedlWlHYuC8uxtdZcOQrC/xebtojCpIg3E+hvxbvD0I5wKLQADiz
         DRzamvYuXXtPbkQx/NQyfXdEZZO748tBRqUK0GMt7YagpyFhDlrrD2iw8ozvIqU+qE7R
         sRCg==
X-Gm-Message-State: APjAAAU52GSEJuDwCbcoFs9PZn62g7uDDm1SWfe3u1vE4tnPXMBwykUR
        Y0vKeuEv4+tPC4crasO5L/qNjUrQrtizXDwN9i8=
X-Google-Smtp-Source: APXvYqwUTax6Nbe0rTjQMRruM2k63P6Yc2eck704d/9awNC5izroT9pbEMuhoHqfwRVTcq8tjZ9+yNcKWj5nNvgcVok=
X-Received: by 2002:a17:906:1903:: with SMTP id a3mr22284151eje.37.1557209181270;
 Mon, 06 May 2019 23:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <1556437474-25319-1-git-send-email-huangzhaoyang@gmail.com> <20190506145727.GA11505@cmpxchg.org>
In-Reply-To: <20190506145727.GA11505@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 7 May 2019 14:06:09 +0800
Message-ID: <CAGWkznE0zsGLVHuCx-WGk+TOcFe6w0wJ-MXM8=cXJPZb-rQD-A@mail.gmail.com>
Subject: Re: [[repost]RFC PATCH] mm/workingset : judge file page activity via timestamp
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 10:57 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sun, Apr 28, 2019 at 03:44:34PM +0800, Zhaoyang Huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > this patch introduce timestamp into workingset's entry and judge if the page is
> > active or inactive via active_file/refault_ratio instead of refault distance.
> >
> > The original thought is coming from the logs we got from trace_printk in this
> > patch, we can find about 1/5 of the file pages' refault are under the
> > scenario[1],which will be counted as inactive as they have a long refault distance
> > in between access. However, we can also know from the time information that the
> > page refault quickly as comparing to the average refault time which is calculated
> > by the number of active file and refault ratio. We want to save these kinds of
> > pages from evicted earlier as it used to be via setting it to ACTIVE instead.
> > The refault ratio is the value which can reflect lru's average file access
> > frequency in the past and provide the judge criteria for page's activation.
> >
> > The patch is tested on an android system and reduce 30% of page faults, while
> > 60% of the pages remain the original status as (refault_distance < active_file)
> > indicates. Pages status got from ftrace during the test can refer to [2].
> >
Hi Johannes,
Thank you for your feedback. I have answer previous comments many
times in different context. I don't expect you accept this patch but
want to have you pay attention to the phenomenon reported in [1],
which has a big refault distance but refaulted very quickly after
evicted. Do you think if this kind of page should be set to INACTIVE?
> > [1]
> > system_server workingset_refault: WKST_ACT[0]:rft_dis 265976, act_file 34268 rft_ratio 3047 rft_time 0 avg_rft_time 11 refault 295592 eviction 29616 secs 97 pre_secs 97
> > HwBinder:922  workingset_refault: WKST_ACT[0]:rft_dis 264478, act_file 35037 rft_ratio 3070 rft_time 2 avg_rft_time 11 refault 310078 eviction 45600 secs 101 pre_secs 99
> >
> > [2]
> > WKST_ACT[0]:   original--INACTIVE  commit--ACTIVE
> > WKST_ACT[1]:   original--ACTIVE    commit--ACTIVE
> > WKST_INACT[0]: original--INACTIVE  commit--INACTIVE
> > WKST_INACT[1]: original--ACTIVE    commit--INACTIVE
> >
> > Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
>
> Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> You haven't addressed any of the questions raised during previous
> submissions.
