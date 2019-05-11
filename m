Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876BDC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2042173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iAAWQhmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEKRgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:36:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40538 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfEKRgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:36:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so10966573wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vwwZLPGcGAXR13vr6qy0UFO0DZOncduClPeRkEBWYFc=;
        b=iAAWQhmGoVZvhmuDcYtYlbKL2yPAIDiBKcRtQzrDY8/2tnIqUlmr2J9Lf9skmq/Yex
         5wV1Wi3D7nRhS41ow4am5x29wFE5pKaU64fT0tP7xnRUuq8CYEnP+hRe9oDfMkJn8GqO
         1Z2YzZChWks5KnM98Nt4DKa3CDhBdO2c2/nBJGJgd4UpNIYUa7efGJ7dVovZ8H/IH+QQ
         3HAb9coU4zCQ9DHeA4Eci3/svDt3GHr7WJI/f+KGnmaI/5Mbw4LSSTe8LxiBsLrudTbm
         wb2XWTWaEqk53tfcLEEKyz1g0E2SZOl++duAqOvOpP/jWGcTZaMe4Yf1Pm4roSoj1T4l
         F9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vwwZLPGcGAXR13vr6qy0UFO0DZOncduClPeRkEBWYFc=;
        b=YL1S3E6Sd+yrKlYvjOl0ynNvCFlVeC9E4vdo/2DDtlD0PExX3XJ59wts3ETYf9eFY5
         3JfSwlSklNgZ7IkDDyDTRrwzkwMj3Dz3dOQZIAPSatH4n9CQWQ0sTHXxCqJ3MQ49neZY
         a/+4SDyK/5EtzgC7bvJ1QP+nmbhM52qZxhYv+OeIQn319vxfE8avCJ7aLAhfXuDDND5U
         LnK1fTciWjUTTj5+0ZwldwUVFSkxMMrCXqk8JCMHqQPCJzLB0YwNybd5VCiwlE/pUwrw
         Txi2gyfD0WYYF0l7PC5yyyTW0zkRfodDfysbXmPDCya6L4vzGAuHoWiPi9x37fgnpybr
         cbsA==
X-Gm-Message-State: APjAAAWH2izhygM1j9DfPNsn/TnZCNzeH5QxcI4HgsiJ7OQpVBXBmH6j
        G8hPYbX6rnR8yE/ubmAozxcXuA==
X-Google-Smtp-Source: APXvYqzMfiElnxb5yZhB+kwVExSHOrKfOzubcaza7o466jpJjApJTMKSG1pFPkqd982U0sk3wi9Rnw==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr2072583wrt.96.1557595846109;
        Sat, 11 May 2019 10:30:46 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id d26sm5315078wmb.4.2019.05.11.10.30.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 11 May 2019 10:30:45 -0700 (PDT)
Message-ID: <b14fef3d74c082a33e24702504bd5b362f6bd628.camel@baylibre.com>
Subject: Re: [PATCH 3/5] arm64: dts: meson: g12a: add mdio multiplexer
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 May 2019 19:30:44 +0200
In-Reply-To: <CAFBinCAe3jd598MPLUGFEoBAOaeXovSz7_8Kn7ZMmSFvRLFSXg@mail.gmail.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
         <20190510164940.13496-4-jbrunet@baylibre.com>
         <CAFBinCAe3jd598MPLUGFEoBAOaeXovSz7_8Kn7ZMmSFvRLFSXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 18:59 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Fri, May 10, 2019 at 6:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Add the g12a mdio multiplexer which allows to connect to either
> > an external phy through the SoC pins or the internal 10/100 phy
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 32 +++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> > index fe0f73730525..6e9587aafb5d 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> > @@ -460,6 +460,38 @@
> >                                 assigned-clock-rates = <100000000>;
> >                                 #phy-cells = <1>;
> >                         };
> > +
> > +                       eth_phy: mdio-multiplexer@4c000 {
> > +                               compatible = "amlogic,g12a-mdio-mux";
> > +                               reg = <0x0 0x4c000 0x0 0xa4>;
> > +                               clocks = <&clkc CLKID_ETH_PHY>,
> > +                                        <&xtal>,
> > +                                        <&clkc CLKID_MPLL_5OM>;
> I haven't noticed that before but there's a typo in the MPLL_5OM clock
> definition:
> the O (capital o) should be a 0 (zero).
> can you fix this typo in an additional clock patch for v5.2 - then we
> don't have to do it in v5.3 where this .dtsi might already use it
> 
> > +                               clock-names = "pclk", "clkin0", "clkin1";
> > +                               mdio-parent-bus = <&mdio0>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               ext_mdio: mdio@0 {
> > +                                       reg = <0>;
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +                               };
> > +
> > +                               int_mdio: mdio@1 {
> > +                                       reg = <1>;
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +
> > +                                       internal_ephy: ethernet_phy@8 {
> > +                                               compatible = "ethernet-phy-id0180.3301",
> > +                                                            "ethernet-phy-ieee802.3-c22";
> please drop the compatible string and replace it with a comment (if
> you feel that it's needed).
> quote from Documentation/devicetree/bindings/net/phy.txt:
> > If the PHY reports an incorrect ID (or none at all) then the
> > "compatible" list may contain an entry with the correct PHY ID in the
> > form: "ethernet-phy-idAAAA.BBBB"

I would keep this for the internal phy. The id completely made up by the MDIO mux, so it
is a lot weaker than the usual PHY.

The fact is that I made a mistake (which I'm going to correct) in the g12a mdio mux and
the id is incorrect. Thanks to this, we know the PHY the correct internal phy driver
is picked up.

> 
> I am going to send a patch for other Amlogic boards to remove any
> ethernet-phy-id comaptible string

Make sense for the external phys but I think it is wiser to keep it for the internal ones.

For external phys, A manufacturer could replace the device w/o any notice, so we should
rely on the id to pick it up correctly. For a the PHY embedded in the SoC, we which one it
is and it can't change (w/o notice at least)

> 
> 
> Regards
> Martin


