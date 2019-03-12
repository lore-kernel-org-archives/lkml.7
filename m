Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF59C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCLKWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:22:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36604 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfCLKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:22:17 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h3eY4-0005EQ-3P
        for linux-kernel@vger.kernel.org; Tue, 12 Mar 2019 10:22:16 +0000
Received: by mail-pf1-f199.google.com with SMTP id v2so2025893pfn.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TgRA/hciwBHAWJoy1gIBJETUZTizs8mL/bXn/5C0jfM=;
        b=dapY9S1hVBOM1pTdOv3tnbYPPlIsC0uapMBsxtK+Ca6ZZx8SzEspMZDS12DVYGiNvZ
         niay/dr83b2QnFGBtP5f+mY2L90YZ3CfqtooUUdrbRcZL6ZRwPk9c71NG715fpUajvz7
         BXTHSwoTM63TK0vGVG6U9kSZkEyx2OYU77KCeHDuE/ePM0qd+WyamVEKGTZu3Jx8+EJB
         GexeOUP5qzM/WBEOxxmS3EKHetlpGXc3nvyblQYrRVNOl9Yt5zLAG8lAmQKjSTvdiqJv
         qNnfkERvBlvSZo+NSZ1rxyUICZ71wwrWgFFencmq+fXudit+wUX+eUCOr+8NPQZODy8T
         BzsQ==
X-Gm-Message-State: APjAAAXx7JMH/eMPFxl7+TwsI1U/iYYVGCjYdPacFiHPOUjKx57TMnkp
        olMTFDPQ0ynKNCW08OO0jDPPR7X4Nv+N4jwG97Nq9Or66yw/tORzO6QHOXSt2uwuE7Tt43XSw/4
        IMyVRGhYy+KlW2rcHTEfhUKIhgMm8jCmHy8+nJYNZPA==
X-Received: by 2002:a65:6559:: with SMTP id a25mr23885800pgw.99.1552386134762;
        Tue, 12 Mar 2019 03:22:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0HJDQ0hcyoMe6Lh3m5PCCbOtGQjOUXkMi5aiGh0T6T3BYSHJCC3GdK87OpwVx4/XezGmAUw==
X-Received: by 2002:a65:6559:: with SMTP id a25mr23885780pgw.99.1552386134373;
        Tue, 12 Mar 2019 03:22:14 -0700 (PDT)
Received: from 2001-b011-380f-14b9-4175-e032-a704-9b27.dynamic-ip6.hinet.net (2001-b011-380f-14b9-4175-e032-a704-9b27.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:4175:e032:a704:9b27])
        by smtp.gmail.com with ESMTPSA id l79sm18719822pfb.102.2019.03.12.03.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:22:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <D84EEC8F-8B65-4B0C-9EA7-E01A0BB47398@canonical.com>
Date:   Tue, 12 Mar 2019 18:22:11 +0800
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <9EC6DA7E-2503-40F8-AB5A-25A2424B6346@canonical.com>
References: <20190124061643.11663-1-kai.heng.feng@canonical.com>
 <20190130082133.GA32660@kroah.com>
 <D84EEC8F-8B65-4B0C-9EA7-E01A0BB47398@canonical.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 00:01, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

>
>
>> On Jan 30, 2019, at 16:21, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jan 24, 2019 at 02:16:43PM +0800, Kai-Heng Feng wrote:
>>> The QCA Rome USB Bluetooth controller has several issues once LPM gets
>>> enabled:
>>> - Fails to get enumerated in coldboot. [1]
>>> - Drains more power (~ 0.2W) when the system is in S5. [2]
>>> - Disappears after a warmboot. [2]
>>>
>>> The issue happens because the device lingers at LPM L1 in S5, so device
>>> can't get enumerated even after a reboot.
>>>
>>> Disable LPM at shutdown to solve the issue.
>>>
>>> [1] https://bugs.launchpad.net/bugs/1757218
>>> [2] https://patchwork.kernel.org/patch/10607097/
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> v2: Use new LPM helpers.
>>>
>>> drivers/usb/core/port.c | 9 +++++++++
>>> 1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>>> index 1a06a4b5fbb1..bbbb35fa639f 100644
>>> --- a/drivers/usb/core/port.c
>>> +++ b/drivers/usb/core/port.c
>>> @@ -285,6 +285,14 @@ static int usb_port_runtime_suspend(struct device  
>>> *dev)
>>> }
>>> #endif
>>>
>>> +static void usb_port_shutdown(struct device *dev)
>>> +{
>>> +	struct usb_port *port_dev = to_usb_port(dev);
>>> +
>>> +	if (port_dev->child)
>>> +		usb_disable_usb2_hardware_lpm(port_dev->child);
>>> +}
>>> +
>>> static const struct dev_pm_ops usb_port_pm_ops = {
>>> #ifdef CONFIG_PM
>>> 	.runtime_suspend =	usb_port_runtime_suspend,
>>> @@ -301,6 +309,7 @@ struct device_type usb_port_device_type = {
>>> static struct device_driver usb_port_driver = {
>>> 	.name = "usb",
>>> 	.owner = THIS_MODULE,
>>> +	.shutdown = usb_port_shutdown,
>>> };
>>
>> So you now do this for all ports in the system, no matter what is
>> plugged in or not.  Are you _SURE_ you want to do that?  It seems like a
>> big hammer to solve just one single device's problems.
>
> Yes I think this should be universally applied.
>
> I don’t think the bug only happens to one device. Users won’t find this
> unless they connect their laptop to a power meter.
>
> Platform may not completely cut off USB bus power during shutdown,
> so the device transits to L1 after system shutdown. Now xHC is disabled
> so nothing can bring it back to L0 or L2.

It would be great if someone can come up with better ideas.

We can also use other approaches, but currently this is the only way I can  
think of.

Kai-Heng

>
> Kai-Heng
>
>> thanks,
>>
>> greg k-h


