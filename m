Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303D6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5F121743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565326879;
	bh=55Gs1G9Rz04Gs41D1M4WjTdna+61wD7lIipwnYMQUFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xlipufRKNk5rdzxmaj2BBXGE6zJXnU1Q665MGowJ69AgrNTGafAgL/dnAwaP1oaMh
	 Kc+OmUwi5t7M6cO08l82jVqca4YY5dsfcAFOsSldcCBP1VJBVcFOIYiE86soxvJp5C
	 XUKhwx8jFJtgcC7vR7uTk8doIX0nnjdSOJb+xYzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405430AbfHIFBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfHIFBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:01:17 -0400
Received: from localhost (unknown [106.51.111.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BE2214C6;
        Fri,  9 Aug 2019 05:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565326876;
        bh=55Gs1G9Rz04Gs41D1M4WjTdna+61wD7lIipwnYMQUFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cwaTFUMUPfzNaN/PYEWqdDYZ+GJMRCu5TiiLR7EnQoxnGsSVl8Z+09Q7JAHTOXjeL
         jvlwUdLeiND0cIP93SeVPyFcKaXUVGw4Wrk+JstNZmj+yvQLLlJ/C+OWjE+2ATQFcr
         E4DCh5p77RxazIhzmgohj63LIDqUX/RbUlnBn12Y=
Date:   Fri, 9 Aug 2019 10:30:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190809050004.GI12733@vkoul-mobl.Dlink>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-19, 15:45, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices which includes how
> SoundWire enumeration address is represented in SoundWire slave device
> tree nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soundwire/slave.txt   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/slave.txt
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/slave.txt b/Documentation/devicetree/bindings/soundwire/slave.txt
> new file mode 100644
> index 000000000000..b8e8d34bbc92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/slave.txt
> @@ -0,0 +1,46 @@
> +SoundWire slave device bindings.
> +
> +SoundWire is a 2-pin multi-drop interface with data and clock line.
> +It facilitates development of low cost, efficient, high performance systems.
> +
> +SoundWire slave devices:
> +Every SoundWire controller node can contain zero or more child nodes
> +representing slave devices on the bus. Every SoundWire slave device is
> +uniquely determined by the enumeration address containing 5 fields:
> +SoundWire Version, Instance ID, Manufacturer ID, Part ID and Class ID
> +for a device. Addition to below required properties, child nodes can

It would help to list them rather than free flowing text

> +have device specific bindings.
> +
> +Required property for SoundWire child node if it is present:

As said earlier, lets make it "Required properties:"

> +- compatible:	 "sdwVER,MFD,PID,CID". The textual representation of
> +		  SoundWire Enumeration address comprising SoundWire
> +		  Version, Manufacturer ID, Part ID and Class ID,
> +		  shall be in lower-case hexadecimal with leading
> +		  zeroes suppressed.
> +		  Version number '0x10' represents SoundWire 1.0
> +		  Version number '0x11' represents SoundWire 1.1
> +		  ex: "sdw10,0217,2010,0"
> +
> +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> +		  Enumeration Address. Instance ID is for the cases
> +		  where multiple Devices of the same type or Class
> +		  are attached to the bus.
> +
> +SoundWire example for Qualcomm's SoundWire controller:
> +
> +soundwire@c2d0000 {
> +	compatible = "qcom,soundwire-v1.5.0"
> +	reg = <0x0c2d0000 0x2000>;
> +
> +	spkr_left:wsa8810-left{
> +		compatible = "sdw10,0217,2010,0";
> +		sdw-instance-id = <1>;
> +		...
> +	};
> +
> +	spkr_right:wsa8810-right{
> +		compatible = "sdw10,0217,2010,0";
> +		sdw-instance-id = <2>;
> +		...
> +	};
> +};
> -- 
> 2.21.0

-- 
~Vinod
