Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0365C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DC720830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Kk/kjDvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCJU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:20:59 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35625 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfDCJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:20:59 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 360A225BDFF;
        Wed,  3 Apr 2019 20:20:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1554283257; bh=DkKCJWdvTSIMAp8BkEPcqSZpgXQNz1bb6fGEdIIjX0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kk/kjDvAKlBMwHLCsCMtD+MoU2KZOg+SW35SyCfe8xt6X0UpVimOFOKFfO50pNnUA
         L62RBmibIs8esGXCfQzkXudQlMDJUw1QWgxcBAVu9Es+Q9jhbiyIYCwOG4veB60a4C
         wjCLSVw/+l2+wFqnrvhGoWA0JHm2Cy1Ou8gmCF30=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 4ECF6940361; Wed,  3 Apr 2019 11:20:55 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:20:55 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Message-ID: <20190403092054.d26pmbngconkn3hx@verge.net.au>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554120083-29990-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shimoda-san,

On Mon, Apr 01, 2019 at 09:01:21PM +0900, Yoshihiro Shimoda wrote:
> To have the detailed property on each PHY specifier, this patch revices
> the #phy-cells property.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> index ad9c290..7f0d4bf 100644
> --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> @@ -27,7 +27,12 @@ Required properties:
>  
>  - reg: offset and length of the partial USB 2.0 Host register block.
>  - clocks: clock phandle and specifier pair(s).
> -- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.

The driver currently supports <0> and with this changeset continues to do
so. I also assume there are existing DTs that use <0>. Would it be
better to describe this as deprecated?

> +- #phy-cells: see phy-bindings.txt in the same directory, must be <1>.
> +
> +The phandle's argument in the PHY specifier is the INT_STATUS bit of controller:
> +- 1 = USBH_INTA (OHCI)
> +- 2 = USBH_INTB (EHCI)
> +- 3 = UCOM_INT (OTG and BC)
>  
>  Optional properties:
>  To use a USB channel where USB 2.0 Host and HSUSB (USB 2.0 Peripheral) are
> -- 
> 2.7.4
> 
