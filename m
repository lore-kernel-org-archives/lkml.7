Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B88C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D71B20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQag3CoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKTVvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:51:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42464 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKTVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id o12so1219234oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jf7tLfUjYPb5KtGZgm15NgY2ll4+ptMssGlo4f+/QP8=;
        b=hQag3CoAJtSyR++N6oRH1spw5PVgBJ5S+rVZM46FNtRd1ldt9b77RUsPPaG2v+doFZ
         yphYtsrbzGly7u/Iu1DYeGy1ay+SNKRGswZ9+tfalxlUSgvIEoing5Kfb4w7mV+sQnMv
         UIEVhrukp0aU1OelUn18hXsJ0haL/O4oh4voXPqNRWC1+ZGwEP+AhyJUdJ5sL1WFiNaE
         ujQ0a3mpois9N3p1fp8wiK3KA7muk7xlrSr6CjvhdzmYK6K+hHdm5szB1zitIbvXzCYD
         2uAS7AT4BLEXHLqIi9JePIVdU2bIEvoKZLVvJHUmhioOn2sMg+IDjCSpeSktAC7uiQAH
         5IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jf7tLfUjYPb5KtGZgm15NgY2ll4+ptMssGlo4f+/QP8=;
        b=pd0Baf4DB7hNMXz+ErFZxvhnYrsVudEpX8E7waNNl1/TuQC2jgfe2zvqk4jslY6tPm
         3FiMaXYXLel+Ha9Jc3d8QPwIghYAdP+/rISUZQSazwe9LvRs7pqUMEQVY3XP/Qg5Zfn0
         NQWSgVGZE2lKreT8PgOWKUC64N/1QZBdsqTi47ZAWpsQBTZA4x10nOrS/yP8CuQ+qESu
         5f586YSCROlo13ueEU7of5JgHCysrz+s7/Lv7FE/cUAofaYhfyzKw8wdIWT2Omtnud8S
         /Fb2r7kHEx1BeIKQ0LYO9hv7Dp3G1WeLlTeA4ZSYAPi3ZeWy1FmJqDbwitz4YrsiHgPA
         r7Fw==
X-Gm-Message-State: APjAAAVzCwUnyQ4lIb126lwNlUhLWa/sSZEN4V4O/Gafdd1Kl8UaU41Y
        /o2swtxCa1zxrbcsXLXph4tEHdTNMOYt+lUUvyCMrw==
X-Google-Smtp-Source: APXvYqxeXDdAm/bIMOB1KZ3V0iUjTHJNHA7Z192YpVmgnSjvhy4GdVvXYw55M76MX0aA+6NVHi0Ga7Lqs/iMH/a1VVU=
X-Received: by 2002:aca:f408:: with SMTP id s8mr4856194oih.69.1574286678048;
 Wed, 20 Nov 2019 13:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20191120080230.16007-1-saravanak@google.com> <20191120153625.GA2981769@kroah.com>
In-Reply-To: <20191120153625.GA2981769@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Nov 2019 13:50:42 -0800
Message-ID: <CAGETcx9eB0ZicHs=8jxwRxbKYHKxoV5u7otud_TAx2Z_DyTw0Q@mail.gmail.com>
Subject: Re: [PATCH] of: property: Fix the semantics of of_is_ancestor_of()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:36 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 20, 2019 at 12:02:29AM -0800, Saravana Kannan wrote:
> > The of_is_ancestor_of() function was renamed from of_link_is_valid()
> > based on review feedback. The rename meant the semantics of the function
> > had to be inverted, but this was missed in the earlier patch.
> >
> > So, fix the semantics of of_is_ancestor_of() and invert the conditional
> > expressions where it is used.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> What git commit does this patch fix?
>

Fixes commit a3e1d1a7f5fcc. Let me know if you want me to send a v2 or
if you can fix up the commit text on your end.

Thanks,
Saravana


-Saravana
