Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BC2208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 19:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tnL7VdGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfHOThK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:37:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36198 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfHOThJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:37:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id d23so2851816qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B7ZU3Bek5iBR0Gc89ftYh7TjZXjD4yEwlomz+Wjt2c=;
        b=tnL7VdGDL1IfU6GuDBD8g0drMYas0nnbVjc+7f8CZnUThvQdLzT7XOWxXXBLjg1Y14
         lm4/rSaWP/p9c9TiwpdLwVIspFL8XMuaFhv2W4/APnwO6Lkq5yNQbb97VuAkt86No62W
         4byyYEFKglar1JlJbV5SoVGpGcs8vVB7ulNv6COAP5ahYQQ3BFP00GX9pp/EUSIsFmiI
         C+6zXy6YwnvfBhu9ad48JcVkU/IYS8AeP/VF3pY/3CYccCFyZnZT2r/b9KQDac+vaNKl
         +EdL0ZkwY+b1e3Rr0nEiuuQnUOZfkzMO0xdrArQF38ZIjYDZVMd2s6DJqauS6Sx6neqY
         FcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B7ZU3Bek5iBR0Gc89ftYh7TjZXjD4yEwlomz+Wjt2c=;
        b=Makp6dfg7llbQbB7WKcp0CpCg009Idv/F73G+4G5Dy5xVWl/+Gfbnp9EyU9G5K51Im
         cFCq6kNKTVSBWHBdXWj8io/S+qIavmM5Hs+CY/PxBrgR0b5sW6itoh8fPexLU+PKxrL7
         wD/vOPW5l3zeATGyE4NOHk/lWk0aF+wUKdLcIR/IN1+S0abUKx5BaqXAJF5ewHoTqNVY
         7GyH/rCQn/AuzVO66GRZD0BaARaneLO0St+xz02a2ysonvnWwgrrf7V632JVTnysmjDl
         a1BvDa9SJ2PMFBG3pppTotLZQKLKEyv8M66SypuFrSviHAsNr0l2AwqRrD/NA0PsPYuC
         aerw==
X-Gm-Message-State: APjAAAWGdBaEagEfCv6o5vGPjB4yzynPFsG0wi59Gsr6SQZ+BcD95Ylv
        IS+JSy3Cffx3Tz8NTdl+P53qYzF+AAZdSY4QZQoDtQ==
X-Google-Smtp-Source: APXvYqyN/Rpqc+hcug45XccFd01EyKUDyLxn6LexP6EjGyp4UwYCtw4O8N3LruktHoRZPbqNumM+D2HKyuMZBe8Knr8=
X-Received: by 2002:a37:c40d:: with SMTP id d13mr5642585qki.8.1565897829056;
 Thu, 15 Aug 2019 12:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de>
 <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de> <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
 <20190814073854.GA27249@lst.de> <20190814132746.GE13756@mellanox.com>
 <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com> <20190815180325.GA4920@redhat.com>
In-Reply-To: <20190815180325.GA4920@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Aug 2019 12:36:58 -0700
Message-ID: <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:07 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Aug 14, 2019 at 07:48:28AM -0700, Dan Williams wrote:
> > On Wed, Aug 14, 2019 at 6:28 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Wed, Aug 14, 2019 at 09:38:54AM +0200, Christoph Hellwig wrote:
> > > > On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> > > > > Section alignment constraints somewhat save us here. The only example
> > > > > I can think of a PMD not containing a uniform pgmap association for
> > > > > each pte is the case when the pgmap overlaps normal dram, i.e. shares
> > > > > the same 'struct memory_section' for a given span. Otherwise, distinct
> > > > > pgmaps arrange to manage their own exclusive sections (and now
> > > > > subsections as of v5.3). Otherwise the implementation could not
> > > > > guarantee different mapping lifetimes.
> > > > >
> > > > > That said, this seems to want a better mechanism to determine "pfn is
> > > > > ZONE_DEVICE".
> > > >
> > > > So I guess this patch is fine for now, and once you provide a better
> > > > mechanism we can switch over to it?
> > >
> > > What about the version I sent to just get rid of all the strange
> > > put_dev_pagemaps while scanning? Odds are good we will work with only
> > > a single pagemap, so it makes some sense to cache it once we find it?
> >
> > Yes, if the scan is over a single pmd then caching it makes sense.
>
> Quite frankly an easier an better solution is to remove the pagemap
> lookup as HMM user abide by mmu notifier it means we will not make
> use or dereference the struct page so that we are safe from any
> racing hotunplug of dax memory (as long as device driver using hmm
> do not have a bug).

Yes, as long as the driver remove is synchronized against HMM
operations via another mechanism then there is no need to take pagemap
references. Can you briefly describe what that other mechanism is?
