Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A548C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A5F206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566917039;
	bh=YYcpRPJ9ObMCi1TUYaeck+9yIfym9MWqOaqRL4NI7/4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IuksBYepfXpCowdqaC5zUhKHDqRqxhUayrUQsBozZS2ar0w1cfgbPV/rOZf0i+K7m
	 0jFQWUlr3Od4RkreXDdgzWM2LQPvac5+xR4YQnAee0cbqw8Jf5Bk/r6jSJL81Wh5UM
	 DrlnAT08D/k4t+JQgQw3SarkL1tLGkA0xsFKLhEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfH0On6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0On5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:43:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2B8206BF;
        Tue, 27 Aug 2019 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566917036;
        bh=YYcpRPJ9ObMCi1TUYaeck+9yIfym9MWqOaqRL4NI7/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cBiwjWnUXHcYFU3+QphcsfL72GFFmfOQGPRnuLrsHhJOcR6F78UmipUiaQI6iZm4D
         qDQQmggQbuPN+9Oa5GSd4YSLI9mBcKtlNW/gxgg6DxdaRWnTbHQIYPJc3wu4OHjw+1
         RgMxnG17Y2D37nVwjzKnXMFV7MqFcm11llSvwuts=
Subject: Re: [PATCH v8] usbip: Implement SG support to vhci-hcd and stub
 driver
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190826172348.23353-1-suwan.kim027@gmail.com>
 <d7bc3d7c-47a9-4b8c-ede2-2ed276fe2a77@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <9000ddaa-24f0-5c76-43a4-318f00ea31dc@kernel.org>
Date:   Tue, 27 Aug 2019 08:43:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7bc3d7c-47a9-4b8c-ede2-2ed276fe2a77@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 8:38 AM, shuah wrote:
> On 8/26/19 11:23 AM, Suwan Kim wrote:
>> There are bugs on vhci with usb 3.0 storage device. In USB, each SG
>> list entry buffer should be divisible by the bulk max packet size.
>> But with native SG support, this problem doesn't matter because the
>> SG buffer is treated as contiguous buffer. But without native SG
>> support, USB storage driver breaks SG list into several URBs and the
>> error occurs because of a buffer size of URB that cannot be divided
>> by the bulk max packet size. The error situation is as follows.
>>
>> When USB Storage driver requests 31.5 KB data and has SG list which
>> has 3584 bytes buffer followed by 7 4096 bytes buffer for some
>> reason. USB Storage driver splits this SG list into several URBs
>> because VHCI doesn't support SG and sends them separately. So the
>> first URB buffer size is 3584 bytes. When receiving data from device,
>> USB 3.0 device sends data packet of 1024 bytes size because the max
>> packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
>> But the first URB buffer has only 3584 bytes buffer size. So host
>> controller terminates the transfer even though there is more data to
>> receive. So, vhci needs to support SG transfer to prevent this error.
>>
>> In this patch, vhci supports SG regardless of whether the server's
>> host controller supports SG or not, because stub driver splits SG
>> list into several URBs if the server's host controller doesn't
>> support SG.
>>
>> To support SG, vhci sets URB_DMA_MAP_SG flag in transfer_flags of
>> usbip header if URB has SG list and this flag will tell stub driver
>> to use SG list.
>>
>> vhci sends each SG list entry to stub driver. Then, stub driver sees
>> the total length of the buffer and allocates SG table and pages
>> according to the total buffer length calling sgl_alloc(). After stub
>> driver receives completed URB, it again sends each SG list entry to
>> vhci.
>>
>> If the server's host controller doesn't support SG, stub driver
>> breaks a single SG request into several URBs and submits them to
>> the server's host controller. When all the split URBs are completed,
>> stub driver reassembles the URBs into a single return command and
>> sends it to vhci.
>>
>> Moreover, in the situation where vhci supports SG, but stub driver
>> does not, or vice versa, usbip works normally. Because there is no
>> protocol modification, there is no problem in communication between
>> server and client even if the one has a kernel without SG support.
>>
>> In the case of vhci supports SG and stub driver doesn't, because
>> vhci sends only the total length of the buffer to stub driver as
>> it did before the patch applied, stub driver only needs to allocate
>> the required length of buffers using only kmalloc() regardless of
>> whether vhci supports SG or not. But stub driver has to allocate
>> buffer with kmalloc() as much as the total length of SG buffer which
>> is quite huge when vhci sends SG request, so it has overhead in
>> buffer allocation in this situation.
>>
>> If stub driver needs to send data buffer to vhci because of IN pipe,
>> stub driver also sends only total length of buffer as metadata and
>> then sends real data as vhci does. Then vhci receive data from stub
>> driver and store it to the corresponding buffer of SG list entry.
>>
>> And for the case of stub driver supports SG and vhci doesn't, since
>> the USB storage driver checks that vhci doesn't support SG and sends
>> the request to stub driver by splitting the SG list into multiple
>> URBs, stub driver allocates a buffer for each URB with kmalloc() as
>> it did before this patch.
>>
>> * Test environment
>>
>> Test uses two difference machines and two different kernel version
>> to make mismatch situation between the client and the server where
>> vhci supports SG, but stub driver does not, or vice versa. All tests
>> are conducted in both full SG support that both vhci and stub support
>> SG and half SG support that is the mismatch situation. Test kernel
>> version is 5.3-rc6 with commit "usb: add a HCD_DMA flag instead of
>> guestimating DMA capabilities" to avoid unnecessary DMA mapping and
>> unmapping.
>>
>>   - Test kernel version
>>      - 5.3-rc6 with SG support
>>      - 5.1.20-200.fc29.x86_64 without SG support
>>
>> * SG support test
>>
>>   - Test devices
>>      - Super-speed storage device - SanDisk Ultra USB 3.0
>>      - High-speed storage device - SMI corporation USB 2.0 flash drive
>>
>>   - Test description
>>
>> Test read and write operation of mass storage device that uses the
>> BULK transfer. In test, the client reads and writes files whose size
>> is over 1G and it works normally.
>>
>> * Regression test
>>
>>   - Test devices
>>      - Super-speed device - Logitech Brio webcam
>>      - High-speed device  - Logitech C920 HD Pro webcam
>>      - Full-speed device  - Logitech bluetooth mouse
>>                           - Britz BR-Orion speaker
>>      - Low-speed device   - Logitech wired mouse
>>
>>   - Test description
>>
>> Moving and click test for mouse. To test the webcam, use gnome-cheese.
>> To test the speaker, play music and video on the client. All works
>> normally.
>>
>> * VUDC compatibility test
>>
>> VUDC also works well with this patch. Tests are done with two USB
>> gadget created by CONFIGFS USB gadget. Both use the BULK pipe.
>>
>>          1. Serial gadget
>>          2. Mass storage gadget
>>
>>   - Serial gadget test
>>
>> Serial gadget on the host sends and receives data using cat command
>> on the /dev/ttyGS<N>. The client uses minicom to communicate with
>> the serial gadget.
>>
>>   - Mass storage gadget test
>>
>> After connecting the gadget with vhci, use "dd" to test read and
>> write operation on the client side.
>>
>> Read  - dd if=/dev/sd<N> iflag=direct of=/dev/null bs=1G count=1
>> Write - dd if=<my file path> iflag=direct of=/dev/sd<N> bs=1G count=1
>>
>> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
>> ---
>> v7 - v8
>> - Modify the commit log which describes URB_DMA_MAP_SG flag setting.
>>
>> v6 - v7
>> - Move the flag set in setup_cmd_submit_pdu() of vhci_tx.c and
>>    manipulate usbip header flag instead of urb->transfer_flags.
>>
>> - Remove clearing URB_DMA_MAP_SG flag in vhci_rx.
> 
> setup_cmd_submit_pdu() is just for pdu and shouldn't be concerned
> about the urb.
> 
> Please keep the URB_DMA_MAP_SG setting in urb->transfer_flags.
> That mean you are restoring v6 code change with the commit log
> updates from v8.
> 

I mean v6 with my comments on v6 addressed, moving setting the flag
after kalloc() and other comments.

thanks,
-- Shuah

