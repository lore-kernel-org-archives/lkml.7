Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26336C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18492053B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577730130;
	bh=y85qsWru3mquCSNLQMiT2SqRg6FipI5QoHdTsNtINBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yYHp4n5NUeD5jHWQA5ppJBTaLhH6VvRSrWujzb0r3REqIaAQb//XgrCfl4kAkwr2t
	 xF1IURLc58O3Pvp33zBBbadwuN3ZNQ8kdYXV0ArVXt97RDGM5oYhVfWw5IEltUdNw8
	 W9uQ+IEqDdmcIDX/TtyudpThkqXYj3JEFq9yUcwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfL3SWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:22:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfL3SWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:22:08 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FA82053B;
        Mon, 30 Dec 2019 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577730127;
        bh=y85qsWru3mquCSNLQMiT2SqRg6FipI5QoHdTsNtINBw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nk/+OB8I1A/tho1qYFMzykNRkLCDzDTeOXxHgf9FZD9DK2KCX9PRy+bL9he3hBsb9
         iwaye8QwmfpHaJpbg0eVXGj/ISakmacPgYgiPIIYuZ18eGnD/F4f9pjdHJeBFi1hcN
         Twxtlylj+/H+7ewb3JqkfhvAZdVB1irVRMDT29cY=
Received: by mail-qk1-f173.google.com with SMTP id t129so26808299qke.10;
        Mon, 30 Dec 2019 10:22:07 -0800 (PST)
X-Gm-Message-State: APjAAAVO9IQeMe9Te7MPR+m3lFnTaXT/k1PigFb0CO4wp8PvfZyLfwTv
        6z7K8zu8iUjrqnFg2JSdWUK7qSqjFoz7XME+Pw==
X-Google-Smtp-Source: APXvYqzqZJWNs+sslqC+8ZeBAuoujPITSyr59D77wL4ZRh24oPbPEKS5xit8eSBZTP/cXCoRZdcWY0dX3rMp4gxn/tA=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr56825281qkn.254.1577730126720;
 Mon, 30 Dec 2019 10:22:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575906694.git.jsarha@ti.com> <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
 <20191219190833.GA16358@bogus> <3cf64e30-6b4d-a138-7164-54d1cdc8e05a@ti.com>
 <CAL_JsqKNFbPebM=pC+GL_DMuf5OPZF4FyJ7KGdSonDAeL_3P1A@mail.gmail.com> <15d0bd42-5bb5-ee14-9e2a-7beb55671e8a@ti.com>
In-Reply-To: <15d0bd42-5bb5-ee14-9e2a-7beb55671e8a@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Dec 2019 11:21:55 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK-h-dwQ+T_nATsiBAS8yuV5yp+ZD9=iT-=VBi3+2SvVQ@mail.gmail.com>
Message-ID: <CAL_JsqK-h-dwQ+T_nATsiBAS8yuV5yp+ZD9=iT-=VBi3+2SvVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: phy: Add lane<n>-mode property to WIZ
 (SERDES wrapper)
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 2:37 AM Jyri Sarha <jsarha@ti.com> wrote:
>
> On 24/12/2019 23:31, Rob Herring wrote:
> > On Fri, Dec 20, 2019 at 5:52 AM Jyri Sarha <jsarha@ti.com> wrote:
> >>
> >> On 19/12/2019 21:08, Rob Herring wrote:
> >>> On Mon, Dec 09, 2019 at 06:22:11PM +0200, Jyri Sarha wrote:
> >>>> Add property to indicate the usage of SERDES lane controlled by the
> >>>> WIZ wrapper. The wrapper configuration has some variation depending on
> >>>> how each lane is going to be used.
> >>>>
> >>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> >>>> ---
> >>>>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ++++++++++++
> >>>>  1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >>>> index 94e3b4b5ed8e..399725f65278 100644
> >>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >>>> @@ -97,6 +97,18 @@ patternProperties:
> >>>>        Torrent SERDES should follow the bindings specified in
> >>>>        Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> >>>>
> >>>> +  "^lane[1-4]-mode$":
> >>>> +    allOf:
> >>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +      - enum: [0, 1, 2, 3, 4, 5, 6]
> >>>> +    description: |
> >>>> +     Integer describing static lane usage for the lane indicated in
> >>>> +     the property name. For Sierra there may be properties lane0 and
> >>>> +     lane1, for Torrent all lane[1-4]-mode properties may be
> >>>> +     there. The constants to indicate the lane usage are defined in
> >>>> +     "include/dt-bindings/phy/phy.h". The lane is assumed to be unused
> >>>> +     if its lane<n>-use property does not exist.
> >>>
> >>> The defines were intended to be in 'phys' cells. Does putting both lane
> >>> and mode in the client 'phys' properties not work?
> >>>
> >>
> >> Let me first check if I understood you. So you are suggesting something
> >> like this:
> >>
> >> dp-phy {
> >>         #phy-cells = <5>; /* 1 for phy-type and 4 for lanes = 5 */
> >>         ...
> >> };
> >>
> >> dp-bridge {
> >>         ...
> >>         phys = <&dp-phy PHY_TYPE_DP 1 1 0 0>; /* lanes 0 and 1 for DP */
> >
> > Yes, but I think the lanes can be a single cell mask. And I'd probably
> > make that the first cell which is generally "which PHY" and make
> > type/mode the 2nd cell. I'd look for other users of PHY_TYPE_ defines
> > and match what they've done if possible.
> >
>
> I see. This will cause some head ache on the driver implementation side,
> as there is no way for the phy driver to peek the lane use or type from
> the phy client's device tree node.

Yes, there is a way. Not really fast, but use
for_each_node_with_property(node, "phys") and filter on ones matching
your phy's node.

> It also looks to me that the phy
> API[1] has to be extended quite a bit before the phy client can pass the
> lane usage information to the phy driver. It will cause some pain to
> implement the extension without breaking the phy API and causing a nasty
> cross dependency over all the phy client domains.

Not really a concern from a binding standpoint. Bindings shouldn't be
designed around some OS's current design or limitations.

There's already several cases using PHY_TYPE_* in phy cells, so I'm
not sure what the issue is.

> Also, there is not much point in putting the PHY_TYPE constant to the
> phy client's node, as normally the phy client driver will know quite
> well what PHY_TYPE to use. E.g. a SATA driver will always select
> PHY_TYPE_SATA and a PCIE driver will select PHY_TYPE_PCIE, etc.

Good point. That could work as well.

> Kishon, if we have to take this road it also starts to sound like we
> will have to move the phy client's phandle to point to the phy wrapper
> node, if we want to keep the actual phy driver wrapper agnostic. Then we
> can make the wrapper to act like a proxy that forwards the phy_ops calls
> to the actual phy driver. Luckily the per lane phy-type selection is not
> a blocker for our j721e DisplayPort functionality.
>
> Best regards,
> Jyri
>
> [1] include/linux/phy/phy.h
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
