Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E960C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AD214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFHJWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:22:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfFHJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:22:20 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hZXYH-0003RD-Uz
        for linux-kernel@vger.kernel.org; Sat, 08 Jun 2019 09:22:18 +0000
Received: by mail-pl1-f199.google.com with SMTP id bc12so2777916plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qTfPpH/VSNx4VR/dHZLtP7vQ2zYZpuf5ydZQKPkbDFg=;
        b=Vy6ux/thnj6CpxKwTwAKXGmArttU6nnnDb7s0xiFZjaxNWK5M6CSUepOumG3m/Yw7q
         YK4u6E0xRspbL4zWzrHz64uSZIYcVcNCKc+pPG1XGFgndXH9vtTYH1wRXuIUEFL7A8G+
         pDkUcPhOk+d7HSDCQUljKEdgiWdwY9bcyE5nhcAkmZvmPfhr4m3xqytPXbH+O+X32ENN
         E84KPbzv5IfE5KpEsG3N7YxWdvZbMmb3XgbZ1cwlPPLGC+rjKR2u5E2A7cvU7ZQlUQqx
         f/0N6zTFgP9DyZtoXQffDozVA0KCOtfDxqkm06TTeB6cLVJwOE4cdP66yLoHmo9n+X+F
         ffnQ==
X-Gm-Message-State: APjAAAVjeMf3jn2H4c9rrXT06pEMMlTPJVhXt+A/XAjadPYEJ3tiGCQv
        /RMynWCADL4jHk96wlCr2P19FslFFUmi9wC0CD6+riXtek9GvLKY7dZenM8d94TVAgk5Xiin7uT
        ixYVU0r/TmYrfHQohAE0DOfF1pDu45yPYJJHftx1Pig==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr59519027plp.313.1559985736611;
        Sat, 08 Jun 2019 02:22:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpgaL5LY+dtNo9LRBSCyLK9NB3P9p6s0vgE38zVQXfGeRkCgf8G+tehfLzAfh9gNnUPpBbXA==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr59519002plp.313.1559985736237;
        Sat, 08 Jun 2019 02:22:16 -0700 (PDT)
Received: from 2001-b011-380f-115a-4089-ef2e-1543-07a3.dynamic-ip6.hinet.net (2001-b011-380f-115a-4089-ef2e-1543-07a3.dynamic-ip6.hinet.net. [2001:b011:380f:115a:4089:ef2e:1543:7a3])
        by smtp.gmail.com with ESMTPSA id 10sm4627720pfh.179.2019.06.08.02.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 02:22:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1906061013490.1641-100000@iolanthe.rowland.org>
Date:   Sat, 8 Jun 2019 17:22:04 +0800
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <46147522-7BC2-4C30-B3E5-6568E9642982@canonical.com>
References: <Pine.LNX.4.44L0.1906061013490.1641-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 22:17, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Thu, 6 Jun 2019, Kai-Heng Feng wrote:
>
>> at 15:55, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>>> at 18:22, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>
>>>> at 00:01, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>>
>>>>>> On Jan 30, 2019, at 16:21, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On Thu, Jan 24, 2019 at 02:16:43PM +0800, Kai-Heng Feng wrote:
>>>>>>> The QCA Rome USB Bluetooth controller has several issues once LPM  
>>>>>>> gets
>>>>>>> enabled:
>>>>>>> - Fails to get enumerated in coldboot. [1]
>>>>>>> - Drains more power (~ 0.2W) when the system is in S5. [2]
>>>>>>> - Disappears after a warmboot. [2]
>>>>>>>
>>>>>>> The issue happens because the device lingers at LPM L1 in S5, so  
>>>>>>> device
>>>>>>> can't get enumerated even after a reboot.
>>>>>>>
>>>>>>> Disable LPM at shutdown to solve the issue.
>>>>>>>
>>>>>>> [1] https://bugs.launchpad.net/bugs/1757218
>>>>>>> [2] https://patchwork.kernel.org/patch/10607097/
>>>>>>>
>>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>>>> ---
>>>>>>> v2: Use new LPM helpers.
>>>>>>>
>>>>>>> drivers/usb/core/port.c | 9 +++++++++
>>>>>>> 1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>>>>>>> index 1a06a4b5fbb1..bbbb35fa639f 100644
>>>>>>> --- a/drivers/usb/core/port.c
>>>>>>> +++ b/drivers/usb/core/port.c
>>>>>>> @@ -285,6 +285,14 @@ static int usb_port_runtime_suspend(struct
>>>>>>> device *dev)
>>>>>>> }
>>>>>>> #endif
>>>>>>>
>>>>>>> +static void usb_port_shutdown(struct device *dev)
>>>>>>> +{
>>>>>>> +	struct usb_port *port_dev = to_usb_port(dev);
>>>>>>> +
>>>>>>> +	if (port_dev->child)
>>>>>>> +		usb_disable_usb2_hardware_lpm(port_dev->child);
>>>>>>> +}
>>>>>>> +
>>>>>>> static const struct dev_pm_ops usb_port_pm_ops = {
>>>>>>> #ifdef CONFIG_PM
>>>>>>> 	.runtime_suspend =	usb_port_runtime_suspend,
>>>>>>> @@ -301,6 +309,7 @@ struct device_type usb_port_device_type = {
>>>>>>> static struct device_driver usb_port_driver = {
>>>>>>> 	.name = "usb",
>>>>>>> 	.owner = THIS_MODULE,
>>>>>>> +	.shutdown = usb_port_shutdown,
>>>>>>> };
>>>>>>
>>>>>> So you now do this for all ports in the system, no matter what is
>>>>>> plugged in or not.  Are you _SURE_ you want to do that?  It seems  
>>>>>> like a
>>>>>> big hammer to solve just one single device's problems.
>>>>>
>>>>> Yes I think this should be universally applied.
>>>>>
>>>>> I don’t think the bug only happens to one device. Users won’t find this
>>>>> unless they connect their laptop to a power meter.
>>>>>
>>>>> Platform may not completely cut off USB bus power during shutdown,
>>>>> so the device transits to L1 after system shutdown. Now xHC is disabled
>>>>> so nothing can bring it back to L0 or L2.
>>>>
>>>> It would be great if someone can come up with better ideas.
>>>>
>>>> We can also use other approaches, but currently this is the only way I
>>>> can think of.
>>>
>>> Alan and Mathias,
>>>
>>> It would be great if you can review this patch, or give me some  
>>> suggestion.
>>
>> Can I get some advice here?
>> I really think disabling LPM should be universally applied.
>>
>> Kai-Heng
>
> I agree with Kai-Heng, this seems like a fairly light-weight solution
> to a reasonable problem.

Thanks for your review.

>
> As to the issue of how much it will slow down system shutdowns, I have
> no idea.  Probably not very much, unless somebody has an unusually
> large number of USB devices plugged in, but only testing can give a
> real answer.

In addition to that, only USB2 devices that enable LPM will slow down  
shutdown process.
Right now only internally connected USB2 devices enable LPM, so the numbers  
are even lower.

>
> I suppose we could add an HCD flag for host controllers which require
> this workaround.  Either way, it's probably not a very big deal.

IMO this is not necessary. Only xHCI that reports hw_lpm_support will be  
affected. At least for PC, this only became true after Whiskey Lake.

Kai-Heng

>
> Alan Stern


