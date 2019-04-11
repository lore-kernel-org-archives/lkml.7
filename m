Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA5D2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEgO+XK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfDKQyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:54:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:54:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so8250374wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cOPpYZ3H0MfSv2c9lP19htg6l7OxmezHtSYFlHqm1UU=;
        b=fEgO+XK1as3Z1ARlG/p809yfJJrV/4vTjcSHcrjqur3X5wDIwo8kCIGgLMCR/T/RE7
         JCcKGqLNte/YPw1IOGMrt0ckjOKvXwxnNWBzr1DMzDRQTicjRfaU9ZaBWcJZJC6b+NQC
         IwW8l1E2rpIcEIAPtPayK/MvxALsohFBGstFYmh3kDT67vKFq/HuGdRhmophtHY2vdkH
         XedXJx11QcfMRzVsG0FQdEKiVPjuoDWIszEkyufFTnQNZWPXLFD+T2G/9h0wennRhgMV
         HPrjg0AbBZ+Ho2DvRE6lnWrcL0+P9zXkDxID2rO1CPO/n384OMvlUa73JoAN0siG+u8f
         pjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOPpYZ3H0MfSv2c9lP19htg6l7OxmezHtSYFlHqm1UU=;
        b=TcEgeSVTb/tSpTZgsopcs839GxDADxUnylb6Ft2GnxrCNPs/jX8mO1I95sEspQhdBi
         iW3gy94oCaRg+Duw625BRC8q5uJ63KuJkox8MLN0Lns1eAQaGCzHxe48Ns79OqFNbvL1
         mG3bvmEfVp4QJdk2PoWYYL0v5uRUrakXwzgoJyy3QkYh9kaS4KQlJZFjFKcUUjOTkkQr
         fYVVi9dBw/u8pG1Ydi97BaPJcXv5zsuWvj7ulHeoxmc6rKDKgFpJRLy+FU8KXcbIxdr9
         AZDnKCyx89vA1F8Ef+/ZEXjq7FUdnIcHoLYWilYpOutPOgEI6uYQrswJZDWLE5MCQhVh
         TiKg==
X-Gm-Message-State: APjAAAXmK2647an89E4XcEBb7sA7MyNgbyjZWj//HdoEt6eMhaD/cn4R
        HeDk5FIT0Rkir366AbVHo5M88tWJavk=
X-Google-Smtp-Source: APXvYqzxeM5u5pIVhTsvKsMqIBrH2illPdq3axdBpz3E+n8nzrtGegGuKG19noMTlgSUB9ulYXnkMw==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr9784948wrw.68.1555001690222;
        Thu, 11 Apr 2019 09:54:50 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id y6sm41552051wru.9.2019.04.11.09.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:54:49 -0700 (PDT)
Subject: Re: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into
 struct qoriq_tmu_data
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-6-andrew.smirnov@gmail.com>
 <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
 <CAHQ1cqEJbXKdoqqwKjkD_yPjv52Y9w+XOOKxqFpPN23q-qnFaw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4a61e24a-fbb5-30f6-691a-0376fbca7b46@linaro.org>
Date:   Thu, 11 Apr 2019 18:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqEJbXKdoqqwKjkD_yPjv52Y9w+XOOKxqFpPN23q-qnFaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 20:00, Andrey Smirnov wrote:
> On Thu, Apr 4, 2019 at 12:57 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 01/04/2019 06:14, Andrey Smirnov wrote:
>>> Embed per-sensor data into struct qoriq_tmu_data so we can drop the
>>> code allocating it. This also allows us to get rid of per-sensor back
>>> reference to struct qoriq_tmu_data since now its address can be
>>> caluclated using container_of().
>>
>> This seems to be a repeating pattern, drivers are forced to put a back
>> pointer in the thermal sensor structure to regain access to the
>> container structure in the get_temp callback.
>>
>> It would make sense to pass the sensor id to the get_temp callback as we
>> register with the sensor id.
>>
> 
> I'll rebase this series on the two patches you submitted.

Well I should have added the RFC tag because I was not able to test with
a platform.

[ ... ]

>> Why not replace the little_endian boolean by a couple of callback
>> read/write and assign them to ioread32|ioread32be at init time.
>>
>> That will kill the tmu_read and tmu_write functions and from there you
>> can figure out how to remove the qdata backpointer. In addition, it will
>> save a few instructions to test the boolean.
>>
> 
> I am sure you've seen it by now, but little_endian is going away in
> this series in regmap conversion patch.

Right :)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

