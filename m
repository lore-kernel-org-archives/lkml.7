Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCACC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B487E217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbfHHP6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:58:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:42340 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390115AbfHHP6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:58:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 08:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="169029082"
Received: from mcasscle-mobl1.amr.corp.intel.com (HELO [10.251.13.192]) ([10.251.13.192])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2019 08:58:49 -0700
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
Date:   Thu, 8 Aug 2019 10:58:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
> +have device specific bindings.

In case the controller supports multiple links, what's the encoding then?
in the MIPI DisCo spec there is a linkId field in the _ADR encoding that 
helps identify which link the Slave device is connected to

> +
> +Required property for SoundWire child node if it is present:
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

so it is actually required if you have a single Slave device? Or is it 
only required when you have more than 1 device of the same type?

FWIW in the MIPI DisCo spec we kept the instanceID as part of the _ADR, 
so it's implicitly mandatory (and ignored by the bus if there is only 
one device of the same time)

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

Isn't the MIPI encoding reported in the Dev_ID0..5 registers 0-based?

> +		...
> +	};
> +};
> 

And now that I think of it, wouldn't it be simpler for everyone if we 
aligned on that MIPI DisCo public spec? e.g. you'd have one property 
with a 64-bit number that follows the MIPI spec. No special encoding 
necessary for device tree cases, your DT blob would use this:

soundwire@c2d0000 {
	compatible = "qcom,soundwire-v1.5.0"
	reg = <0x0c2d0000 0x2000>;

	spkr_left:wsa8810-left{
		compatible = "sdw0000100217201000"
	}

	spkr_right:wsa8810-right{
		compatible = "sdw0000100217201100"
	}
}

We could use parentheses if it makes people happier, but the information 
from the MIPI DisCo spec can be used as is, and provide a means for spec 
changes via reserved bits.
