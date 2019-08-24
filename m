Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A81C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2249A2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvW6JYBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfHXMxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:53:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43706 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfHXMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:53:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so7292939pld.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 05:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=F/nPYFepDy0cUjW6EXTQwdfVi+FEnIDznVuIrRm/76A=;
        b=GvW6JYBUVbXc2ui2gYORsIjOTFeKIL7aFET4Fh6Q1fjGX5ma243XPCtctwoAIBRx+B
         HRSTGuKLsYHrtx/TJXzo+hq3zSdDEUOnHwWWzlS2hi96JavVbw5KHLfQJaY/1wDD2sfj
         PEf3L1nhNeLzJGbFlSCAe/dfJ3AjaU8M5vFIvWg622vjgrORIZmamtKY+rpUbhxTLeb3
         X3ZxxTGW/FxrA/P+w61QkVQGFd0EZdXY9mhBzLGB4XLehU3fSTu4hB7WK+oFTD0Kv5Yk
         VxmuIFrkV70XEBs1VFFt69Runp3vapWFHskYnevB4alDXlmiWTkES0DGtIDn4o8yn0GE
         +EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F/nPYFepDy0cUjW6EXTQwdfVi+FEnIDznVuIrRm/76A=;
        b=cjQz+CVBRU1KHEKgRkYhs+iGHbRJ5hhCxO5GcFFf6dc528im3F4/zG06FrHFD70TBC
         dzoqOG+loeRKs5mOm5huqH7IMLFfW17jAod4Mgukkq2OkZeu7RImyIRFiuZ6hXTFm7eh
         jn+mpbG3y4KS3DkZujbu0l3CWko5s2l6BXQa0UawSLBAulH5SkqkjVE7AaZHHHtcoAyu
         kTbYzPIVDMY1Z/EF6zkEMDsdYN2uFziaTea6lSzVCn+1whKG6BMWnghmSlqUmCuF9kCm
         W7TSffUvhayg0tt99AFhZIsM0eReO6YMWMTYWKykee0h4nzBVNcRpPm61I8yQrlf/EFx
         ne6A==
X-Gm-Message-State: APjAAAXoaWM6mnWG4qYDPqNWKCvKp4H5MWsv+Zz46QrlJv615dZ+G6wt
        PiU08LhL7dayllDhyVepVWdyWA==
X-Google-Smtp-Source: APXvYqx+IURKcWdwfiEX/7uNVRhZ17G7ahM9Vc5+Ev5lEshJUeeeQA2/NEVdPLW7JlCdXRlh3EmkdA==
X-Received: by 2002:a17:902:860b:: with SMTP id f11mr9745085plo.48.1566651194290;
        Sat, 24 Aug 2019 05:53:14 -0700 (PDT)
Received: from [192.168.11.133] (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id x9sm4493152pgp.75.2019.08.24.05.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 05:53:13 -0700 (PDT)
From:   zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/2] uacce: add uacce module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815142021.GE23267@kroah.com>
 <5d5a6f5b.1c69fb81.9d35e.5303SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190819102413.GB2030@kroah.com>
 <0f7c6241-2028-76e7-0314-8b99cd353bd6@linaro.org>
 <20190820143341.GB1536@kroah.com>
Message-ID: <3e237a99-8832-30d5-11de-f65325195478@linaro.org>
Date:   Sat, 24 Aug 2019 20:53:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820143341.GB1536@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/20 下午10:33, Greg Kroah-Hartman wrote:
> On Tue, Aug 20, 2019 at 08:36:50PM +0800, zhangfei wrote:
>> Hi, Greg
>>
>> On 2019/8/19 下午6:24, Greg Kroah-Hartman wrote:
>>>>>> +static int uacce_create_chrdev(struct uacce *uacce)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
>>>>>> +	if (ret < 0)
>>>>>> +		return ret;
>>>>>> +
>>>>> Shouldn't this function create the memory needed for this structure?
>>>>> You are relying ont he caller to do it for you, why?
>>>> I think you mean uacce structure here.
>>>> Yes, currently we count on caller to prepare uacce structure and call
>>>> uacce_register(uacce).
>>>> We still think this method is simpler, prepare uacce, register uacce.
>>>> And there are other system using the same method, like crypto
>>>> (crypto_register_acomp), nand, etc.
>>> crypto is not a subsystem to ever try to emulate :)
>>>
>>> You are creating a structure with a lifetime that you control, don't
>>> have someone else create your memory, that's almost never what you want
>>> to do.  Most all driver subsystems create their own memory chunks for
>>> what they need to do, it's a much better pattern.
>>>
>>> Especially when you get into pointer lifetime issues...
>> OK, understand now, thanks for your patience.
>> will use this instead.
>> struct uacce_interface {
>>          char name[32];
>>          unsigned int flags;
>>          struct uacce_ops *ops;
>> };
>> struct uacce *uacce_register(struct device *dev, struct uacce_interface
>> *interface);
> What?  Why do you need a structure?  A pointer to the name and the ops
> should be all that is needed, right?
We are thinking transfer structure will be more flexible.
And modify api later would be difficult, requiring many drivers modify 
together.
Currently parameters need a flag, a pointer to the name, and ops, but in 
case more requirement from future drivers usage.
Also refer usb_register_dev, sdhci_pltfm_init etc, and the structure 
para can be set as static.
> And 'dev' here is a pointer to the parent, right?  Might want to make
> that explicit in the name of the variable :)
Yes, 'dev' is parent, will change to 'pdev', thanks.
>>>>>> +
>>>>>> +static int uacce_dev_match(struct device *dev, void *data)
>>>>>> +{
>>>>>> +	if (dev->parent == data)
>>>>>> +		return -EBUSY;
>>>>> There should be in-kernel functions for this now, no need for you to
>>>>> roll your own.
>>>> Sorry, do not find this function.
>>>> Only find class_find_device, which still require match.
>>> It is in linux-next, look there...
>>>
>> Suppose you mean the funcs: device_match_name,
>> device_match_of_node,device_match_devt etc.
>> Here we need dev->parent, there still no such func.
> You should NEVER be matching on a parent.  If so, your use of the driver
> model is wrong :)
>
> Remind me to really review the use of the driver core code in your next
> submission of this series please, I think it needs it.
>
>

OK, thanks Greg.

