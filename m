Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A886CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6EA205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571686138;
	bh=aL519NiYCbs7aj+hNkciLs7n+wrEjTqYqKNI1l5QCAM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cNwnTN6OzTAdGW4X8jDbBZxtzm1hxDL99hJZ/6SQtW7TpmAqnZBakbgTi32nCT34h
	 q6S36XvH2stgyi/drd+Sp06v8qWEDp/NdX9E9VW+spEOYvXJttrafd1OMGalkr1hfg
	 6v7TwLA34H4YjSsc5EPnsRUQRsDXz0qk7xktxKDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfJUT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfJUT25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:28:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97543205ED;
        Mon, 21 Oct 2019 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571686136;
        bh=aL519NiYCbs7aj+hNkciLs7n+wrEjTqYqKNI1l5QCAM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sMH4Csq9dBDHCKtTWRpR3hDjvXzW8duYFGeq1M984poBAFdjZ9OjMxIaLqGidbAMS
         hsryK3KEsHntoMDQGMiP4jimYIGln/4CQZfmhLvnmWICsIWDu+dlvnWy10R1ZP0J/u
         0lHczooeberiJ8lt4QRhv51tMzK7M0QlAlkLNn5Q=
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_usbip=3a=c2=a0Fix_free_of_unallocated_m?=
 =?UTF-8?Q?emory_in_vhci_tx?=
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Suwan Kim <suwan.kim027@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
        kbuild test robot <lkp@intel.com>, shuah <shuah@kernel.org>
References: <20191021142414.27164-1-suwan.kim027@gmail.com>
 <alpine.DEB.2.21.1910211706240.2877@hadrien>
From:   shuah <shuah@kernel.org>
Message-ID: <936d4cf8-cd5a-a297-8298-e9bc5d3c193d@kernel.org>
Date:   Mon, 21 Oct 2019 13:28:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910211706240.2877@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/19 9:08 AM, Julia Lawall wrote:
> 
> 
> On Mon, 21 Oct 2019, Suwan Kim wrote:
> 
>> iso_buffer should be set to NULL after use and free in the while loop.
>> In the case of isochronous URB in the while loop, iso_buffer is
>> allocated and after sending it to server, buffer is deallocated. And
>> then, if the next URB in the while loop is not a isochronous pipe,
>> iso_buffer still holds the previously deallocated buffer address and
>> kfree tries to free wrong buffer address.
>>
>> Fixes: ea44d190764b (“usbip: Implement SG support to vhci-hcd and stub driver”)
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>> ---
>>   drivers/usb/usbip/vhci_tx.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
>> index c3803785f6ef..b290e810d11b 100644
>> --- a/drivers/usb/usbip/vhci_tx.c
>> +++ b/drivers/usb/usbip/vhci_tx.c
>> @@ -73,6 +73,7 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
>>   		memset(&pdu_header, 0, sizeof(pdu_header));
>>   		memset(&msg, 0, sizeof(msg));
>>   		memset(&iov, 0, sizeof(iov));
>> +		iso_buffer = NULL;
> 
> Somehow I would have put it after the kfree, since the kfree makes the
> value invalid.  iso_buffer is already initialized to NULL for the first
> iteration.  If you want to put the setting to NULL at the top of the loop,
> maybe the = NULL in the first line should be removed.
> 

It makes sense to clear it after kfree() on line 150.

This kfree() and clearing iso_buffer are necessary only for
PIPE_ISOCHRONOUS case.

Please add a comment above that this is for isoc case.

thanks,
-- Shuah


