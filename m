Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40212184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWtkLkMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCTOZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:25:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43918 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfCTOZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:25:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so2975816wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zhB+LeFVS6OFyErgJNo3tOKrMggpNFpe2MsHnlwSdoc=;
        b=GWtkLkMWuzbZyx7qkGuvjmvhnO2mFey3KQu0tw7hSNUr5avZXIrfzKKNGVqsZkhxsK
         +JQFdVsjKw6bsjh2T7DlDn1ed7msi4HqiHFVdb2V3bIncbdhYIIRQJv3B01UZiQJnd4D
         A7qC7XvxxBMbn+qOFviFOkVj9aXYXTV5bRGE6lI61OijVOQqwmmibC5VyHXCRGj2FLEg
         Az/0edLTmoDEKrPkRK1cI5s5ieatxdUC+onrjLAt/lFQtvtfBF5DKdrEK9mgZqf+bDqc
         9MM95hxEeNE2fJU0FblSJu/E/IRWNqXFaUxWFEf4Z1xcQiuiQA3hTM/6D/YvChhAeivQ
         mkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhB+LeFVS6OFyErgJNo3tOKrMggpNFpe2MsHnlwSdoc=;
        b=faEaflHVKntCvsXmUsvFbclUULOrcmsOHcmc2pgclb7UOIcqG79ajQydpiSiFjg5EN
         LyibHCLa5RZ/LcbatuCZxld4y9js7PFL6dR4f1c4BufmrjhzV1IC6RzgaLY0/RSF9tMZ
         ILJUqlWDsbzRVQ/X9rkdFuw5NKVrJDa4gbPR2DBRdKv2wdWudNAY7qRtRhgTbX7uYMCO
         WI0T/IJnfsUoYXSMiS6UiLHehbghEQ7xKVbn/UbnT4ZQxIUNgLUR87PjA9mtuiukPanj
         gY/k3JirieCN+ZWdWwWq22KjrDCUPjXtR/EOnITjPDXm3GPO5sD7VLZxDsgbcRvWGfhi
         vG/Q==
X-Gm-Message-State: APjAAAVtkF08zdQLSFeNQPzOJhXJCPy6ksdwut4/tdv+I3aFqZfA8ocQ
        kKn7AmJuh6mXtUanM71WvhOGzkssDTw=
X-Google-Smtp-Source: APXvYqy97hHbUmezKnrVjDvyeTgzMEv5T5YP9IFOx7VmHF/9vMkePzRUYLH/rbnon7DyJ83vFB6qbw==
X-Received: by 2002:adf:e889:: with SMTP id d9mr9095138wrm.162.1553091938812;
        Wed, 20 Mar 2019 07:25:38 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v20sm7710526wmj.2.2019.03.20.07.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:25:38 -0700 (PDT)
Subject: Re: [PATCH 0/6] nvmem: sunxi_sid: native format and A83T/H5 support
To:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190318073354.12151-1-wens@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <437873bb-26c5-a451-0a4e-5d846b05244a@linaro.org>
Date:   Wed, 20 Mar 2019 14:25:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318073354.12151-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2019 07:33, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi everyone,
> 
> This series converts the sunxi_sid driver to read out data in native
> endianness for all Allwinner SoCs. It was already the case for the H3,
> which used a different read-out method. The endianness for this hardware
> was found to be either native or little endian [1], based on the data
> layout for the thermal sensor calibration data stored within. Some SoCs
> have either 1 or 3 sensors, and calibration data for each sensor is 2
> bytes wide, with data for 2 sensors packed into 1 word.
> 
> The first three patches do some clean-up and improvements of the code
> overall. The fourth patch converts the driver to reading out data in
> native endianness. The fifth adds support for the A83T and H5. These
> two were already listed in the device tree bindings. The last patch
> adds a device node for it on H3 and H5.
> 
> Please have a look.
> 
> Regards
> ChenYu
> 
> [1] https://lkml.org/lkml/2019/2/18/134
> 
> Chen-Yu Tsai (6):
>    nvmem: sunxi_sid: Read out SID for randomness without looping
>    nvmem: sunxi_sid: Optimize register read-out method
>    nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
>    nvmem: sunxi_sid: Read out data in native format
>    nvmem: sunxi_sid: Support SID on A83T and H5
>    ARM: dts: sunxi: h3/h5: Add device node for SID
> 
Applied all the nvmem patches except DTS patch to nvmem next

Thanks,
srini
