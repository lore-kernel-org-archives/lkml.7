Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF70C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31CF208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="C6mOGcHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfFFUTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:19:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35334 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfFFUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:19:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so3282491ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/03xw2tp9NftYo6y3lqGwgx/5/L6jpHZDgrcUrW11Ls=;
        b=C6mOGcHiaVmH85p7U7iwG8/iC0iR06aNXeaSXUH7HDVESCO6hX0YzCVBmJA28M9jLH
         N1Y4rCIH84mshtTrWvh6iej7PDWJ4yGcF1AsMZZTx7xJduPJlljsmkHLmSjP9zG/Xp5R
         GqL9GlKj295vqo4NA6kAIDYMZBpcfXuV4amDihjRcFPLDzzgLItUJ6XybX2mxHRXSg6z
         vzPERSHRCGtH35IpNxF6Q6cZt9KaVrLrKBB1mN6GmVNOxnlujaJ7NdUo89Zw1nw3EOW7
         awkyxiiCs6BI4goeDyxJoQOQQAI5NXiwkDyfeNV5iJo35vWKPfXFyZxgXT+1RVTOoNvp
         fUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/03xw2tp9NftYo6y3lqGwgx/5/L6jpHZDgrcUrW11Ls=;
        b=ZIdpY/I5pH1eLDpQMGu715otz72nOtpdI0pZmCV8Qa34IkrlOV7ivTByvu+Favg+bT
         8RaOlYtEoxD+ToeHBrYnH+MgDk3Bt65ztnCCoNnAs2c9dfH1toOMtQ0KXiW/wT6ITToo
         PlMTzTiNQY6jaHW8qVWSdNQxyYVsNzUpYSv8vYLZV6u3UAM15SVbrNDkdY2YScxRUT4/
         6wnfF8oAuRNcHTeog0wICH92pPIi7nbJjETW+Bb50air3B/c3t5q4EeWzr38oyCE+TYp
         cakbru96cyw2AE8FL2ozq53sx9Zbyi2+ECKJav5Zb5lemB9I/C0Oa90am7aJZkleptkx
         xSsg==
X-Gm-Message-State: APjAAAVj3mWGuXcd6KXLPrRP4cyNcAWYenxXab6MH21ee8a04Wpo9w9p
        cyOpmE5T5TZ+o1cNlSgXLMe9KpGwFAU=
X-Google-Smtp-Source: APXvYqzgZWw8o0bIGbPew+V04P4R1bupPBNRB+zTHJIX2UUIcycbT6+JsRt9BBlOQc6u4j5RWpUJqg==
X-Received: by 2002:a2e:880d:: with SMTP id x13mr25825603ljh.72.1559852348590;
        Thu, 06 Jun 2019 13:19:08 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.83.115])
        by smtp.gmail.com with ESMTPSA id 20sm14917ljf.21.2019.06.06.13.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 13:19:07 -0700 (PDT)
Subject: Re: [PATCH 01/20] dt-bindings: display: renesas,cmm: Add R-Car CMM
 documentation
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190606142220.1392-1-jacopo+renesas@jmondi.org>
 <20190606142220.1392-2-jacopo+renesas@jmondi.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0c04c0b6-1fbf-fba3-ca40-c4a999ed6a17@cogentembedded.com>
Date:   Thu, 6 Jun 2019 23:19:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190606142220.1392-2-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2019 05:22 PM, Jacopo Mondi wrote:

> Add device tree bindings documentation for the Renesas R-Car Display
> Unit Color Management Module.
> 
> CMM is the image enhancement module available on each R-Car DU video
> channel on Gen2 and Gen3 SoCs (V3H and V3M excluded).
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/display/renesas,cmm.txt          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,cmm.txt b/Documentation/devicetree/bindings/display/renesas,cmm.txt
> new file mode 100644
> index 000000000000..d8d3cf9ce2ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/renesas,cmm.txt
> @@ -0,0 +1,25 @@
> +* Renesas R-Car Color Management Module (CMM)
> +
> +Renesas R-Car image enhancement module connected to R-Car DU video channels.
> +
> +Required properties:
> + - compatible: shall be one of:
> +   - "renesas,cmm-gen3"
> +   - "renesas,cmm-gen2"
> +
> + - reg: the address base and length of the memory area where CMM control
> +   registers are mapped to.
> +
> + - clocks: phandle and clock-specifier pair to the CMM functional clock
> +   supplier.
> +
> +Example:
> +--------
> +
> +	cmm0: cmm@fea40000 {
> +		compatible = "renesas,cmm";

   Dosent' match the description above.

> +		reg = <0 0xfea40000 0 0x1000>;
> +		power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> +		clocks = <&cpg CPG_MOD 711>;
> +		resets = <&cpg 711>;
> +	};
> 

MBR, Sergei
