Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA6FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E44E206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575500345;
	bh=Ysf1J+BSQwUnFJHhUpB/ZT36dXA4hNeM8yJmqNkFhDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mpxewbmHzJr20yJH3lvRAYLp99HDptWfpA4mdSrXpAXEd2TE+l3Gd89iY1adz71nd
	 HCkYYZ6BWamo/VtC+sX5jhzujrFQWZ8eWYkelUu6y8Y2PjUFm9ugkLTv3GLtc4DON0
	 +kuOR+7A7Y+aCk7mfLCfh1gx8keCcWy5oCGFJvLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfLDW7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:59:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40747 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDW7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:59:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id 6so889315oix.7;
        Wed, 04 Dec 2019 14:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hqWdSoHcQzyTJkL7Mf3rYI2CqKq7GxVmoPtx9Wj/NUQ=;
        b=HeeqcbTXIDcg1+EgDquum9Gbc+rK+sg/vwkSEMV7s6Jgb7mrLTGYzIzlP9ba2GjAKd
         qc1HCRGBW17kPOVYcKC1Iru94DEnxak5qGbiU4ciNkWWg8vQGPCubtRstceKUc7BoNil
         PVbwEgTGGtfOBdA++mpW4YJTyAH2Rt8RO2rDBqXC2W1GZ+o3B/ATDrWq+NEYbtWsUlVt
         WBwQgvJ/zzxVp0xwfofvv/+ypqBcdC73t4bJ8MzFOMnwYjpLwtVjeQ1UYJ6V7yTFXHfH
         wMQRjXRAz50+aEPBSPBzF/2yQH9ouK49D3Updpm2egJxwDwY+LX/f8EctHqbo9jw1aCI
         9VJw==
X-Gm-Message-State: APjAAAWXoSnc+ioG/xqExlZotU+sIBG0F+7FLrofM80o4SKYrP/BgDiO
        s03CFzvqBckJTiuUU6JRnQ==
X-Google-Smtp-Source: APXvYqzIMPoCRlaPXBAfjx/AI4iavLfiFcz3CpUIlhsCYXfOEc8f3duMXCd6ObvZG8FDt5/AHwWi0w==
X-Received: by 2002:a05:6808:f:: with SMTP id u15mr4639374oic.164.1575500342713;
        Wed, 04 Dec 2019 14:59:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f11sm2842044oij.8.2019.12.04.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:59:02 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:59:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Wright <wrightj@linux.vnet.ibm.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Wright <jlwright@us.ibm.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon/pmbus: Add UCD90320 power
 sequencer
Message-ID: <20191204225901.GA20804@bogus>
References: <20191122222542.29661-1-wrightj@linux.vnet.ibm.com>
 <20191122222542.29661-2-wrightj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122222542.29661-2-wrightj@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 04:25:41PM -0600, Jim Wright wrote:
> From: Jim Wright <jlwright@us.ibm.com>
> 
> Document the UCD90320 device tree binding.
> 
> Signed-off-by: Jim Wright <jlwright@us.ibm.com>
> ---
>  .../devicetree/bindings/hwmon/pmbus/ucd90320.txt    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt

Can you make this a schema. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt b/Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt
> new file mode 100644
> index 000000000000..e1c1057c6292
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/ucd90320.txt
> @@ -0,0 +1,13 @@
> +UCD90320 power sequencer
> +-------------------------
> +
> +Requires node properties:
> +- compatible : "ti,ucd90320"
> +- reg : the I2C address of the device. This is 0x11, 0x13, 0x17, 0x31, 0x33,
> +        0x37, 0x71, 0x73, or 0x77.
> +
> +Example:
> +	ucd90320@11 {
> +		compatible = "ti,ucd90320";
> +		reg = <0x11>;
> +	};
> -- 
> 2.17.1
> 
