Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A259B2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576788511;
	bh=11d+8TOsaR+h3PcI3AJIjQ13LDs8NKzaCv3sFkDL45k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E02pzGaFnJ6ePajemKt1VKM8JJutcuQrJtS26nAxsxd6iASMnloKB44STuwx9/WBX
	 IEnOm+tx3dLifHE8useBfwyOxGtgpejCGhCp6inLQJeAqsvjVC0BOUXO2w1QqejhUl
	 hg6hDAh9hh2aRucIlwmEhQgjDa64EeTYlDWl4+CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLSUsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:48:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38264 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:48:29 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so4418153otf.5;
        Thu, 19 Dec 2019 12:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYsDTzHFnFQqFh94ii3OQBBPVqMmCO4Don5GWMELd6M=;
        b=PKysp8J0azYpvWxolL+5X5+8qbvhC0SHs5ZfCt/0eUmBBCQRediMgy4Gx7w3ppNAhu
         z013e3AdwTrCVaudHU+8irm2qlie0loJIV5gEOtXnx+1zJyGeLlaLPf8L+w3rpgzM0/6
         pnMXhBvURdWVNM2v7wkBa3ZDJbZ4sqA5AA6y8gygxS30W+fS5AsyCPsztzzPEztkRxKl
         2+AhQdg7A+zYxvwdgfZyxi5CjbLfQJwc6rtpzpuEcmW0w/Gx/e6FirKlBNiXmZQ6h7+v
         DnSGT6qfmmG/OSuK9PPv39cgRKEZBTqK4WqzrJ+7aOWMsaC0qmFdzn57T9LV4UAc2E3c
         v00w==
X-Gm-Message-State: APjAAAUks/hrTuhOExk2CqaSw90I6p3DIdHDncXWhKLpHflw6kRr56B7
        i39L5kA9HRnsOVNPtC4NXw==
X-Google-Smtp-Source: APXvYqyJMSMjyoi+YU4x++Z/hDeE6fV5GGR8Guk8WGxwZLLKVy/j7Nqvr8NBYU/caqbxoJt0GcAJ9A==
X-Received: by 2002:a9d:10d:: with SMTP id 13mr10335983otu.149.1576788509284;
        Thu, 19 Dec 2019 12:48:29 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id p65sm793744oif.47.2019.12.19.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:48:28 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:48:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: Add GPIO display mux
 binding
Message-ID: <20191219204827.GA13740@bogus>
References: <20191211061911.238393-1-hsinyi@chromium.org>
 <20191211061911.238393-4-hsinyi@chromium.org>
 <CAL_Jsq+jkgDj6-SH1FrnjB1CQmf33=XUwN3N_fw_aJsQm3Fq9A@mail.gmail.com>
 <CAJMQK-iwF78=2PDMxp=cvS3sotNi7kjj1ZoVO9q_axejUPdLYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJMQK-iwF78=2PDMxp=cvS3sotNi7kjj1ZoVO9q_axejUPdLYA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 03:16:23PM +0800, Hsin-Yi Wang wrote:
> On Sat, Dec 14, 2019 at 5:29 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Dec 11, 2019 at 12:19 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > From: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > Add bindings for Generic GPIO mux driver.
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > ---
> > > Change from RFC to v1:
> > > - txt to yaml
> > > ---
> > >  .../bindings/display/bridge/gpio-mux.yaml     | 89 +++++++++++++++++++
> > >  1 file changed, 89 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > new file mode 100644
> > > index 000000000000..cef098749066
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > @@ -0,0 +1,89 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Generic display mux (1 input, 2 outputs)
> >
> > What makes it generic? Doesn't the mux chip have power supply,
> > possibly a reset line or not, etc.? What about a mux where the GPIO
> > controls the mux?
> >
> > Generally, we avoid 'generic' bindings because h/w is rarely generic.
> > You can have a generic driver which works on multiple devices.
> >
> Then how about making it mt8173-oak-gpio-mux? Since this is currently
> only used in this board.

Isn't there an underlying part# you can use? Or if you can point me to 
multiple chips implementing the same thing, then maybe a generic binding 
is fine.

Rob
