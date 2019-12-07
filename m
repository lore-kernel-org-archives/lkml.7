Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3280DC2BD09
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0938F217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FcTHjpXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfLGAyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:54:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37930 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLGAyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:54:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so9686975wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YyHqnh3RgU+jkragtEYCmywD+W1GeJPYa5pDIp3hGtA=;
        b=FcTHjpXtuWKl1ktGy/jvKmj2CEIxaOGf7WtJh22SSUSCoRnxI007b1epPMs2yzPAU6
         8XKVC+aUUW4HrvmDIskh7Faxk/Hkh/OBnV3BQ53u77XgaJZ944tnynobm08sy3X5HTGy
         p9ox1+HGbfpaQpNgvjmcoidglRxGol+snYZog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyHqnh3RgU+jkragtEYCmywD+W1GeJPYa5pDIp3hGtA=;
        b=ZIy3s5QSmLr5heWaek0/2TIUiJ96uyyASVOcW8LxmNi91CL53fwffCow1MGH7ulpv2
         TYvvH5eM+NUuIwQ8atMUa+LCTPWA1xXmPL055sQiRLfbSzstIdkdKfa/x8+X6vjK9kC9
         VU85kgP0B2tt+e9v9dcjH++GxWUR3aItig7TWzd/ISSvcxEc7km5W6JH4ShVgJuYxACI
         28Hx6bXPUbbRp2kunzCdsmx5j1IL3Tjk4hvOt8zef5l03cnCvlYh6YW498THpxNngAoh
         CJf93KjcRdKDlJXLKQmq+tyBq7eF0pw2r1dYMgznlZrKWmPBpu5RND4E7TOQCkqX7gG/
         ZU9Q==
X-Gm-Message-State: APjAAAU8GYgQ9RX5QsAWhk3uLHN+hfifIz5Vo5MrlBulXN3YMPVgD+t5
        KDQpVvMCrILCNzkiOCrSX1ReFxqTAT5OKHIrk9+PgoYeGRMw64P/uixxqW5VAtlYJLj2fOEK5kD
        y+9RI7RZ/GfUsgAGwWYIYMG1BTBhHW+6gn7s/Mua7NnIwDB2V+McMJeO6unKHshjOw9M873qj/W
        we
X-Google-Smtp-Source: APXvYqycLhNIOEqhQ1FJre7Q/J/PU8EfKeYG6wG58YToIgr2m9pkiKsbRjmM2iUnZ/GXddXke7yIhQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr17461759wrv.86.1575680069042;
        Fri, 06 Dec 2019 16:54:29 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h97sm19347000wrh.56.2019.12.06.16.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:54:28 -0800 (PST)
Subject: Re: [PATCH] ARM: dts: Cygnus: Fix MDIO node address/size cells
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     grygorii.strashko@ti.com, simon.horman@netronome.com,
        robh+dt@kernel.org, rafal@milecki.pl, davem@davemloft.net,
        andrew@lunn.ch, mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        open list <linux-kernel@vger.kernel.org>
References: <20191206181909.10962-1-f.fainelli@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <86e8fbec-f9e5-28d8-cc58-c12ce53a18e9@broadcom.com>
Date:   Fri, 6 Dec 2019 16:54:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206181909.10962-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 10:19 AM, Florian Fainelli wrote:
> The MDIO node on Cygnus had an reversed #address-cells and
>   #size-cells properties, correct those.
> 
> Fixes: 40c26d3af60a ("ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY")
> Reported-by: Simon Horman <simon.horman@netronome.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 2dac3efc7640..1bc45cfd5453 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -174,8 +174,8 @@
>   		mdio: mdio@18002000 {
>   			compatible = "brcm,iproc-mdio";
>   			reg = <0x18002000 0x8>;
> -			#size-cells = <1>;
> -			#address-cells = <0>;
> +			#size-cells = <0>;
> +			#address-cells = <1>;
>   			status = "disabled";
>   
>   			gphy0: ethernet-phy@0 {
> 

Looks good! Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
