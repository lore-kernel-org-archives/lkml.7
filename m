Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1896C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0EB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqGU1/Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfCYK6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:58:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfCYK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:58:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so8535634wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eILKmzMrpMZFo3dDcsQ+WEokZNTW7WudiyklPBTgKgg=;
        b=oqGU1/Jf2LZN7TUMx9O6j7/WzFDIexPS79zAzMueXSbMCwHpqvBtETSitsbCp7uqEv
         fCVHHnQEBbX0ph1x1N9mJ2BpAkaH4aZ+6N1b086iRDYr+xzoICzb2UF8bH2O5gXrZi9w
         WA3uDj02C+CuiAsKEHth4VwoPzVsKUj7jbwlwc2AMP3EtpDQmVnyEFUh4OAZ8OHH3sDp
         yUolUyo3GQY4a1m6FPJF09qdD2f2il8tUMPaHq4tYPf8C008Ijn9LBoxO6ByXtJq9Vuo
         l/iqnSR9eaLe1oitGE+gB5XSKU2P87J2yD1lcif8Hb4mlSA7IU73vYIcL18VfCpEzazU
         Sttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eILKmzMrpMZFo3dDcsQ+WEokZNTW7WudiyklPBTgKgg=;
        b=KxmaqFB4XMPYV9+1Finfk1zkRjvw595AYdPpL61rRk+w2VEss7LQcaNPZfgk9ykYeB
         DRRwiWaDt+2Ix2sUNoeP6Yny0uvjaJQI+Kel7OtTSh4bpd793RqQ9kS85LWzWri7aZgu
         3sUkiQZo1ggfOkJ8qhpAmnCI6wcYAYgDa4n5wJ2ZY81US4P8SYu/T7pl3qT9GSGIy4LV
         7hvW1kViEmNmCqzodta3G6JG8goLpklgkDLEfqHckew8ikQ4mr3yWcUyqHvu0RNSFyyv
         gtXaLA2W/N4OIZ9/bR1WSd+zV3+msxGYrXbXDCB1/5XkfQEwCQ38I+2sPEFGL4lRPMzr
         z3/A==
X-Gm-Message-State: APjAAAX+ZNpcoZ0Kn9pB+FL/rf84VXK+OJn/potHDO53v7I0nDVRypdX
        LdVzTUBOCfFuK4eUZnsDfa2+PA==
X-Google-Smtp-Source: APXvYqyIAHIw++Z9eBCJ6cxuUjuDsmgY0qBQR2OT1wLIO8zKkIu5QoR7vJAhJqrzdOaIuppQwJ43tw==
X-Received: by 2002:a7b:ce1a:: with SMTP id m26mr4792005wmc.131.1553511519125;
        Mon, 25 Mar 2019 03:58:39 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o17sm16815863wrw.73.2019.03.25.03.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:58:38 -0700 (PDT)
Subject: Re: [PATCH v0] nvmem: core: Export nvmem cell info to userspace
To:     Gaurav Kohli <gkohli@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Shiraz Hashim <shashim@codeaurora.org>
References: <1553061201-28894-1-git-send-email-gkohli@codeaurora.org>
 <b356f99c-15ff-06ce-e40b-4bb8b664b6c9@linaro.org>
 <ecd3986a-7846-1f87-4d2e-4c66bd6698c9@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f6a9162f-4d91-1ef4-db9c-deb763cf5778@linaro.org>
Date:   Mon, 25 Mar 2019 10:58:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ecd3986a-7846-1f87-4d2e-4c66bd6698c9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2019 15:25, Gaurav Kohli wrote:
> 
> On 3/22/2019 8:53 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 20/03/2019 05:53, Gaurav Kohli wrote:
>>> From: Shiraz Hashim <shashim@codeaurora.org>
>>>
>>> Existing nvmem framework export full register space
>>> as nvmem binary, but not exporting child node of nvmem
>>> which is nvmem cell. Kernel can read the specific cell
>>> by using nvmem_cell_read but userspace don't have such
>>> provision.
>>>
>>> Add framework to export nvmem cell as well, So
>>> userspace can use it directly.
>>>
>>> Signed-off-by: Shiraz Hashim <shashim@codeaurora.org>
>>> Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>
>>> Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>
>> Thankyou for the patch.
>>
>> Why do you need such provision when the userspace can just get the 
>> cell values using correct offset and size.
>> This will also bring over head of managing entries dynamically + 
>> confusing userspace abi.
>>
>> Unless you have a valid reason or usecase I don't see the need for this.
> 
> 
> Hi Srinivas,
> 
> 
> This is mainly for user space convenience, In existing implementation 
> they have to do manipulation according

> 
> to offset and bit, And with present patch, they just have to do cat for 
> cell name and which can also be easily maintainable
Yes, that is expected I guess!

> 
> for different soc. But with current, it is difficult to maintain users 
> space code as each time we have to change user space code according to bit.

Which user space code/application are you referring to here? Are these 
open source?

> 
> 
> This would also help to expose certain bit only as per the bit parameter 
> mentioned in dt node, which would also help to protect exposing of
> 
NVMEM is not just limited for DT users, non dt users use this f/w too.
So the problem is not as simple as it sounds.

If your issue is just about DT, you could easily parse active device 
tree via  /proc/device-tree and get cell offset, length and names from 
it, use this information to read from nvmem.

There are other concerns about the userspace ABI w.r.t udev events.
udev events would race with the creation on this cell entries resulting 
in a behavior where user-space applications would not see the entries 
after udev events.

In worst case if we decide to go with adding cells to nvmem then we 
should do it before the device is even probed using group attributes.
And this would mean that we can not support cells that are dynamically 
defined. And there might be some memory freeing issues in this method too!

--srini


> other bits to user space.
> 
>>
>> thanks,
>> srini
> 
