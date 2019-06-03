Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2DC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D029327726
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="NcfueCi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfFCPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:21:12 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:53974 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfFCPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:21:11 -0400
Received: from g550jk.localnet (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2DA26C1EA1;
        Mon,  3 Jun 2019 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1559575268; bh=7lWq2A3Lrc28KJtfHYy0Wb+Zh4J86K9tw6JaC+YS190=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NcfueCi9EZ+5MR4qMjNwW7RWSbqdzNVZ//pdTCqaUdOg8Vgf+yZ/9P2FisvGPEt60
         Yhcm2gZ2u0yRi+oi3/zmq4mQc/sxQVOl1ySw5iVzLb+mO34+PWZlRVHu2KXRsN8s+q
         RZKOdsqSWS68fgvD4d3TpsRPmw9mCWxG2gCRS35w=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Date:   Mon, 03 Jun 2019 17:20:51 +0200
Message-ID: <3880268.VpfjThaCW4@g550jk>
In-Reply-To: <20190603074247.hlayod2pxq55f6ci@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz> <6901794.oDhxEVzEqc@g550jk> <20190603074247.hlayod2pxq55f6ci@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4884027.SNrMX4W1oj"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4884027.SNrMX4W1oj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 3. Juni 2019 09:42:47 CEST Maxime Ripard wrote:
> Hi,
> 
> On Fri, May 31, 2019 at 12:27:55PM +0200, Luca Weiss wrote:
> > On Freitag, 24. Mai 2019 11:20:01 CEST Maxime Ripard wrote:
> > > It would be great to drop the -keys from the compatible, and to
> > > document the bindings
> > > 
> > > Looks good otherwise
> > > 
> > > Maxime
> > 
> > So I should just document the "allwinner,sun50i-a64-lradc" string in
> > Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt ? Don't I
> > also
> > have to add the compatible to the driver code then? Just adding the a64
> > compatible to a dts wouldn't work without that.
> 
> What I meant was that you needed both, something like:
> 
> compatible = "allwinner,sun50i-a64-lradc", "allwinner,sun8i-a83t-lradc";
> 
> That way, the OS will try to match a driver for the A64 compatible if
> any, and fallback to the A83's otherwise. And since we don't have any
> quirk at the moment, there's no change needed to the driver.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Hi Maxime,
sorry for the long back and forth, I hope I understood you correctly now.
Here's what I would submit as v2 then (I'll split the two files into seperate 
patches as the devicetree documentation suggests)

Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt:
  - compatible: should be one of the following string:
                "allwinner,sun4i-a10-lradc-keys"
                "allwinner,sun8i-a83t-r-lradc"
+               "allwinner,sun50i-a64-lradc", "allwinner,sun8i-a83t-r-lradc"

arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:
+               lradc: lradc@1c21800 {
+                       compatible = "allwinner,sun50i-a64-lradc",
+                                    "allwinner,sun8i-a83t-r-lradc";
+                       reg = <0x01c21800 0x400>;
+                       interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+                       status = "disabled";
+               };
+

Thanks,
Luca
--nextPart4884027.SNrMX4W1oj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE66ocILd+OiPORlvAOY2pEqPLBhkFAlz1OtMACgkQOY2pEqPL
BhniWhAAlYK190VpcKotzROcAO4PQWaBW+NvYV6iqItgjYPBg88mefVeqvnC1P8n
aga2RYwebN4iL8W3Rr+jyAzMza2B0ofuyn/2FTSizOxnfF6IgmEUvs2VehLPHSM8
oYD/J2aGB8aBVMRfGLmEaI2Ky47lnDCfoBS8iF6sh4ownDJyWrKVctwjqg5yTidq
sA2Qr8VnJyRdu75RAz9mJ9xKxiSOOK1IZlBlcuJBWpHHP9RBga8vNX12iKAwSpy6
wScB1JSUV3SzrarYn0Rp5CgQ1GocJJBM7I41si3cTkkhGdcngto+j3D5b/EZl61U
yv4BMhBhPpXsWhlRiWu0AeixVMBahlmNIkxKouehpMs1OvsgtVamdo/KLXzi/q9A
yN1Ut/WJkC3l8LzRg7ZQ9eXGO2HcbEmgNos2b5q6MgG55SyLVOmnpH7wGqdVnXNB
HTOfA0j2GCnJGWfVySBXXKLn4uIVrRyDeX0grO8nJp74f6Xp1iX4MC8jOjLidFPk
wPZmzgiGNzajyDLwyHt2Ir94n2qCRDxdp4Oh6mdXBxIDc0UDWEW58VcDZCdYDiL3
93BM+E1+3sQpIzryj1K9IElpGsUhcLYRemD+TchmNLKJAlLb+KlKac6ykLwMNwat
510fwJqUGSMJdgM4TldRE8sNLjJFRtUsJRDQ0yti6lkfDIBS5kA=
=CDr4
-----END PGP SIGNATURE-----

--nextPart4884027.SNrMX4W1oj--



