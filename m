Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4910C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D992084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjNJtAvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfEOP6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:58:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38086 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:58:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id s19so490449otq.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qHNpaDZ9T9s/rwoEWw89q2mPvkb2at7yYH9yRZc7MGE=;
        b=BjNJtAvVMsBA6RQu7Dzlu9zInVoqfOkwbmLfPlz63CZxfKHJFfDmhIqQW34A/4RZ/C
         AkM254blN5+VAhEoC9E4bLnU6p+cMFUbZJ5TIZnuqBzojN3l0IpC3VDl/KBiam0PRMv3
         d4awiJLew9Kqf/ufetc01p7yZ9qXUwzPL71K1AcTbeiYMzu7bSHoFgzGGIaexsbRQXt0
         Ny8bNFf/F6QZ2aSQK0MyRtiNDR9WgF+U5JqktGdS7pDygkpf3yNH0O1nQsbV5N2TQE6C
         Df79wRweK/EbN3TACdyagXhlCHSjXSr0MDNpaB+vdJwgoavz0FF0zJ3qZcL4VyRJlaA2
         AUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qHNpaDZ9T9s/rwoEWw89q2mPvkb2at7yYH9yRZc7MGE=;
        b=WDYQQ6XqJaoFUefpszj6LBa9NBYyEwX8yiPHbDuWejjBqBzhzKYA0kCjQ53wZrGH0q
         vHNU+K2k/Wtyi1Qa776SZJZdSPtbcZbD/onp5BM3cZkKY0RPQhuFJMRHrACJZ+sUe3gG
         IMTHsd3QGCfpSlJWCJrELN/VOcDBixsdK+Lf7avGSt+NG6r18vPCZ+ZCxdyvaODxbFJF
         oQJfpK8kI0UCp2TKM39CQVP1U0kD8PKCpwPdv0EXXRhlRIy9Ei2FOwXowk4zuStD7RFz
         MxybuIGMIVmkyEW1GWE/e/IyWmK2ro4frQ7r5bOwBndI66JBNHZEu97AIuz0s6PLMWd6
         I94A==
X-Gm-Message-State: APjAAAXI4X2QFj80UEIQVWMSC+JszxG3ETR49ETu0IT345idmQPG0XXx
        zaickI8SKPrO1xug3t1L+4xLCKYz
X-Google-Smtp-Source: APXvYqyqFf43xvvae24OrE0kRunWOIwr3I4My90hiPN62HNd2F9EZIMqc5+wSglwEGnPHZ8n5qtdmQ==
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr24947805otp.110.1557935925326;
        Wed, 15 May 2019 08:58:45 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k139sm864974oib.11.2019.05.15.08.58.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 08:58:44 -0700 (PDT)
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
 <20190515114022.GA18824@kroah.com>
 <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
 <20190515123319.GA435@kroah.com>
 <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <05cd96e6-cc60-7feb-7098-a0a902012ef0@lwfinger.net>
Date:   Wed, 15 May 2019 10:58:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 8:06 AM, Kai-Heng Feng wrote:
> at 20:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> On Wed, May 15, 2019 at 07:54:58PM +0800, Kai-Heng Feng wrote:
>>> at 19:40, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>>> On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
>>>>> The rtl8821ce can be found on many HP and Lenovo laptops.
>>>>> Users have been using out-of-tree module for a while,
>>>>>
>>>>> The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
>>>>> later.
>>>>
>>>> Where is that driver, and why is it going to take so long to get merged?
>>>
>>> rtw88 is in 5.2 now, but it doesn’t support 8821ce yet.
>>>
>>> They plan to add the support in 2020.
>>
>> Who is "they" and what is needed to support this device and why wait a
>> full year?
> 
> “They” refers to Realtek.
> It’s their plan so I can’t really answer that on behalf of Realtek.
> 
>>
>>>>> 296 files changed, 206166 insertions(+)
>>>>
>>>> Ugh, why do we keep having to add the whole mess for every single one of
>>>> these devices?
>>>
>>> Because Realtek devices are unfortunately ubiquitous so the support is
>>> better come from kernel.
>>
>> That's not the issue here.  The issue is that we keep adding the same
>> huge driver files to the kernel tree, over and over, with no real change
>> at all.  We have seen almost all of these files in other realtek
>> drivers, right?
> 
> Yes. They use one single driver to support different SoCs, different 
> architectures and even different OSes.
> That’s why it’s a mess.
> 
>> Why not use the ones we already have?
> 
> It’s virtually impossible because Realtek’s mega wifi driver uses tons of 
> #ifdefs, only one chip can be selected to be supported at compile time.
> 
>>
>> But better yet, why not add proper support for this hardware and not use
>> a staging driver?
> 
> Realtek plans to add the support in 2020, if everything goes well.
> Meanwhile, many users of HP and Lenovo laptops are using out-of-tree driver, 
> some of them are stuck to older kernels because they don’t know how to fix the 
> driver. So I strongly think having this in kernel is beneficial to many users, 
> even it’s only for a year.

Why not solve the older kernel problem the way I do with drivers for many 
Realtek devices by creating a GitHub project with the kernel API changes 
properly handled by ifdef statements? See the lwfinger projects. That solves the 
problem of users without the skills needed to adjust to kernel changes without 
burdening the entire Linux kernel with these bloated drivers. There are no 
reasons that a wifi driver should require 200K lines of code!

Larry

