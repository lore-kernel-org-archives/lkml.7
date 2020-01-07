Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15FAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D63A2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EbjTiyiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgAGWMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:12:35 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50538 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:12:35 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7664E52F;
        Tue,  7 Jan 2020 23:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1578435154;
        bh=AXbJzKOK2zmPPbII3OVLxs1ZXTCLfVVQ/T0Ks5djkL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbjTiyiwbEq4A00sbxnPH+eeETrat7SOpeH0qx6VK1CsFFEd4qdaU0hk1jX8nEnkx
         drN4MrG3GtbTbwAtyqKJ8c3bA0URpgTwjMQyApIY/LKwYjCaRnj4SrOx8G2GIk1qvt
         PE/HZ51FKJDWKjepuZUz5ZPTREwI60iPwYue3z6E=
Date:   Wed, 8 Jan 2020 00:12:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: panel: fix excessive stack usage in
 td028ttec1_prepare
Message-ID: <20200107221222.GE7869@pendragon.ideasonboard.com>
References: <20200107212747.4182515-1-arnd@arndb.de>
 <20200107220019.GC7869@pendragon.ideasonboard.com>
 <CAK8P3a1Gt10_OLF1dXiNBxcO-seJfutcPu3w_dsHKNsDN4r7-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Gt10_OLF1dXiNBxcO-seJfutcPu3w_dsHKNsDN4r7-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jan 07, 2020 at 11:09:13PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 7, 2020 at 11:00 PM Laurent Pinchart wrote:
> > On Tue, Jan 07, 2020 at 10:27:33PM +0100, Arnd Bergmann wrote:
> > > With gcc -O3, the compiler can inline very aggressively,
> > > leading to rather large stack usage:
> > >
> > > drivers/gpu/drm/panel/panel-tpo-td028ttec1.c: In function 'td028ttec1_prepare':
> > > drivers/gpu/drm/panel/panel-tpo-td028ttec1.c:233:1: error: the frame size of 2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > >  }
> > >
> > > Marking jbt_reg_write_1() as noinline avoids the case where
> > > multiple instances of this function get inlined into the same
> > > stack frame and each one adds a copy of 'tx_buf'.
> > >
> > > Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Isn't this something that should be fixed at the compiler level ?
> 
> I suspect but have not verified that structleak gcc plugin is partly at
> fault here as well, it has caused similar problems elsewhere.
> 
> If you like I can try to dig deeper before that patch gets merged,
> and explain more in the changelog or open a gcc bug if necessary.

I think we'll need to merge this in the meantime, but if gcc is able to
detect too large frame sizes, I think it should have the ability to take
a frame size limit into account when optimizing. I haven't checked if
this is already possible and just not honoured here (possibly due to a
bug) or if the feature is entirely missing. In any case we'll likely
have to live with this compiler issue for quite some time.

-- 
Regards,

Laurent Pinchart
