Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC6C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7271C206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LAn02cio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKMV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:26:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:26:53 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so3232106oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GXkcX2JCtyKHHo0cyAglaiWGhE2YBu5/DI/DhPu01Ow=;
        b=LAn02cio2MfDiRJwrNq18V3/ueYXDq6XkkbOMC9mIKr8Og4Hg9ge7OM8DRKJiQIHL/
         bumdQzTlMxUhgjy/QBL0GW8zIJWFFWxIPImeU8EQmjwRcrbRTPhEisRh05HJxEKvRxjC
         HXLhoZ41YrOyPC/YB0HfY5kWYQVTDJ2bVWmEz4D4meNck4DWvbST6A9fRbgoliBURU0t
         1W6rzDHt/Ofaa8L8fEoROHquPzJWNvWoBk7M28H4w4pFQIMmaoT7SelSj1/E13G2DdLg
         xGekDE5Vk1TeqpDeVVjIfYZJoJPFdS+FFh77Z2AUOJ0WB/YrzFEL6pmPSYxIFqQHQjt1
         3AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GXkcX2JCtyKHHo0cyAglaiWGhE2YBu5/DI/DhPu01Ow=;
        b=kIgOpWi/jqAi0XdhxXzgJ4oQILs8BWYtPoasEyAjmlmlKggvSQlfnk+m2OOSOwVrFZ
         cmFsI4Fj4+7lW+SNq/PztOsGBDXcG/8rXVedp8P5d3C6BL62XjcwrK1gapUalC/QpSl9
         aM1WRQ/gfSdzer4PTrC/GKQq6NUbpLPKZdpAGPgTLuwKhOaL162tfV6n6n30RnRkG3Kv
         LV+2ozmpnfP/ypmjvccQwOjKMHBmT1p5xXkrKTbhp3CdwtpykECWXX1tDqm/5nQl4zGr
         71OQ6uyErW1jaIQ1FpRg4UltvwnWL3vv/qPrDASViDoG+Vhj/zP0HpQKEm1DTxVTorP/
         GFsg==
X-Gm-Message-State: APjAAAXMRNWXSCawLgRY2mdA//fY5w4NxXHGBYlLuGDSaRZFFKYoD0mF
        HQjero+N6fAbkXqeAgtZGC5I0oqrn3Lic71Xy0zgeQ==
X-Google-Smtp-Source: APXvYqyDjhelVNRtH2Dd05TmcchN1KTJcyS9q6Qq71HSgmwdkipeSp+OhTiPzV+812M0dS2nt+KFP1CXO1g6gIoBsTo=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr653822oib.105.1573680412830;
 Wed, 13 Nov 2019 13:26:52 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gpN8kbh1i6jCDdC2OP41G3C2+7YD4rYz-3HaD_pufvyg@mail.gmail.com>
 <3E71366A-9232-46BB-8261-3FCB2300C80A@redhat.com>
In-Reply-To: <3E71366A-9232-46BB-8261-3FCB2300C80A@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 13:26:42 -0800
Message-ID: <CAPcyv4hw58eYJdb4ifvwX8m1E-AMyF5COmjEppz7px6vaB5cRA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Introduce subsection_dev_map
To:     David Hildenbrand <david@redhat.com>
Cc:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 1:22 PM David Hildenbrand <david@redhat.com> wrote:
>
>
>
> > Am 13.11.2019 um 22:12 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BFOn Wed, Nov 13, 2019 at 12:40 PM David Hildenbrand <david@redh=
at.com> wrote:
> > [..]
> >>>>>> I'm still struggling to understand the motivation of distinguishin=
g
> >>>>>> "active" as something distinct from "online". As long as the "onli=
ne"
> >>>>>> granularity is improved from sections down to subsections then mos=
t
> >>>>>> code paths are good to go. The others can use get_devpagemap() to
> >>>>>> check for ZONE_DEVICE in a race free manner as they currently do.
> >>>>>
> >>>>> I thought we wanted to unify access if we don=E2=80=99t really care=
 about the zone as in most pfn walkers - E.g., for zone shrinking.
> >>>>
> >>>> Agree, when the zone does not matter, which is most cases, then
> >>>> pfn_online() and pfn_valid() are sufficient.
> >>
> >> Oh, and just to clarify why I proposed pfn_active(): The issue right n=
ow is that a PFN that is valid but not online could be offline memory (memm=
ap not initialized) or ZONE_DEVICE. That=E2=80=98s why I wanted to have a w=
ay to detect if a memmap was initialized, independent of the zone. That=E2=
=80=98s important for generic PFN walkers.
> >
> > That's what I was debating with Toshiki [1], whether there is a real
> > example of needing to distinguish ZONE_DEVICE from offline memory in a
> > pfn walker. The proposed use case in this patch set of being able to
> > set hwpoison on ZONE_DEVICE pages does not seem like a good idea to
> > me. My suspicion is that this is a common theme and others are looking
> > to do these types page manipulations that only make sense for online
> > memory. If that is the case then treating ZONE_DEVICE as offline seems
> > the right direction.
>
> Right. At least it would be nice to have for zone shrinking - not sure ab=
out the other walkers. We would have to special-case ZONE_DEVICE handling t=
here.
>

I think that's ok... It's already zone aware code whereas pfn walkers
are zone unaware and should stay that way if at all possible.

> But as I said, a subsection map for online memory is a good start, especi=
ally to fix pfn_to_online_page(). Also, I think this might be a very good t=
hing to have for Oscars memmap-on-memory work (I have a plan in my head I c=
an discuss with Oscar once he has time to work on that again).

Ok, I'll keep an eye out.
