Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B40CC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209A724649
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 06:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgADGmB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 01:42:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50458 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgADGmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 01:42:00 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ind8J-000887-9I
        for linux-kernel@vger.kernel.org; Sat, 04 Jan 2020 06:41:59 +0000
Received: by mail-pf1-f198.google.com with SMTP id v14so4164985pfm.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 22:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aw6Ol3KnPt3nI5GLfalvRNJwitFrTF7FtxRZ9wnMWcU=;
        b=WxUqdu8XQTLZfmIH8D4E3w4wVZrzSvyUSg+v6NPHfTezw3HbWjkjcNmETfGOPdFXlL
         Pj4y4kMsZZNV0BNWtnaZUcT8b0g98XULqlW3cyvp9sBhqnsIOtviYtnj003xQ4GvFp/m
         vZaHo9WZeh0yYX8O9WeOj6o0FdFOZCEgCAHc0UUSTFZqIOLnW6tRnUigeF9qa4NBbdBh
         U+btm9q+oKihR35qVaVysDwQM5eOhhLWIFxFpC02hzVgbRC0L0Rjl7NRIi9+Sg2+9mPU
         ThdGhYoxsJyBV2rqQNN31eW7bgSZZ3fe4oHSr85qN8n9F/vK366YxbsaVNr/Bp80ZmR7
         oYGw==
X-Gm-Message-State: APjAAAXU5Ld29GejLwCWtc0Hj/k+OlmMp9STKmh5xtAZgcDiTDYc+cYz
        f46NsXlNHl/CUUb+ca6+JHGmDjvtMWX7pq8P594XWO9VGeJ7MFqSUlFscRaysMNaCm49/Ii1vLR
        HyH6IOz0RJ2CrjlIoK3o3cJMWlQh40/+b2gnFgGX/Xw==
X-Received: by 2002:a17:90a:65ca:: with SMTP id i10mr32235834pjs.28.1578120117866;
        Fri, 03 Jan 2020 22:41:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgnspeYazvlTTZBJTMP0vq6Rip9jTd7u5/5DrFZE2XokVk+ln/TCA8f3iltl1i/IGgIVxVJQ==
X-Received: by 2002:a17:90a:65ca:: with SMTP id i10mr32235818pjs.28.1578120117561;
        Fri, 03 Jan 2020 22:41:57 -0800 (PST)
Received: from 2001-b011-380f-35a3-b9ae-9bbf-bd71-ab73.dynamic-ip6.hinet.net (2001-b011-380f-35a3-b9ae-9bbf-bd71-ab73.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:b9ae:9bbf:bd71:ab73])
        by smtp.gmail.com with ESMTPSA id q9sm66601400pgc.5.2020.01.03.22.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 22:41:57 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH 3/3] USB: Disable LPM on WD19's Realtek Hub during setting
 its ports to U0
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.2001031137290.1560-100000@iolanthe.rowland.org>
Date:   Sat, 4 Jan 2020 14:41:54 +0800
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        gregkh@linuxfoundation.org, acelan.kao@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <97F72C66-8D9B-4316-B096-1993FD18CF56@canonical.com>
References: <Pine.LNX.4.44L0.2001031137290.1560-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 4, 2020, at 00:54, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Sat, 4 Jan 2020, Kai-Heng Feng wrote:
> 
>> Hi Alan,
>> 
>>> On Jan 3, 2020, at 23:21, Alan Stern <stern@rowland.harvard.edu> wrote:
>>> 
>>> On Fri, 3 Jan 2020, Kai-Heng Feng wrote:
>>> 
>>>> Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
>>>> bus when bringing underlying ports from U3 to U0.
>>>> 
>>>> After some expirements and guessworks, the hub itself needs to be U0
>>>> during setting its port's link state back to U0.
>>>> 
>>>> So add a new quirk to let the hub disables LPM on setting U0 for its
>>>> downstream facing ports.
>>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/usb/core/hub.c     | 12 ++++++++++--
>>>> drivers/usb/core/quirks.c  |  7 +++++++
>>>> include/linux/usb/quirks.h |  3 +++
>>>> 3 files changed, 20 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>>>> index f229ad6952c0..35a035781c5a 100644
>>>> --- a/drivers/usb/core/hub.c
>>>> +++ b/drivers/usb/core/hub.c
>>>> @@ -3533,9 +3533,17 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>>>> 	}
>>>> 
>>>> 	/* see 7.1.7.7; affects power usage, but not budgeting */
>>>> -	if (hub_is_superspeed(hub->hdev))
>>>> +	if (hub_is_superspeed(hub->hdev)) {
>>>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
>>>> +			usb_lock_device(hub->hdev);
>>>> +			usb_unlocked_disable_lpm(hub->hdev);
>>>> +		}
>>>> 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
>>>> -	else
>>>> +		if (hub->hdev->quirks & USB_QUIRK_DISABLE_LPM_ON_U0) {
>>>> +			usb_unlocked_enable_lpm(hub->hdev);
>>>> +			usb_unlock_device(hub->hdev);
>>> 
>>> The locking here seems questionable.  Doesn't this code sometimes get
>>> called with the hub already locked?  Or with the child device locked
>>> (in which case locking the hub would violate the normal locking order:  
>>> parent first, child second)?
> 
> I did a little checking.  In many cases the child device _will_ be 
> locked at this point.
> 
>> Maybe introduce a new lock? The lock however will only be used by this specific hub.
>> But I still want the LPM can be enabled for this hub.
> 
> Do you really need to lock the hub at all?  What would the lock protect 
> against?

There can be multiple usb_port_resume() run at the same time for different ports, so this is to prevent LPM enable/disable race.

Kai-Heng

> 
> Alan Stern

