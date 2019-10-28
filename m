Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A299ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9C621721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbfJ1NwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:52:14 -0400
Received: from foss.arm.com ([217.140.110.172]:40080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfJ1NwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:52:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 421DE1F1;
        Mon, 28 Oct 2019 06:52:13 -0700 (PDT)
Received: from arm.com (unknown [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081AC3F6C4;
        Mon, 28 Oct 2019 06:52:11 -0700 (PDT)
Date:   Mon, 28 Oct 2019 13:52:06 +0000
From:   Steven Price <steven.price@arm.com>
To:     "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "tomeu.vizoso@collabora.com" <tomeu.vizoso@collabora.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "wang.liang82@zte.com.cn" <wang.liang82@zte.com.cn>,
        "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>,
        "up2wing@gmail.com" <up2wing@gmail.com>
Subject: Re: [PATCH v3] drm/panfrost: fix -Wmissing-prototypes warnings
Message-ID: <20191028135205.GA31804@arm.com>
References: <31dc2f01-299c-6a52-4111-3e60e555cb9b@arm.com>
 <201910281727338249544@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201910281727338249544@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:27:33AM +0000, wang.yi59@zte.com.cn wrote:
> Hi Steve,
> 
> Thanks a lot for your time and patience :)
> 
> > On 25/10/2019 02:30, Yi Wang wrote:
> > > We get these warnings when build kernel W=1:
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:35:6: warning: no previous prototype for ‘panfrost_perfcnt_clean_cache_done’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:40:6: warning: no previous prototype for ‘panfrost_perfcnt_sample_done’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:190:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_enable’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:218:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_dump’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:250:6: warning: no previous prototype for ‘panfrost_perfcnt_close’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:264:5: warning: no previous prototype for ‘panfrost_perfcnt_init’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_perfcnt.c:320:6: warning: no previous prototype for ‘panfrost_perfcnt_fini’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_mmu.c:227:6: warning: no previous prototype for ‘panfrost_mmu_flush_range’ [-Wmissing-prototypes]
> > > drivers/gpu/drm/panfrost/panfrost_mmu.c:435:5: warning: no previous prototype for ‘panfrost_mmu_map_fault_addr’ [-Wmissing-prototypes]
> > >
> > > For file panfrost_mmu.c, make functions static to fix this.
> > > For file panfrost_perfcnt.c, include header file can fix this.
> > >
> > > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > ---
> > >
> > > v3: using tab size of 8 other than 4.
> > >
> > > v2: align parameter line and modify comment. Thanks to Steve.
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 9 +++++----
> > >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 1 +
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > > index bdd9905..871574c 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > > @@ -224,9 +224,9 @@ static size_t get_pgsize(u64 addr, size_t size)
> > >      return SZ_2M;
> > >  }
> > >
> > > -void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
> > > -                  struct panfrost_mmu *mmu,
> > > -                  u64 iova, size_t size)
> > > +static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
> > > +                    struct panfrost_mmu *mmu,
> > > +                    u64 iova, size_t size)
> >
> > Ok, I'll admit I wouldn't have spotted this unless I'd double checked by
> > applying the patch, but you still seem to have something misconfigured
> > in your editor. This is out by one character:
> >
> > static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
> > >------->------->------->-------    struct panfrost_mmu *mmu,
> > >------->------->------->-------    u64 iova, size_t size)
> >
> > There should be an extra space to align correctly.
> 
> According to [Linux kernel coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html):
> > Outside of comments, documentation and except in Kconfig, spaces are
> > never used for indentation, and the above example is deliberately broken.
> 
> If I understand corretly, the tab is enough for indentation :-)

There's a (subtle) difference between indentation and alignment.
Indentation is where the code is moved over because it is contained
within an outer statement (e.g. an 'if' or 'while'). The Linux coding
style is that this should be done with only tabs as you quote.

However when the line is a continuation of the previous line, like in
the example here, then we often need a combination of tabs/spaces to
align correctly. The desire here is that the continuation lines all
start straight after the "(" on the first line. Since that is 37
characters from the start we need 4 tabs + 5 spaces (4*8+5=37), whereas
you had 4 tabs + 4 spaces. My guess is this is because you've got the
following vim configuration:

 tabstop = 8
 softtabstop = 4
 noexpandtab

This means that pressing <tab> moves you along only 4 columns (i.e.
inserts 4 spaces), a second <tab> will then replace the spaces with a
real tab character (i.e. move another 4 columns for a total of 8).

It's probably best to set "softtabstop = 0" so that <tab> always inserts
a real tab character. You might also find it useful to make tabs
visible:

 set list
 set listchars=tab:>-

That way you can easily see where you have tab characters and spaces
(like in the example I quoted above).

Steve

> >
> > >  {
> > >      if (mmu->as < 0)
> > >          return;
> > > @@ -432,7 +432,8 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
> > >
> > >  #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
> > >
> > > -int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> > > +static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
> > > +                    u64 addr)
> >
> > Here you're off-by-one in the other direction - you need to replace the
> > final tab with 7 spaces:
> >
> > static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
> > >------->------->------->------->-------u64 addr)
> >
> > Sorry to nit-pick over this, but it's good to get your editor setup
> > correctly to ensure your formatting is correct.
> 
> Yeah, it worth time on the editor setup, and thanks again.
> 
> >
> > Thanks,
> >
> > Steve
> 
> 
> ---
> Best wishes
> Yi Wang
