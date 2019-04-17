Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B24C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8020693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="tiQy37b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfDQU04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:26:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40767 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbfDQU0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:26:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id a28so19880197lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjIFuWx1KX02yKTr+E/orZ3y381docbzWDlECrUzZO8=;
        b=tiQy37b8+nGX5ESLjSPLCNwGtEwFSAf+CuvZpzq6l4WDVIc92bcItJjKa5wGw3SeeX
         4c8XdSO9ar3coJyLHsH4tKbsUoGmbSlc26ghvVQBl/1+2mk7VL/sT5nVoot7vRF/OT+K
         V2Eai2FN+8clZUN7tJh+60wS8K+H/gLJ2zOIf7/XalplYaOaghyc74z8HhsfPnpgrt7H
         et1VLgTdmaKki1PMjSvGfpu+PAnTwD7hdvqD2Ex0N0elNM2HUNXu8RDQ4btOTpRWRP2q
         5DXSWyB5kGizpsHEDG0SAB6g42WkcKQ/Ppg3dhLxTaaMp31TLxFXd5q9MnEXe7aCOzgF
         jzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SjIFuWx1KX02yKTr+E/orZ3y381docbzWDlECrUzZO8=;
        b=eo5AaMrJ0/LUrKZxuhhefQxSbEl0lYwIrkj0I+FTc16UthavHgV1wYkjQQvsYZ25Lz
         lSQSIStZWxCQzsnVC0AQ4NdnE7C29ngpSTtj+iLUiakbu5VhAFR7Mk/2mZHh2t2MPISq
         NwJBweL3TRywRpGbg3gEnK21Gsp+fdCSPokcGfjCvoPjc77i5jL+VHwBTk90DCIIntAr
         UeFykCZoUSDsSb9VQlCLPhIOKay3DgO06TpnDuoQ6qlNpAKJ1UV00u3JhQ5GgjwyXrG6
         xzEjxs2qSCMaExSlF29NQqkVE4/3P8I4zxHEqJ7eE81Tm1DAGwH3NrNIx5qdBi1tJn1d
         hrzg==
X-Gm-Message-State: APjAAAVhfKLa0rO7kRmCkBHybq7iVrOZk0Z04pwksfoMJG1IN8bwvulJ
        yeZavta8TMRWQxL2tl43ogl2yg==
X-Google-Smtp-Source: APXvYqzKT0KknDgG0w0fOqDmlQ1NMP6WxPf9AQe+WKcpgPpVydN1ouORS9udjE6W7Wl7hJ8zA2vi1g==
X-Received: by 2002:a19:c216:: with SMTP id l22mr24646529lfc.112.1555532813455;
        Wed, 17 Apr 2019 13:26:53 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.147])
        by smtp.gmail.com with ESMTPSA id i25sm2737268lfc.19.2019.04.17.13.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:26:52 -0700 (PDT)
Subject: Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
 <935046cc-e2e5-b9b8-0c94-1be5ae604276@cogentembedded.com>
 <OF8A9D093C.B3035121-ON482583DE.00065F23-482583DE.00074AC0@mxic.com.tw>
 <770002ab-7e08-b695-b5a5-fce772b600a5@cogentembedded.com>
 <OF2BD84B79.FBC5E822-ON482583DF.0020009F-482583DF.0022E315@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <76e9c2a8-1537-04ad-17e0-ebd9fa9b7b91@cogentembedded.com>
Date:   Wed, 17 Apr 2019 23:26:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF2BD84B79.FBC5E822-ON482583DF.0020009F-482583DF.0022E315@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2019 09:21 AM, masonccyang@mxic.com.tw wrote:

>> >> Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD
>> controller driver
>> >>
>> >> The patch name is somewhat misleading -- there's no "MFD controller".
>> >
>> > Can't get your point ?
>> >
>> > RPC-IF support SPI and HF, it's a MFD controller and
>> > that's why I patch it to MFD as Marek's comments.
>>
>>    I'd like the "controller" word dropped, as MFD stands for multi-
>> function device
>> anyway. "Controller" seems to be superfluous here...
> 
> okay, will rename to:
> 
> [PATCH v11 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver

   Thanx!

>> >> On 04/15/2019 10:37 AM, Mason Yang wrote:
>> >>
>> >> > Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
>> >> >
>> >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >> [...]
>> >> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> >> > index 26ad646..7914349 100644
>> >> > --- a/drivers/mfd/Kconfig
>> >> > +++ b/drivers/mfd/Kconfig
>> >> > @@ -978,6 +978,15 @@ config MFD_RDC321X
>> >> >       southbridge which provides access to GPIOs and Watchdog using the
>> >> >       southbridge PCI device configuration space.
>> >> >  
>> >> > +config MFD_RENESAS_RPC
>> >> > +   tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
>> >> > +   select MFD_CORE
>> >> > +   depends on ARCH_RENESAS
>> >> > +   help
>> >> > +     This supports for Renesas R-Car Gen3 RPC-IF multifunction device
>> >>
>> >>    "For" node needed here.
>> >
>> > ?
>>
>>    Sorry, that was a typo: s/node/not/.
> 
> Oops, still don't know what do you mean to ?
> 
> Will change to:
>          help
>            This supports for Renesas R-Car Gen3 RPC-IF multifunction device
>            which provides either SPI host or HyperFlash.
>            You have to select individual components under the corresponding menu.
> 
> is it ok ?

   Should be "This supports Renesas..."

[...]

MBR, Sergei
