Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88634C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8FC22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfGYOhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:37:23 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:38403 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729058AbfGYOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:37:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 68FA18047AB9;
        Thu, 25 Jul 2019 14:37:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mist49_3f8efb7ea8d42
X-Filterd-Recvd-Size: 3266
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 14:37:16 +0000 (UTC)
Message-ID: <cc582041ad4a33780a7101b3df9d03bf36a2a280.camel@perches.com>
Subject: Re: [PATCH 03/12] drm: aspeed_gfx: Fix misuse of GENMASK macro
From:   Joe Perches <joe@perches.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jul 2019 07:37:14 -0700
In-Reply-To: <CACPK8Xd3+iwkuw-Ofwf+Hy1Ez5-1pBvnk_G4xT72ZQdOVd7Sag@mail.gmail.com>
References: <cover.1562734889.git.joe@perches.com>
         <cddd7ad7e9f81dec1e86c106f04229d21fc21920.1562734889.git.joe@perches.com>
         <2a0c5ef5c7e20b190156908991e4c964a501d80a.camel@perches.com>
         <4f6709f8-381f-415c-8569-798b074b66c5@www.fastmail.com>
         <4e5bc8d61436024a30a8fb6a1516e29e23a75ede.camel@perches.com>
         <CACPK8Xd3+iwkuw-Ofwf+Hy1Ez5-1pBvnk_G4xT72ZQdOVd7Sag@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 02:52 +0000, Joel Stanley wrote:
> On Thu, 25 Jul 2019 at 01:18, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-07-25 at 10:40 +0930, Andrew Jeffery wrote:
> > > On Thu, 25 Jul 2019, at 02:46, Joe Perches wrote:
> > > > On Tue, 2019-07-09 at 22:04 -0700, Joe Perches wrote:
> > > > > Arguments are supposed to be ordered high then low.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > > ---
> > > > >  drivers/gpu/drm/aspeed/aspeed_gfx.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > > index a10358bb61ec..095ea03e5833 100644
> > > > > --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> > > > > @@ -74,7 +74,7 @@ int aspeed_gfx_create_output(struct drm_device *drm);
> > > > >  /* CTRL2 */
> > > > >  #define CRT_CTRL_DAC_EN                  BIT(0)
> > > > >  #define CRT_CTRL_VBLANK_LINE(x)          (((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
> > > > > -#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(20, 31)
> > > > > +#define CRT_CTRL_VBLANK_LINE_MASK        GENMASK(31, 20)
> > > 
> > > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> > 
> > This hardly needs a review, it needs to be applied.
> > There's a nominal git tree for aspeed here:
> > 
> > T:      git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> > 
> > But who's going to do apply this?
> 
> This is a DRM patch, so it goes through the DRM tree. I am a
> co-maintainer there and can apply it once I remember how to drive the
> tools.
> 
> (FYI, this macro is not used by the current driver).

Then perhaps CRT_CTRL_VBLANK and _MASK defines
should be removed instead.

cheers, Joe

