Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D978C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003572173E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NdQOnzKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfETSZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:25:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45912 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfETSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:25:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so15648172wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=sdtwsXgqa/NDq4JZO/qTIK4aUEyBtvxUvqlGly1nriI=;
        b=NdQOnzKz6heoK6zaciWzqf3ePB2ECiG3nRuCSbEsXZu76sa2AL2Ldo+j/m6TP3/JHA
         36eF8VzFXeFWRa74x2Z6KsjgEDTyxSPRbHm6Z5FxSBhEwsOjLDj8OhcwHg49SPBdhYTU
         Jpzy0aZ+floKjG2FR4g9i7rFFQ8nlulhSX1e29HrELIhby0knGJWen/07yz8jtQL03b3
         HtNlPO3AQnmgFaHZGqFCt4Hx0QvEaSY1EzKQR3AZfhNRyHdDb0CxitDCXs8GSkmcgPNP
         SB4V8z/Eja5I0pVC9c6IhdT9RYTk1cyRDCkYqAbgVNL2L4n5RFPVTOTphS+INj+7srT7
         Abiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=sdtwsXgqa/NDq4JZO/qTIK4aUEyBtvxUvqlGly1nriI=;
        b=Vj31RUtA0OpNgDXS5PKNMLarVCc8+oYfX1PQ/iP/aFJ9QxIGHlyqA4xwcRPBLpBPmt
         C6uGHcPx7XkD8LHY96RzGFLxsktOrsflEIxwalNz0WJDppWME6bQZyaYVE9G/uDOBcaU
         2+oykc1kZAdFQp09e3P3akfX34ZJCA6wK5dqEFCRWWEQv8Nu8k5kupU1Ux9RPQ4Qs//x
         VBYYEiJ1P2kykSxdtwEAnuRr9CDQdWEHL4joOV/P5bI76txWcMM+uZerqK3Rm55AREaM
         rGgmE2cY+tgKozPppT5iGDWxoc86tOTY6Z9Dlb6LWr3fvxe/lC9CnJph93FJhRDRFdCw
         zPsw==
X-Gm-Message-State: APjAAAXGhOco87bF/mBH3eE5xinf+8gb53eXNHqUaGXEC26dqxuCDACB
        dYDv5zFL7uzc45eO3X1KvrMTRg==
X-Google-Smtp-Source: APXvYqzF2++lQ5ZuxocUnfANpanLa7uAQ0+FDIAeGsP5M2LB9AUNt0qLR81E1CVhrpDpPpXwwrLa0A==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr11774775wrs.280.1558376750654;
        Mon, 20 May 2019 11:25:50 -0700 (PDT)
Received: from [192.168.1.77] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id j28sm28737171wrd.64.2019.05.20.11.25.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 11:25:50 -0700 (PDT)
Message-ID: <5CE2F12D.3040303@baylibre.com>
Date:   Mon, 20 May 2019 20:25:49 +0200
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     jason@lakedaemon.net, marc.zyngier@arm.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: irq-meson-gpio: update with SPDX Licence identifier
References: <20190520140310.29635-1-narmstrong@baylibre.com> <alpine.DEB.2.21.1905202001270.1635@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1905202001270.1635@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/05/2019 20:02, Thomas Gleixner a écrit :
> On Mon, 20 May 2019, Neil Armstrong wrote:
> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/irqchip/irq-meson-gpio.c | 15 +--------------
>>  1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
>> index 7b531fd075b8..d83244ea0959 100644
>> --- a/drivers/irqchip/irq-meson-gpio.c
>> +++ b/drivers/irqchip/irq-meson-gpio.c
>> @@ -1,22 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> + ????
> 
>>  /*
>>   * Copyright (c) 2015 Endless Mobile, Inc.
>>   * Author: Carlo Caione <carlo@endlessm.com>
>>   * Copyright (c) 2016 BayLibre, SAS.
>>   * Author: Jerome Brunet <jbrunet@baylibre.com>
>> - *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of version 2 of the GNU General Public License as
>> - * published by the Free Software Foundation.
> 
> I really can't spot a 'or any later version' text here ....

Exact, will re-spin, thanks for reviewing !

It was all blurry after 54 SPDX updates !

Neil

> 
>> - * This program is distributed in the hope that it will be useful, but
>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - * General Public License for more details.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> - * The full GNU General Public License is included in this distribution
>> - * in the file called COPYING.
>>   */
>>  
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> -- 
>> 2.21.0
>>
>>
