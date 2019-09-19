Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696E5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D821907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="PlX2yOux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfISNMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:12:48 -0400
Received: from vps.xff.cz ([195.181.215.36]:49264 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732283AbfISNMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1568898764; bh=DsLnHJtgS83n/ESig8HWVUvNCRcNXSJ22qlrHekhpfk=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=PlX2yOuxJo7EI/ZuDl0v0lWeTHR2hEjJeivFtp6182wKcULZyqYMCnNLTmugvzWI/
         Ewkq4k2GKxXzobl/GH7s23k2Dkt0ybMpvzPPYc1ORbeSsiddqpofc2/9DtwNrMjlCz
         oeaXU5KXCeoOhbrg5eOnkrJNZma7Kl5Q/q0wi2iQ=
Date:   Thu, 19 Sep 2019 15:12:44 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun8i-ui/vi: Fix layer zpos change/atomic
 modesetting
Message-ID: <20190919131244.35hmnp7jizegltp7@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190914220337.646719-1-megous@megous.com>
 <20190918141734.kerdbbaynwutrxf6@gilmour>
 <20190918152309.j2dbu63jaru6jn2t@core.my.home>
 <20190918201617.5gwzmshoxbcxbmrx@gilmour>
 <20190919122058.fhpuafogdq7oir2d@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919122058.fhpuafogdq7oir2d@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 02:20:58PM +0200, megous hlavni wrote:
> On Wed, Sep 18, 2019 at 10:16:17PM +0200, Maxime Ripard wrote:
> > On Wed, Sep 18, 2019 at 05:23:09PM +0200, Ondřej Jirman wrote:
> > > Hi,
> > >
> > > On Wed, Sep 18, 2019 at 04:17:34PM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >
> > > > On Sun, Sep 15, 2019 at 12:03:37AM +0200, megous@megous.com wrote:
> > > > > From: Ondrej Jirman <megous@megous.com>
> > > > >
> > > > > There are various issues that this re-work of sun8i_[uv]i_layer_enable
> > > > > function fixes:
> > > > >
> > > > > - Make sure that we re-initialize zpos on reset
> > > > > - Minimize register updates by doing them only when state changes
> > > > > - Fix issue where DE pipe might get disabled even if it is no longer
> > > > >   used by the layer that's currently calling sun8i_ui_layer_enable
> > > > > - .atomic_disable callback is not really needed because .atomic_update
> > > > >   can do the disable too, so drop the duplicate code
> > > > >
> > > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > >
> > > > It looks like these fixes should be in separate patches. Is there any
> > > > reason it's not the case?
> > >
> > > Bullet points just describe the resulting effect/benefits of the change to fix
> > > the pipe control register update issue (see the referenced e-mail).
> > 
> > It's definitely ok to have multiple patches needed to address a single
> > perceived issue.
> 
> Yes, but I can't simply split the patch. In order for each change to work on its
> own, they'd have to be done differently than the final result.
> 
> I wouldn't mind at all if it was just a simple splitting, but you're asking
> for too much work, this time, for no benefit that I can see.
> 
> > A commit is not about what you're fixing but what you're changing. And
> > the fact that you have tha bullet list in the first place proves that
> > you have multiple logical changes in your patch.
> > 
> > And even then, your commit log mentions that you're fixing multiple
> > issues (without explaining them).
> 
> I can reword the commit message if that helps, and skip the bullet list if it
> is confusing. There's a single core issue and that is that the driver doesn't
> update the pipe/channel configuration correctly leading to disabling of
> arbitrary layers (not even those being updated - update of UI layer may disable
> VI layer as a side effect for example) at wrong times. And only changes
> necessary to debug/fix this are included.

How about this:

 A problem was found where identical configuration of planes leads
 to different register settings at the HW layer when using a X server
 with modesetting driver and one plane marked as a cursor.
  
 On first run of the X server, only the black screen and the layer
 containing the cursor is visible. Switching to console and back
 corrects the situation.
 
 I have dumped registers, and found out this:

 (In both cases there are two enabled planes, plane 1 with zpos 0 and
 plane 3 with zpos 1).
 
 1) First Xorg run:
 
   0x01101000 : 00000201
   0x01101080 : 00000030
 
   BLD_FILL_COLOR_CTL: (aka SUN8I_MIXER_BLEND_PIPE_CTL)
     P1_EN
 
   BLD_CH_RTCTL: (aka SUN8I_MIXER_BLEND_ROUTE)
     P0_RTCTL channel0
     P1_RTCTL channel3
 
 2) After switch to console and back to Xorg:
 
 0x01101000 : 00000301
 0x01101080 : 00000031
 
   BLD_FILL_COLOR_CTL:
     P1_EN and P0_EN
 
   BLD_CH_RTCTL:
     P0_RTCTL channel1
     P1_RTCTL channel3
 
 What happens is that sun8i_ui_layer_enable() function may disable
 blending pipes even if it is no longer assigned to its layer, because
 of incorrect state/zpos tracking in the driver.
 
 In particular, layer 1 is configured to zpos 0 and thus uses pipe 0.
 When layer 3 is enabled by X server, sun8i_ui_layer_enable() will get
 called with old_zpos=0 zpos=1, which will lead to disabling of pipe 0.
 
 In general this issue can happen to any layer during enable or zpos
 changes on multiple layers at once.
 
 To correct this we now pass previous enabled/disabled state of the
 layer, and pass real previous zpos of the layer to
 sun8i_ui_layer_enable() and rework the sun8i_ui_layer_enable() function
 to react to the state changes correctly. In order to not complicate
 the atomic_disable callback with all of the above changes, we simply
 remove it and implement all the chanes as part of atomic_update, which
 also reduces the code duplication.
 
 To make this all work, initial zpos positions of all layers need to be
 restored to initial values on reset.


> I may try generating a nicer patch with a different diff options, if it makes it
> more readable for review.
> 
> > > I can maybe split off the first bullet point into a separate patch. But
> > > I can't guarantee it will not make the original issue worse, because it might
> > > have been hiding the other issue with register updates.
> > >
> > > The rest is just a result of the single logical change. It doesn't work
> > > individually, it all has the goal of fixing the issue as a whole.
> > >
> > > If I were to split it I would have to actually re-implement .atomic_disable
> > > callback only to remove it in the next patch. I don't see the benefit.
> > 
> > Your commit log says that you remove atomic_disable. Why would you
> > remove it, to add it back, to remove it again?
> 
> Because if I remove it I need to re-implement the functionality in the update
> callback. The core will change what is called based on presence of callbacks.
> It's not a simple removal.
> 
> If I first implement the new sun8i_[uv]i_layer_enable and update callback,
> keeping a disable callback would not work, because the new update callback
> will only work if disable callback is not defined (because it it is, then
> the drm core will not call the update callback in all cases that I need).
> 
> regards,
> 	o.
> 
> > Maxime
> 
> 
> 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
