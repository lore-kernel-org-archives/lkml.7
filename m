Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9315CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 21:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C18206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577223124;
	bh=PW26vJkEN6uyM1jLVMnYbaWn5MmZ8bT2hZKZaiAyDbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uqpi121yn2mMRmi+Bn5J7T1SMiB0JX6RFn5k0/HuKbZ3JzubPuFwIQbH+XtBy/WtR
	 MMYroeRn45xxEXIDJ7oHlds2xVobsZsejbdRDt5USaC+NRBpipmi8/XopTRTWsBfN3
	 RcaxfC3ZAuzNcgDMPRAJ6T698dHAXyf+MZ/39Y0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLXVcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 16:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfLXVcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 16:32:03 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE42206D7;
        Tue, 24 Dec 2019 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577223122;
        bh=PW26vJkEN6uyM1jLVMnYbaWn5MmZ8bT2hZKZaiAyDbQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oHPyy4ePIKxjx+iXoUJKf+1O102P0tZM7ugK49hOGsy0ZK/THY8EMhs8SUdm8Cw7A
         DcqjoW/LY/Brbfp7IbjClouB5vmuP3feeoZmJmPMOCgGc0bCvHODlqzKRWm43K/VYg
         BCN9rD9OKk0zWtmdAeni78IZuDTYGJL9trpODlN8=
Received: by mail-qt1-f170.google.com with SMTP id d5so19021016qto.0;
        Tue, 24 Dec 2019 13:32:02 -0800 (PST)
X-Gm-Message-State: APjAAAUCb2mLKUHWvJWudIHVGhjTuLkvdcwI5dPGCQlRRyJqVhWIwY1x
        BFiCeJCTuJ6NyW88M222MFc9FFiKrHqwkS2BLQ==
X-Google-Smtp-Source: APXvYqzX3sSA1eAxiKh9/g8KaclHH/nPU2IJsCXV3xdACeBNoxxmI/7PtcbsiV1p1DIQHcIU7ZHLTZ5iv0VhS2+39k0=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr14221841qtj.300.1577223121574;
 Tue, 24 Dec 2019 13:32:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575906694.git.jsarha@ti.com> <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
 <20191219190833.GA16358@bogus> <3cf64e30-6b4d-a138-7164-54d1cdc8e05a@ti.com>
In-Reply-To: <3cf64e30-6b4d-a138-7164-54d1cdc8e05a@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Dec 2019 14:31:49 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKNFbPebM=pC+GL_DMuf5OPZF4FyJ7KGdSonDAeL_3P1A@mail.gmail.com>
Message-ID: <CAL_JsqKNFbPebM=pC+GL_DMuf5OPZF4FyJ7KGdSonDAeL_3P1A@mail.gmail.com>
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

On Fri, Dec 20, 2019 at 5:52 AM Jyri Sarha <jsarha@ti.com> wrote:
>
> On 19/12/2019 21:08, Rob Herring wrote:
> > On Mon, Dec 09, 2019 at 06:22:11PM +0200, Jyri Sarha wrote:
> >> Add property to indicate the usage of SERDES lane controlled by the
> >> WIZ wrapper. The wrapper configuration has some variation depending on
> >> how each lane is going to be used.
> >>
> >> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> >> ---
> >>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >> index 94e3b4b5ed8e..399725f65278 100644
> >> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> >> @@ -97,6 +97,18 @@ patternProperties:
> >>        Torrent SERDES should follow the bindings specified in
> >>        Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> >>
> >> +  "^lane[1-4]-mode$":
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +      - enum: [0, 1, 2, 3, 4, 5, 6]
> >> +    description: |
> >> +     Integer describing static lane usage for the lane indicated in
> >> +     the property name. For Sierra there may be properties lane0 and
> >> +     lane1, for Torrent all lane[1-4]-mode properties may be
> >> +     there. The constants to indicate the lane usage are defined in
> >> +     "include/dt-bindings/phy/phy.h". The lane is assumed to be unused
> >> +     if its lane<n>-use property does not exist.
> >
> > The defines were intended to be in 'phys' cells. Does putting both lane
> > and mode in the client 'phys' properties not work?
> >
>
> Let me first check if I understood you. So you are suggesting something
> like this:
>
> dp-phy {
>         #phy-cells = <5>; /* 1 for phy-type and 4 for lanes = 5 */
>         ...
> };
>
> dp-bridge {
>         ...
>         phys = <&dp-phy PHY_TYPE_DP 1 1 0 0>; /* lanes 0 and 1 for DP */

Yes, but I think the lanes can be a single cell mask. And I'd probably
make that the first cell which is generally "which PHY" and make
type/mode the 2nd cell. I'd look for other users of PHY_TYPE_ defines
and match what they've done if possible.

Rob
