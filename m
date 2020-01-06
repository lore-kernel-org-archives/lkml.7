Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD12FC32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC51215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgAFGTR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:19:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFGTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:19:17 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ioLjP-00069F-7m
        for linux-kernel@vger.kernel.org; Mon, 06 Jan 2020 06:19:15 +0000
Received: by mail-pl1-f197.google.com with SMTP id b5so18663601pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 22:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vqkeBbtQ/S3eGJG7ALwvxRss7P5JkNLpwge+MbQGY3E=;
        b=GFgVInBC5AGGSKRSkEW7NSijBao0iiJ4Gfw0yxEJ6dIHP81EcUpOgnNY0WzZkMxBLW
         sShRicf8UPT5KdIg2u+W6uUSDnT8X1ufd9uSETTfGy0st1Jdbb5DDNruEIsgXFni4WxZ
         Oq7DkGpDCvpCm81+C0R7Y7LuX6toZwx8LdrqpJ10gpsyZm3yGcqpcpe3caWhqgNbxLQZ
         LUbVJoN4RKPOgPpgDPDmGC8K4z65VqD+nuxMWyR1z9hiUhblawKpKloEX6c8ZG6k26dB
         Whwkm9FVaQ7hv2tK26h0WfWYmVnOm9mZ63EtS5/Dw4+Xj+PrgOZpI4O9t0XQ/nB4OQOT
         AaSw==
X-Gm-Message-State: APjAAAUlYEwqmrWTuxjdeEEneEbdVfwJNYlcVOctOQ1uKsru0QFKKODT
        46eYqWxSZpO1LnWdeRJCFEnzezqgZE6SoFLKNpXaXbueSUfXTU+ETmlFr4oFK81Sf0WUo/W9O06
        DXIi+t4pMtqb22w6s5i8zIq5MMwPX4bASeYi3ib+RKQ==
X-Received: by 2002:a62:1c88:: with SMTP id c130mr108394749pfc.195.1578291553831;
        Sun, 05 Jan 2020 22:19:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwneR4KEMxSx+1Y1t/2K3PN/9q9+hJWQvCmqIhS/uOCbyKHuq5HQvg5itd1UaQq8J8UXre5Q==
X-Received: by 2002:a62:1c88:: with SMTP id c130mr108394738pfc.195.1578291553557;
        Sun, 05 Jan 2020 22:19:13 -0800 (PST)
Received: from 2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net (2001-b011-380f-35a3-2839-ccbd-36ed-2f4a.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:2839:ccbd:36ed:2f4a])
        by smtp.gmail.com with ESMTPSA id j5sm60724985pfn.180.2020.01.05.22.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 22:19:13 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting
 its ports to U0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.2001041117130.7125-100000@netrider.rowland.org>
Date:   Mon, 6 Jan 2020 14:19:07 +0800
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        gregkh@linuxfoundation.org, acelan.kao@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <90B37743-30D1-41BB-8272-D5FBDC89C88F@canonical.com>
References: <Pine.LNX.4.44L0.2001041117130.7125-100000@netrider.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 5, 2020, at 00:20, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Sat, 4 Jan 2020, Kai-Heng Feng wrote:
> 
>>>>>> @@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>>>>>> 	}
>>>>>> 
>>>>>> 	/* see 7.1.7.7; affects power usage, but not budgeting */
>>>>>> -	if (hub_is_superspeed(hub->hdev))
>>>>>> +	if (hub_is_superspeed(hub->hdev)) {
>>>>>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
>>>>>> +			usb_lock_device(hub->hdev);
>>>>>> +			usb_unlocked_disable_lpm(hub->hdev);
>>>>>> +		}
>>>>>> 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
>>>>>> -	else
>>>>>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
>>>>>> +			usb_unlocked_enable_lpm(hub->hdev);
>>>>>> +			usb_unlock_device(hub->hdev);
>>>>> 
>>>>> The locking here seems questionable.  Doesn't this code sometimes get
>>>>> called with the hub already locked?  Or with the child device locked
>>>>> (in which case locking the hub would violate the normal locking order:  
>>>>> parent first, child second)?
>>> 
>>> I did a little checking.  In many cases the child device _will_ be 
>>> locked at this point.
>>> 
>>>> Maybe introduce a new lock? The lock however will only be used by this specific hub.
>>>> But I still want the LPM can be enabled for this hub.
>>> 
>>> Do you really need to lock the hub at all?  What would the lock protect 
>>> against?
>> 
>> There can be multiple usb_port_resume() run at the same time for different ports, so this is to prevent LPM enable/disable race.
> 
> But there can't really be an LPM enable/disable race, can there?  The 
> individual function calls are protected by the bandwidth mutex taken by 
> the usb_unlocked_{en|dis}able_lpm routines, and the overall LPM setting 
> is controlled by the hub device's lpm_disable_counter.

For enable/disable LPM itself, there's no race.
But the lock here is to protect hub_set_port_link_state().
If we don't lock the hub, other instances of usb_port_resume() routine can enable LPM and we want the LPM stays disabled until hub_set_port_link_state() is done.

Kai-Heng

> 
> So I think you don't need to lock the hub here.
> 
> Alan Stern
> 

