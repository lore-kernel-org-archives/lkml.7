Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5BC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 03:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9C1214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 03:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfF2DeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 23:34:25 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:2567 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfF2DeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 23:34:24 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 23:34:24 EDT
X-Halon-ID: e98c0dff-9a1d-11e9-8601-0050569116f7
Authorized-sender: niklas.soderlund@fsdn.se
Received: from localhost (unknown [145.14.112.32])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPSA
        id e98c0dff-9a1d-11e9-8601-0050569116f7;
        Sat, 29 Jun 2019 05:28:08 +0200 (CEST)
Date:   Sat, 29 Jun 2019 05:28:17 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@fsdn.se>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] media: v4l2-subdev: Verify arguments in
 v4l2_subdev_call()
Message-ID: <20190629032817.GQ32581@bigcity.dyn.berto.se>
References: <20190520212747.368-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520212747.368-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch breaks rcar-vin. I'm sorry I did not find out before it was 
merged as a8fa55078a7784a9 ("media: v4l2-subdev: Verify arguments in 
v4l2_subdev_call()").

The problem is that rcar-vin calls enum_mbus_code in its bound callback.  
At this point call_enum_mbus_code() is invoked which then calls 
check_pad(). At this point sd->entity.graph_obj.mdev is not set so the 
check if (pad > 0) fails and the binding of the subdevice in rcar-vin 
fails.

I'm not sure how to best solve this, suggestions are appreciated. I see 
two options, move the call to enum_mbus_code from the bound to the 
complete callback or make sure the mdev is associated with the subdev 
before the bound callback is invoked. I don't like the former as I think 
the complete callback should be removed ;-)

On 2019-05-20 23:27:44 +0200, Janusz Krzysztofik wrote:
> Correctness of format type (try or active) and pad ID parameters passed
> to subdevice operation callbacks is now verified only for IOCTL calls.
> However, those callbacks are also used by drivers, e.g., V4L2 host
> interfaces.
> 
> Since both subdev_do_ioctl() and drivers are using v4l2_subdev_call()
> macro while calling subdevice operations, move those parameter checks
> from subdev_do_ioctl() to v4l2_subdev_call().  Also, add check for
> non-NULL pointers, including pad config if V4L2_SUBDEV_FORMAT_TRY is
> requested.
> 
> Having that done, we can avoid taking care of those checks inside
> drivers.
> 
> Janusz Krzysztofik (3):
>   media: v4l2-subdev: Verify arguments in v4l2_subdev_call()
>   media: v4l2-subdev: Verify v4l2_subdev_call() pointer arguments
>   media: v4l2-subdev: Verify v4l2_subdev_call() pad config argument
> 
>  drivers/media/v4l2-core/v4l2-subdev.c | 268 +++++++++++++++++---------
>  include/media/v4l2-subdev.h           |   6 +
>  2 files changed, 188 insertions(+), 86 deletions(-)
> 
> Changelog:
> v6->v7:
> Changes suggested by Sakari - thanks!
> - never succeed pad check on media entities with pad_num == 0,
> - allow pad 0 on subdevies not registered as media entities.
> 
> v5->v6:
> - rename wrappers to call_something() as suggested by Sakari - thanks!
> - make check_ functions inline - also on Sakari's suggestion, thanks!
> - drop patch 2/4 and remove WARN_ONs from remaining patches to avoid
>   kernel WARNs on non-kernel bugs - thanks Hans for pointing this out!
> 
> v4->v5:
> - a few coding style and code formatting changes,
> - require CONFIG_MEDIA_CONTROLLER, not CONFIG_VIDEO_V4L2_SUBDEV_API,
>   for a valid pad ID check,
> - perform pad ID check only if at least one pad is configured so
>   drivers which don't configure pads are not affected if built with
>   CONFIG_MEDIA_CONTROLLER defined,
> - issue kernel warnings on invalid parameters (new patch - 2/4),
> - validate pointers before using them (new patch - 3/4).
> 
> v3->v4:
> - fix 'struct' keyword missing from patch 2/2,
> - fix checkpatch reported style issue in patch 2/2
> Sorry for that.
> 
> v2->v3:
> - add patch 2/2 with pad config check,
> - adjust continuation line alignments in patch 1/2 to match those
>   used in 2/2.
> 
> v1->v2:
> - replace the horrible macro with a structure of wrapper functions;
>   inspired by Hans' and Sakari's comments - thanks!
> 
> -- 
> 2.21.0
> 
