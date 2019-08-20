Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D4FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950B922DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBjaFwfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfHTMhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:37:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37867 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfHTMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:37:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so3315602pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jGa90KjCZLs3XQF8pYGAfTFC9htf4pf+TqK+4kgZQIM=;
        b=kBjaFwfoUoCB5Mgv3/qjghfztD3vuU7t5h3A5nPvIRx8xJeTQu8x+6uEeB7foPImSj
         qB1KhbPIqKCz0YtDFfJzEJ58IyRwVom4nC2bFO07DEiIs4zp3+v42TkEHyTez4mYQzeo
         bUkTfnKhXPPXx2MJs2F3Rwl0alO48up7wHAia478XdcbRDFGbB91rHxrRfI5OI6M62MV
         iyt284s+mo2k4nmYrUnCWGRKfQytVHYMf6OiE4WhzOFyyxuemVNowJ5K4FzhtbfrlwGP
         U2b0+VVyqqE9CTCQt7V1bpYSlsAWuONWvJesNhfszFNs7qiyb93pnkdeuJnLpc62xYiy
         YPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jGa90KjCZLs3XQF8pYGAfTFC9htf4pf+TqK+4kgZQIM=;
        b=CEaZbs1GzfFyFlucO9fcT6iyIw+nzLnnuMN2ACaGG3eNIlL2llXzkc37Kb1xzqToaD
         JqthW5Bne1gGxEFWz0mg8tUiPg50lE3FL0Rk36LYh5c8k6eYfkXxC7vwA/PHsZHYFXA2
         GNC/8R7+zSSGUUGbARALViz0ws9tG8EVwQy7SKY3lXEnZlmFy+yl+bKPUVbd1Kt8VQLJ
         voQHg4KzA3uRKJUbVerWy2ES8DkAT4kpKltl3RuIVdca+8yL2uAAnVDGmt+k9Zj+30ji
         GEZnhFtAW07VUXHS7Idrs6JK1SSU3vT1DHK1NjvK/H79NVZl0uFL3OavmByjk9pq3tYY
         uRxw==
X-Gm-Message-State: APjAAAVxV8ZBz4abMH0l5PzCWfaFQOzctPg7OOYQds193IiEpEYPf2ah
        VITotY00oQmQD9te2kyBlFGVpg==
X-Google-Smtp-Source: APXvYqyliPX6/Lu+qHN+gc8VFBswmjP0GCsqg4InvNqBQ2jmCFNKc3NVnFxjCnND0TUP4kDaPpIc2A==
X-Received: by 2002:a17:90a:b014:: with SMTP id x20mr6833014pjq.60.1566304623451;
        Tue, 20 Aug 2019 05:37:03 -0700 (PDT)
Received: from ?IPv6:240e:362:43e:2200:6d55:ae74:3a5b:9669? ([240e:362:43e:2200:6d55:ae74:3a5b:9669])
        by smtp.gmail.com with ESMTPSA id a142sm23797497pfd.147.2019.08.20.05.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 05:37:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] uacce: add uacce module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815142021.GE23267@kroah.com>
 <5d5a6f5b.1c69fb81.9d35e.5303SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190819102413.GB2030@kroah.com>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <0f7c6241-2028-76e7-0314-8b99cd353bd6@linaro.org>
Date:   Tue, 20 Aug 2019 20:36:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819102413.GB2030@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

On 2019/8/19 下午6:24, Greg Kroah-Hartman wrote:
>>>> +static int uacce_create_chrdev(struct uacce *uacce)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = idr_alloc(&uacce_idr, uacce, 0, 0, GFP_KERNEL);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>> Shouldn't this function create the memory needed for this structure?
>>> You are relying ont he caller to do it for you, why?
>> I think you mean uacce structure here.
>> Yes, currently we count on caller to prepare uacce structure and call
>> uacce_register(uacce).
>> We still think this method is simpler, prepare uacce, register uacce.
>> And there are other system using the same method, like crypto
>> (crypto_register_acomp), nand, etc.
> crypto is not a subsystem to ever try to emulate :)
>
> You are creating a structure with a lifetime that you control, don't
> have someone else create your memory, that's almost never what you want
> to do.  Most all driver subsystems create their own memory chunks for
> what they need to do, it's a much better pattern.
>
> Especially when you get into pointer lifetime issues...
OK, understand now, thanks for your patience.
will use this instead.
struct uacce_interface {
         char name[32];
         unsigned int flags;
         struct uacce_ops *ops;
};
struct uacce *uacce_register(struct device *dev, struct uacce_interface 
*interface);
>>>> +}
>>>> +
>>>> +static int uacce_dev_match(struct device *dev, void *data)
>>>> +{
>>>> +	if (dev->parent == data)
>>>> +		return -EBUSY;
>>> There should be in-kernel functions for this now, no need for you to
>>> roll your own.
>> Sorry, do not find this function.
>> Only find class_find_device, which still require match.
> It is in linux-next, look there...
>
Suppose you mean the funcs: device_match_name, 
device_match_of_node,device_match_devt etc.
Here we need dev->parent, there still no such func.

Thanks

