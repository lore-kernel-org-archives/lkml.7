Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13050C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E449421783
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MKO23OSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfETS2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:28:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34110 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfETS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:28:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so9317049wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=1FK2DXKOFB3m2S1KpmmuQv43CteVea0a4jQ56pD1zGU=;
        b=MKO23OSaVzWu2iXq1D/NoheHxvM//TR5El/kkQWNWAzfwY7e7J8R+enPDRvIUbcqyZ
         NGjqLknvjtxjieY11283DVblu86q3rTCxZdPRE6GthHzIt14xZqzra6jDX8IfVhEOK1/
         /dEo62OMajZdNoyVKHqPkx+lHxc1FV3t3UhJnYKtkjDl2Y8it0vSpPJvUDkDMsMGfn6a
         gA0PWm0KnRhdrdWs3nwI8OEBx+LXru7EBryVdEbd4vsoerDD76wUxbeTHeNylKy0aBbA
         muSMpvm/t3fHZZPRMZ/auAhltKn3kuz76uRjZVNj2P8gpjWuBFOPvKqhGhAug5LKeXrZ
         v5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=1FK2DXKOFB3m2S1KpmmuQv43CteVea0a4jQ56pD1zGU=;
        b=INhctiXJ8KcY98klr2+X4G/r2vFo3C6y5mClLnqSezezzNFVCAz/3sX5zrMA/KcMgW
         EruWOiWDP2xd5QL1oiXvM3hrQT9AtzhVBIAsD4RXpjB7PnMYEYJdVsoNuD89ttHCxlgy
         GokABKebsMdsFAnzVXybcW8QXS00VUBkLMgEfyn5V55Xc6DCOoDhKcxb9fkzCWjC9e/8
         3EUDAcGDysVRQACPIPf4cv5MQR9oSMJOUVa49f4zlchZ60JSKujSrgiSqMStcFo4gs7W
         EfEEYq0nKe3+3Hdii5RwBtMPkfvbsjdFl7a0lxcH1RcZoEu9a56NdYNxyr5iiitepRJT
         gw0A==
X-Gm-Message-State: APjAAAXnPV4Dj6UwrYJNZBbPb2nAuzRrMmIKpwgLGvmymUAWOOp+n0Ln
        o20Ng1XButSwJ+VtIwZcCfUqkA==
X-Google-Smtp-Source: APXvYqz1r9onPeVavfsoGIY5wwRXwdggSKOmpXExBfHgCEti4JqdGoRECSwavjBIMt+Lt5YrV3VNfg==
X-Received: by 2002:a5d:51d0:: with SMTP id n16mr34573876wrv.167.1558376926448;
        Mon, 20 May 2019 11:28:46 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a62sm600078wmh.11.2019.05.20.11.28.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 11:28:45 -0700 (PDT)
Message-ID: <5CE2F1DD.4070700@baylibre.com>
Date:   Mon, 20 May 2019 20:28:45 +0200
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson_saradc: update with SPDX Licence identifier
References: <20190520140228.29325-1-narmstrong@baylibre.com> <CAFBinCD8Gkb0aRXWPb1uuezSHuS9DxQmnhuuSttspDzWHNAV1w@mail.gmail.com>
In-Reply-To: <CAFBinCD8Gkb0aRXWPb1uuezSHuS9DxQmnhuuSttspDzWHNAV1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Le 20/05/2019 19:55, Martin Blumenstingl a écrit :
> Hi Neil,
> 
> On Mon, May 20, 2019 at 4:02 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/iio/adc/meson_saradc.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index 510d8b7ef3a0..e39d95734496 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -1,14 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> the original license text didn't mention "... or later"
> personally I'm happy with either GPL-2.0 or GPL-2.0+
> 

I'll fix and re-spin, thanks for reviewing.

Neil
