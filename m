Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13454C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5420823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcNwWM6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCCOBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:01:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44674 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCCOBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:01:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id d2so2507038qti.11;
        Sun, 03 Mar 2019 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XzcbIbIjJxWYB1FT7VpeLNoZ8jMBhFFxl9MPY5fbVW0=;
        b=IcNwWM6Z+798YB4TvVkCZcaWBgf+I6mZ/BupHRlPaZxAF+UZ/ok4zJjnYeXZe541GU
         5Fe0zoM7rE4zAKbS60kY3WYZuObafuHI1ahYA14N8Cq+vdzTTJ3PDdWrHYXd77xXWpX8
         CFs9IVD9zRtWC++no/ensNLj1JUuTWSXsav9PVsYmrLf1nR8E3cvv1UR12OH8LZyOREK
         5+hB7/bPN1ZtGzspiKQr4NCM88tTK/YFwfjL1MznmSabV7DKvhnqCX6/AXOV5Bvnd67g
         Nj9Bp5gFsVo/r1FzABhz7/Yt+iJtQ4NWlxcFQ0yGMgnLfbjFZrQ5rirEWdRGGz4+W7l8
         wnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XzcbIbIjJxWYB1FT7VpeLNoZ8jMBhFFxl9MPY5fbVW0=;
        b=UR0ciYimNGx9sQisLvfnt3oS4lHvjbCKn5hYIkm4YggcWy1uDiebZqxGOSehwfx37D
         /GiEdFJHErKO8V2Tt/87uOFIQe3V6KjTv35ijfixRLQq8Okw8Q78PhV6fgvCVqxtlwPn
         03hin2ixX04WJR3t51oHd52jOB61PtZ2Kxoiq33jiEkq0/HoRGZl86uPhWXI0YSKX83p
         U0Ean61USE6uxWgOxAM4u8x/h3g2I77PoN7oAOSY4nXHGjZX9Hfgjw3VabmPl9LebxKO
         j+gRLrb5Y5SsIz7wua9wIghbnThB6Oo4rHTCh7KBaALSjKPVebRsO1aTDAkJPGyumd4H
         EheA==
X-Gm-Message-State: APjAAAW2msgHI/QGDplDSnmPFyEhvDZZv7zcniGodGtKH5rRUalGeUBc
        iLxLqq7V6bH4WLGqzEWZ6Tk=
X-Google-Smtp-Source: APXvYqz1rn1wTvuHZyVHCK9/GQMYyTJHHBcBp4JXeDilpLgnCEdQXsPOoYzXURrp7Thy97DNDYlABw==
X-Received: by 2002:ac8:1735:: with SMTP id w50mr11343081qtj.361.1551621675023;
        Sun, 03 Mar 2019 06:01:15 -0800 (PST)
Received: from renatolg ([186.220.23.48])
        by smtp.gmail.com with ESMTPSA id j139sm2067799qke.26.2019.03.03.06.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 06:01:14 -0800 (PST)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Sun, 3 Mar 2019 11:01:09 -0300
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] staging:iio:ad7780: add chip ID values and mask
Message-ID: <20190303140107.ljjo3flatwmd44ya@renatolg>
References: <cover.1551358569.git.renatogeh@gmail.com>
 <90c573cd53bb54d49de6ac270bcff66880ccfeb5.1551358569.git.renatogeh@gmail.com>
 <190e26b19b8ed6559b92d3a000d852bbb0099a52.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <190e26b19b8ed6559b92d3a000d852bbb0099a52.camel@analog.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01, Ardelean, Alexandru wrote:
>On Thu, 2019-02-28 at 11:24 -0300, Renato Lui Geh wrote:
>>
>>
>> The ad7780 supports both the ad778x and ad717x families. Each chip has
>> a corresponding ID. This patch provides a mask for extracting ID values
>> from the status bits and also macros for the correct values for the
>> ad7170, ad7171, ad7780 and ad7781.
>>
>> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
>> ---
>>  drivers/staging/iio/adc/ad7780.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7780.c
>> b/drivers/staging/iio/adc/ad7780.c
>> index 56c49e28f432..ad7617a3a141 100644
>> --- a/drivers/staging/iio/adc/ad7780.c
>> +++ b/drivers/staging/iio/adc/ad7780.c
>> @@ -26,10 +26,14 @@
>>  #define AD7780_RDY             BIT(7)
>>  #define AD7780_FILTER          BIT(6)
>>  #define AD7780_ERR             BIT(5)
>> -#define AD7780_ID1             BIT(4)
>> -#define AD7780_ID0             BIT(3)
>>  #define AD7780_GAIN            BIT(2)
>>
>> +#define AD7170_ID              0
>> +#define AD7171_ID              1
>> +#define AD7780_ID              1
>> +#define AD7781_ID              0
>> +
>> +#define AD7780_ID_MASK         (BIT(3) | BIT(4))
>
>This also doesn't have any functionality change.
>The AD7170_ID, AD7171_ID, AD7780_ID & AD7781_ID IDs are also unused (maybe
>in a later patch they are ?).

They aren't. I added them following a previous review suggestion. Should
I remove them?
>
>I would also leave the AD7780_ID1 & AD7780_ID0 definitions in place, since
>they're easier matched with the datasheet.
>
>>
>>  #define AD7780_PATTERN_GOOD    1
>>  #define AD7780_PATTERN_MASK    GENMASK(1, 0)
>> --
>> 2.21.0
>>
