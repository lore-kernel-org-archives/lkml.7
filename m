Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544B8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2871E218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="mg/ptGc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfIRPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:23:12 -0400
Received: from vps.xff.cz ([195.181.215.36]:59682 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfIRPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1568820189; bh=kRc8vp8BAB11xc+/TQcnK+fReDy51rfmeTkpuKM5zHM=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=mg/ptGc6dXUGFsO2H5hLJjbsOQ/VgVQSZiexphZP1C1FRS1rwh7D7VzHbTc1W3NSr
         ZYM44/sJcvtiR+3pt+Zcn/oMif/DRC2uHY4PIssBohbuPYA/yCwbeSLTNZ7phlMH7m
         3IsVRn3Rd/LOktCj5i5Z4/V1/9Qniz007k7EQ3dk=
Date:   Wed, 18 Sep 2019 17:23:09 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun8i-ui/vi: Fix layer zpos change/atomic
 modesetting
Message-ID: <20190918152309.j2dbu63jaru6jn2t@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190914220337.646719-1-megous@megous.com>
 <20190918141734.kerdbbaynwutrxf6@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918141734.kerdbbaynwutrxf6@gilmour>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 18, 2019 at 04:17:34PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Sep 15, 2019 at 12:03:37AM +0200, megous@megous.com wrote:
> > From: Ondrej Jirman <megous@megous.com>
> >
> > There are various issues that this re-work of sun8i_[uv]i_layer_enable
> > function fixes:
> >
> > - Make sure that we re-initialize zpos on reset
> > - Minimize register updates by doing them only when state changes
> > - Fix issue where DE pipe might get disabled even if it is no longer
> >   used by the layer that's currently calling sun8i_ui_layer_enable
> > - .atomic_disable callback is not really needed because .atomic_update
> >   can do the disable too, so drop the duplicate code
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> It looks like these fixes should be in separate patches. Is there any
> reason it's not the case?

Bullet points just describe the resulting effect/benefits of the change to fix
the pipe control register update issue (see the referenced e-mail).

I can maybe split off the first bullet point into a separate patch. But
I can't guarantee it will not make the original issue worse, because it might
have been hiding the other issue with register updates.

The rest is just a result of the single logical change. It doesn't work
individually, it all has the goal of fixing the issue as a whole.

If I were to split it I would have to actually re-implement .atomic_disable
callback only to remove it in the next patch. I don't see the benefit.

regards,
	o.

> Maxime
