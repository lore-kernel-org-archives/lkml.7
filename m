Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66918CA9EC7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A1420818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfKEFOY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:14:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37264 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfKEFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:14:23 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iRrAc-00048c-2g
        for linux-kernel@vger.kernel.org; Tue, 05 Nov 2019 05:14:22 +0000
Received: by mail-pg1-f199.google.com with SMTP id q1so5970909pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 21:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JprAQtkugXMNo/gg2BE2hUTsxxRNgFiIwg+1mQgKeVY=;
        b=CxdCA5rwUMvyDu+ciE6g4S8z/aBWp3bcmBixmb6RPr+r2MeGErgFDte2OLjUx31RB6
         8lzjtO8W1fS2boY4Oxz5iWSWvLCLCe9eT+tchgUDfDTXZQkOnrubUCpAjTryZ8txrquB
         8bGUR+nPEnhs1It0sD6RUnT8a6bPDyYXGBNsA21bjioFYPoftgr8i/4mIETSV7owNnGM
         Hh8CfcgDTrEGtX1oMSjZGGo0RFHd00x0Ji9oxaBFIVWnC4+1TIh+REXNImOcAsNa6uLQ
         jMBBeuRCx7Kn/5aZAy5SsfTlqOgNpBUGiuxUwe3NTLXRmIv52UXQzu8mPo6oXJckUQuD
         /aQg==
X-Gm-Message-State: APjAAAWwzPqvfKfJf55DbdILr98HjjVR99zJd6OAY4e7sCWTLGD3iw7J
        7uileMU2ihHbFqUocEwMLZM+2YzFT9whb7SAQIZ4ITKuLtST44tW10madCND1v/0AWULFXLwYv5
        RZ8wgX7AfdLO2AxVTcbsah3rJ2fLJ5LrBGtxwzSNy8A==
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr35413444pfb.167.1572930860592;
        Mon, 04 Nov 2019 21:14:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLeAQ3fElRGQNEY/4syv8RZhQVelT90aGVjAH0F7fIO1ra0NmQdetGZnHO/2G4Z3YOLxkD8Q==
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr35413421pfb.167.1572930860214;
        Mon, 04 Nov 2019 21:14:20 -0800 (PST)
Received: from [10.101.46.71] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id t8sm8783700pji.11.2019.11.04.21.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 21:14:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 2/2] usb: core: Attempt power cycle when port is in
 eSS.Disabled state
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20191104143838.GA2183570@kroah.com>
Date:   Tue, 5 Nov 2019 13:14:16 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CFDCF282-FBBC-43BC-9E6B-093B752E5C33@canonical.com>
References: <20191007182840.4867-1-kai.heng.feng@canonical.com>
 <20191007182840.4867-2-kai.heng.feng@canonical.com>
 <20191104143838.GA2183570@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 4, 2019, at 10:38 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Tue, Oct 08, 2019 at 02:28:40AM +0800, Kai-Heng Feng wrote:
>> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
>> then connects to ASMedia xHCI's root hub:
>> 
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>> 
>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
>> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
>> 
>> The SMSC hub may disconnect after system resume from suspend. When this
>> happens, the reset resume attempt fails, and the last resort to disable
>> the port and see something comes up later, also fails.
>> 
>> When the issue occurs, the link state stays in eSS.Disabled state
>> despite the warm reset attempts. The USB spec mentioned this can be
>> caused by invalid VBus, and after some expiremets, it does show that the
>> SMSC hub can be brought back after a power cycle.
>> 
>> So let's power cycle the port at the end of reset resume attempt, if
>> it's in eSS.Disabled state.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/usb/core/hub.c | 21 +++++++++++++++++++--
>> 1 file changed, 19 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 6655a6a1651b..5f50aca7cf67 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -2739,20 +2739,33 @@ static bool hub_port_warm_reset_required(struct usb_hub *hub, int port1,
>> 		|| link_state == USB_SS_PORT_LS_COMP_MOD;
>> }
>> 
>> +static bool hub_port_power_cycle_required(struct usb_hub *hub, int port1,
>> +		u16 portstatus)
>> +{
>> +	u16 link_state;
>> +
>> +	if (!hub_is_superspeed(hub->hdev))
>> +		return false;
>> +
>> +	link_state = portstatus & USB_PORT_STAT_LINK_STATE;
>> +	return link_state == USB_SS_PORT_LS_SS_DISABLED;
>> +}
>> +
>> static void hub_port_power_cycle(struct usb_hub *hub, int port1)
>> {
>> +	struct usb_port *port_dev = hub->ports[port1  - 1];
>> 	int ret;
>> 
>> 	ret = usb_hub_set_port_power(hub, port1, false);
>> 	if (ret) {
>> -		dev_info(&udev->dev, "failed to disable port power\n");
>> +		dev_info(&port_dev->dev, "failed to disable port power\n");
>> 		return;
>> 	}
>> 
>> 	msleep(2 * hub_power_on_good_delay(hub));
>> 	ret = usb_hub_set_port_power(hub, port1, true);
>> 	if (ret) {
>> -		dev_info(&udev->dev, "failed to enable port power\n");
>> +		dev_info(&port_dev->dev, "failed to enable port power\n");
>> 		return;
>> 	}
>> 
>> @@ -3600,6 +3613,10 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>> 	if (status < 0) {
>> 		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
>> 		hub_port_logical_disconnect(hub, port1);
>> +		if (hub_port_power_cycle_required(hub, port1, portstatus)) {
>> +			dev_info(&udev->dev, "device in disabled state, attempt power cycle\n");
> 
> Why dev_info()?  Shouldn't we only care if this fails?

I’ll lower the level to dev_dbg().

> 
>> +			hub_port_power_cycle(hub, port1);
> 
> Weren't we only going to do this for the broken types of devices?  And
> not for everything?

From what I can understand from the spec, if the device is in eSS.Disabled state, there’s no way out.
So "power cycling as a last resort” is indeed targets everything.

Kai-Heng

> thanks,
> 
> greg k-h

