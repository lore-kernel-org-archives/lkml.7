Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5DCC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1B4206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G89E42Pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfEQIp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:45:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfEQIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:45:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so6208914wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=zANvFWcmKo8EuxHsHKy0+A0TL7ZrRo4zFgliyPjUUj4=;
        b=G89E42Pa8/i0yLqFzDrR7voEnExiA0bj6nxX/4R5r20F5lboYP6d80VB+yt+uns+cU
         CLh2KVwNUMjJb6+O8Y93sHBY/NUt++OAt1tQ/3SDeNABXCdBOafrfibAkCOB3L+feT2m
         s8KKjZzoi+CZ3QwFklDFwfqL5xNo4+o+laL2vGQMvFhfjpOpDpH/nYqr7zoFiWsDa+wF
         eDvewynCTMPVD2dTSK+2OE91AyC87rburN6cEoGRymtk4UVzaG5SUtZU/qTII1JxVCcO
         KybayTKa8Vw6kkWVbJAPaHWf/bzv2rVzxFntNfCUMdPh8jfM3u2rwPh3bOb1tqB2Uf0v
         rEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zANvFWcmKo8EuxHsHKy0+A0TL7ZrRo4zFgliyPjUUj4=;
        b=V6Hl7kgk1x/gAQzN6mfK+AwZmuNcn/yLxUxXmfAr7gLEompRXO1kJd0dwdzTR3J506
         Hk8ATw6Rx2XIcXwYiBQcyIqEo+NesWLuC3z4GNIICsivdchL2GsdWFTN1ItWKsvCx5ZG
         JEVllh4U5FZD7iwylA1cckbaVLFv5dcy+UGbO0OXw0hLB/5wooTOKEbggdTO08TbiNIa
         AWA2sEC3LmqDkZ0+JCYmJu8pJuFSEkxe+INaWQ+0SbQigbLrdBVLbbyc3OKciySB4Xrv
         mDdG5gDoDIeI+XpJiqMG8TzknGYLYRJtRQh6+vCLhzZYMwW7E099q8NRdchAKdjzPEsR
         oZZg==
X-Gm-Message-State: APjAAAXVZ2AATGsi68UokfWbMxqaBEaKVyqoTplaceIozlY1b7CRG25p
        5vRSeT7b7cYzabaLCwfKJSAkZg==
X-Google-Smtp-Source: APXvYqwBWa7+jkAlmZTk18op83oeFtloTczIxdn6drxP9ta4epZYJ52bFHtjfdYK8jPP5UQwHeCBig==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr32445004wrn.77.1558082756357;
        Fri, 17 May 2019 01:45:56 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:fcd4])
        by smtp.gmail.com with ESMTPSA id v17sm5528287wmc.30.2019.05.17.01.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 01:45:55 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Colin Ian King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] gnss: get serial speed from subdrivers
In-Reply-To: <69b5e90c-c1c3-9f2e-57a8-64741182a96e@arm.com>
References: <1558024626-19395-1-git-send-email-lollivier@baylibre.com> <69b5e90c-c1c3-9f2e-57a8-64741182a96e@arm.com>
Date:   Fri, 17 May 2019 10:45:53 +0200
Message-ID: <86y33579ku.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 May 2019 at 19:02, Robin Murphy <robin.murphy@arm.com> wrote:

>> -/*
>> - * FIXME: need to provide subdriver defaults or separate dt parsing from
>> - * allocation.
>> - */
>>   static int gnss_serial_parse_dt(struct serdev_device *serdev)
>>   {
>>   	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
>>   	struct device_node *node = serdev->dev.of_node;
>> -	u32 speed = 4800;
>> +	u32 speed;
>>   
>> -	of_property_read_u32(node, "current-speed", &speed);
>> +	of_property_read_u32(node, "default-speed", &speed);
>>   
>>   	gserial->speed = speed;
>
> Hmm, maybe it's a bit too convoluted for the compiler to warn about, but 
> if a "default-speed" property is not present, gserial->speed will now be 
> assigned an uninitialised value. I don't know what the intent is neither 
> the driver nor the DT provides a value, but you'll either need to bring 
> back the fallback initialisation above or propagate errors from 
> of_property_read_u32().
>
> Robin.
>

Robin,
Good point, thank you for your review. I'll think about it and see about
a fallback scenario.
I would be in favour of propagating the error because default values are
very dependent on the hardware in use.

Best,

Loys
