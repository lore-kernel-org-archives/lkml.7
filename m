Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFBFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7592A206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfDWNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:00:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55720 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfDWNAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:00:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D8BA78;
        Tue, 23 Apr 2019 06:00:15 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7139A3F557;
        Tue, 23 Apr 2019 06:00:15 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id ACA0668240D; Tue, 23 Apr 2019 14:00:13 +0100 (BST)
Date:   Tue, 23 Apr 2019 14:00:13 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Ben Davis <Ben.Davis@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] Add writeback scaling
Message-ID: <20190423130013.GX15144@e110455-lin.cambridge.arm.com>
References: <1556016490-6906-1-git-send-email-ben.davis@arm.com>
 <CAKMK7uE=m4dYodGp34Twcs-HEV4rExvvguM5m1Qt9HzUD8ZYEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uE=m4dYodGp34Twcs-HEV4rExvvguM5m1Qt9HzUD8ZYEw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:24:11PM +0200, Daniel Vetter wrote:
> On Tue, Apr 23, 2019 at 12:48 PM Ben Davis <Ben.Davis@arm.com> wrote:
> >
> > Add support for scaling on writeback. To do this add writeback_dest_w
> > and writeback_dest_h as writeback connector properties to specify the
> > desired output dimensions.
> > Then implement downscaling on writeback for Malidp-550 and Malidp-650
> > (upscaling on writeback is not supported on these devices).
> >
> > v2: Use 0 as default for writeback_w,h and so update range to use 1 as
> >     minimum.
> 
> Hm I missed that, I don't think that's good, since it prevents
> userspace from blindly writing back the properties it's read. We've
> tried hard to avoid that, since we're suggesting compositor can take a
> snapshot of all kms properties (including the ones they don't
> understand) and restore that on vt switching. Hence stuff like fence
> fds returning -1, and accepting -1 as NULL to make this work.

Is that they way it should work, though? I remember a few good years
back, before KMS, there were lots of issues with X server hanging and
not restoring the vt mode correctly. Should it not be that on getting
back control of a DRM master, an application sets it last known good
mode that it had, before it lost (or gave away) control?

> 
> tldr; I think range needs to include 0, and we need make that a
> special thing, maybe enforced with a
> drm_connector_state_compute_writeback_dst_h/w, which takes
> crtc_state->mode.v/hdisplay into account if the writeback_dst_h/w is
> 0.

Repeating just to make sure we're on the same page: we allow 0 as valid
range value, but writeback_dst_h/w ultimately gets updated before the
commit gets passed on to the driver to use crtc_state->mode.v/hdisplay
so as not to trigger any scaling. Correct?

Best regards,
Liviu


> -Daniel
> 
> >
> > v3: Rename properties to specify they are destination width/height.
> >     Make sure the values from the properties are passed to
> >     enable_memwrite rather than the framebuffer dimensions
> >
> > Ben Davis (2):
> >   drm: Add writeback_dest_w,h properties
> >   drm/malidp: Enable writeback scaling
> >
> >  drivers/gpu/drm/arm/malidp_crtc.c | 49 +++++++++++---------
> >  drivers/gpu/drm/arm/malidp_crtc.h | 12 +++++
> >  drivers/gpu/drm/arm/malidp_drv.c  | 10 +++--
> >  drivers/gpu/drm/arm/malidp_hw.c   | 45 +++++++++++++------
> >  drivers/gpu/drm/arm/malidp_hw.h   | 19 ++++++--
> >  drivers/gpu/drm/arm/malidp_mw.c   | 94 ++++++++++++++++++++++++++++++---------
> >  drivers/gpu/drm/arm/malidp_regs.h |  1 +
> >  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++
> >  drivers/gpu/drm/drm_writeback.c   | 30 +++++++++++++
> >  include/drm/drm_connector.h       |  4 ++
> >  include/drm/drm_mode_config.h     | 10 +++++
> >  11 files changed, 220 insertions(+), 62 deletions(-)
> >  create mode 100644 drivers/gpu/drm/arm/malidp_crtc.h
> >
> > --
> > 2.7.4
> >
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
