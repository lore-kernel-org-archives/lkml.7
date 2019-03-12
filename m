Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD179214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOW5+EKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCLLFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:05:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46881 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:05:20 -0400
Received: by mail-io1-f65.google.com with SMTP id k21so1643769ior.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xH7u0SIa2NIqLp+XLrFdsgjL0uBSb7uHvpHDRDB7p5U=;
        b=mOW5+EKMTy+WiyZtH8detQ3wUr/c7TNL1Qy/LragZbtl6h2wdtk49YpuBuEexJQlsa
         lj/VBzbcVbMX9yaYBUWfsQ0b2NhR9CXKz8alLTdwboeei/qmPJnXqLG8iXsTOscAjjtt
         BPWsJi0A6suM2TbTuXNmpBd6Phl7VhP5Bs3JpSRno1kE3EhPCbL3OmVCeuasv/g7wd6A
         qgANJkBulCV5vrq4nIXXatCsj+DHQvBUNkXsDgLx+iPRf1AM6GTmRBfwRN8ns3HckGyH
         hXZyUvVqNQA2PhtNZu6YCe372FG3VMhaerjz6N3zJZdaJkrIc9zUGliaB8LDWp7BE1c7
         AZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xH7u0SIa2NIqLp+XLrFdsgjL0uBSb7uHvpHDRDB7p5U=;
        b=kAD+/VslsW7vbTgAnMn6x2eqgZsqIL9a1jPh7puibsmbYe3spSgu0JwJ+qNOu1Wki1
         C66pJwczMFxtHMp4yY2ok6lSBQUpaD4pBCPm26z6fisdS6oH5GXblbud8UEFh9G5pTt7
         CQrL1IMOSqcRUUXXbuLQPzOjwP+oKTv1fXxHBLyV+yAMcw6tXkQMis9DJki1ft2DAiAe
         8bp1YkF/F7efqsUrn18i7jGyDpL8/+gJfPQDXkxpkGBAPm6Nr5dD1Sa2zvEjX2KbDO1m
         +VoIjXL9qZg4OiXSo0ptJ60CKy2Lktn6OHPLhP6ex2OYsaV+j0HFQhC3Yz0AF4gZIKf/
         CsFA==
X-Gm-Message-State: APjAAAWVZPk7UWMePP7ggzRi9QzL6t9CAVBXJB/XNgyxCAf6J/QqHcGV
        vmnisNFm1wrfIMWa5OxgzEXqHm6rVaFCNAX+dCg=
X-Google-Smtp-Source: APXvYqweUbWZD1AYGdvU7fmlc//2ygm4OyFUT2sT8YLocP/dIa+DgeNXPueNq3IZMDBFiLToCtAqmFh43FtBmqfwndc=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr7892691iof.11.1552388718871;
 Tue, 12 Mar 2019 04:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <1551425934-28068-1-git-send-email-laoar.shao@gmail.com> <20190311084743.GX5232@dhcp22.suse.cz>
In-Reply-To: <20190311084743.GX5232@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 12 Mar 2019 19:04:43 +0800
Message-ID: <CALOAHbDHM1mJ3X9x3vFpDagd81T+hrb7_xdqM12x6JQXuHqwxA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: show zone type in kswapd tracepoints
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 4:47 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 01-03-19 15:38:54, Yafang Shao wrote:
> > If we want to know the zone type, we have to check whether
> > CONFIG_ZONE_DMA, CONFIG_ZONE_DMA32 and CONFIG_HIGHMEM are set or not,
> > that's not so convenient.
> >
> > We'd better show the zone type directly.
>
> I do agree that zone number is quite PITA to process in general but do
> we really need this information in the first place? Why do we even care?
>

Sometimes we want to know this event occurs in which zone, then we can
get the information of this zone,
for example via /proc/zoneinfo.
It could give us more information for debugging.


> Zones are an MM internal implementation details and the more we export
> to the userspace the more we are going to argue about breaking userspace
> when touching them. So I would rather not export that information unless
> it is terribly useful.
>

I 'm not sure whether zone type is  terribly useful or not, but the
'zid' is useless at all.

I don't agree that Zones are MM internal.
We can get the zone type in many ways, for example /proc/zoneinfo.

If we show this event occurs in which zone, we'd better show the zone type,
or we should drop this 'zid'.


> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/trace/events/vmscan.h | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> > index a1cb913..4c8880b 100644
> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -73,7 +73,10 @@
> >               __entry->order  = order;
> >       ),
> >
> > -     TP_printk("nid=%d zid=%d order=%d", __entry->nid, __entry->zid, __entry->order)
> > +     TP_printk("nid=%d zid=%-8s order=%d",
> > +             __entry->nid,
> > +             __print_symbolic(__entry->zid, ZONE_TYPE),
> > +             __entry->order)
> >  );
> >
> >  TRACE_EVENT(mm_vmscan_wakeup_kswapd,
> > @@ -96,9 +99,9 @@
> >               __entry->gfp_flags      = gfp_flags;
> >       ),
> >
> > -     TP_printk("nid=%d zid=%d order=%d gfp_flags=%s",
> > +     TP_printk("nid=%d zid=%-8s order=%d gfp_flags=%s",
> >               __entry->nid,
> > -             __entry->zid,
> > +             __print_symbolic(__entry->zid, ZONE_TYPE),
> >               __entry->order,
> >               show_gfp_flags(__entry->gfp_flags))
> >  );
> > --
> > 1.8.3.1
> >
>
> --
> Michal Hocko
> SUSE Labs
