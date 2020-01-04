Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A6CC33C8C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0C24650
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173077;
	bh=jwi2dj5IW+krgeYs+eGWPIKkZTbgLBpUUfqX7WKMmOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P3FX/vn8vY6HLirTnggDv+SShI251N1NkKofsulBKyNb8pN0Ii9jnex6JfFwHndxt
	 aGKyuxvqmAucBfDtmQ3F55l1YV/X5rFF7vTyH1ICcJguaAxXe9qzJ+KQWkp+C2JrtG
	 eEGQDSXMH9e0zB9ADhe9VIgR5K0vil8YptVmAIaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgADVYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:24:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45073 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgADVYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:24:35 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so44709056ioi.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WyWVG0AV1etUHsC9L0mRRBH/xbmVRwK43x0QSdsR04=;
        b=Ny8tg8CN3/dXCvXCrrFFIol5uiPbw/SJJjK/l3oOscZDHh4ksMvaJcRDKiadb5WoJ9
         EC1qMyTt0ylyEpMEXGgzV8mTvPQIJ1U5QYpWIfkpvDMrAtbpFwH1WyiOj+IaLI2mtczs
         6NwWsl0E7+oBe2rmPRcihnyAAIk1FE7w+q1ikzSwtW/zUMRwhk13+kdNmKJ3ZHox8opg
         Nxhls0ZzVns6nbyXFehCXkAZQnYvESR+cmpJzf/yMIeoY2XavWEjTAgskHoLpU6WsNWg
         caa+4M2MSrLldeeKSci5UZVkQAgaje1IdFcK9wq1PpGW0Q/X4NBJt3DsEVB69igWUIza
         VOYg==
X-Gm-Message-State: APjAAAU7tBO6cHkTjFIVgOq0KaU05MbuOLYNaPakbf/bfbSlnjMbVkBO
        +Og2c4HiN2j7LetBIwUQfKpr9Qc=
X-Google-Smtp-Source: APXvYqx+axx3boBs6EMGDyhlgVIiLZ/W/b0eTsWw4mv5m1J2e1UqiLtfb0VDzDVA5viJnDr3YiezxQ==
X-Received: by 2002:a05:6638:41d:: with SMTP id q29mr22655079jap.128.1578173074396;
        Sat, 04 Jan 2020 13:24:34 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v64sm22438369ila.36.2020.01.04.13.24.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:24:33 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:24:32 -0700
Date:   Sat, 4 Jan 2020 14:24:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     Yuti Amonkar <yamonkar@cadence.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kishon@ti.com, mark.rutland@arm.com,
        maxime@cerno.tech, tomi.valkeinen@ti.com, praneeth@ti.com,
        mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v2 01/14] dt-bindings: phy: Convert Cadence MHDP PHY
 bindings to YAML.
Message-ID: <20200104212432.GA2584@bogus>
References: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
 <1577114139-14984-2-git-send-email-yamonkar@cadence.com>
 <a96aef7e-7c6d-5152-2e14-bb803d206cba@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96aef7e-7c6d-5152-2e14-bb803d206cba@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 02:24:07PM +0200, Jyri Sarha wrote:
> On 23/12/2019 17:15, Yuti Amonkar wrote:
> > - Convert the MHDP PHY devicetree bindings to yaml schemas.
> > - Rename DP PHY to have generic Torrent PHY nomrnclature.
> > - Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".
> >   This will not affect ABI as the driver has never been functional,
> >   and therefore do not exist in any active use case
> > 
> > Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> > ---
> >  .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 ----------
> >  .../bindings/phy/phy-cadence-torrent.yaml          | 64 ++++++++++++++++++++++
> >  2 files changed, 64 insertions(+), 30 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> > deleted file mode 100644
> > index 7f49fd54e..0000000
> > --- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -Cadence MHDP DisplayPort SD0801 PHY binding
> > -===========================================
> > -
> > -This binding describes the Cadence SD0801 PHY hardware included with
> > -the Cadence MHDP DisplayPort controller.
> > -
> > --------------------------------------------------------------------------------
> > -Required properties (controller (parent) node):
> > -- compatible	: Should be "cdns,dp-phy"
> > -- reg		: Defines the following sets of registers in the parent
> > -		  mhdp device:
> > -			- Offset of the DPTX PHY configuration registers
> > -			- Offset of the SD0801 PHY configuration registers
> > -- #phy-cells	: from the generic PHY bindings, must be 0.
> > -
> > -Optional properties:
> > -- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
> > -- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
> > -		  2430, 2700, 3240, 4320, 5400 or 8100)
> > --------------------------------------------------------------------------------
> > -
> > -Example:
> > -	dp_phy: phy@f0fb030a00 {
> > -		compatible = "cdns,dp-phy";
> > -		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
> > -		      <0xf0 0xfb500000 0x0 0x00100000>;
> > -		num_lanes = <4>;
> > -		max_bit_rate = <8100>;
> > -		#phy-cells = <0>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > new file mode 100644
> > index 0000000..3587312
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> > @@ -0,0 +1,64 @@
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Cadence Torrent SD0801 PHY binding for DisplayPort
> > +
> > +description:
> > +  This binding describes the Cadence SD0801 PHY hardware included with
> > +  the Cadence MHDP DisplayPort controller.
> > +
> > +maintainers:
> > +  - Swapnil Jakhade <sjakhade@cadence.com>
> > +  - Yuti Amonkar <yamonkar@cadence.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: cdns,torrent-phy
> > +
> > +  reg:
> > +    items:
> > +      - description: Offset of the DPTX PHY configuration registers.
> 
> Isn't it possible to use torrent-phy in a configuration that does not
> have dptx? Shouldn't the "dptx_phy" reg entry be optional?
> 
> BTW, I have no idea how to indicate in a yaml binding that some named
> reg-entry is mandatory, and another is optional... anybody? Or is it
> just something to explain in the description?

If it is the last entry (which is preferred), then you just need a 
'minItems: 1' in here.

If it is the first entry which is the case here, then you need 2 entries 
under a oneOf:

oneOf:
  - items:
      - description: Offset of the SD0801 PHY configuration registers.
  - items:
      - description: Offset of the DPTX PHY configuration registers.
      - description: Offset of the SD0801 PHY configuration registers.

Otherwise, the schema looks fine to me.

Rob
