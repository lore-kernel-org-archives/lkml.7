Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB491C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C03322CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566423881;
	bh=V/Wb/WJDlNuY+FLx/5Fpk/OFwrHjtgAVyrc7/UYazpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yVncTmGIxw/OSwEUqATIjEocNlCGd8xmKgcJ9Z/nInR6EYS7Mlivfm7mMlQbbaC1+
	 uWmSDmHVzBfEsqWQqb1OO8Wy3EawcrApXsxiGYFO6dQDbaNjFM1zBdCl4NQYpGBHH1
	 krfMhzfnYTOBv/HAhTkevOdKEavwYoGZCfKsFnm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfHUVok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:44:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44460 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHUVoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:44:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id k22so2774556oiw.11;
        Wed, 21 Aug 2019 14:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLnoMCGg4aZAXQG/7EhE1lAx/LE1YZXQ51HizQcuuSk=;
        b=DPLHpQg7mRC2yS3q/NPwCXTstMe5AHbZuZlhHgVMKwTqH5+7wyAi+FA5d8LDckWJAK
         9QoeALiocFFBAXgYZr+4QIaLjdT/1qlV8w2qr15SWNArAsYJFcAYgqyeTTA+xAO2ZZdm
         vCPRyBUre0VXrf8kQjMgcOcTlTdL2ybS1/bzj2KF5q+0cmbj+Oy0bOnA/IiJ4YfblM3N
         7wHqpJXKf4CNb/A+hkr5niMwozmNo8/I9WN4RygEDGLqXW7CsQcyruSQc6LBVY2g1+DN
         RiQLgGPaZSE06Q3XfefI/zwY2toKeApqfq2tCPJUvDbTxDKkdoChMA0OPMzcfRwaTakO
         Gmog==
X-Gm-Message-State: APjAAAVBgRvvB7FoiDIZ/Ar9pTegauddPueUjcA3R5CnGlUIIc8D87Xu
        LzG+exD5ScyxUONc1wWjGw==
X-Google-Smtp-Source: APXvYqwHMvNmtkabfkRrV911VbE74YYZKFohSjzXpV0vzc4tBsAYOT28isHK4N/rXNz29ZFzUCPLIA==
X-Received: by 2002:a54:4f09:: with SMTP id e9mr1583851oiy.89.1566423877964;
        Wed, 21 Aug 2019 14:44:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm7881807otw.2.2019.08.21.14.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:44:37 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:44:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, pierre-louis.bossart@linux.intel.com,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190821214436.GA13936@bogus>
References: <20190809133407.25918-1-srinivas.kandagatla@linaro.org>
 <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809133407.25918-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 02:34:04PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soundwire/slave.txt   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt

Can you convert this to DT schema given it is a common binding.

What does the host controller look like? You need to define the node 
hierarchy. Bus controller schemas should then include the bus schema. 
See spi-controller.yaml.

> 
> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
> new file mode 100644
> index 000000000000..201f65d2fafa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
> @@ -0,0 +1,51 @@
> +SoundWire slave device bindings.
> +
> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> +It facilitates development of low cost, efficient, high performance systems.
> +
> +SoundWire slave devices:
> +Every SoundWire controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SoundWire slave device is
> +uniquely determined by the enumeration address containing 5 fields:
> +SoundWire Version, Instance ID, Manufacturer ID, Part ID
> +and Class ID for a device. Addition to below required properties,
> +child nodes can have device specific bindings.
> +
> +Required properties:
> +- compatible:	 "sdw<LinkID><VersionID><InstanceID><MFD><PID><CID>".
> +		  Is the textual representation of SoundWire Enumeration
> +		  address along with Link ID. compatible string should contain
> +		  SoundWire Link ID, SoundWire Version ID, Instance ID,
> +		  Manufacturer ID, Part ID and Class ID in order
> +		  represented as above and shall be in lower-case hexadecimal
> +		  with leading zeroes. Vaild sizes of these fields are
> +		  LinkID is 1 nibble,
> +		  Version ID is 1 nibble
> +		  Instance ID in 1 nibble
> +		  MFD in 4 nibbles
> +		  PID in 4 nibbles
> +		  CID is 2 nibbles
> +
> +		  Version number '0x1' represents SoundWire 1.0
> +		  Version number '0x2' represents SoundWire 1.1

This can all be a regex.

> +		  ex: "sdw0110217201000" represents 0 LinkID,
> +		  SoundWire 1.0 version slave with Instance ID 1.
> +		  More Information on detail of encoding of these fields can be
> +		  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +SoundWire example for Qualcomm's SoundWire controller:
> +
> +soundwire@c2d0000 {
> +	compatible = "qcom,soundwire-v1.5.0"
> +	reg = <0x0c2d0000 0x2000>;
> +
> +	spkr_left:wsa8810-left{
> +		compatible = "sdw0110217201000";
> +		...
> +	};
> +
> +	spkr_right:wsa8810-right{
> +		compatible = "sdw0120217201000";

The normal way to distinguish instances is with 'reg'. So I think you 
need 'reg' with Instance ID moved there at least. Just guessing, but 
perhaps Link ID, too? And for 2 different classes of device is that 
enough? 

Rob
