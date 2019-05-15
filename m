Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D734C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03032084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6G3WkPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbfEOMDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:03:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36204 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfEOMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:03:21 -0400
Received: by mail-io1-f65.google.com with SMTP id e19so1998790iob.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oXcC1WmqtHCA/25OGfVus2ss0Q8/KBx9Yi1Cn7vNm64=;
        b=E6G3WkPNv9aRnK4QX8NVYVlIXkq1xCV+BGD0zKo/346Ai0W84w4531tTwaaoa6GiVa
         pnG47pwJBnNz4UMUDTzh6hwKzV1NIzL8y18kMSF5/0yEMEXM6YYTUOE0TG7FtfOkjrye
         rIJFqkh18+vzTKMC3c7twyU/M8TsVKijeLilBIoGSdYy6tXV9Tm7+WuqUO4bfaHtw10u
         WFZENFZBeCpccvYJ+KKr4huEegGw+9Ld6LOsKXojNesHbgE/nQOTLt+wnxeCFd7DnLui
         3GCr8DhvevVwiVKJ9y60rOqqYlJM5QTtIGTVpxYOWROhaYgqSr5cx4dWU9rNeGi+/mf/
         FR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oXcC1WmqtHCA/25OGfVus2ss0Q8/KBx9Yi1Cn7vNm64=;
        b=Be5lTDDJLVN0MbJKejbcJVno74WWtO1wEdRNFyUPw06VayVmDAYFwDsptw9U7o0kht
         6HfYKOa+cZzRkuMaUtw8BxpJ3e0vKI0lyDdornXVZPsPfJUsDqQTVMppQ1sZejLwIdXc
         mFdBYR0J11tqaQTvc/DGqNZhXToQl8GMu/jmB4pkPfmr8ORB37Gx5L2yGKHdcgtRonZb
         ru2b1knkrfLnSXhve6caBnWmDuSALpm8pDwDmpipT0NNsXg9RuBlyNRqbB6YAcO2dX3U
         o0JrpbSRy6kbmdYP4Zje4oJmJiOn3PeZTJBjM0oX43PV9NDkI/5cktUZ+tyTbz4/HxHk
         /O9g==
X-Gm-Message-State: APjAAAV4da53A34apJ+x95gCoLnu8qwnw4bZL3s28HDaYDLh7ALhgthd
        u87tr4LAuRdb2kM1abB6JukQyyoYm54=
X-Google-Smtp-Source: APXvYqwtP6NSXcbHsqX0dDky2Qlej8/PFqCVyQfH3swfAJRmYCZiBBbts6OBrlklfZM/BpOIdhtDmg==
X-Received: by 2002:a6b:fe0d:: with SMTP id x13mr23295482ioh.1.1557921799968;
        Wed, 15 May 2019 05:03:19 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id h191sm31334ith.5.2019.05.15.05.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:03:18 -0700 (PDT)
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        subashab@codeaurora.org, stranche@codeaurora.org,
        YueHaibing <yuehaibing@huawei.com>,
        Joe Perches <joe@perches.com>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-3-elder@linaro.org>
 <CAK8P3a16HpKEUB7_6G_W_RKkyVeVBW_rofLbdhC2QmWjVOAHMg@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <9cae00c4-29ab-6c3e-7437-6ed878a3061f@linaro.org>
Date:   Wed, 15 May 2019 07:03:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a16HpKEUB7_6G_W_RKkyVeVBW_rofLbdhC2QmWjVOAHMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 1:59 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
> 
>> diff --git a/include/soc/qcom/rmnet.h b/include/soc/qcom/rmnet.h
>> new file mode 100644
>> index 000000000000..80dcd6e68c3d
>> --- /dev/null
>> +++ b/include/soc/qcom/rmnet.h
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (C) 2018-2019 Linaro Ltd.
>> + */
>> +#ifndef _SOC_QCOM_RMNET_H_
>> +#define _SOC_QCOM_RMNET_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/* Header structure that precedes packets in ETH_P_MAP protocol */
>> +struct rmnet_map_header {
>> +       u8  pad_len             : 6;
>> +       u8  reserved_bit        : 1;
>> +       u8  cd_bit              : 1;
>> +       u8  mux_id;
>> +       __be16 pkt_len;
>> +}  __aligned(1);
> 
> If we move this into include/soc/, I want the structure to be portable,
> and avoid the bit fields. Please use mask/shift operations or the
> include/linux/bits.h macros instead to make this work with big-endian
> kernels.

Sure, I'll do that.  I did that everywhere else in the driver,
but here I just tried to preserve the original code as I moved
it.  I will update at least these structures, and all existing
code (plus the IPA code) to use fields masks.

					-Alex
> 
>      Arnd
> 

