Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EDCC04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7413216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557336488;
	bh=eIo+PcE7Ep+/ctNlCY8O7UDHkmpxPP9eIOH2j7a7EPE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=loELWFwcmRJ6zUha4VEaFW5ZuWwUHPeYcXmjR9C4+IMC5Me5j9GTkD5Iptc3y8ika
	 esKaqfzYsEUu4uGpL05ihRRlQywoYJB53YpkuqGanxaIDB7f5qTOMHLjm2Vq8sLMbd
	 yccsKOOr/Gr2O3+XbJn4tERn8IeNzpyoFxfrJoUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfEHR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbfEHR2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:28:07 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320E0216F4;
        Wed,  8 May 2019 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557336486;
        bh=eIo+PcE7Ep+/ctNlCY8O7UDHkmpxPP9eIOH2j7a7EPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cUU1ApB4RvQ8W7pFwOX+gnBcC7+mV8cBLaA3YyXRsWHer73SoUv/O8AyKyfcdOe1+
         +MBo4L/jCo6m1gmNM5yzxUN6KuKVgUNLVhvILUc1e8YDXeGWVlKYNpnFLVirK9uMc1
         gifAAAKLQ7EvRb/VYM3nHViFmpHX1IE+NyJi6gRw=
Subject: Re: [PATCH 1/2] usbip: Remove repeated setting of hcd->state in
 vhci_bus_suspend()
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190506125550.7826-1-suwan.kim027@gmail.com>
 <440389ab-62c3-7bc2-0e9b-0b302a88c929@kernel.org>
 <20190507154918.GA2427@localhost.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <0ad76300-9b7f-f368-0533-1f88de649d10@kernel.org>
Date:   Wed, 8 May 2019 11:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507154918.GA2427@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 9:49 AM, Suwan Kim wrote:
> Hi Shuah,
> 
> On Mon, May 06, 2019 at 09:13:02AM -0600, shuah wrote:
>> On 5/6/19 6:55 AM, Suwan Kim wrote:
>>> When hcd suspends execution, hcd_bus_suspend() calls vhci_bus_suspend()
>>> which sets hcd->state as HC_STATE_SUSPENDED. But after calling
>>> vhci_bus_suspend(), hcd_bus_suspend() also sets hcd->state as
>>> HC_STATE_SUSPENDED.
>>> So, setting hcd->state in vhci_hcd_suspend() is unnecessary.
>>>
>>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>>> ---
>>>    drivers/usb/usbip/vhci_hcd.c | 4 ----
>>>    1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index 667d9c0ec905..e6f378d00fb6 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -1238,10 +1238,6 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
>>>    	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
>>> -	spin_lock_irqsave(&vhci->lock, flags);
>>> -	hcd->state = HC_STATE_SUSPENDED;
>>> -	spin_unlock_irqrestore(&vhci->lock, flags);
>>> -
>>>    	return 0;
>>>    }
>>>
>>
>> Tell me more about why you think this change is needed? How did you test
>> this change?
> 
> I think that host controller specific functions, vhci_bus_resume()
> or vhci_bus_suspend() in the case of vhci, usually process host
> controller specific data (struct vhci_hcd) not a generic data
> (struct usb_hcd). The generic data is usually processed by generic HCD
> layer. But vhci_bus_resume() and vhci_bus_suspend() set generic data
> (hcd->state) and moreover this variable is set in generic HCD layer
> once again(hcd_bus_resume() and hcd_bus_suspend()).
> 
> So, i think host controller specific functions (vhci_bus_resume()
> and vhci_bus_suspend()) don't need to set the generic data that is
> "hcd->state = HC_STATE_RUNNING or HC_STATE_SUSPEND".
> 

It depends. In this case, vhci_hcd is virtual driver and maintains
port status for devices that are remote. It checks hcd->state in
vhci_hub_status().

It updates the hcd->state in suspend with vhci->lock hold and checks
status from vhci_hub_status(). Removing updating hcd->state from 
vhci_bus_suspend()will open a window where vhci_hub_status() might
find it wrong state.

Same thing for HC_STATE_RUNNING. There are few other drivers that
do the same for similar reasons. xhci_hcd, and dummy_hcd and a few
more. This is the same comment on your patch that removes
HC_STATE_RUNNING update from resume.

> For test, I loaded vhci-hcd module, suspended and resumed my computer
> and checked hcd->state variable. There is no difference compared with
> not modified version because my patch just removes repeated and
> unnecessary part.
> 

This won't fully test the condition since there are remote devices
attached and triggering suspend while attach/detach is in progress.

thanks,
-- Shuah

