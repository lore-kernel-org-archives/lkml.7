Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13FDC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED91208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFYOMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:12:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:12:20 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hfmBE-0004Im-Hb; Tue, 25 Jun 2019 16:12:16 +0200
Message-ID: <1561471935.2587.11.camel@pengutronix.de>
Subject: Re: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms
 wait
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Harry Wentland <harry.wentland@amd.com>, airlied@gmail.com,
        natechancellor@gmail.com
Cc:     sunpeng.li@amd.com, Anthony.Koo@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Jun.Lei@amd.com, Bhawanpreet.Lakha@amd.com,
        christian.koenig@amd.com
Date:   Tue, 25 Jun 2019 16:12:15 +0200
In-Reply-To: <20190625140046.31682-1-harry.wentland@amd.com>
References: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
         <20190625140046.31682-1-harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harry,

Am Dienstag, den 25.06.2019, 10:00 -0400 schrieb Harry Wentland:
> arm32's udelay only allows values up to 2000 microseconds. msleep
> does the trick for us here as there is no problem if this isn't
> microsecond accurate and takes a tad longer.

A "tad" longer in this case means likely double the intended wait.
Please see "SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms)" in
Documentation/timers/timers-howto.txt.

The sleep here should use usleep_range. In general the DC code seems to
use quite a lot of the udelay busy waits. I doubt that many of those
occurrences are in atomic context, so could easily use a sleeping wait.

Digging further this seems to apply across amdgpu, not only DC.

Regards,
Lucas

> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 4c31930f1cdf..f5d02f89b3f9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -548,7 +548,7 @@ static void
> read_edp_current_link_settings_on_detect(struct dc_link *link)
>  			break;
>  		}
>  
> -		udelay(8000);
> +		msleep(8);
>  	}
>  
>  	ASSERT(status == DC_OK);
