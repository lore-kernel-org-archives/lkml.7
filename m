Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E134214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+FrO7/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCLOL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:11:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53892 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfCLOLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:11:25 -0400
Received: by mail-it1-f193.google.com with SMTP id x189so4565909itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7plJKK7CMAfrjjVhJmorscumrWINpd8NhhS/I9a1N4=;
        b=t+FrO7/WFFNvRRbG9RKQnGKwO5ptegBmevRSjLlq+7PjEMRUwdPgKwe0hXNEUb/Cn6
         jim3QVCnCg4R4TWqZE5xvDaRi/dP5AQucB8wpSTpdV0uixu82PlOea9Fh1LFNSRiIn/Z
         aUPbsFd77rzjjGO1imhp385V1WblN5P7JFu/JJYZaydEkyyu2xHwbR9MwWds/aUQzGlb
         XGRmm/h38oXpONofHzxTvmxIn93AP8gLorGkTYJR+johXKhADDfK82ATA7PvFnFJh/D+
         4+wiqAhl7pDA7pvC/FhzCdGhoW7P5Sg92OIjPZ205JWeZaj/0gvhpJTqle+0Ff7CHNhR
         E5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7plJKK7CMAfrjjVhJmorscumrWINpd8NhhS/I9a1N4=;
        b=RFp8MnBcKkE2cp3YmJ/ahMTp0YT6wNK9/nCaWy+HupBLbXHvbVIRqGoq1IvJirQnUG
         rWPusuna8z4VCVWWgqsvtgd7aRU/7CbE5xpnWcpGYL64hSEx0h/YbQHKrRkK3THEsu4s
         eQAGAAsVnJIbf0b64p4pCxscDbo4F8DWzziARNJuTmSo+9q6IUIm7MO/fHhqQvdCyUf8
         2EPA++GBbVLBRE12NxIxvvmbdC94ctvQj0Z/7nsapX30+xmMy8+cRn0BglfV5f4jmXEE
         sRdVAvtf35qGhj7hYFr/pfgyJj/bAQi6j2vnNigakWG+xzo2J1nL/kTF9N7vbGLltnI+
         Bvjw==
X-Gm-Message-State: APjAAAV15dbdEHEy/4dRe5a5fJ2UGF0urx/gXfM4879/lA9F1DRR48EO
        hN/AM446rUfkCLF9hCBqlBRBYWj7aesK79wqxUY=
X-Google-Smtp-Source: APXvYqymm3PEvBUzrEOe9DRQXJEMkaeITUai5JGJMbusc/VPi1OO4e9F1mdeyLn9p3ChVrjpKIjFtfyySdpQPkE10Ow=
X-Received: by 2002:a24:ee89:: with SMTP id b131mr348404iti.97.1552399884412;
 Tue, 12 Mar 2019 07:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <1551425934-28068-1-git-send-email-laoar.shao@gmail.com>
 <20190311084743.GX5232@dhcp22.suse.cz> <CALOAHbDHM1mJ3X9x3vFpDagd81T+hrb7_xdqM12x6JQXuHqwxA@mail.gmail.com>
 <20190312133816.GR5721@dhcp22.suse.cz>
In-Reply-To: <20190312133816.GR5721@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 12 Mar 2019 22:10:48 +0800
Message-ID: <CALOAHbA6FG97tkKLJQSYocmgYRYJGa=5ULV1AK92+dw=MtKZJA@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 9:38 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 12-03-19 19:04:43, Yafang Shao wrote:
> > On Mon, Mar 11, 2019 at 4:47 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 01-03-19 15:38:54, Yafang Shao wrote:
> > > > If we want to know the zone type, we have to check whether
> > > > CONFIG_ZONE_DMA, CONFIG_ZONE_DMA32 and CONFIG_HIGHMEM are set or not,
> > > > that's not so convenient.
> > > >
> > > > We'd better show the zone type directly.
> > >
> > > I do agree that zone number is quite PITA to process in general but do
> > > we really need this information in the first place? Why do we even care?
> > >
> >
> > Sometimes we want to know this event occurs in which zone, then we can
> > get the information of this zone,
> > for example via /proc/zoneinfo.
> > It could give us more information for debugging.
>
> Could you be more specific please?
>

Honestly speaking,  this one hasn't help us fix the real issue yet.

> > > Zones are an MM internal implementation details and the more we export
> > > to the userspace the more we are going to argue about breaking userspace
> > > when touching them. So I would rather not export that information unless
> > > it is terribly useful.
> > >
> >
> > I 'm not sure whether zone type is  terribly useful or not, but the
> > 'zid' is useless at all.
> >
> > I don't agree that Zones are MM internal.
> > We can get the zone type in many ways, for example /proc/zoneinfo.
> >
> > If we show this event occurs in which zone, we'd better show the zone type,
> > or we should drop this 'zid'.
>
> Yes, I am suggesting the later. If somebody really needs it then I would
> like to see a _specific_ usecase. Then we can add the proper name.

This 'zid' always seems like a noise currently.
I will send a patch to drop this one.

Thanks
Yafang
