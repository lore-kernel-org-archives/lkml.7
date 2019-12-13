Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EAAC50737
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A9F2470C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nlHPlznw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfLMOHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:07:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52511 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfLMOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:07:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so6511349wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 06:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=B8XeIUMlmn1LnNEcrDK6VX5QC3QQw4jrJkYLaEf7rhY=;
        b=nlHPlznwfxHFz2zwQOmaNikkzmKhjllm5ZJu+/n6bjwty/5/1CBnF3xcSHWFb4WFGA
         8gm+x6vnonzksRDxmYQASHzbHN5p4DjN4VvCN4Psui0+FPqzPD6SSW/t50pPFFUTwAR5
         ZIrawi2ScEJuqUvd52HdpajLP+OKTSgv+J/wfe5RsfKZ6DHoh9tdWtqQLuUDrxTZzEuM
         P9QXeo9SnoE+ZYl/Kb6px8ma5B5Kbnr0tT4xNvK4qDniGCNhW4Em8NJepzheHqie99Yk
         zsxC8pvqZKJHcnseGnt3cnjCQ0s5qCSdKwtoDul7mSIkMElznqeekiF5VH0ctYcnsMkl
         Zp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=B8XeIUMlmn1LnNEcrDK6VX5QC3QQw4jrJkYLaEf7rhY=;
        b=RGQ6W+JUnVzwphIEtN38btKm1cuhwVo7nN5LzyfH4Ny0MMUZ6sRrQ0CqUy2oSIYzsJ
         y+oPd12HJbgiVHwn1NALH3hvYIzG1zJtlWPv+k+rykQO7P6M93jREX1AOOUCZXaSdSVX
         dO5VI4L5Dh6F0DCXF4LPWQ91wUGOpzLpXv2bVzok5AueTLpj3CwNmYGaYricBubCbSlB
         DB7MC4Oi8dSjoY5WT2IZP1HtqkNw8ql6iKZwOObvgjXYNDoGSY1iWvny1F0EsQ/BCR/M
         +n5a07JYr9GaFfTW5ct/k/tmommpnsAM4r8Q2+/kV3Pb/hqDJCAlE8jwm0Z6OFNurlFX
         Po1w==
X-Gm-Message-State: APjAAAWAuD0rQCJ7tHhnwBfvTHTYB/JYg73cHBURrY+/joJExIaCWR9o
        1kqebAoJNqkZal6qp9ZOQVd+GQ==
X-Google-Smtp-Source: APXvYqz70IRnslxWa/SgLp9cuf267xbRH/QgTq6jrm8dwyDfX8ZUGfjMqqrvJ0VyX2FNVMVKvcbqBQ==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr13728535wml.107.1576246058120;
        Fri, 13 Dec 2019 06:07:38 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca? ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id d8sm10004369wre.13.2019.12.13.06.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 06:07:37 -0800 (PST)
Subject: Re: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
References: <20191213105521.4290-1-glaroque@baylibre.com>
 <20191213111702.GX10631@localhost>
 <162e5588-a702-6042-6934-dd41b64fa1dc@baylibre.com>
 <20191213134404.GY10631@localhost>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <08ae6108-0829-3bb4-f398-7e6a58719d29@baylibre.com>
Date:   Fri, 13 Dec 2019 15:07:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213134404.GY10631@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/19 2:44 PM, Johan Hovold wrote:
> On Fri, Dec 13, 2019 at 01:31:18PM +0100, guillaume La Roque wrote:
>> Hi Johan,
>>
>> On 12/13/19 12:17 PM, Johan Hovold wrote:
>>> On Fri, Dec 13, 2019 at 11:55:21AM +0100, Guillaume La Roque wrote:
>>>> @@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>>>  #endif
>>>>  	bcmdev->serdev_hu.serdev = serdev;
>>>>  	serdev_device_set_drvdata(serdev, bcmdev);
>>>> +	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);
>>> Shouldn't you be used using of_irq_get_byname()?
>> i can use it if you prefer but no other interrupt need to be defined
> Maybe not needed then. Was just thinking it may make it more clear that
> you now have two ways to specify the "host-wakeup" interrupt (and in
> your proposed implementation the interrupts-property happens to take
> priority). Perhaps that can be sorted out when you submit the binding
> update for review.

no problem i add a "host-wakeup" interrupt-name.
you are right it will be more clear with name and we know why this interrupt is needed.

> Johan

thanks

Guillaume

