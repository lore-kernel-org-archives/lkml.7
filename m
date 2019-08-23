Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C46233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQzDM+EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfHWB1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:27:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35348 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfHWB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:27:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so5250532pfd.2;
        Thu, 22 Aug 2019 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8+8yuYK16262CDN+ZxtmlGEgmLpOhgOgpMGr9koQfx8=;
        b=EQzDM+EZm1n/3JRPSqgy65MO96XftGB13VIxawHZ8R/y+psdgvGf12uisksVlwfFtY
         g7GrJuBmwiLyZcOJYF78I8+0dW22xtcyBW+ACcdmc1Dmc9ZIyHpCr1OetLffwCWCl7a1
         MlHNj5MPLTTcyPOLiaMUlM5S/deBQ2dd//kcZshhkhQSg6rgMVAxYd7JJyYsqFqeS+8D
         Y7xOw1IVEYg6IeQZHwLkmSiQyVAastek2k9gERMv7Y5JEzqzZcwgfhPmq6JntHWL+E3Z
         VZjZwQ4CNc184I3JgVIIBMOoR5UWQxf6t47h9XaYjz8hC6lIjGG/UmJ7VpX+kC8gMHmA
         5+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8+8yuYK16262CDN+ZxtmlGEgmLpOhgOgpMGr9koQfx8=;
        b=QsyLGzOLzc0VCE3EbJjHtLBI/PfjxAIU5mUZtq+dT1nhuyugqI3FZzRwkMKKT2vOvu
         /zjwjVNEzlhqK8QGoMOtngXqGNszo05S+Eyu9hkl11ifs3wA4kcuJfU53F24fs3KexBt
         NpMxKgaVQhoDvfRek/WqNgusJok3fz7DvosZF7gqw4dsUoP51MZlJZfP9QBRnW5UCE6s
         pIZuF48uHycUrbE5iU6/MDZnIQLwERnvXrfezjfFfSlyhU5WL7dROhNJSPT/SRoo8txT
         GXqDK+f7OrlPsZqrmBytBajAvcCI41UsbkGQRbCs/DDCBqnzFXUNLxgex4gRZZB9M2dd
         cd4w==
X-Gm-Message-State: APjAAAW+JJnLaRLDmyzOHm7RzE5KqMk3A6wTsJVbSLj/r72CsCwBIMwJ
        0pa0eGYKAXSXM7YG++sgdO8=
X-Google-Smtp-Source: APXvYqygq8tpOYst9vMC8OsAqYaTJOmKvYD0sAW96IJYY1wDP41IeA29GN2x3ng8cgd5KkwIskpr9Q==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr1715430pgb.396.1566523620683;
        Thu, 22 Aug 2019 18:27:00 -0700 (PDT)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id k3sm702449pfg.23.2019.08.22.18.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 18:26:59 -0700 (PDT)
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jslaby@suse.com, jay.dolan@accesio.com, hslester96@gmail.com,
        je.yen.tam@ni.com, lkp@intel.com, kai.heng.feng@canonical.com,
        heikki.krogerus@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190816112644.GF30120@smile.fi.intel.com>
 <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
 <20190822211511.GA11893@kroah.com>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <b15b0504-91d3-a147-0613-5c8a4749e74d@gmail.com>
Date:   Fri, 23 Aug 2019 09:26:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822211511.GA11893@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Greg KH 於 2019/8/23 上午 05:15 寫道:
>> Andy Shevchenko 於 2019/8/16 下午 07:26 寫道:
>>> We have 8250_fintek.
>>> Isn't it a right place to add these?
>>>
>>
>> The 8250_fintek implements PNP device with id PNP0501.
>> Should I also implements PCIe device in this file?
> 
> Does it use the same logic?  If so, that makes sense, but if you can not
> share anything, then no, it does not make sense.
> 

It's same with old series F81504/508/512 and the old series had
implement in 8250_pci.c (pbn_fintek_4/pbn_fintek_8/pbn_fintek_12).
So I decide implements the new series in 8250_pci.c


Thanks
-- 
With Best Regards,
Peter Hong
