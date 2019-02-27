Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C846DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8451E21783
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551311991;
	bh=/kMUpwEL7W5EwJGbccgHrRzWdBSZU+KQ8QdN1WzCqeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iNab3JZw5kr97H8tQ4Djnzsz8eLmCg2DJjF7qvu/1pIGau53vfSY3AD/6MSm5QIbV
	 FEh/uX1LCzEW2MWtoxrO7Op5HBVY/B8jeBOPVmFEdZsZyHx5DhI+eFljHnizSBMXoC
	 w7d8SLyb/RRZaKk1f/sAZfwurPP1xrf7U4mAXYSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfB0X7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 18:59:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42569 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0X7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 18:59:50 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so16047334oto.9;
        Wed, 27 Feb 2019 15:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iuw7ppTeRBVeO4grX4blVXww60pr9qTi6AWNXrLdORw=;
        b=MpNUR1CWGgxG+LkWB3r18rO2NiNCbWhSDBIOmWH9HtkwmhmxNWKDqWyoCRoZDkm3no
         yPLaLqzXbrmQ98M872+dU/zQGrkuU8sfczdCne49s2EPK2Xvc0V2Fp/sUd4MeKcKLJkd
         Ioca7+WB0uPxDY0A4F/gfPpAcU4saKTykW1mIeqpu5FpA8u8macO7Zxh5Q3ouqdBtJsX
         AjMJKtXksYyoGE6aKufp14Ph+5m8/kb4bken00JpSZ40wYewJ2gfrOSWl8m8fZqXY41c
         CcRwF/ZtSNuPh8K9iz84eOrgdlXtnZ7JVWlpDyeHdlMcD/58dfME+z7hK8WpjqsZdB9A
         ijQw==
X-Gm-Message-State: AHQUAuYVk+x5J0Xqul/UBv7MbhNu2qaCXxIncO5gNsHyv9DrXy5MqiAy
        3Nmf864rl69jxGh/QritWDQ0tSw=
X-Google-Smtp-Source: AHgI3IaqRRZfYlSHBSfWVfRBX0w00XIdPZD7MQgBq9zlJTssbqv7k6XQmiozAcNSSdCn8CJKaV9qhw==
X-Received: by 2002:a9d:80e:: with SMTP id 14mr3874736oty.108.1551311988816;
        Wed, 27 Feb 2019 15:59:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p188sm7722013oia.58.2019.02.27.15.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 15:59:47 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:59:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio:temperature:max31856:Add device tree bind info
Message-ID: <20190227235947.GA27130@bogus>
References: <20190226150214.19467-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226150214.19467-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 04:02:13PM +0100, Patrick Havelange wrote:
> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> 
> This patch added device tree binding info for MAX31856 driver.
> 
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes
> v1 -> v2
> [Matt
>  - Removed comment block and added possibilities of
>    thermocouple type in device tree binding doc.
> 
> v2 -> v3
>  - Rebased
> 
> v3 -> v4
>  - Removed one-shot property related information.
>  - Used standard name 'temp-sensor'
> 
> v4 -> v5
> [Patrick
>  - Rename thermocouple type to maxim,thermocouple-type for DT entry
> ---
>  .../bindings/iio/temperature/max31856.txt     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> new file mode 100644
> index 000000000000..b4396069b8fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> @@ -0,0 +1,29 @@
> +Maxim MAX31856 thermocouple support
> +
> +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> +
> +Required properties:
> +	- compatible: must be "maxim,max31856"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: As per datasheet max. supported freq is 5000000
> +	- spi-cpha: must be defined for max31856 to enable SPI mode 1
> +	- maxim,thermocouple-type: Type of thermocouple (By default is K-Type)
> +		0x00 : TYPE_B
> +		0x01 : TYPE_E
> +		0x02 : TYPE_J
> +		0x03 : TYPE_K (default)
> +		0x04 : TYPE_N
> +		0x05 : TYPE_R
> +		0x06 : TYPE_S
> +		0x07 : TYPE_T

These appear to be standard types. Perhaps this should be a common 
property instead?

> +
> +	Refer to spi/spi-bus.txt for generic SPI slave bindings.
> +
> + Example:
> +	temp-sensor@0 {
> +		compatible = "maxim,max31856";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		spi-cpha;
> +		maxim,thermocouple-type = <0x03>;
> +	};
> -- 
> 2.19.1
> 
