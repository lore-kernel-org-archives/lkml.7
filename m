Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78526C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483A72064A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfGLTxl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 15:53:41 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56979 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfGLTxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 15:53:41 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BE9A0FF804;
        Fri, 12 Jul 2019 19:53:37 +0000 (UTC)
Date:   Fri, 12 Jul 2019 21:53:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
Message-ID: <20190712195336.zgn5mseyfba2lfu7@flea>
References: <f530844d-70f2-c3cc-d5f6-b435f1dbdfd2@gmail.com>
 <20190710130615.gvi2jwgr2cds66xr@flea>
 <75719cad-c65c-7ebc-3ea8-98134f86ddc3@gmail.com>
 <4a13f12f-05a7-473e-4e4e-7a7e32d09720@gmail.com>
 <20190710140504.t5lsk36gnn5cdn6b@flea>
 <e7d78307-4a48-45b1-ffbe-bc397fec0e40@gmail.com>
 <20190711090327.keuxt2ztfqecdbef@flea>
 <de21fe78-87a6-741f-caf7-2771f6468739@gmail.com>
 <20190712081027.arybdoxr6nzrmkxt@flea>
 <686a20ce-e09a-037c-a5db-bd1309790c3e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <686a20ce-e09a-037c-a5db-bd1309790c3e@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:30:01AM +0300, Dmitry Osipenko wrote:
> 12.07.2019 11:10, Maxime Ripard пишет:
> > On Thu, Jul 11, 2019 at 06:55:03PM +0300, Dmitry Osipenko wrote:
> >> 11.07.2019 12:03, Maxime Ripard пишет:
> >>> On Wed, Jul 10, 2019 at 06:05:18PM +0300, Dmitry Osipenko wrote:
> >>>> 10.07.2019 17:05, Maxime Ripard пишет:
> >>>>> On Wed, Jul 10, 2019 at 04:29:19PM +0300, Dmitry Osipenko wrote:
> >>>>>> This works:
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> >>>>>> index 56d36779d213..e5a2f9c8f404 100644
> >>>>>> --- a/drivers/gpu/drm/drm_client_modeset.c
> >>>>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
> >>>>>> @@ -182,6 +182,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
> >>>>>>         mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
> >>>>>>         if (mode)
> >>>>>>                 list_add(&mode->head, &connector->modes);
> >>>>>> +       else
> >>>>>> +               cmdline_mode->specified = false;
> >>>>>
> >>>>> Hmmm, it's not clear to me why that wouldn't be the case.
> >>>>>
> >>>>> If we come back to the beginning of that function, we retrieve the
> >>>>> cmdline_mode buffer from the connector pointer, that will probably
> >>>>> have been parsed a first time using drm_mode_create_from_cmdline_mode
> >>>>> in drm_helper_probe_add_cmdline_mode.
> >>>>>
> >>>>> Now, I'm guessing that the issue is that in
> >>>>> drm_mode_parse_command_line_for_connector, if we have a named mode, we
> >>>>> just copy the mode over and set mode->specified.
> >>>>>
> >>>>> And we then move over to do other checks, and that's probably what
> >>>>> fails and returns, but our drm_cmdline_mode will have been modified.
> >>>>>
> >>>>> I'm not entirely sure how to deal with that though.
> >>>>>
> >>>>> I guess we could allocate a drm_cmdline_mode structure on the stack,
> >>>>> fill that, and if successful copy over its content to the one in
> >>>>> drm_connector. That would allow us to only change the content on
> >>>>> success, which is what I would expect from such a function?
> >>>>>
> >>>>> How does that sound?
> >>>>
> >>>> I now see that there is DRM_MODE_TYPE_USERDEF flag that is assigned only
> >>>> for the "cmdline" mode and drm_client_rotation() is the only place in
> >>>> DRM code that cares about whether mode is from cmdline, hence looks like
> >>>> it will be more correct to do the following:
> >>>
> >>> I'm still under the impression that we're dealing with workarounds of
> >>> a more central issue, which is that we shouldn't return a partially
> >>> modified drm_cmdline_mode.
> >>>
> >>> You said it yourself, the breakage is in the commit changing the
> >>> command line parsing logic, while you're fixing here some code that
> >>> was introduced later on.
> >>
> >> The problem stems from assumption that *any* named mode is valid. It
> >> looks to me that the ultimate solution would be to move the mode's name
> >> comparison into the [1], if that's possible.
> >>
> >> [1] drm_mode_parse_command_line_for_connector()
> >
> > Well, one could argue that video=tegrafb is invalid and should be
> > rejected as well, but we haven't cleared that up.
>
> The video=tegrafb is invalid mode, there is nothing to argue here. And
> the problem is that invalid modes and not rejected for the very beginning.

Yeah, I guess fb_get_options should also return an error in such a
case, but I'm a bit worried about the side effects here.

> >>> Can you try the followintg patch?
> >>> http://code.bulix.org/8cwk4c-794565?raw
> >>
> >> This doesn't help because the problem with the rotation_reflection is
> >> that it's 0 if "rotation" not present in the cmdline and then ilog2(0)
> >> returns -1. So the patch "drm/modes: Don't apply cmdline's rotation if
> >> it wasn't specified" should be correct in any case.
> >
> > So we would have the same issue with rotate=0 then?
>
> No, we won't. Rotation mode is parsed into the DRM_MODE bitmask and
> rotate=0 corresponds to DRM_MODE_ROTATE_0, which is BIT(0) as you may
> notice. Hence rotation_reflection=0 is always an invalid value, meaning
> that "rotate" option does not present in the cmdline. Please consult the
> code, in particular see drm_mode_parse_cmdline_options() which was
> written by yourself ;)

Sigh... You're right :)

Sorry for that, I'll reply to the other patch

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
