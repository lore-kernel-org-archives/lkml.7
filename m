Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F21BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7441206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="A7yzewJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfKMTGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:06:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44401 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfKMTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:06:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so2784534oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=evIuNrrlG6EZmvamCM+sMtWrypDnzooLTyDJ1S1Tl1k=;
        b=A7yzewJb20+HepONFpbwXw3tYORpvEyr4MDoe2TBcw3ff8pgibms8R+9F7w6h19QZK
         eKZ7S7noqVDg8eD4984+lLkv4gvgtVffwrv5u2KDDpHd0Yv+jkyyVxekrGqCbCfw14kB
         NFFyuRihnCZ6iyRO72+2RUoK5XzscuNVKKIB//ZTXlG61OMDX++6m4R7zekIU9dgbTQQ
         XqBIKYl010Jyiew74YNcmwIyqg4TIgjAcQz1cS1MrAaPzKub/ug++ShTixXLaA4cSWMn
         iewaa0BwrX1HI3uCr+iY+C8eptHxTX9dKdZQZ9sp+KTfYi39+GacuoIrkTNvENfQzi1E
         g4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evIuNrrlG6EZmvamCM+sMtWrypDnzooLTyDJ1S1Tl1k=;
        b=M4ktB+NrsbsEP68QgU0qkcE/YaldsrquLGuHXFKWDfAovIal5WMq5OUkzYywk719RO
         e7lseo5ZwwLDvTsDfmzzW6rlVJzVpJOVufRSk25sbc0+2LyQHwXtFBH55K5wUA1eoMZl
         cqyJkojs+3MLXLb+sGk+xLc6duYAXPK4qZnljxm/8S+X2buafDICYlQr88n6iE6KgR39
         tajI3WDDV081teUZT7SSU/2m4Mo4XCcocXHIANjdN2iHx2On9u6OZVIkdQetoa5pW5v3
         97dfxpI1cin7Xy42DUcUrLQ6Y9B+2MBRatQ5YM7ARAXzLQHo6ahNJb7iaUGg+slRIzdp
         NQfw==
X-Gm-Message-State: APjAAAWjWp7C4Y8Lp8BtaG/icSE0GMjEHSe8h3TvB0bKBI0d7FMDMlI4
        xHSrWlNyVeZOIO94lTG8iXZ4Uzmp5r5MfqQ9k9BTBg==
X-Google-Smtp-Source: APXvYqxlCW2sXfqrOozCNuUeVMdzUz9tPqWKwSathCzp4elJR1uVRsYFgSgb7sV27mHmtvy8uoZBmtl6l8JsUG7E7XI=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr193568oih.0.1573672006126;
 Wed, 13 Nov 2019 11:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
 <20191108000855.25209-3-t-fukasawa@vx.jp.nec.com> <CAPcyv4h+++k1VTB2xKWHXjC4LC0N=nvDUMcdbGAsDBmwMob5dw@mail.gmail.com>
 <163d1d41-19c1-d8cf-6c1c-eec226c34ac1@redhat.com>
In-Reply-To: <163d1d41-19c1-d8cf-6c1c-eec226c34ac1@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Nov 2019 11:06:35 -0800
Message-ID: <CAPcyv4iPk4bzOCE=7Eq8w-jwUuOXzZP9F=+RcxjqdXCn0SC01A@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:51 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.11.19 20:13, Dan Williams wrote:
> > On Thu, Nov 7, 2019 at 4:15 PM Toshiki Fukasawa
> > <t-fukasawa@vx.jp.nec.com> wrote:
> >>
> >> Currently, there is no way to identify pfn on ZONE_DEVICE.
> >> Identifying pfn on system memory can be done by using a
> >> section-level flag. On the other hand, identifying pfn on
> >> ZONE_DEVICE requires a subsection-level flag since ZONE_DEVICE
> >> can be created in units of subsections.
> >>
> >> This patch introduces a new bitmap subsection_dev_map so that
> >> we can identify pfn on ZONE_DEVICE.
> >>
> >> Also, subsection_dev_map is used to prove that struct pages
> >> included in the subsection have been initialized since it is
> >> set after memmap_init_zone_device(). We can avoid accessing
> >> pages currently being initialized by checking subsection_dev_map.
> >>
> >> Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
> >> ---
> >>   include/linux/mmzone.h | 19 +++++++++++++++++++
> >>   mm/memremap.c          |  2 ++
> >>   mm/sparse.c            | 32 ++++++++++++++++++++++++++++++++
> >>   3 files changed, 53 insertions(+)
> >>
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index bda2028..11376c4 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -1174,11 +1174,17 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
> >>
> >>   struct mem_section_usage {
> >>          DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> >> +#ifdef CONFIG_ZONE_DEVICE
> >> +       DECLARE_BITMAP(subsection_dev_map, SUBSECTIONS_PER_SECTION);
> >> +#endif
> >
> > Hi Toshiki,
> >
> > There is currently an effort to remove the PageReserved() flag as some
> > code is using that to detect ZONE_DEVICE. In reviewing those patches
> > we realized that what many code paths want is to detect online memory.
> > So instead of a subsection_dev_map add a subsection_online_map. That
> > way pfn_to_online_page() can reliably avoid ZONE_DEVICE ranges. I
> > otherwise question the use case for pfn_walkers to return pages for
> > ZONE_DEVICE pages, I think the skip behavior when pfn_to_online_page()
> > == false is the right behavior.
>
> To be more precise, I recommended an subsection_active_map, to indicate
> which memmaps were fully initialized and can safely be touched (e.g., to
> read the zone/nid). This map would also be set when the devmem memmaps
> were initialized (race between adding memory/growing the section and
> initializing the memmap).
>
> See
>
> https://lkml.org/lkml/2019/10/10/87
>
> and
>
> https://www.spinics.net/lists/linux-driver-devel/msg130012.html

I'm still struggling to understand the motivation of distinguishing
"active" as something distinct from "online". As long as the "online"
granularity is improved from sections down to subsections then most
code paths are good to go. The others can use get_devpagemap() to
check for ZONE_DEVICE in a race free manner as they currently do.

> I dislike a map that is specific to ZONE_DEVICE or (currently)
> !ZONE_DEVICE. I rather want an indication "this memmap is safe to
> touch". As discussed along the mentioned threads, we can combine this
> later with RCU to handle some races that are currently possible.

The rcu protection is independent of the pfn_active vs pfn_online
distinction afaics.
