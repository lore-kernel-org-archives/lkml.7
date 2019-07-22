Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98817C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E021951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563832899;
	bh=tNmfUezDHq+a7BuWrXqmVdnoKGw19y2xJZRBgPWqAas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YMGyBjqxOFQQltJG9LTxaQhg8ffqQwJ7S/qz2n4MFodKNgpBnsQxyZdLEns9M7Uet
	 gAsLJUZBxzs8X3hkOrmFOm+xQtADvNfW96RS7+YlLCiCtYd/G7VTwCoEis7Z63eQU5
	 kbN00Ruzj4RFVKvEuAsZqttKdZrvyXu9KAjsXIcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfGVWBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:01:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34180 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbfGVWBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:01:37 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so77497551iot.1;
        Mon, 22 Jul 2019 15:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=317qAQxotsgQLMyHaOatEPkOpAMyuma68l0S3IPmCaI=;
        b=EcfolNmWHKOs07TusFtE8Xttqyv9FzRhG8syMXj0+af/nARq1kziopo4MdR3KWeUQN
         5PdZ7eVxNyDMyWwG/gwIpmBBtUcq0psMyVyyYE0fAj9rVzUiFrGtdI2uVefbf7wVpcuI
         PeJfuAWiZv6Rn5fsTsD6XHi4qxpV7ZqyCCrI7NsNkmNg+13g3qCD4TKKdJU6aKLlBQPz
         sQXrAzXqt4W65f5pM/rczCu46acbx/+HOmA42Sx53BD9CGORCogsNjX0DXN8AX3ppefW
         10laOp4O29f9cpWMZuY3XetaTzOpRkrcJQnx/VGAzedBfgIzCxyINT+9nn2WwyetKueU
         6GbQ==
X-Gm-Message-State: APjAAAVcFz4zQGCzSWgqUWZF+/D27JZBz4Jb4wbpxh4IpiSspkZgmSNq
        PXQyPNCqK7VfMskTen8k9S63wgE=
X-Google-Smtp-Source: APXvYqztwogHmK5lyRPBzlOeroG5MXmFrVdx5UE5txZpgI4VvzYvgFsczv8iMCAnS69d8QVpaTBpZw==
X-Received: by 2002:a5d:9643:: with SMTP id d3mr70534966ios.227.1563832896219;
        Mon, 22 Jul 2019 15:01:36 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c81sm63005975iof.28.2019.07.22.15.01.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:01:35 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:01:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com, heiko@sntech.de,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        olof@lixom.net, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 07/11] dt-bindings: mmc: arasan: Add optional
 properties for Arasan SDHCI
Message-ID: <20190722220134.GA8281@bogus>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-8-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561958991-21935-8-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:59:47AM +0530, Manish Narani wrote:
> Add optional propeties for Arasan SDHCI which are used to set clk delays
> for different speed modes in the controller.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 7c79496..7425d52 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -49,6 +49,21 @@ Optional Properties:
>      properly. Test mode can be used to force the controller to function.
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
> +  - clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy Mode.
> +  - clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
> +  - clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
> +  - clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
> +  - clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
> +  - clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
> +  - clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for SDR104.
> +  - clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD DDR50.
> +  - clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC DDR52.
> +  - clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC HS200.
> +  - clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC HS400.

Either these need vendor prefixes or be added as common properties if 
that makes sense.

Rob

> +
> +  Above mentioned are the clock (phase) delays which are to be configured in the
> +  controller while switching to particular speed mode. If not specified, driver
> +  will configure the default value defined for particular mode in it.
>  
>  Example:
>  	sdhci@e0100000 {
> -- 
> 2.1.1
> 
