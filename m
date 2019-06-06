Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6FDC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32073206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfFFIGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:06:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfFFIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:06:36 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hYnPu-0005fw-BU
        for linux-kernel@vger.kernel.org; Thu, 06 Jun 2019 08:06:34 +0000
Received: by mail-pl1-f199.google.com with SMTP id b24so1025027plz.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vnPQv7wSaML5HbRULOaOYWAw6aFeo0e2SgXfuH28KXY=;
        b=QzTHMj7YJQAvXvI+taUcTO6E3d2+T0gyHYpKOLxXRrvTPP/1EWQjBQVp72rfJhhh60
         fXUCWqD1TL4ExUHswf/7+fUNSmj4nH6j6n9ZRQ971pMnwPvf4A3+wVL5NzWrrcpLG4Ci
         7aveTRixXhifIbNv/AKFb7ZJA5MIe3neZ7ujT0kpXBTaJfmC/Oa5ZERMyxOshoHUlZuM
         3E2kZqK0PF+YtNDusiU8rtJh9yDpxE0tiTlDnsX4qyr8eh0Xy5lDYPcZP60K2MGC1aj5
         0JsNSgis6BWgaloZffUU+YKCIc/vuIzaIbTuwpElgDbsI1C2MwAOYF7tioAyZCOUIMLS
         EFbA==
X-Gm-Message-State: APjAAAVEceaa3uLmgmq7F2xOWtPejfxVLyyEKcgFgVWSBMGZuUvyvXeU
        O//4/8K0yE1DdL2kThJHOmt+YBKqp7++mDdbx1LU/HGyzDoVXwsaEPT2KIZDa+1chheMZAK1ela
        Kh6cCA/4tTQv6m9kmpJYLKWI+dmVqsqDlKAzqfQ49uQ==
X-Received: by 2002:a63:374d:: with SMTP id g13mr2211352pgn.413.1559808392733;
        Thu, 06 Jun 2019 01:06:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz47i1oZrAZILOOXCizCnA0BYBNyE2ZcG3QlIejqMqXeooR0KqKyDd7j7vS5ybdardZwzJKEw==
X-Received: by 2002:a63:374d:: with SMTP id g13mr2211330pgn.413.1559808392506;
        Thu, 06 Jun 2019 01:06:32 -0700 (PDT)
Received: from 2001-b011-380f-115a-4031-dc0c-76c4-a6d1.dynamic-ip6.hinet.net (2001-b011-380f-115a-4031-dc0c-76c4-a6d1.dynamic-ip6.hinet.net. [2001:b011:380f:115a:4031:dc0c:76c4:a6d1])
        by smtp.gmail.com with ESMTPSA id n2sm1198257pgp.27.2019.06.06.01.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:06:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <80534332-7E39-42B9-8B64-580B483B83A5@canonical.com>
Date:   Thu, 6 Jun 2019 16:06:27 +0800
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <1C63D05A-1AEF-40F6-8127-4958A4112676@canonical.com>
References: <20190124061643.11663-1-kai.heng.feng@canonical.com>
 <20190130082133.GA32660@kroah.com>
 <D84EEC8F-8B65-4B0C-9EA7-E01A0BB47398@canonical.com>
 <9EC6DA7E-2503-40F8-AB5A-25A2424B6346@canonical.com>
 <80534332-7E39-42B9-8B64-580B483B83A5@canonical.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 15:55, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> at 18:22, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
>> at 00:01, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>>>> On Jan 30, 2019, at 16:21, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Thu, Jan 24, 2019 at 02:16:43PM +0800, Kai-Heng Feng wrote:
>>>>> The QCA Rome USB Bluetooth controller has several issues once LPM gets
>>>>> enabled:
>>>>> - Fails to get enumerated in coldboot. [1]
>>>>> - Drains more power (~ 0.2W) when the system is in S5. [2]
>>>>> - Disappears after a warmboot. [2]
>>>>>
>>>>> The issue happens because the device lingers at LPM L1 in S5, so device
>>>>> can't get enumerated even after a reboot.
>>>>>
>>>>> Disable LPM at shutdown to solve the issue.
>>>>>
>>>>> [1] https://bugs.launchpad.net/bugs/1757218
>>>>> [2] https://patchwork.kernel.org/patch/10607097/
>>>>>
>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> ---
>>>>> v2: Use new LPM helpers.
>>>>>
>>>>> drivers/usb/core/port.c | 9 +++++++++
>>>>> 1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>>>>> index 1a06a4b5fbb1..bbbb35fa639f 100644
>>>>> --- a/drivers/usb/core/port.c
>>>>> +++ b/drivers/usb/core/port.c
>>>>> @@ -285,6 +285,14 @@ static int usb_port_runtime_suspend(struct  
>>>>> device *dev)
>>>>> }
>>>>> #endif
>>>>>
>>>>> +static void usb_port_shutdown(struct device *dev)
>>>>> +{
>>>>> +	struct usb_port *port_dev = to_usb_port(dev);
>>>>> +
>>>>> +	if (port_dev->child)
>>>>> +		usb_disable_usb2_hardware_lpm(port_dev->child);
>>>>> +}
>>>>> +
>>>>> static const struct dev_pm_ops usb_port_pm_ops = {
>>>>> #ifdef CONFIG_PM
>>>>> 	.runtime_suspend =	usb_port_runtime_suspend,
>>>>> @@ -301,6 +309,7 @@ struct device_type usb_port_device_type = {
>>>>> static struct device_driver usb_port_driver = {
>>>>> 	.name = "usb",
>>>>> 	.owner = THIS_MODULE,
>>>>> +	.shutdown = usb_port_shutdown,
>>>>> };
>>>>
>>>> So you now do this for all ports in the system, no matter what is
>>>> plugged in or not.  Are you _SURE_ you want to do that?  It seems like a
>>>> big hammer to solve just one single device's problems.
>>>
>>> Yes I think this should be universally applied.
>>>
>>> I don’t think the bug only happens to one device. Users won’t find this
>>> unless they connect their laptop to a power meter.
>>>
>>> Platform may not completely cut off USB bus power during shutdown,
>>> so the device transits to L1 after system shutdown. Now xHC is disabled
>>> so nothing can bring it back to L0 or L2.
>>
>> It would be great if someone can come up with better ideas.
>>
>> We can also use other approaches, but currently this is the only way I  
>> can think of.
>
> Alan and Mathias,
>
> It would be great if you can review this patch, or give me some suggestion.

Can I get some advice here?
I really think disabling LPM should be universally applied.

Kai-Heng

>
> Kai-Heng
>
>> Kai-Heng
>>
>>> Kai-Heng
>>>
>>>> thanks,
>>>>
>>>> greg k-h


