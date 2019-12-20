Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA05C2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5D24676
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uu68m5g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLTD6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:58:02 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33605 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfLTD6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:58:02 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so8063607ioh.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 19:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4nCCF+EzJiIuxfjV2kTWNg3Z7MNbVOSCn8Lx8XGK8U=;
        b=Uu68m5g3z0N7oHxNK4TYLIAyQL54Y8wxUcLjSl2I3K3wgHJKJBUiAS1hKJHut9+Ozy
         KR3IK3MjEt3a+jdjt6m9JLZsgNfAcwdmW1QDt2LzrCQ8Pzb8W8/l0+9PjOwOuxx0WzFR
         vQLEf+/JQOavUARm496IWPyNLtwK7QcXRZ3n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4nCCF+EzJiIuxfjV2kTWNg3Z7MNbVOSCn8Lx8XGK8U=;
        b=TsHMng3A2fMgLIDo4irB7KFyvjcBgSIy0qgZu3lv6si3NCT/juyNK1KuJAM2j3sRfl
         49Nb1fQ9t8oQZTBQpot2qSAZrW1b6J1Ep46zKaVaYdw7VOgFnbZPCibli3o5Y/S8aXxw
         9yLY7NLTrf92FWNsasjJwVIXPLf8bYdn1nDzJKhCP6EzRrH1+FbrHZFD/bt54doucxeh
         Q7CVeqdDX8s0D1zw4BucCzsb+nGkiTyluFR6NelQL5VFy7DbrZlCuVQVavQtdcmyceqS
         Z6paMB9aysdw5rjf317fuJeLRKB+6oZNa6ZwyagUIwAgFk7bjYzw2LpsrFlLXlhiH6Ci
         GocQ==
X-Gm-Message-State: APjAAAVvejTFj2yc0tItUNV+6m+moNMnCRzVnM8+JZqapHQHUdVZkM36
        pcljqzBZV8SYx/O9m/OwHkt44fjAduAhsq8Sp16PFA==
X-Google-Smtp-Source: APXvYqze2GCzHNzigs0wrMKV1f5dOTa2IoCFv0kR1FK9X5FibE53e4kl8NAd0VW+nLWtv2oN+HBirF/XchUbVIFRZMw=
X-Received: by 2002:a05:6638:10e:: with SMTP id x14mr10484146jao.4.1576814281622;
 Thu, 19 Dec 2019 19:58:01 -0800 (PST)
MIME-Version: 1.0
References: <20191211061911.238393-1-hsinyi@chromium.org> <20191211061911.238393-4-hsinyi@chromium.org>
 <CAL_Jsq+jkgDj6-SH1FrnjB1CQmf33=XUwN3N_fw_aJsQm3Fq9A@mail.gmail.com>
 <CAJMQK-iwF78=2PDMxp=cvS3sotNi7kjj1ZoVO9q_axejUPdLYA@mail.gmail.com> <20191219204827.GA13740@bogus>
In-Reply-To: <20191219204827.GA13740@bogus>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 20 Dec 2019 11:57:35 +0800
Message-ID: <CAJMQK-jGw8kJFNjoHjeZUL+3NCiOS2hgGERnAnMwNsL_cm_J=Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: Add GPIO display mux binding
To:     Rob Herring <robh@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 4:48 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 03:16:23PM +0800, Hsin-Yi Wang wrote:
> > On Sat, Dec 14, 2019 at 5:29 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 12:19 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > > >
> > > > From: Nicolas Boichat <drinkcat@chromium.org>
> > > >
> > > > Add bindings for Generic GPIO mux driver.
> > > >
> > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > ---
> > > > Change from RFC to v1:
> > > > - txt to yaml
> > > > ---
> > > >  .../bindings/display/bridge/gpio-mux.yaml     | 89 +++++++++++++++++++
> > > >  1 file changed, 89 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > > new file mode 100644
> > > > index 000000000000..cef098749066
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > > > @@ -0,0 +1,89 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Generic display mux (1 input, 2 outputs)
> > >
> > > What makes it generic? Doesn't the mux chip have power supply,
> > > possibly a reset line or not, etc.? What about a mux where the GPIO
> > > controls the mux?
> > >
> > > Generally, we avoid 'generic' bindings because h/w is rarely generic.
> > > You can have a generic driver which works on multiple devices.
> > >
> > Then how about making it mt8173-oak-gpio-mux? Since this is currently
> > only used in this board.
>
> Isn't there an underlying part# you can use? Or if you can point me to
> multiple chips implementing the same thing, then maybe a generic binding
> is fine.
There are some similar chips, for example:
https://www.paradetech.com/zh-hant/%E7%94%A2%E5%93%81%E4%BB%8B%E7%B4%B9/ps8223-3-0gbps-hdmi-12-demultiplexer/
and http://www.ti.com/lit/ds/symlink/ts3dv642.pdf
If they are used in a similar way
(https://lore.kernel.org/lkml/CANMq1KDDEzPWhByEtn-EjNcg+ofVT2MW-hOXANGooYFOYJ35VA@mail.gmail.com/),
they would need such driver. But currently we only know that mt8173
oak board have this use case.
>
> Rob
