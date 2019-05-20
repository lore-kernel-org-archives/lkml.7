Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85790C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC3D206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfETRxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:53:10 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:50144 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfETRxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:53:10 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id AF5B5803DF;
        Mon, 20 May 2019 19:53:04 +0200 (CEST)
Date:   Mon, 20 May 2019 19:53:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Yisheng Xie <ysxie@foxmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 27/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
Message-ID: <20190520175303.GA31421@ravnborg.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-28-daniel.vetter@ffwll.ch>
 <20190520172008.GB27230@ravnborg.org>
 <CAKMK7uEfyaex+kWyphReA9uaX9p21hDd_WquskocarvWtq1MHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEfyaex+kWyphReA9uaX9p21hDd_WquskocarvWtq1MHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=-wFEsubm2uO9Ciycw-kA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

On Mon, May 20, 2019 at 07:29:52PM +0200, Daniel Vetter wrote:
> On Mon, May 20, 2019 at 7:20 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Daniel.
> >
> > > With the recursion broken in the previous patch we can drop the
> > > FBINFO_MISC_USEREVENT flag around calls to fb_blank - recursion
> > > prevention was it's only job.
> > >
> > When grepping for FBINFO_MISC_USEREVENT I get a few hits not addressed
> > in the patch below:
> >
> > drivers/video/fbdev/core/fbcon.c:                       if (!(info->flags & FBINFO_MISC_USEREVENT))
> > drivers/video/fbdev/core/fbmem.c:                       if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
> > drivers/video/fbdev/core/fbmem.c:                               info->flags &= ~FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbmem.c:               info->flags |= FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbmem.c:               info->flags &= ~FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbmem.c:               info->flags |= FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbmem.c:               info->flags &= ~FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags |= FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags &= ~FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags |= FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/core/fbsysfs.c:     fb_info->flags &= ~FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/ps3fb.c:                            info->flags |= FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/ps3fb.c:                            info->flags &= ~FBINFO_MISC_USEREVENT;
> > drivers/video/fbdev/sh_mobile_lcdcfb.c:  * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
> > include/linux/fb.h:#define FBINFO_MISC_USEREVENT          0x10000 /* event request
> >
> > The use in ps3fb looks like a candidate for removal and this file is not
> > touch in this patch series, so I guess I did not miss it.
> >
> > As I did not apply the full series maybe some of the other users was
> > already taken care of.
> 
> It's also used to break recursion around fb_set_par and fb_set_pan.
> Untangling that one would be possible, but also requires untangling
> some locking, so a lot more work. If you chase all the call paths then
> you'll noticed that the users still left have no overlap with the ones
> I'm removing here.
Now you spell it out it is obvious. I guess I never read more than fb_
and missed that we are dealing with different calls.
Thanks for the quick feedback, and sorry for the noise.

	Sam
