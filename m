Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B534C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E9B21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DEshovlq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSfPjRs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfLQQBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:01:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35511 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbfLQQB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:01:29 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 57EC5214CE;
        Tue, 17 Dec 2019 11:01:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Dec 2019 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=Y
        HIMCc3/SwCjYhzOqSCPEnWxTwNP453CayjjOfzEEEA=; b=DEshovlqPlbPnnl9W
        rWoscm41p9R2HT2FQnZBMF4K0Mpu56k1+I9PssBwz8lAzJvBnluCvLnhLc7dqoeL
        51vb/t1EAhPtWEEa90JLYh+KIzs0rqEW2XLvNRZqrmERzvzjqL1Cqphon1Fw5Ycj
        AeZ71M9TU6bNOM1xV9iJmsxN4Wktw43AVts4EjK3itzRCEHfAaYNVPZEvDxyJDwB
        czWGpI/RnGNKTZv6GPd/SoAjZIuCIWt2GCoq1Bgu83hbglfBkskhnm/812sw09Vy
        jmKJj+aCByaAnC4QrCvfs2vk1YlDpE6C7itDOLq+iI99l6mjDpAMV0n3YY3oyfFZ
        9Ylzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YHIMCc3/SwCjYhzOqSCPEnWxTwNP453CayjjOfzEE
        EA=; b=SSfPjRs0n/teT+8ELHDjqJexAvfcNzNmZXDYI7Mo0h4yKN1C2Mssv7OjL
        c8LYIqcqAExc4nubBM7ACNdlf6K3gOEADVaFFB10PlwZstixjjPHJ5V8DNtKvlUI
        3W0GbmK1V7iE3C+MIKFCzulP7mJ73AV1x9TpV1jA/p6vqKT1bdxCDZJhcfw5LJ5R
        y+Kqhe2r816Qi/FQe4201wPVOrsZpuCYm+wxQBvH4O98+D50QA83W9jsTgPaxghO
        wgtSPJqE1k7+PNxd2FMsvfi1WpxqFDoUsmNZ+Eyyc3Nr1YWBkR3WS/UEUfiWZLbz
        Qj9okuoKoasEkoLrSalsjxmAQm0sg==
X-ME-Sender: <xms:1Pv4Xdd_GwUuGLKbzYRLs9N4olWgj3iJRHwAiBQw6ecosSp_wgtHtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtjedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrg
    hinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghhnecuve
    hluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:1Pv4XQesoeRACw8dYH21Py4H-7RCKANRMLsA7d0IE6GAye0-PUzZaw>
    <xmx:1Pv4XZLYJGYeWjURFkBwAnS09OKATB7Ih86x8BvrwriOnPIOmq-zMg>
    <xmx:1Pv4XWp-opwi82fJNStAcAVPMPxNXGd5_klApx4v54kev_5BUv-NlQ>
    <xmx:1vv4XZIX-GxCFKrlIxmkBMRJBCLp8nccp0qQgjyGeC6lKVhRBkku9w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 84A338005A;
        Tue, 17 Dec 2019 11:01:24 -0500 (EST)
Date:   Tue, 17 Dec 2019 17:01:22 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, sam@ravnborg.org
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: Add binding document
 for Xinpeng XPP055C272
Message-ID: <20191217160122.psxwdd6accn7soed@gilmour.lan>
References: <20191217140703.23867-1-heiko@sntech.de>
 <20191217140703.23867-2-heiko@sntech.de>
 <20191217142446.yexcmh5ox4336qmd@gilmour.lan>
 <1823876.MjdJyG0ANN@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1823876.MjdJyG0ANN@diego>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:08:49PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 17. Dezember 2019, 15:24:46 CET schrieb Maxime Ripard:
> > Hi,
> >
> > On Tue, Dec 17, 2019 at 03:07:02PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > >
> > > The XPP055C272 is a 5.5" 720x1280 DSI display.
> > >
> > > changes in v2:
> > > - add size info into binding title (Sam)
> > > - add more required properties (Sam)
> > >
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > > ---
> > >  .../display/panel/xinpeng,xpp055c272.yaml     | 48 +++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/x=
inpeng,xpp055c272.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,=
xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,x=
pp055c272.yaml
> > > new file mode 100644
> > > index 000000000000..2d0fc97d735c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c=
272.yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/sony,acx424akp.yaml#
> >
> > The ID doesn't match the file name.
> >
> > Did you run dt_bindings_check?
>
> Thanks for that pointer ... I did run dtbs_check on the binding and was
> sooo happy to not find any panel errors in the pages of other dt errors
> but till now didn't realize that there's also a dtbinding_check.

dt_bindings_check is a sanity check on the bindings
themselves. dtbs_check is using those bindings to check the device
trees.

dtbs_check used to have a dependency on dt_bindings_check, but it got
removed recently.

Maxime

>
> Will keep that in mind for future bindings  - and of course fix things
> in the next version.
>
>
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xinpeng XPP055C272 5.5in 720x1280 DSI panel
> > > +
> > > +maintainers:
> > > +  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: xinpeng,xpp055c272
> > > +  reg: true
> > > +  backlight: true
> > > +  port: true
> >
> > What is the port supposed to be doing?
>
> Hooking the display up to the dsi controller. But you're right,
> works without port as well with these single-dsi displays.
>
> I just remember needing one for the Gru-Scarlet display that needed
> to connect to two dsi controllers.
>
> So I'll drop the port node here and from my board devicetree.

It's not really what I meant though :)

If it's needed then we should definitely have it, but we should
document our expectations here: is it the input port ? output? in
which case do we want to use it since it's optional, etc.

Maxime
