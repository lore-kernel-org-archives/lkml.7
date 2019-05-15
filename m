Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE3320843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Akbiq8u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfEOME6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:04:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52626 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbfEOMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:04:54 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so2760167itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gWDGHQlINMY637LA0rkzmHJ184n+4lXL69Jz1SVmEeg=;
        b=Akbiq8u5JFtbaEC1MDoNI4f4D7f7lBbSGAF9vRhIGnRTC+IrcgwYeCbvHl1DlPGrd/
         uLlMVXOol3moj0DitDDLOTcdB/zL11V1ry4lDhtpBU7Ty72egPL9gLXZtr2KsD0pbt8Y
         ujJG/oLEFjuMICLG2racJPZIDBjmUK0W9bsefTQLk9da9Pmn9iaJzeM23AcM7jyxogBv
         GEFZTu8ZmJZs0XCtXOla1MzrFNArPIaD+Hq9XJ+vzb9BKZqK33+eub/o+xi8kpB605O0
         XT2jezPKFug2wmK21/WeVXOZcEZpE+YO+pMJDbiTHM5EIiv80p+FXtvfl7CwLEaIc7bs
         lgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gWDGHQlINMY637LA0rkzmHJ184n+4lXL69Jz1SVmEeg=;
        b=eLAXo4BZZa5dJsKs/6bT0I1O+Wh91/Qs9l5vuKkuQGhuzRO7QDiWSuC2Q/yIuPiwUQ
         xUf93uJvmU6WROm9JAxbskRMT6uhEca5AFMeu3JRUBY+F6FTOib0Go0sqJJqRn390CGm
         IxMzHuVHLHynJ9XVZrPYVSt9rMWXSKUS0eLDyCdToQL1FlgKmQy4W4ZbfGwt4D7ZKm2S
         yaqBPdrfpv7pKiC3qOyLV1e1p6h7NfC7WZtNIYGgIHehnONNCR4tUw7dOoYsOS/b993e
         KsNtJO7IKh5u4Pe6EwX1hf2yPve252rTpjGW1qgrN17+eHLZpxjUaJ6zh2uzjmYZ7bA7
         wFrw==
X-Gm-Message-State: APjAAAUZZ4XKOuhELwH0KNDpK/F/lMNWY/PVBrLA4yTqmuIHrSk1i13P
        mqm6ayWCcTd3qekhK8a7oOb+rqztKno=
X-Google-Smtp-Source: APXvYqztxRurLYFbNqlUSgw9PHMnGWQUtrrC+MpUHTY7IRcD8rWRKxZEIo9cIrTPKoHE1Nxs+Ou5wA==
X-Received: by 2002:a24:5255:: with SMTP id d82mr8296250itb.104.1557921892588;
        Wed, 15 May 2019 05:04:52 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id x77sm41767ita.1.2019.05.15.05.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:04:51 -0700 (PDT)
Subject: Re: [PATCH 03/18] dt-bindings: soc: qcom: add IPA bindings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-4-elder@linaro.org>
 <CAK8P3a3KLj5x-5VS5eUQfNVhPL101Dg_rezEzra4GFY5Dva2Cg@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <fa75eb5e-90bc-b164-740f-4dbba8bccc46@linaro.org>
Date:   Wed, 15 May 2019 07:04:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3KLj5x-5VS5eUQfNVhPL101Dg_rezEzra4GFY5Dva2Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 2:03 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
>>
>> Add the binding definitions for the "qcom,ipa" device tree node.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  .../devicetree/bindings/net/qcom,ipa.txt      | 164 ++++++++++++++++++
>>  1 file changed, 164 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.txt b/Documentation/devicetree/bindings/net/qcom,ipa.txt
>> new file mode 100644
>> index 000000000000..2705e198f12e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.txt
> 
> For new bindings, we should use the yaml format so we can verify the
> device tree files against the binding.

OK.  I didn't realize that was upstream yet.  I will convert.

>> +
>> +- reg:
>> +       Resources specifying the physical address spaces of the IPA and GSI.
>> +
>> +- reg-names:
>> +       The names of the two address space ranges defined by the "reg"
>> +       property.  Must be:
>> +               "ipa-reg"
>> +               "ipa-shared"
>> +               "gsi"
> 
> Those are three, not two ;-)

Oops!  I added one recently and I guess I missed that.  Thanks
for catching it.

					-Alex

> 
>         Arnd
> 

