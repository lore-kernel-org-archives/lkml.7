Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D653218E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014487;
	bh=rkQjprLs0laMYp8I4h4itq0nOGJNQ69UEbhkrDxWlbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i/cmTRl2PAAv+ruoyhfu+SyuZaT9KE9Z2B1zPo0vlTLmGjmq+ugBuw5oYFIQt+j2U
	 kBwfUEQP361hAJezJW/1TK4OMrpK6zcUqkGoY+A5RjWs5FQaHPsqgkylSZp3WjNHDR
	 awHAgu+mp/X9O31LxNCxC6rseSTO9n/ezUhnmj9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfCaGlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfCaGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so2986555pfr.4;
        Sat, 30 Mar 2019 23:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5MRPTU8wvJqcDxvf+J9TBm5Cwyxby0vJet9oon74Dg=;
        b=bIw1Qr9fuZYbb0v6gAyY3fW2J7ZW7iaE+hiHRl8NZjRhJPX18X37+5ZnyM6hkmd346
         1veDCcieebD10pFKzJQtg9i7Mnnl08Cl7IdfBrM2IlijQqK5eq8ueXy6eYflJKPYWvJ4
         mXxQJoZPk3W7bUdSO057JnVYeQpc2M4D1rywNdrcyjefX46h4NPp7F2BmOccFh3e5QFn
         TzE3/y+7XVdcRGg5yVEV0k1QlZSBhAMMLrOaA0+rADfmGBUyMW3Ls4d2Mk5JsvIFuFD7
         Qr7Qrnrhu+i8ygKAJTIz0QMQfe9CPu2KY7sinFa1X0gcs7wERf64qX4hAXx9XnMxDfja
         n49A==
X-Gm-Message-State: APjAAAXplwZBSO6pMiivf5azY/MqIVDYdWpXCT4XJE2aRMIehKbLbDpm
        u6WR1pthvl8bVsysPA03PA==
X-Google-Smtp-Source: APXvYqxoQSa+BzjWOvkhMAXJOB6mCbruOJCYcmL6eYY5Db+K5k9nZgCT3ar4B/gCeoOKXqaZ/g9TOg==
X-Received: by 2002:a63:5c43:: with SMTP id n3mr53869947pgm.163.1554014483649;
        Sat, 30 Mar 2019 23:41:23 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id s19sm10034954pfe.74.2019.03.30.23.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:22 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:41:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Cormier, Jonathan" <jcormier@criticallink.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: ASoC: tlv320aic26: Add device tree
 binding
Message-ID: <20190331010229.GA10206@bogus>
References: <20190321221549.13765-1-jcormier@criticallink.com>
 <20190321221549.13765-3-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321221549.13765-3-jcormier@criticallink.com>
X-Mutt-References: <20190321221549.13765-3-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 06:15:44PM -0400, Cormier, Jonathan wrote:
> Add support for the TI tlv320aic26 sound codec
> 
> Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
> ---
>  .../devicetree/bindings/sound/tlv320aic26.txt | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic26.txt b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
> new file mode 100644
> index 000000000000..93aa0f76ec0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
> @@ -0,0 +1,65 @@
> +Texas Instruments - tlv320aic26 Codec module
> +
> +The tlv320aic26 serial control bus communicates through I2C protocols
> +
> +Required properties:
> +
> +- compatible - "string" - One of:
> +    "ti,tlv320aic26" - TLV320AIC26
> +- reg - <int> -  SPI chip select
> +
> +CODEC input pins:
> +  * MICIN
> +  * AUX
> +
> +CODEC output pins:
> +  * HPL
> +  * HPR
> +
> +The pins can be used in referring sound node's audio-routing property.
> +
> +Example:
> +
> +tlv320aic26: tlv320aic26@0 {

audio-codec@0

> +	compatible = "ti,tlv320aic26";
> +	reg = <0>;
> +};
> +
> +&spi0 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&spi0_pins>;
> +	pinctrl-1 = <&spi0_sleep_pins>;
> +
> +	status = "okay";

Don't show status in examples.

> +	ti,pindir-d0-out-d1-in = <1>;
> +
> +	tlv320aic26: tlv320aic26@1 {

This split is convention, but outside the scope of binding docs, so 
please just show the complete node.

> +		compatible = "ti,tlv320aic26";
> +		reg = <0x1>;
> +		status = "okay";
> +
> +		spi-max-frequency = <2000000>;
> +		spi-cpha;
> +	};
> +};
> +
> +sound {
> +	compatible = "simple-audio-card";
> +	simple-audio-card,name = "AM335x_SND";
> +	simple-audio-card,format = "dsp_b";
> +	/* SND_SOC_DAIFMT_CBM_CFM */
> +	simple-audio-card,bitclock-master = <&tlv320aic26_codec>;
> +	simple-audio-card,frame-master = <&tlv320aic26_codec>;
> +	/* SND_SOC_DAIFMT_IB_NF */
> +	simple-audio-card,bitclock-inversion;
> +
> +	simple-audio-card,cpu {
> +		sound-dai = <&mcasp1>;
> +		system-clock-frequency = <24576000>;
> +	};
> +
> +	tlv320aic26_codec: simple-audio-card,codec {
> +		sound-dai = <&tlv320aic26>;
> +		system-clock-frequency = <24576000>;
> +	};
> +};
> -- 
> 2.21.0
> 

