Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96865C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEBE21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mfSJF8Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393749AbfIJOxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:53:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40670 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393693AbfIJOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:53:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so19155303ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8ly24a+jxc+91/TFypCkb4F8N+FEdjNAE/zhEV+IIE=;
        b=mfSJF8PaPQmyDY9iChJmuo3gGAWGIprSFFiC1eBc2RjVbb7pyDG60UmszTQjZrSGzE
         K+6tCKyTJkmcwwALfPMqRwAAPujuq/yfI4Q7jmV94bCU1aEGBOuCvUS/J0XvzmRrUCPT
         RbHLsv9SLAoH4EtNfOkt11yzTbrSPIchF8T+3d4u2dBZAUQ6enJw8Bu21MoZnYakcb8V
         pIF/7U8K9/s3i0xFyyDQE9CXIl7k54gXZUXpJ2aHYdpSLJLRrBjZj+RzxftUZmwtuMCS
         FEhwcoyAlMjk4xyslFR+dSTbEKdEdPR9o4fPblns1DCFNeCX3XfB9wgSTm+V1YFqLqWw
         U5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8ly24a+jxc+91/TFypCkb4F8N+FEdjNAE/zhEV+IIE=;
        b=A/png5M1YSLzPQ+QUWW7cmOxUjgzpOkaSgOANdi9wDKkPgEgWAbeNIVSl0XN19U8oG
         zZzd2CBhEonCiUPOLy3nkL+EJJzlZgEph7SQMioMbTzFkRoYundvIVFnP7W66V+Y/58q
         W04MBl1CK+/9oRzNoXrVhHCR7eyDdjb0dnlD+Vrf1Zo47vr72IF12N8Ubp5SVjHKE0gq
         Ha+ueVAC8KR2QgiHOQ7dh8JYj05JD3zBY2G+mnQPhow31QVGtrkbbxtj2lSvK5ya/05c
         D1D1CdLi7ESNBWTM1YB4CvfVtB7jLO+i/Yzc5xeT+hhouh6/UnWVa6vgjNHdrxSrTZk2
         mvhg==
X-Gm-Message-State: APjAAAX3UD7BlL6ZpgAYuNDRj3EWHPGYYokYCTsDv3FlK0BemPdo7UuV
        ulIfl0HoDI7iIgcgVfhtH5pDemGO76cThSu4/eSJew==
X-Google-Smtp-Source: APXvYqxQmuDGMJwxn/eWcj+lNZcggHjhtKUuLiO38N7aE8QSYKsPN792e8m5XBP9d1ntulf0NUV56UxMjwtQxhgQXFU=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr25476337otb.247.1568127208568;
 Tue, 10 Sep 2019 07:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190906081027.15477-1-t-fukasawa@vx.jp.nec.com> <20190910140107.GD2063@dhcp22.suse.cz>
In-Reply-To: <20190910140107.GD2063@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 10 Sep 2019 07:53:17 -0700
Message-ID: <CAPcyv4jkZJLzEDne6W2pEDGB+q96NkkozmhKxybTu1LjnPYY9g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: initialize struct pages reserved by
 ZONE_DEVICE driver.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 7:01 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 06-09-19 08:09:52, Toshiki Fukasawa wrote:
> [...]
> > @@ -5856,8 +5855,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >               if (!altmap)
> >                       return;
> >
> > -             if (start_pfn == altmap->base_pfn)
> > -                     start_pfn += altmap->reserve;
> >               end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
>
> Who is actually setting reserve? This is is something really impossible
> to grep for in the kernle and git grep on altmap->reserve doesn't show
> anything AFAICS.

Yes, it's difficult to grep, here is the use in the nvdimm case:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvdimm/pfn_devs.c#n600

>
> Btw. irrespective to this issue all three callers should be using
> pfn_to_online_page rather than pfn_to_page AFAICS. It doesn't really
> make sense to collect data for offline pfn ranges. They might be
> uninitialized even without zone device.

Agree.
