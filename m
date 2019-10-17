Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA30FECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3D02089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnGzyi7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438863AbfJQSfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:35:44 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34151 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:35:43 -0400
Received: by mail-yb1-f193.google.com with SMTP id m1so1025857ybm.1;
        Thu, 17 Oct 2019 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e0Fv/9q1RP7k5MMlTnFQ+NkUCo2Z4WjoAL5z869bMFg=;
        b=KnGzyi7lgBbkt+FTXOcx6dPG+6CX/Of9IIuIBRATesx6l61nclhOCeG7fkafpro1uH
         VUZFjLjqwLYrjMjyi2WADJo20nDFeVcQ352IcYy6R8SYfL6kGoUYB603OspEFVIrn/9U
         zXy9MLgsti8FCqCnB5VdqFdSlBeNnn7fpOGnKZ+CUVuQ2zFcCOnBiQCynrsqH98zlrIl
         HzNLP+v5RbGpCN9EY7TobAiViDL1jkI4nMpVnB1S/Ka/+IXCd6xmLtjiLFXbfnjR/Nj/
         uVJCl6j6L3j2fxRFstsaG20jftmhaxLGbifgtWxNrP9XTnmZfU/9llOo30LTtO7GUbjn
         30nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0Fv/9q1RP7k5MMlTnFQ+NkUCo2Z4WjoAL5z869bMFg=;
        b=EnOZTs1XaAhMydx918NK/Xbn+Xyxf3BkA60NkubVn/NLoG9gFPYhxogaeBNp+lAirs
         vT/N64YCXpYhfaIi3pmwADu/j9eoCinNnm6kMepqW1o16sSkgdL87v2IiYDigQ2T7DL1
         JjH64w1xS1/xGzYh7LblSgCYTLArwB4AwfHVD2u+8DTlUiKqsnl0On3ZF5xmkdJumbh3
         LXHAYjAmuJE58Ou7Hc5diaYTSFYQyqiAVZ4gzLNQnihWnKzCGJA/uGHHrHWOcmmFX5/s
         U88Exd7xqMduax6HAFJQsTEW7ilCNYta8lASe9YKjevCJt8j9cmV/0lk5GissUz7fsXZ
         dhgA==
X-Gm-Message-State: APjAAAUmiCBIm8x9jinm9mSIuk8mU4ZPZjsivXPw1OtkcgAilSbKxho6
        iVHzelBfqLZUIMKbq4SFb84=
X-Google-Smtp-Source: APXvYqxM3RZNbgPFNEfprJ7YdpnEpJ2Yr3LvFiSSdG+RW6uQOcwafO2tCWC3w5nwJ7Cctz2crni6Zw==
X-Received: by 2002:a25:2189:: with SMTP id h131mr3041545ybh.231.1571337342928;
        Thu, 17 Oct 2019 11:35:42 -0700 (PDT)
Received: from [192.168.1.62] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z66sm75337ywz.78.2019.10.17.11.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:35:42 -0700 (PDT)
Subject: Re: [PATCH] of: Add of_get_memory_prop()
To:     Rob Herring <robh@kernel.org>, rananta@codeaurora.org
Cc:     Trilok Soni <tsoni@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190918184656.7633-1-rananta@codeaurora.org>
 <CAL_JsqJ2WeW0JHSHZuvo9bbc7JSFBr_qCuOp97i=b6Q+OPY7Cg@mail.gmail.com>
 <19d727bbfce08e59294920ba8097be7a@codeaurora.org>
 <5d93ce80.1c69fb81.4acf3.4716@mx.google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6a5a6cdc-e5e0-0f94-4eba-cfaaf0a16b19@gmail.com>
Date:   Thu, 17 Oct 2019 13:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5d93ce80.1c69fb81.4acf3.4716@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghavendra,

I have not received your emails in this conversation, and I do not see
them in my spam folder.  I see some replies from Rob, so I am guessing
he added me to the CC: list.

Please add me to future Devicetree emails.

Digging a little deeper, in the devicetree mail list archive, I see
myself on the CC: list of your "Date: Wed, 18 Sep 2019 15:32:14 -0700"
reply to Rob.  I'm not sure why that email did not get through to me.

So just a heads up that something may be interfering with delivery of email
from you to me.  I've seen disappearing email problem from other senders,
even when most of their emails get through.

Thanks,

Frank


On 10/01/2019 17:09, Rob Herring wrote:
> On Wed, Sep 18, 2019 at 03:32:14PM -0700, rananta@codeaurora.org wrote:
>> On 2019-09-18 13:13, Rob Herring wrote:
>>> On Wed, Sep 18, 2019 at 1:47 PM Raghavendra Rao Ananta
>>> <rananta@codeaurora.org> wrote:
>>>>
>>>> On some embedded systems, the '/memory' dt-property gets updated
>>>> by the bootloader (for example, the DDR configuration) and then
>>>> gets passed onto the kernel. The device drivers may have to read
>>>> the properties at runtime to make decisions. Hence, add
>>>> of_get_memory_prop() for the device drivers to query the requested
>>>
>>> Function name doesn't match. Device drivers don't need to access the
>>> FDT.
>>>
>>>> properties.
>>>>
>>>> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
>>>> ---
>>>>  drivers/of/fdt.c       | 27 +++++++++++++++++++++++++++
>>>>  include/linux/of_fdt.h |  1 +
>>>>  2 files changed, 28 insertions(+)
>>>
>>> We don't add kernel api's without users.
>>>
>>>>
>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>> index 223d617ecfe1..925cf2852433 100644
>>>> --- a/drivers/of/fdt.c
>>>> +++ b/drivers/of/fdt.c
>>>> @@ -79,6 +79,33 @@ void __init of_fdt_limit_memory(int limit)
>>>>         }
>>>>  }
>>>>
>>>> +/**
>>>> + * of_fdt_get_memory_prop - Return the requested property from the
>>>> /memory node
>>>> + *
>>>> + * On match, returns a non-zero positive value which represents the
>>>> property
>>>> + * value. Otherwise returns -ENOENT.
>>>> + */
>>>> +int of_fdt_get_memory_prop(const char *pname)
>>>> +{
>>>> +       int memory;
>>>> +       int len;
>>>> +       fdt32_t *prop = NULL;
>>>> +
>>>> +       if (!pname)
>>>> +               return -EINVAL;
>>>> +
>>>> +       memory = fdt_path_offset(initial_boot_params, "/memory");
>>>
>>> Memory nodes should have a unit-address, so this won't work frequently.
>> Sorry, can you please elaborate more on this? What do you mean by
>> unit-address and working frequently?
> 
> A memory node is typically going to be something like: /memory@80000000. 
> So your function will not work for any of those cases. And just 
> '/memory' generates a dtc warning.
> 
> Rob
> 
> 

