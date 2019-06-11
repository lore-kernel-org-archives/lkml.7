Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D789FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C3521734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q34tb1BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406980AbfFKSOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:14:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36430 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406685AbfFKSOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:14:23 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 348E7112D;
        Tue, 11 Jun 2019 20:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560276860;
        bh=Qaii2hzx2ceSMkoNdcuS2j/nQYnyPQB92jJfokvbcLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q34tb1BDgS18AJaIrFPJ2tcd64cyCIwuV4A4W3PyXhpXz31a4Th5P20rSoYdzMC3g
         V9E+fEOf4HX5zAMW8TV6E2A7BNf+tpRMQfe/QaorFlgsi0J/Q6L5jDhk/fqgJSukIg
         dkrp4eI4mc5guCJlPg0Uf+naGxkJtYTOfp+gx7mw=
Date:   Tue, 11 Jun 2019 21:13:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Drake <michael.drake@codethink.co.uk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v1 08/11] dt-bindings: display/bridge: Add bindings for
 ti949
Message-ID: <20190611181351.GW5016@pendragon.ideasonboard.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-9-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611140412.32151-9-michael.drake@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Jun 11, 2019 at 03:04:09PM +0100, Michael Drake wrote:
> Adds device tree bindings for:
> 
>   TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer
> 
> It supports instantiation via device tree / ACPI table.
> 
> The device has the compatible string "ti,ds90ub949", and
> and allows an arrray of strings to be provided as regulator
> names to enable for operation of the device.

All the comments I made regarding the ds90ub948 DT bindings apply here
too. Same for the comments related to the driver, they apply to the
subsequent patches in this series.

> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  .../bindings/display/bridge/ti,ds90ub949.txt  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
> new file mode 100644
> index 000000000000..3ba3897d5e81
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
> @@ -0,0 +1,24 @@
> +TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer
> +============================================================
> +
> +This is the binding for Texas Instruments DS90UB949-Q1 bridge serializer.
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible: "ti,ds90ub949"
> +
> +Optional properties:
> +
> +- regulators: List of regulator name strings to enable for operation of device.
> +
> +Example
> +-------
> +
> +ti949: ds90ub949@0 {
> +	compatible = "ti,ds90ub949";
> +
> +	regulators: "vcc",
> +	            "vcc_hdmi";
> +};

-- 
Regards,

Laurent Pinchart
