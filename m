Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA0C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0BC21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qScjuueY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfFLS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:29:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35999 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFLS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:29:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so4281019pfl.3;
        Wed, 12 Jun 2019 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xh+lRCoBNSUNCnjzBT3gFLnOefy9JtUPnH1Sk9zgEY=;
        b=qScjuueY/Y7fAPJLdBsYS3qqBDIRMMmGLaeatFVjunpMbFOrhCu9BNyFsprRA/pMIH
         M3k+wlQU5Rv+FewVRd5PnagyahVuj+rN7qLWNw3BUkeHMyeY9GFAC2sch2WHjW8O85AP
         o8iMswHm/gzoWO9p1HakHSni5AdvjWGoU/eTj+UAxRThi0dr7knaSTKgh7gTSLmU7rbj
         XgP/iSIWpFd6Nzty3ea9R1EawtTpsU83a5AZhUI//q+TrQ3f26dX5a3iAqcFYj1qo7Uy
         tn/cLFwSG9JBXuNzQXmd0j4/Zmq3+SHhbMfj1hMT2izwsplM7lHOT9RJToTO5clbE523
         ZrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xh+lRCoBNSUNCnjzBT3gFLnOefy9JtUPnH1Sk9zgEY=;
        b=swYnUGK+qhWbBtjwQHDj339xyA6jzPr83QPDkXXsPzz7RjepR7JQ/FCbeSujPQMIDA
         HZp/ON6ECS0N4iC0uU8l8K+oBvqK4Wv4WtW3Lz2nPwrABTQvn+/OTMtPR4EIYyOJiQai
         Xs8vdNmhq/tbO2+fV6sSPLHRkkZUZRg2r0mN3HryM3xboMN0m/DPQ+Pnv/A6BGsA69nM
         8H1Z70SKY+ovETL1kZrlE5zPPjEL9FdruEH1xN/I5DhDYvFTbh/tKllXLpT8ExLnyEkY
         AhJ+9N4stj7VuNMESBbmxiR8/8fpy/KhyFin7R6DCzQ3WZcS4YG4+XXSyrBykQ1Gbe1O
         t3WA==
X-Gm-Message-State: APjAAAUxaFLZyt9Yf9P+SD4r0LyHYAi660J9x4vHg5cTH/s3+HYNh2e8
        VQrkXFS1CE0f2R23dY8ATik=
X-Google-Smtp-Source: APXvYqyLpbwJSDc+RSef01G3HjJdQwBC/92V2uPNbaJsEfe2NE8MKuthAMZ2Nf/v4mQKrLERiBsUkw==
X-Received: by 2002:a63:7ca:: with SMTP id 193mr26036392pgh.240.1560364149360;
        Wed, 12 Jun 2019 11:29:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z14sm174571pgs.79.2019.06.12.11.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:29:08 -0700 (PDT)
Subject: Re: [PATCH next] of/fdt: Fix defined but not used compiler warning
To:     Rob Herring <robh@kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
 <0702fa2d-1952-e9fc-8e17-a93f3b90a958@gmail.com>
 <CAL_JsqKsjK237W+-Yz4McxSZG=Gd3Pfp2JtgMnfAqiNRUcCg1g@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <41acc800-1ab8-c715-2674-c1204d546b4f@gmail.com>
Date:   Wed, 12 Jun 2019 11:29:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKsjK237W+-Yz4McxSZG=Gd3Pfp2JtgMnfAqiNRUcCg1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 10:00 AM, Rob Herring wrote:
> On Wed, Jun 12, 2019 at 10:45 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> Hi Kefeng,
>>
>> If Rob agrees, I'd like to see one more change in this patch.
>>
>> Since the only caller of of_fdt_match() is of_flat_dt_match(),
>> can you move the body of of_fdt_match() into  of_flat_dt_match()
>> and eliminate of_fdt_match()?
> 
> That's fine as long as we think there's never any use for of_fdt_match
> after init? Fixup of nodes in an overlay for example.

We can always re-expose the functionality as of_fdt_match() in the future
if the need arises.  But Stephen's recent patch was moving in the opposite
direction, removing of_fdt_match() from the header file and making it
static.

-Frank

> 
> Rob
> 
>>
>> (Noting that of_flat_dt_match() consists only of the call to
>> of_fdt_match().)
>>
>> -Frank
>>
>>
>> On 6/11/19 6:00 PM, Kefeng Wang wrote:
>>> When CONFIG_OF_EARLY_FLATTREE is disabled, there is a compiler warning,
>>>
>>> drivers/of/fdt.c:129:19: warning: ‘of_fdt_match’ defined but not used [-Wunused-function]
>>>  static int __init of_fdt_match(const void *blob, unsigned long node,
>>>
>>> Move of_fdt_match() and of_fdt_is_compatible() under CONFIG_OF_EARLY_FLATTREE
>>> to fix it.
>>>
>>> Cc: Stephen Boyd <swboyd@chromium.org>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  drivers/of/fdt.c | 106 +++++++++++++++++++++++------------------------
>>>  1 file changed, 53 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>> index 3d36b5afd9bd..d6afd5b22940 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -78,38 +78,6 @@ void __init of_fdt_limit_memory(int limit)
>>>       }
>>>  }
>>>
>>> -/**
>>> - * of_fdt_is_compatible - Return true if given node from the given blob has
>>> - * compat in its compatible list
>>> - * @blob: A device tree blob
>>> - * @node: node to test
>>> - * @compat: compatible string to compare with compatible list.
>>> - *
>>> - * On match, returns a non-zero value with smaller values returned for more
>>> - * specific compatible values.
>>> - */
>>> -static int of_fdt_is_compatible(const void *blob,
>>> -                   unsigned long node, const char *compat)
>>> -{
>>> -     const char *cp;
>>> -     int cplen;
>>> -     unsigned long l, score = 0;
>>> -
>>> -     cp = fdt_getprop(blob, node, "compatible", &cplen);
>>> -     if (cp == NULL)
>>> -             return 0;
>>> -     while (cplen > 0) {
>>> -             score++;
>>> -             if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
>>> -                     return score;
>>> -             l = strlen(cp) + 1;
>>> -             cp += l;
>>> -             cplen -= l;
>>> -     }
>>> -
>>> -     return 0;
>>> -}
>>> -
>>>  static bool of_fdt_device_is_available(const void *blob, unsigned long node)
>>>  {
>>>       const char *status = fdt_getprop(blob, node, "status", NULL);
>>> @@ -123,27 +91,6 @@ static bool of_fdt_device_is_available(const void *blob, unsigned long node)
>>>       return false;
>>>  }
>>>
>>> -/**
>>> - * of_fdt_match - Return true if node matches a list of compatible values
>>> - */
>>> -static int __init of_fdt_match(const void *blob, unsigned long node,> -                             const char *const *compat)
>>> -{
>>> -     unsigned int tmp, score = 0;
>>> -
>>> -     if (!compat)
>>> -             return 0;
>>> -
>>> -     while (*compat) {
>>> -             tmp = of_fdt_is_compatible(blob, node, *compat);
>>> -             if (tmp && (score == 0 || (tmp < score)))
>>> -                     score = tmp;
>>> -             compat++;
>>> -     }
>>> -
>>> -     return score;
>>> -}
>>> -
>>>  static void *unflatten_dt_alloc(void **mem, unsigned long size,
>>>                                      unsigned long align)
>>>  {
>>> @@ -764,6 +711,59 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
>>>       return fdt_getprop(initial_boot_params, node, name, size);
>>>  }
>>>
>>> +/**
>>> + * of_fdt_is_compatible - Return true if given node from the given blob has
>>> + * compat in its compatible list
>>> + * @blob: A device tree blob
>>> + * @node: node to test
>>> + * @compat: compatible string to compare with compatible list.
>>> + *
>>> + * On match, returns a non-zero value with smaller values returned for more
>>> + * specific compatible values.
>>> + */
>>> +static int of_fdt_is_compatible(const void *blob,
>>> +                   unsigned long node, const char *compat)
>>> +{
>>> +     const char *cp;
>>> +     int cplen;
>>> +     unsigned long l, score = 0;
>>> +
>>> +     cp = fdt_getprop(blob, node, "compatible", &cplen);
>>> +     if (cp == NULL)
>>> +             return 0;
>>> +     while (cplen > 0) {
>>> +             score++;
>>> +             if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
>>> +                     return score;
>>> +             l = strlen(cp) + 1;
>>> +             cp += l;
>>> +             cplen -= l;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * of_fdt_match - Return true if node matches a list of compatible values
>>> + */
>>> +static int __init of_fdt_match(const void *blob, unsigned long node,
>>> +                            const char *const *compat)
>>> +{
>>> +     unsigned int tmp, score = 0;
>>> +
>>> +     if (!compat)
>>> +             return 0;
>>> +
>>> +     while (*compat) {
>>> +             tmp = of_fdt_is_compatible(blob, node, *compat);
>>> +             if (tmp && (score == 0 || (tmp < score)))
>>> +                     score = tmp;
>>> +             compat++;
>>> +     }
>>> +
>>> +     return score;
>>> +}
>>> +
>>>  /**
>>>   * of_flat_dt_is_compatible - Return true if given node has compat in compatible list
>>>   * @node: node to test
>>>
>>
> 

