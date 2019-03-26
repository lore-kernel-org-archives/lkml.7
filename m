Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C53EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BC32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfCZAoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:44:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:51162 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCZAoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:44:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 17:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="134712607"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 17:44:15 -0700
Date:   Tue, 26 Mar 2019 08:28:52 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 02/17] fpga: dfl: fme: align PR buffer size per PR
 datawidth
Message-ID: <20190326002852.GA2901@hao-dev>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-3-git-send-email-hao.wu@intel.com>
 <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXSUMkfQu8QnN-T0B5qeA4vaGxDTvGur9EGyLbGsBFBeKQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 12:50:40PM -0500, Alan Tull wrote:
> On Sun, Mar 24, 2019 at 10:23 PM Wu Hao <hao.wu@intel.com> wrote:
> 
> Hi Hao,
> 
> Looks good, one question below.
> 
> >
> > Current driver checks if input bitstream file size is aligned or
> > not per PR data width (default 32bits). It requires one additional
> > step for end user when they generate the bitstream file, padding
> > extra zeros to bitstream file to align its size per PR data width,
> > but they don't have to as hardware will drop extra padding bytes
> > automatically.
> >
> > In order to simplify the user steps, this patch aligns PR buffer
> > size per PR data width in driver, to allow user to pass unaligned
> > size bitstream files to driver.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> >  drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> > index d9ca955..c1fb1fe 100644
> > --- a/drivers/fpga/dfl-fme-pr.c
> > +++ b/drivers/fpga/dfl-fme-pr.c
> > @@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >         struct dfl_fme *fme;
> >         unsigned long minsz;
> >         void *buf = NULL;
> > +       size_t length;
> >         int ret = 0;
> >         u64 v;
> >
> > @@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >         if (port_pr.argsz < minsz || port_pr.flags)
> >                 return -EINVAL;
> >
> > -       if (!IS_ALIGNED(port_pr.buffer_size, 4))
> > -               return -EINVAL;
> > -
> >         /* get fme header region */
> >         fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
> >                                                FME_FEATURE_ID_HEADER);
> > @@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
> >                        port_pr.buffer_size))
> >                 return -EFAULT;
> >
> > -       buf = vmalloc(port_pr.buffer_size);
> > +       /*
> > +        * align PR buffer per PR bandwidth, as HW ignores the extra padding
> > +        * data automatically.
> > +        */
> > +       length = ALIGN(port_pr.buffer_size, 4);
> > +
> > +       buf = vmalloc(length);
> 
> Since it may not be completely filled, would it be worthwhile to alloc
> a zero'ed buff?
>

Hi Alan,

Thanks for the review, acutally per spec, hw doesn't care about the
extra padding data. So for now, i guess we don't need this.

Thanks
Hao

> Alan
> 
