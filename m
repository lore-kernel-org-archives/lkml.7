Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50654C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2851021901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ge0uFG/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfGVS0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:26:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46210 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGVS0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:26:48 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so76027666iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xd8+bke3yG/y3dYsucasUXPsB26BxcN6ADe6/HW5ETc=;
        b=Ge0uFG/2wqPxirgpCGl6xtgNoTIUW/0V8GH3t6EBdA4MT1xJr201XDTOPkxjai9n3b
         0yFoJhBVZPr8eyCdj/JzM3tbg1v30b+8GOuw71B7wiUoaGEz/c2Qs2fC68TjR70vEGEp
         AQxg/IxGsAVXB9moRs7/lxX+IFyhUw45JXbI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xd8+bke3yG/y3dYsucasUXPsB26BxcN6ADe6/HW5ETc=;
        b=cIfiiprRIfMub/5ZLYjr87jb6Ct5mgrWpcySnpKyaPVSYbECu+nQJ0dud5tPPods+J
         8AgKA5u+G36KfDr+fXWifhw5pO7jBu6IJF4/BLn60QX1rXyHwTU/Xto0F1Nle74TY7PB
         N4V0RRmmdfYJlurogfC+ADcmFPj29PwoGzqSUZ58C85z2vJUN9Bf3I9zL00ANra5ezup
         H+hwSGZfESYG5c7gKvRiJxyssE/OwdQ/G6Nfyy41Kj6REAZLbWJBY5ElQN0oEzaAwiIb
         syAMH0KZobRFW0qCy5rQhQqHDMHWH2w2xd8AZNNnSuIxqOyTmBGHOo9jQbt3fWHmKFqI
         XhMw==
X-Gm-Message-State: APjAAAWhvccocrC0XaOyXmvUfMtYHDJTPacNvIXUffLwtETJvTCkGRoq
        L9jIg/niEin711roUAqM687+/XJm13I=
X-Google-Smtp-Source: APXvYqzBE4bNqXvIFEwmvf+DM7VWOnQbd4doaWgIZfPBTNs2Htij4w1mHL/qJp0fb4QAwLNboUaS8w==
X-Received: by 2002:a02:cd83:: with SMTP id l3mr38909559jap.66.1563820007561;
        Mon, 22 Jul 2019 11:26:47 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id t14sm34301490ioi.60.2019.07.22.11.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 11:26:46 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id g20so76071625ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:26:46 -0700 (PDT)
X-Received: by 2002:a5e:db0a:: with SMTP id q10mr50198497iop.168.1563820006498;
 Mon, 22 Jul 2019 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190712163333.231884-1-dianders@chromium.org>
 <20190717173317.GA4862@ravnborg.org> <20190721093815.GA4375@ravnborg.org>
In-Reply-To: <20190721093815.GA4375@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jul 2019 11:26:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+JR1r1+w1QRpOTu4jjr6AKy_DV_cetqRONO+dGgnFJw@mail.gmail.com>
Message-ID: <CAD=FV=X+JR1r1+w1QRpOTu4jjr6AKy_DV_cetqRONO+dGgnFJw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: simple: Doxygenize 'struct panel_desc'; rename
 a few functions
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 21, 2019 at 2:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Doug.
>
> On Wed, Jul 17, 2019 at 07:33:17PM +0200, Sam Ravnborg wrote:
> > Hi Doug.
> >
> > On Fri, Jul 12, 2019 at 09:33:33AM -0700, Douglas Anderson wrote:
> > > This attempts to address outstanding review feedback from commit
> > > b8a2948fa2b3 ("drm/panel: simple: Add ability to override typical
> > > timing").  Specifically:
> > >
> > > * It was requested that I document (in the structure definition) that
> > >   the device tree override had no effect if 'struct drm_display_mode'
> > >   was used in the panel description.  I have provided full Doxygen
> > >   comments for 'struct panel_desc' to accomplish that.
> > > * panel_simple_get_fixed_modes() was thought to be a confusing name,
> > >   so it has been renamed to panel_simple_get_display_modes().
> > > * panel_simple_parse_override_mode() was thought to be better named as
> > >   panel_simple_parse_panel_timing_node().
> > >
> > > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Thanks.
> >
> > I updated the $subject to:
> >     drm/panel: simple: document panel_desc; rename a few functions
> >
> > And pushed out to drm-misc-next.
>
> I see the following error printed at each boot:
>
>     /panel: could not find node 'panel-timing'
>
> The error originates from this snip (from panel-simple.c):
>
>        if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
>                 panel_simple_parse_panel_timing_node(dev, panel, &dt);
>
> of_get_display_timing() returns -2 (-ENOENT).
>
> In the setup I use there is no panel-timing node as the timing specified
> in panel-simple.c is fine.
> This is the typical setup - and there should not in the normal case
> be printed error messages like this during boot.
>
> Will you please take a look at this.

Breadcrumbs: series has been posted to address this.  PTAL.

https://lkml.kernel.org/r/20190722182439.44844-1-dianders@chromium.org


-Doug
