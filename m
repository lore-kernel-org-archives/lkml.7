Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22AEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D632206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PQ29wPrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKMUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:10:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38647 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:10:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so3012654oid.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YWH9ke4c1/CtD4q6Is1TXT0RQwZYPzq9oYNkDhxs540=;
        b=PQ29wPrlDDhONQP35XIRij91EVjfglBp0QHwicxi3pzAkWQZe1Zc/BbK7rTlFQ2NMY
         9xRlbeMP7o1QDsuQM2yN7pZ7+qb2EJOx9o8wYzNLH+jOGHY32ASTlvoRBYMT7ePAaYaF
         eVUILQRjxsGwGcld3Ub5c3NM9uggulqZsZlGqaRHXIxR4BO1Gv9RClVXZtcYUD3Csbjr
         V9KtLIqLDR6exny/Tj5u0OAaKvNI3nJfYIvcb2jeQYRfm9M1pDRV2I+68Tg7UMzcxETi
         FY6i+lBOQp2+ccPaB8nEXggrQaT8Y9UkeW0u9gDyJLqS3/lgawuvZpvowp+fMy+lqUnm
         j6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YWH9ke4c1/CtD4q6Is1TXT0RQwZYPzq9oYNkDhxs540=;
        b=isEToEhF2Kv0lK1n95lJl+oi0JFdFMPR0A6rTvLXt99Fo+FqaQYJgcWbGiNVT0CJnw
         dMiSbv5osxsYmvI9qQ4MIA4A/3IbogNhd/Qe5WD99OD3hTk6LVLEY/WUSQjHDvWRlVFv
         rdrPJ3lPQxO3gKAFbIshFYVCuEj832tfI9pfb2DJjBysWj6DumDLJ67oSipXT1X9gPnH
         oMKYcENZwTHL7s/Kq+YZnAP/aiPgnKxXvTsnhT4QK7FcXvy0Aw3qGJm7OzUTvY1H76pr
         edvrMw0qfgrwhgT2AXgB8Pq08XmYHS30Q4H6n3P9OwOS8L21rCIBXSJ+y6agSt6OX9gT
         u8Aw==
X-Gm-Message-State: APjAAAW16herwwjP1yqkNbFBqkkzqSBhtR/08jZnVa0AXZjK8bR61GY+
        7txk8sqjGvMhxUTi2++Gw2QxWEeh/TeViifHIRZQ4g==
X-Google-Smtp-Source: APXvYqxZLEWCKz8wCuh/m700RGuDyJEGtkv8PjsIL0dFtRpTcLmFcrwsWsaRxYDz/RYvDEMt1Z5YnlZfOc4ybJSz5f0=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr368717oia.70.1573675845013;
 Wed, 13 Nov 2019 12:10:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4iPk4bzOCE=7Eq8w-jwUuOXzZP9F=+RcxjqdXCn0SC01A@mail.gmail.com>
 <6193C847-F09C-439A-81EE-98A59473D582@redhat.com>
In-Reply-To: <6193C847-F09C-439A-81EE-98A59473D582@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 12:10:34 -0800
Message-ID: <CAPcyv4h-aPh5yGtAmTm28HgSz5evnvQjq7eh=GetnkY8dqO_Uw@mail.gmail.com>
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
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:53 AM David Hildenbrand <david@redhat.com> wrote=
:
>
>
>
> > Am 13.11.2019 um 20:06 schrieb Dan Williams <dan.j.williams@intel.com>:
> >
> > =EF=BB=BFOn Wed, Nov 13, 2019 at 10:51 AM David Hildenbrand <david@redh=
at.com> wrote:
> >>
> >>> On 08.11.19 20:13, Dan Williams wrote:
> >>> On Thu, Nov 7, 2019 at 4:15 PM Toshiki Fukasawa
> >>> <t-fukasawa@vx.jp.nec.com> wrote:
> >>>>
> >>>> Currently, there is no way to identify pfn on ZONE_DEVICE.
> >>>> Identifying pfn on system memory can be done by using a
> >>>> section-level flag. On the other hand, identifying pfn on
> >>>> ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
> >>>> can be created in units of subsections.
> >>>>
> >>>> This patch introduces a new bitmap subsection_dev_map so that
> >>>> we can identify pfn on ZONE_DEVICE.
> >>>>
> >>>> Also, subsection_dev_map is used to prove that struct pages
> >>>> included in the subsection have been initialized since it is
> >>>> set after memmap_init_zone_device(). We can avoid accessing
> >>>> pages currently being initialized by checking subsection_dev_map.
> >>>>
> >>>> Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
> >>>> ---
> >>>>  include/linux/mmzone.h | 19 +++++++++++++++++++
> >>>>  mm/memremap.c          |  2 ++
> >>>>  mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 53 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>>> index bda2028..11376c4 100644
> >>>> --- a/include/linux/mmzone.h
> >>>> +++ b/include/linux/mmzone.h
> >>>> @@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_pf=
n(unsigned long sec)
> >>>>
> >>>>  struct mem_section_usage {
> >>>>         DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> >>>> +#ifdef CONFIG_ZONE_DEVICE
> >>>> +       DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION);
> >>>> +#endif
> >>>
> >>> Hi Toshiki,
> >>>
> >>> There is currently an effort to remove the PageReserved() flag as som=
e
> >>> code is using that to detect ZONE_DEVICE. In reviewing those patches
> >>> we realized that what many code paths want is to detect online memory=
.
> >>> So instead of a subsection_dev_map add a subsection_online_map. That
> >>> way pfn_to_online_page() can reliably avoid ZONE_DEVICE ranges. I
> >>> otherwise question the use case for pfn_walkers to return pages for
> >>> ZONE_DEVICE pages, I think the skip behavior when pfn_to_online_page(=
)
> >>> =3D=3D false is the right behavior.
> >>
> >> To be more precise, I recommended an subsection_active_map, to indicat=
e
> >> which memmaps were fully initialized and can safely be touched (e.g., =
to
> >> read the zone/nid). This map would also be set when the devmem memmaps
> >> were initialized (race between adding memory/growing the section and
> >> initializing the memmap).
> >>
> >> See
> >>
> >> https://lkml.org/lkml/2019/10/10/87
> >>
> >> and
> >>
> >> https://www.spinics.net/lists/linux-driver-devel/msg130012.html
> >
> > I'm still struggling to understand the motivation of distinguishing
> > "active" as something distinct from "online". As long as the "online"
> > granularity is improved from sections down to subsections then most
> > code paths are good to go. The others can use get_devpagemap() to
> > check for ZONE_DEVICE in a race free manner as they currently do.
>
> I thought we wanted to unify access if we don=E2=80=99t really care about=
 the zone as in most pfn walkers - E.g., for zone shrinking.

Agree, when the zone does not matter, which is most cases, then
pfn_online() and pfn_valid() are sufficient.

> Anyhow, a subsection online map would be a good start, we can reuse that =
later for ZONE_DEVICE as well.

Cool, good to go with me sending a patch to introduce pfn_online() and
a corresponding subsection_map for the same?
