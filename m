Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E13D2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="kyw+LQV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfDPS5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:57:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44114 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDPS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:57:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id h18so16820849lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mHWtmwyAL2XHOrKy1SeAKzyIarOVhhoWMy3soLN/2qk=;
        b=kyw+LQV7Gbz9iqhZALqq7LnL9dn8ByI5wvqzsDFqNCkE14gstYHSQs2J9snQYYoJXe
         U+Gl0MdkqNxwD1/RFC5I+stF4MCuHAlWKR1mK4UzWUEUpH1B5M4IgN0/7umQZ/jDWbRV
         nk6MGeG414sTNnQsPgQqcb06/knQ6ZTNyApQc8jiODwNcr9C/8s13IV0efq0X6rrBaVf
         66TQ65HobdLxq119M800LNE5m1iku7MjaRnWqCjfhSxk4TwY3f7DoHR81tG8OVlIooBW
         urJkg+nDrpszhpqCXT+nhvJkajpdBni2G1cuVJVUBZDul4hxeeeq3NVVnmJOpeYouFLl
         AHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mHWtmwyAL2XHOrKy1SeAKzyIarOVhhoWMy3soLN/2qk=;
        b=rUGunnWQUG98F1/GyulxGzcPXgYvnLso/IT7laHPT0pTrXWeGZ08WZNOIkWmO3yxfK
         K3wDY7ZabPFN9ToyrHs5EIXzCZ7mTvrWVGEQtumZ4MlVEprHHUP5Do84zTxlMpN7lpPy
         YhRK8NopUo7TCVuB1Fx4CuUM905y6BvXxrkBWpBa6bMyM3BRZQSb1vH2pX88zQawOcsD
         zRB+uK0tpBLaIOyUOx8p/jLoKZcpzR+AgDRd9FXnhrkfF1h8UKF2TDOVy8NeNC7vLZIp
         lfXa5Bn/GcmVHerWQ0SnXqc8rcJMFDKz+otNn3AMA4CaMCq/4RzPscXUrMjYdNNNkiac
         ma4Q==
X-Gm-Message-State: APjAAAVVNxUdNCtDJtKFlmGADpqj/qxwmCPORZosLG5V/XexG5WQ1QPV
        nZiEXIoJwrLmoilKsRnwCRYL2g==
X-Google-Smtp-Source: APXvYqw6JXyPu+u3zD1dLYZF9dT+mzft1fi+6i7CtOeN61K5R1JdnqfSFY0Il3YJjWByO41Y7CH1xg==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr5861456lfn.33.1555441053129;
        Tue, 16 Apr 2019 11:57:33 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.184])
        by smtp.gmail.com with ESMTPSA id b12sm248341lfa.74.2019.04.16.11.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:57:32 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
Organization: Cogent Embedded
Message-ID: <770002ab-7e08-b695-b5a5-fce772b600a5@cogentembedded.com>
Date:   Tue, 16 Apr 2019 21:57:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF8A9D093C.B3035121-ON482583DE.00065F23-482583DE.00074AC0@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2019 04:19 AM, masonccyang@mxic.com.tw wrote:

>> Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller driver
>>
>> The patch name is somewhat misleading -- there's no "MFD controller".
> 
> Can't get your point ?
> 
> RPC-IF support SPI and HF, it's a MFD controller and
> that's why I patch it to MFD as Marek's comments.

   I'd like the "controller" word dropped, as MFD stands for multi-function device
anyway. "Controller" seems to be superfluous here...

>> On 04/15/2019 10:37 AM, Mason Yang wrote:
>>
>> > Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> [...]
>> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> > index 26ad646..7914349 100644
>> > --- a/drivers/mfd/Kconfig
>> > +++ b/drivers/mfd/Kconfig
>> > @@ -978,6 +978,15 @@ config MFD_RDC321X
>> >       southbridge which provides access to GPIOs and Watchdog using the
>> >       southbridge PCI device configuration space.
>> >  
>> > +config MFD_RENESAS_RPC
>> > +   tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
>> > +   select MFD_CORE
>> > +   depends on ARCH_RENESAS
>> > +   help
>> > +     This supports for Renesas R-Car Gen3 RPC-IF multifunction device
>>
>>    "For" node needed here.
> 
> ?

   Sorry, that was a typo: s/node/not/.

>> [...]
>> > diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/
>> renesas-rpc.h
>> > new file mode 100644
>> > index 0000000..61ada14
>> > --- /dev/null
>> > +++ b/include/linux/mfd/renesas-rpc.h
>> > @@ -0,0 +1,153 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +//
>> > +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
>> > +// Copyright (C) 2019 Macronix International Co., Ltd.
>> > +//
>> > +// R-Car Gen3 RPC-IF MFD driver
>> > +//
>> > +// Author:
>> > +//   Mason Yang <masonccyang@mxic.com.tw>
>> > +//
>> > +
>> > +#ifndef __MFD_RENESAS_RPC_H
>> > +#define __MFD_RENESAS_RPC_H
>> > +
>> > +#include <linux/clk.h>
>> > +#include <linux/io.h>
>> > +#include <linux/log2.h>
>> > +#include <linux/iopoll.h>
>> > +#include <linux/module.h>
>> > +#include <linux/mtd/mtd.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/pm_runtime.h>
>> > +#include <linux/of.h>
>> > +#include <linux/regmap.h>
>> > +#include <linux/reset.h>
>>
>>    NAK. I have already told you that these #include's are only needed in the
>> drivers, not in this header.
> 
> why ?

   Why what? As a rule of thumb, we #include only headers necessary to build
the file in question.

> I think these #include files are still needed in HyperFlash driver.

   Hopefully not. Though that doesn't really matter much.

> i.e,. clk controller, mtd and so on.
> 
>>
>>    My idea is to contain all hardware manipulation in the MFD driver,
>> with SPI/HF drivers calling that code via a set of APIs declared in
>> this header.
>> The registers (declared below) would end up only needed by that
>> common MFD driver...
> 
> best regards,
> Mason

MBR, Sergei
