Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A63C2D0D3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683FB206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 00:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrONicy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfLaAVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:21:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37214 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfLaAVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:21:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so34159908edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nq2qLM+ldDGbo3KqEbg/2SHDvGelrcv8ab8F/WIjQTk=;
        b=OrONicy6E3ewJpZEj0f2BfXQ0AGl/3JidHk5elKMBSSKDW937hs+WBQjj9q8LYohkA
         Zmira+Jncb7oQgSVxBg9efsUhdrlL6E7REPxbuszwg968Iqx6cTt/K0P/EzijizUIq0J
         WCfyk/ImlXF5RRYvzkuXSrbmxvUbX2wZz1MrliJxdkObh7diHH9w2hM8Dr3cEovR9ot/
         4uaOwsX4R8r0mEqlZKVQXSaeZyEIwE0709jTQO6jBKhHzhWmSiirH9k/2x+eldtQFrUl
         OCYwegJ/jz2WyAAG9oV+JCqx4+C6uDwrGvVRMbzpvMUB9Y4xW4bSauwXyDucKR8XweYd
         fdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nq2qLM+ldDGbo3KqEbg/2SHDvGelrcv8ab8F/WIjQTk=;
        b=JEIV2x5QKhT/iMHoya4PagoqDybNtfoCIzk2k94c+EFUyHhwivDW0z+5CZApO+Chgp
         wFIqi3mHIAzo4aPDvGAXctMMaaVX1QUokAcKry7Q4HYXrcpMEBsuR82rY4LbV1Qess6N
         /g2s1RtmNBz8O3+KymkFffLt9SNlXO1iChnubMzSmgUeTSfE86lrigm7XVLO9QRv0jJa
         73SD6w5EwfkGI5oAwPNRXY09n0ZFeDifE5GX1IO9lLl7wCD2rZz4P8EShsCFyg4WwbQn
         U92AruuNsICPu+LfcCCZ5U3H4La0RJ03/a+DpwiffYhb2wuaKgUankqBKV1Fr6fcxF8K
         s4xw==
X-Gm-Message-State: APjAAAV2jw11BJbUno6hExcUV1YnkPKtvip+GP8ObTdO/hORlfj4J1mO
        csB09ozaN4ADkPVzJJCqBzG0xAoEBuc=
X-Google-Smtp-Source: APXvYqzNBRSrfS5KQ3SgkmJWdOik57w3b6mvgOpqJAAlYh2kpNHKBwTcXq0jog+Nt701sUg8oHewyw==
X-Received: by 2002:aa7:da42:: with SMTP id w2mr73419856eds.3.1577751665723;
        Mon, 30 Dec 2019 16:21:05 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id y5sm5221392ejm.57.2019.12.30.16.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 16:21:05 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: gadget: Fix failure to detect end of transfer
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191230161321.2738541-1-bryan.odonoghue@linaro.org>
 <20191230185703.GA1763367@kroah.com>
 <e772c382-b820-355d-f2b9-8690a5f85885@linaro.org>
Message-ID: <0c183570-38cc-c27e-f5ab-606387a88dff@linaro.org>
Date:   Tue, 31 Dec 2019 00:21:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e772c382-b820-355d-f2b9-8690a5f85885@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2019 00:05, Bryan O'Donoghue wrote:
> On 30/12/2019 18:57, Greg KH wrote:
>> On Mon, Dec 30, 2019 at 04:13:21PM +0000, Bryan O'Donoghue wrote:
>>> A recent bugfix 8c7d4b7b3d43 ("usb: dwc3: gadget: Fix logical 
>>> condition")
>>> correctly fixes a logical error in the gadget driver but, exposes a 
>>> further
>>> bug in determining when a transfer has completed.
>>>
>>> Prior to 8c7d4b7b3d43 we were calling dwc3_gadget_giveback() when we
>>> shouldn't have been. Afer this change the below test fails to 
>>> complete on
>>> my hardware.
>>>
>>> Host:
>>> echo "host" > /dev/ttyACM0
>>>
>>> Device:
>>> cat < /dev/ttyGS0
>>>
>>> This is caused by the driver incorrectly detecting end of transfer, a
>>> problem that had previous been masked by the continuous calling of
>>> dwc3_gadget_giveback() prior to 8c7d4b7b3d43.
>>>
>>> Remediate by making the test <= instead of ==
>>>
>>> Fixes: e0c42ce590fe ("usb: dwc3: gadget: simplify IOC handling")
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   drivers/usb/dwc3/gadget.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> I think this patch:
>>     https://lore.kernel.org/linux-usb/ac5a3593a94fdaa3d92e6352356b5f7a01ccdc7c.1576291140.git.thinhn@synopsys.com/ 
>>
>>
>> should fix this issue instead, right?
>>
>> If not, do I need to include both of these?
> 
> Yep, works fine in isolation.
> 

I don't have that in my inbox anywhere - not sure why, would have saved 
me 1/2 a day of work.

Anyway, please feel free to add my

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> to Thinh's patch

---
bod
