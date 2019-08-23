Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C474C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5358C233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIL4cyU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfHWIKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:10:23 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43926 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbfHWIKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:10:22 -0400
Received: by mail-vk1-f194.google.com with SMTP id b11so2208830vkk.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vk0xnq0ITYu+qK5F5bHmWu1n+k56nkz4SDOnjpES1c4=;
        b=bIL4cyU9dSP/ALR5PyTy9imEpBjuuekcxGRN531QuzEWTMtS/diQ53/pBD2JltkrUQ
         v/DldtUOcf0oNH+d3mHV+G6sZcQr04FqzjlxHx3/OPxTZycheKykIT10IQ0IOyiiHCCa
         LSQdHXmj4PF8G96lDqq7vWV5NXn8yNn/IHn1ukKcifYXkrC8gg2VlKj4jFGWEpgcyjSY
         mdNJBtL0WTMHJKpI/Eiee4q0HDh8aRsDD0d0T9tQkZX2dL6f77w6jOZvbXivz5INFSdV
         5++KgsGrqm30WI+O+QV2ztJGBpLDYF+ISWJGDravcCBNUYKRXCvzZxjmXGGgHBX5HGRz
         oSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vk0xnq0ITYu+qK5F5bHmWu1n+k56nkz4SDOnjpES1c4=;
        b=tmuFZGobyfr1dcYQYVZRnBIcAOAiOHu8lwyP3WwlkObdBOSyL4vz9ZbChr4DlD+mDN
         vmT55uYh35lmtkoOwmmi1cSFfpPRYjz9EgYg3v6Jp8kf5/zJa/ijmZq4/HsNx/6VpkJh
         eMO3zCDQBi/gf4ktJttaytw4BjX64Q8Fq6rtWEOMLspI0IZglTQ5oqrX53UCU4Iul26C
         VTwPiSq9I4Zze9tUthwi8DR+/PbyoHnqwEYM8UfAr0cLvxsSXvFE8Y8bkB+gIk+cAHXg
         raxCNuNNa/Nv7MoI83Fm2INw7CqzAY1iKLML46hZpaNncOoSn6x/rgYJXGnaq7RfLcRk
         N0uQ==
X-Gm-Message-State: APjAAAUrDQAQWlm3Jb2o8kQSU3sEIkdNU9srzhvLPhauowd2APnSrp85
        +NjHRh65IwtFPz+IqpoiQ/OHXxj38Ghje/qtV7k=
X-Google-Smtp-Source: APXvYqywy9LzD7vUm9M9D/scLpRY6ubVNI/1X2o3mOFhrG8Lfm8/xY+Co2Mgc8z72VEK6tWFJEos0yVZAmNMjdPCyY4=
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr1843983vkl.28.1566547821739;
 Fri, 23 Aug 2019 01:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190809181751.219326-1-henryburns@google.com>
 <20190809181751.219326-2-henryburns@google.com> <20190820025939.GD500@jagdpanzerIV>
 <20190822162302.6fdda379ada876e46a14a51e@linux-foundation.org>
In-Reply-To: <20190822162302.6fdda379ada876e46a14a51e@linux-foundation.org>
From:   Henry Burns <henrywolfeburns@gmail.com>
Date:   Fri, 23 Aug 2019 04:10:10 -0400
Message-ID: <CADJK47M=4kU9SabcDsFD5qTQm-0rQdmage8eiFrV=LDMp7OCyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] mm/zsmalloc.c: Fix race condition in zs_destroy_pool
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Henry Burns <henryburns@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 7:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 20 Aug 2019 11:59:39 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>
> > On (08/09/19 11:17), Henry Burns wrote:
> > > In zs_destroy_pool() we call flush_work(&pool->free_work). However, we
> > > have no guarantee that migration isn't happening in the background
> > > at that time.
> > >
> > > Since migration can't directly free pages, it relies on free_work
> > > being scheduled to free the pages.  But there's nothing preventing an
> > > in-progress migrate from queuing the work *after*
> > > zs_unregister_migration() has called flush_work().  Which would mean
> > > pages still pointing at the inode when we free it.
> > >
> > > Since we know at destroy time all objects should be free, no new
> > > migrations can come in (since zs_page_isolate() fails for fully-free
> > > zspages).  This means it is sufficient to track a "# isolated zspages"
> > > count by class, and have the destroy logic ensure all such pages have
> > > drained before proceeding.  Keeping that state under the class
> > > spinlock keeps the logic straightforward.
> > >
> > > Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> > > Signed-off-by: Henry Burns <henryburns@google.com>
> >
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> >
>
> Thanks.  So we have a couple of races which result in memory leaks?  Do
> we feel this is serious enough to justify a -stable backport of the
> fixes?

In this case a memory leak could lead to an eventual crash if
compaction hits the leaked page. I don't know what a -stable
backport entails, but this crash would only occur if people are
changing their zswap backend at runtime
(which eventually starts destruction).
