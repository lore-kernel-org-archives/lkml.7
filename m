Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DC4C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6C921855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="bAy5AL9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbfI3P7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:59:39 -0400
Received: from vps.xff.cz ([195.181.215.36]:44246 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731790AbfI3P7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1569859177; bh=D2ejaUWp29uDGi/bAvIoPZtXvcgt2U13kUVwsfjN680=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=bAy5AL9wyR8lQZ/ooSinafOoLY4OVl0wumhpX+V/u5L/fnoADyJ66LTqYnzt8F6uB
         vuhZu6xxYFeSRRDMUbG9iJKqZfp1uyDTvPWh+PDrHysZujX5/uIsBhfrcle2A/IukU
         9UgPwq3/qVl2BpEByIhmFriFzhbz8suwyIsUNrqw=
Date:   Mon, 30 Sep 2019 17:59:37 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun8i-ui/vi: Fix layer zpos change/atomic
 modesetting
Message-ID: <20190930155937.rtvoxprayrkxodxo@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190914220337.646719-1-megous@megous.com>
 <20190918141734.kerdbbaynwutrxf6@gilmour>
 <20190918152309.j2dbu63jaru6jn2t@core.my.home>
 <20190918201617.5gwzmshoxbcxbmrx@gilmour>
 <20190919122058.fhpuafogdq7oir2d@core.my.home>
 <20190919131244.35hmnp7jizegltp7@core.my.home>
 <20190920151142.ijistzhtcaenehx6@gilmour>
 <20190924124054.743s3tlw5qirghxo@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924124054.743s3tlw5qirghxo@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 24, 2019 at 02:40:54PM +0200, megous hlavni wrote:
> > >  On first run of the X server, only the black screen and the layer
> > >  containing the cursor is visible. Switching to console and back
> > >  corrects the situation.
> > >
> > >  I have dumped registers, and found out this:
> > >
> > >  (In both cases there are two enabled planes, plane 1 with zpos 0 and
> > >  plane 3 with zpos 1).
> > >
> > >  1) First Xorg run:
> > >
> > >    0x01101000 : 00000201
> > >    0x01101080 : 00000030
> > >
> > >    BLD_FILL_COLOR_CTL: (aka SUN8I_MIXER_BLEND_PIPE_CTL)
> > >      P1_EN
> > >
> > >    BLD_CH_RTCTL: (aka SUN8I_MIXER_BLEND_ROUTE)
> > >      P0_RTCTL channel0
> > >      P1_RTCTL channel3
> > >
> > >  2) After switch to console and back to Xorg:
> > >
> > >  0x01101000 : 00000301
> > >  0x01101080 : 00000031
> > >
> > >    BLD_FILL_COLOR_CTL:
> > >      P1_EN and P0_EN
> > >
> > >    BLD_CH_RTCTL:
> > >      P0_RTCTL channel1
> > >      P1_RTCTL channel3
> > >
> > >  What happens is that sun8i_ui_layer_enable() function may disable
> > >  blending pipes even if it is no longer assigned to its layer, because
> > >  of incorrect state/zpos tracking in the driver.
> > >
> > >  In particular, layer 1 is configured to zpos 0 and thus uses pipe 0.
> > >  When layer 3 is enabled by X server, sun8i_ui_layer_enable() will get
> > >  called with old_zpos=0 zpos=1, which will lead to disabling of pipe 0.
> > >
> > >  In general this issue can happen to any layer during enable or zpos
> > >  changes on multiple layers at once.
> > >
> > >  To correct this we now pass previous enabled/disabled state of the
> > >  layer, and pass real previous zpos of the layer to
> > >  sun8i_ui_layer_enable() and rework the sun8i_ui_layer_enable() function
> > >  to react to the state changes correctly. In order to not complicate
> > >  the atomic_disable callback with all of the above changes, we simply
> > >  remove it and implement all the chanes as part of atomic_update, which
> > >  also reduces the code duplication.
> > 
> > I'm not even sure why we need that old state. Can't we just reset
> > completely the whole thing and do the configuration all over again?
> 
> That would be nice from a dev standpoint if we can get a complete state for all
> planes at once from DRM core, but how? DRM helper gives callbacks
> for updating individual planes with prev and new state. These individual layer
> change notifications don't map nicely to how pipes are represented in the mixer
> registers.

If anyone wants to pursue this further, feel free to. I'm not planning to
pursue this fix further, at the moment.

regards,
	o.
