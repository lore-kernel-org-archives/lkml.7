Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5624D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d0gvr2as"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfCRRIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:08:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38624 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCRRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:08:09 -0400
Received: by mail-it1-f195.google.com with SMTP id m18so4923029ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U1NXLpFkwNjuQGqwOJzx7XpsAUPIdtZCmOYfw+18ADg=;
        b=d0gvr2as+odTTfrhN3sKuzoC0fpqQrLXMCTXX7uL85mPz0tvD/f+UQrvmiKZZVPSM7
         Nw/m7TRVk4HZqSdu8HvCtuM2En6xubpTJ1b14+P2hxL7DKbbamGXqdq2eybR3/n4g0tQ
         U/zP8VagmQ5UkJaGxW5CWgG5gLn0wbliw1ho0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U1NXLpFkwNjuQGqwOJzx7XpsAUPIdtZCmOYfw+18ADg=;
        b=RF7smqd+ypPPCQZyThUCMhmoxA19h7QbN6hKuZbXVbHDlzuD6b0cwFwJutubguYnOB
         vMJyn4nfbLpY2n+/1X5LeRlDVjQjBImyQD/GaPJmEf41GZk0xmhV14WetF4zTGO0I3me
         cOWbR2PLdz4mIfZtILSZu/8q4ZK9VmcNw2GgLzl0zqVQPfDhcKo+yfxdfqBI13170+9e
         TmmmwpiGLIoJW1iQg6spkTjHKLK5HB+nXbHIIxq2YeJg0J8yJ8YWFUvgzJ1BHCgzTU+H
         MvzcX1ITDwD2Fjx+yYuDyNtBFstSxTuPlJB+On5nxwX3phueA1jOrrObacsx+eqGTLXd
         16vg==
X-Gm-Message-State: APjAAAViajQ21KnLvXEEKmx9VfyTYatN0DBUcjyJQdYzgBkH5FXyOrGJ
        pJwq+o5JcIymCpR5vHtJS9kgW4mlYV4jOgcuscMHWg==
X-Google-Smtp-Source: APXvYqzl1L+OnPV7AeuHYAJ9a+Yqk/9qRzdDybou+Y1sd97fO0c313O7KJ5ofprVuLlrLL5z7A4u+BGTPE2Yg85OT+A=
X-Received: by 2002:a02:23cd:: with SMTP id u196mr11120242jau.103.1552928888279;
 Mon, 18 Mar 2019 10:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
 <20190315130825.9005-2-jagan@amarulasolutions.com> <c52be751ac1bc7b1ee21e3e2a30d5b494bf95faa.camel@bootlin.com>
 <CAMty3ZBOTOR4hHfPE4Ufhb2+VoNJfFQwiii1kti263fi7DEEaQ@mail.gmail.com> <b3f7e096c94347b7a244d5278a38d9ced99218d1.camel@bootlin.com>
In-Reply-To: <b3f7e096c94347b7a244d5278a38d9ced99218d1.camel@bootlin.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 18 Mar 2019 22:37:57 +0530
Message-ID: <CAMty3ZC2M=+Xb1OK0ZtU6wbKzmdYvHoTGSRouqKhMV+xk6DzRA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/6] drm/bridge: Export drm_bridge_detach
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:27 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> Le lundi 18 mars 2019 =C3=A0 22:18 +0530, Jagan Teki a =C3=A9crit :
> > Hi Paul,
> >
> > On Fri, Mar 15, 2019 at 6:58 PM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > Hi Jakan,
> > >
> > > On Fri, 2019-03-15 at 18:38 +0530, Jagan Teki wrote:
> > > > Export drm_bridge_detach from drm bridge core so-that it
> > > > can use on respective interface or bridge driver while
> > > > detaching the bridge.
> > >
> > > I don't see why this change is required based on the commit log. The
> > > DRM bridge code clearly indicates that drm_bridge_attach should *not*
> > > be balanced with a drm_bridge_detach call in the driver, so this seem=
s
> > > quite wrong.
> > >
> > > The DRM core itself should handle detaching the bridge, not the drive=
r.
> > > Is there any reason why you need to do things differently for DSI?
> >
> > Yes, you are correct the detach of bridge is being taking care via
> > drm_encoder_cleanup. This patch exported explicitly, since we need to
> > taken care bridge detach during unbind even exynos_drm_dsi in other
> > patch seems using detach by explicitly pointing.
>
> I can see that from your patches, but you are not explaining why you
> need the change. And if the framework doesn't work for your case, you
> should certainly try and fix the framework instead of working around
> the issue.

Please see below comments.

>
> Anyway, you should probably look into using drm_panel_bridge_add, it
> might fix the underlying issue on its own.
>
> > so I think the better approach is to use drm_encoder_cleanup in
> > unbind, what do you say?
>
> I any case, you need to state what your problem is (in the commit log,
> and not even in subsequent discussions) so that we can have a chance to
> understand it and provide some feedback about what is an appropriate
> fix and what is not. We can't understand the fix if we can't understand
> the underlying issue.

True, if my intentions is trying to fix some issue, but as I said in
previous mail since the other dsi (exynos_drm_dsi) driver is
explicitly detaching I presume it require or missed the export, not
thought about fix and neither I mentioned on the commit head.  Anyway
thanks for the review, will update the code accordingly in next
version.
