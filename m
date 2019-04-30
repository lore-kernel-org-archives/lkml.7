Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC01CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2B42173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556639364;
	bh=yCYkO8N4121wxKLTF87LoI1Jml4WNkrjnoiQJbB2u0Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=wW1JWDyuOUHWLRmeC58g0rtVguT5o6hH1FVEbgrSJBWZJyt4by7OKLdTRLweVvxwb
	 KgTCs03qZmuha12MnwhxSKvRcbiZSyAuNrdsXYJzkqNTjxzzBlcUA9eta1TycB1QG8
	 WdUqPCUxzUdjlfxgYD9BneyjALPH6Z9YdnsMwsOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfD3PtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3PtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:49:22 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A297121734;
        Tue, 30 Apr 2019 15:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556639362;
        bh=yCYkO8N4121wxKLTF87LoI1Jml4WNkrjnoiQJbB2u0Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XCLSYGRbNQ/VNh1KsMX90+coyBttlMIZv5lOet5FFy5ZiFoWNeVI6D18mOoUUzm4U
         HumBpe3rfHfOnyx2Kxhf85DYkLWdAHPSbnEqp5EooLP5MBmLk79cbdS9wU/AM+6jdw
         w3nhu/HkpQ0aQONkjyGe9hapoOLU5sgFDMTCBWig=
Subject: Re: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, shuah <shuah@kernel.org>
References: <20190429143957.GA6725@embeddedor>
 <1daec8c8929e4d18b2059ab1dfbfdf4a@AcuMS.aculab.com>
 <287c8504-eafa-ebbb-aa39-babb86fdeb94@embeddedor.com>
 <20190430154444.GA4224@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <722d3830-cd03-47ba-8587-db3aff076278@kernel.org>
Date:   Tue, 30 Apr 2019 09:49:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430154444.GA4224@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/19 9:44 AM, Greg Kroah-Hartman wrote:
> On Mon, Apr 29, 2019 at 10:05:51AM -0500, Gustavo A. R. Silva wrote:
>>
>>
>> On 4/29/19 9:44 AM, David Laight wrote:
>>> From: Gustavo A. R. Silva
>>>> Sent: 29 April 2019 15:40
>>>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>>>> cases where we are expecting to fall through.
>>> ...
>>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>>> index 667d9c0ec905..000ab7225717 100644
>>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>>> @@ -508,6 +508,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>>>   		case USB_PORT_FEAT_U1_TIMEOUT:
>>>>   			usbip_dbg_vhci_rh(
>>>>   				" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
>>>> +			/* Fall through */
>>>>   		case USB_PORT_FEAT_U2_TIMEOUT:
>>>>   			usbip_dbg_vhci_rh(
>>>>   				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
>>>
>>> That doesn't look right, both debug messages seem to get printed.
>>>
>>
>> At first sight, I thought the same way, then I took a look into
>> commit:
>>
>> 1c9de5bf428612458427943b724bea51abde520a
>>
>> and noticed that the original developer properly added fall-through
>> comments in other places in the same switch() code, that gave me the
>> impression he knew what he was doing; then I noticed the following
>> error message in case USB_PORT_FEAT_U2_TIMEOUT:
>>
>> 	if (hcd->speed != HCD_USB3) {
>> 		pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
>> 		       "supported for USB 2.0 roothub\n");
>> 		goto error;
>> 	}
>>
>> this error message is what makes me think the fall-through is
>> intentional; otherwise I think it would look like this instead:
>>
>> 	if (hcd->speed != HCD_USB3) {
>> 		pr_err("USB_PORT_FEAT_U2_TIMEOUT req not "
>> 		       "supported for USB 2.0 roothub\n");
>> 		goto error;
>> 	}
> 
> I think you are right, that's horrid, but correct :(

Yes. This hub_control is poorly organized and could use cleanup.
> 
> Will go queue this up, thanks.
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks Greg!. It is on my list of things to Ack today.

-- Shuah
