Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C5920665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752869;
	bh=OPoLV3eQMYv05nIBms/7Cv1RsdbgG0/PHdN5JNyYsNU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dYBbKYXv9nLLWGB3SaPJt4l9K1qX2BmfgtswUaXLfEaaUeajZEMl95zRp2QkFGo+w
	 OoXf+CnitcZdO5wykzlWFvElWeCIyUftJkb2rEe4UO6K3NOIZ5p3g/uYCaqmKCl4eJ
	 QDqLyIGFiyDSJsy2UR4yPw7vAxieo9dROLS2wlVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405847AbfHBNe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405647AbfHBNeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:34:24 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9C320665;
        Fri,  2 Aug 2019 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752863;
        bh=OPoLV3eQMYv05nIBms/7Cv1RsdbgG0/PHdN5JNyYsNU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ot5FLTITGot5JlxK4l6yYVZ/wFaXM5TOuv6rzKqhuyXMRcc9mSpuw8h4+WAIqpRdK
         ZzNtV395rnzohCxRJ7ann9CVof44owF7fiF803yJ5Sy9Gni1PK9ARFWSyNODzwVKFw
         iPg0a8Cw4lyntiOL0JL+IvGF+u3tNvAG6AgObRco=
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
 <7c697904-53e3-b469-c907-25b8fb7859bc@kernel.org>
 <20190729145241.GA4557@localhost.localdomain>
 <787051b9-579d-6da5-9d04-3dd0ae3c770b@kernel.org>
 <20190801063859.GA9587@localhost.localdomain>
 <e581b566-65fb-c4d8-74fc-1c1b35b57b9f@kernel.org>
 <20190802074136.GA19534@localhost.localdomain>
From:   shuah <shuah@kernel.org>
Message-ID: <a7a00097-64ce-703e-84f3-04f105e46c80@kernel.org>
Date:   Fri, 2 Aug 2019 07:33:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074136.GA19534@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/19 1:41 AM, Suwan Kim wrote:
> On Thu, Aug 01, 2019 at 08:03:59AM -0600, shuah wrote:
>> On 8/1/19 12:38 AM, Suwan Kim wrote:
>>> On Mon, Jul 29, 2019 at 10:32:31AM -0600, shuah wrote:
>>>> On 7/29/19 8:52 AM, Suwan Kim wrote:
>>>>> Hi Shuah,
>>>>>
>>>>> On Tue, Jul 23, 2019 at 06:21:53PM -0600, shuah wrote:
>>>>>> Hi Suwan,
>>>>>>
>>>>>> On 7/5/19 10:43 AM, Suwan Kim wrote:
>>>>>>> There are bugs on vhci with usb 3.0 storage device. Originally, vhci
>>>>>>> doesn't supported SG, so USB storage driver on vhci breaks SG list
>>>>>>> into multiple URBs and it causes error that a transfer got terminated
>>>>>>> too early because the transfer length for one of the URBs was not
>>>>>>> divisible by the maxpacket size.
>>>>>>>
>>>>>>> In this patch, vhci basically support SG and it sends each SG list
>>>>>>> entry to the stub driver. Then, the stub driver sees the total length
>>>>>>> of the buffer and allocates SG table and pages according to the total
>>>>>>> buffer length calling sgl_alloc(). After the stub driver receives
>>>>>>> completed URB, it again sends each SG list entry to vhci.
>>>>>>>
>>>>>>> If HCD of the server doesn't support SG, the stub driver breaks a
>>>>>>> single SG reqeust into several URBs and submit them to the server's
>>>>>>> HCD. When all the split URBs are completed, the stub driver
>>>>>>> reassembles the URBs into a single return command and sends it to
>>>>>>> vhci.
>>>>>>>
>>>>>>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>>>>>>> ---
>>>>>>>      drivers/usb/usbip/stub.h         |   7 +-
>>>>>>>      drivers/usb/usbip/stub_main.c    |  52 +++++---
>>>>>>>      drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
>>>>>>>      drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
>>>>>>>      drivers/usb/usbip/usbip_common.c |  60 +++++++-- >   drivers/usb/usbip/vhci_hcd.c     |  10 +-
>>>>>>>      drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
>>>>>>>      7 files changed, 372 insertions(+), 121 deletions(-)
>>>>>>
>>>>>> While you are working on v3 to fix chekpatch and other issues
>>>>>> I pointed out, I have more for you.
>>>>>>
>>>>>> What happens when you have mismatched server and client side?
>>>>>> i.e stub does and vhci doesn't and vice versa.
>>>>>>
>>>>>> Make sure to run checkpatch. Also check spelling errors in
>>>>>> comments and your commit log.
>>>>>>
>>>>>> I am not sure if your eeror paths are correct. Run usbip_test.sh
>>>>>>
>>>>>> tools/testing/selftests/drivers/usb/usbip
>>>>>
>>>>> I don't know what mismatch you mentioned. Are you saying
>>>>> "match busid table" at the end of usbip_test.sh?
>>>>> How does it relate to SG support of this patch?
>>>>> Could you tell me more about the problem situation?
>>>>>
>>>>
>>>> What happens when usbip_host is running a kernel without the sg
>>>> support and vhci_hcd does? Just make sure this works with the
>>>> checks for sg support status as a one of your tests for this
>>>> sg feature.
>>>
>>> Now I understand. Thanks for the details!
>>> As a result of testing, in the situation where vhci supports SG,
>>> but stub does not, or vice versa, usbip works normally. Moreover,
>>> because there is no protocol modification, there is no problem in
>>> communication between server and client even if the one has a kernel
>>> without SG support.
>>>
>>> In the case of vhci supports SG and stub doesn't, because vhci sends
>>> only the total length of the buffer to stub as it did before the
>>> patch applied, stub only needs to allocate the required length of
>>> buffers regardless of whether vhci supports SG or not.
>>>
>>> If stub needs to send data buffer to vhci because of IN pipe, stub
>>> also sends only total length of buffer as metadata and then send real
>>> data as vhci does. Then vhci receive data from stub and store it to
>>> the corresponding buffer of SG list entry.
>>>
>>> In the case of stub that supports SG, if SG buffer is requested by
>>> vhci, buffer is allocated by sgl_alloc(). However, stub that does
>>> not support SG allocates buffer using only kmalloc(). Therefore, if
>>> vhci supports SG and stub doesn't, stub has to allocate buffer with
>>> kmalloc() as much as the total length of SG buffer which is quite
>>> huge when vhci sends SG request, so it has big overhead in buffer
>>> allocation.
>>>
>>> And for the case of stub supports SG and vhci doesn't, since the
>>> USB storage driver checks that vhci doesn't support SG and sends
>>> the request to stub by splitting the SG list into multiple URBs,
>>> stub allocates a buffer with kmalloc() as it did before this patch.
>>>
>>> Therefore, everything works normally in a mismatch situation.
>>
>> Looking for you add a test case for that. Please include this
>> in the commit log.
> 
> I'm confused about the test case. Do I add the test case for each
> SG support status of vhci_hcd and usbip_host in usbip_test.sh?
> Or, do I implement the test logic in vhci_hcd code that asks if
> usbip_host supports SG when attaching a remote device?
> I'm sorry but I don't know what exactly you want to add.
> 

What I am asking you do is:

1. test with mismatched host and client.
2. run usbip_test.sh

These two are separate tests. I am not asking you to add any tests.
If you want to add it, I am not going say no :)

How close are you sending the patch?

thanks,
-- Shuah


