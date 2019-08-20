Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E6C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7796622DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ba7uMiXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfHTMi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:38:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38599 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:38:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id o70so3323812pfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0sWRJA7h/2wvrxj+XqUA03JtH59l+JlTt/N+VmW30I0=;
        b=ba7uMiXKvLyrDvP5gZiTLElxzfuOOwtCwOc0K/kjEXcSNniq9kgrFeMrXJYN399WnZ
         pnc3dSZcqFLANSFrStaUj2q5CZ6Na04QZlqXUF342Tt2legAfe51dJXfHHqnuOSCdPAb
         57xHYiQ/dC/sOYsHZpBVZ43PGdt4xAqHOMSU2VaOdVMfhOWC+p7Cdc8+BIvmzQxGfSGD
         TpeKcP75NCRwXuDL6SNGbIsVDR1ArNvkTH5EQTF2au7HMYZX4g+gXzsYv4yem1b8mTMs
         Bch6PMuBWNOb6MtWs8aQnEiQlR1kDS4n9c3Khq8ludB+U7tyE8w22xUIlgiXa1jzg0as
         dUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0sWRJA7h/2wvrxj+XqUA03JtH59l+JlTt/N+VmW30I0=;
        b=AK69nT91SCuDTkzhGWgIO7AmkRUmRLAXGFe44qnrRYz2AiXj1r4ET93Yzi1KEHX+2d
         yRZIEv7Uobp6REEPafKgYv9GItu4viVVE7B/nm+DX53OleFpXItl/UJiAgjf6N7g2Uwe
         YrF3POCOVnEoCB6J2aEKc18OaCvQfy9n4E8Vzxg+kBumWqdLBdXCqKIW5V5s+kJ5Asfy
         CeJd4vWbog3Jlcvf3MpO2DTRmjZcupmkpN/Tog7X8A8tLe3BsNkLs5YOTitakIkavOcw
         NJqcfFF5GRYaRnzSOihUdXO7C4aF7TM3QxefrQFwMGVkCAYQwrvatuVpRHfWN/yxYPQT
         Vy6Q==
X-Gm-Message-State: APjAAAUUeTH95ULmpZxQhmeeLBoXbgZZSRH7RLNYSTaOpcY5M+2+A5GH
        +J1nOHoUIXrwBY6n/XRPb+OyqQ==
X-Google-Smtp-Source: APXvYqxOOzhOX8GyoVGFVm71p/3OV4YApHVsr+O832TKFGdLRYB1AHM3ZAz8bAWpUqDsFBcrCIkk9A==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr24696359pgt.337.1566304737262;
        Tue, 20 Aug 2019 05:38:57 -0700 (PDT)
Received: from ?IPv6:240e:362:43e:2200:6d55:ae74:3a5b:9669? ([240e:362:43e:2200:6d55:ae74:3a5b:9669])
        by smtp.gmail.com with ESMTPSA id a6sm22033421pjv.30.2019.08.20.05.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 05:38:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] uacce: add uacce module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141225.GC23267@kroah.com>
 <5d5a6757.1c69fb81.e0678.2ab2SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190819102250.GA2030@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <350c937f-faee-f74a-ad76-03532c8648bd@linaro.org>
Date:   Tue, 20 Aug 2019 20:38:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819102250.GA2030@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/19 下午6:22, Greg Kroah-Hartman wrote:
> On Mon, Aug 19, 2019 at 05:09:23PM +0800, zhangfei.gao@foxmail.com wrote:
>> Hi, Greg
>>
>> Thanks for your kind suggestion.
>>
>> On 2019/8/15 下午10:12, Greg Kroah-Hartman wrote:
>>> On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
>>>> diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
>>>> new file mode 100644
>>>> index 0000000..44a0a5d
>>>> --- /dev/null
>>>> +++ b/include/uapi/misc/uacce.h
>>>> @@ -0,0 +1,44 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +#ifndef _UAPIUUACCE_H
>>>> +#define _UAPIUUACCE_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +#include <linux/ioctl.h>
>>>> +
>>>> +#define UACCE_CLASS_NAME	"uacce"
>>> Why is this in a uapi file?
>> User app need get attribute from /sys/class,
>> For example: /sys/class/uacce/hisi_zip-0/xxx
>> UACCE_CLASS_NAME here tells app which subsystem to open,
>> /sys/class/subsystem/
> But that never comes from a uapi file.  No other subsystem does this.
OK, got it
Maybe the entry info can come from Documentation/ABI/entries

Thanks
