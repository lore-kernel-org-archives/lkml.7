Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C78C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026B421473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kF6IRAF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDCGs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:48:29 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51080 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfDCGs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:48:29 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so9394334itk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeYBK0S27RBmj3L3TC+n/UZnOfgAtgVPy5brg1/AJMw=;
        b=kF6IRAF3edX0ckh4qESuHmWATwDBHi+JHEGvm8sPTb2DYbpL7ygr1vB+N1MkYjNIY0
         XEhpzhhSM3lF0GS/dcqI1WLwkNtnlogcKUaZlIbOjw4XIasx+it+KLwcLmKXOUfNuxZO
         UfBp7h/YfXsssRSuWZuM9VpQNeKIfqsnbWSE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeYBK0S27RBmj3L3TC+n/UZnOfgAtgVPy5brg1/AJMw=;
        b=Kqz2svDpO/QHDZbWCYWVOhUd6on/L+9+3eJH5xDP8kcGm98MBn3iSXV5vC+rbPDzCr
         aZfqzc69/rluuRljXo0f1g3JZ/ANYV12AYflTq0nV5Cft/zggUNNTDrL+g+neA0BG4ai
         SWY8nVNUfWaOGrJyiRi95O83KQLuswNy0eCVmeZwWrwtO2HE9LzryrXrOE/JvYgfKIor
         aZMgN1dqknEfgd9RsfsMGeRsooaSc5UTHOvT6dP2yo0j7wC8HXCmxBIl9saUVrp3idlL
         YIC1gdgUx1xFy3X/VzoXMgYf5Uzg4dnsDtaUHmwN/UfThl4Hzhrtvy+oj+bsf0P9jG7f
         doKg==
X-Gm-Message-State: APjAAAUarDXXTkq/5NmOcGP0XT/o8/mKf5VO4V5IjtUsp8vT0BQTfrn2
        ONaM6O2q7N/8+O+LoZ8n7l4Xv/AMwuzSyGqbF7MNHQ==
X-Google-Smtp-Source: APXvYqyn9XY+bqn2jcMVOXSXY0LKNrWZSVALOeSukFv0EnLM6961aV6Mh34o6K6T0+jFxovrPn/JQ4W5xHPBXCO6520=
X-Received: by 2002:a24:4d12:: with SMTP id l18mr620624itb.66.1554274108229;
 Tue, 02 Apr 2019 23:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
 <20190314114500.8336-1-kraxel@redhat.com> <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
 <CAKMK7uEs+OaoiEmd9Dp6K_v5Pz4pf197DP8KFkvhNMYXv9tYxA@mail.gmail.com> <20190402204325.cqu7fobzekd3ccls@sirius.home.kraxel.org>
In-Reply-To: <20190402204325.cqu7fobzekd3ccls@sirius.home.kraxel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 3 Apr 2019 08:48:16 +0200
Message-ID: <CAKMK7uHLY1RKUGbqDeHTNnx98y-FLhGWKGcG-o9KDH54=BObAg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting apertures
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 10:43 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 02, 2019 at 02:09:45PM +0200, Daniel Vetter wrote:
> > On Mon, Apr 1, 2019 at 4:00 PM Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> > >
> > >
> > > On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> > > > Simply add all pci memory bars to struct apertures_struct in
> > > > remove_conflicting_pci_framebuffers(), without depending on the
> > > > res_id parameter.
> > > >
> > > > The plan is to drop the res_id parameter later on.  For now keep the
> > > > parameter, use it for sanity-checking and warn on inconsistencies.
> > > >
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >
> > > Patch queued for v5.2, thanks.
> >
> > Might be good to also stuff this into drm (double merge or topic
> > branch, whatever you prefer), since that's where all the users are.
> > Gerd also has some follow-up patches to apply on top of this one iirc.
>
> No follow-up patches yet.  Plan is to wait a bit, see if the
> sanity-checks trigger, and if all goes well go drop the res_id
> parameter in 5.3 ...

Hm I thought you had a patch to convert i915 over. Or did that land already?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
