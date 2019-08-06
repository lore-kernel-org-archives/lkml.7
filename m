Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622C1216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565104438;
	bh=o7Iw858NsCabZtAX4JUiHaN3QVGg5unNWOAa7BMBif8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pmb6QXiaeEFtlT8dz53TmyOJXMW9badDt4Zq0rYrM8GkuFRU60tmyKA/gCoa7rsqn
	 ByQBIGoOGQ+tDI65p6kBKnOlWYtnRhkOGu2l+PkN7XX0RMSHPN8ZcKWEXPwzlhoAuP
	 FjzXiBTjS4afSUqgC4C9YRyUVVzhOxXOTwuQdmUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfHFPN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfHFPN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:13:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBDF216B7;
        Tue,  6 Aug 2019 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565104436;
        bh=o7Iw858NsCabZtAX4JUiHaN3QVGg5unNWOAa7BMBif8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XwSgNMoRE+No0JgezETKcY/oiHEQlOX5Nyc9inInecAShqM3EckNxxCK9abnU91kx
         6PBmidIqcQAdYZUCRULxkmFQETfzQdm+fPKp67XkG6NT71hmKmZoZUG8RoJ3dCisvc
         fjRRH10Bfw2uHkQTFNqxP0SaNltPwUTPO+tE4wcA=
Subject: Re: [PATCH v4 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
To:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-3-suwan.kim027@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <eeb617a1-e0e0-f27e-f8c7-e0180bb6e911@kernel.org>
Date:   Tue, 6 Aug 2019 09:13:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806123154.23798-3-suwan.kim027@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 6:31 AM, Suwan Kim wrote:
> There are bugs on vhci with usb 3.0 storage device. In USB, each SG
> list entry buffer should be divisible by the bulk max packet size.
> But with native SG support, this problem doesn't matter because the
> SG buffer is treated as contiguous buffer. But without native SG
> support, USB storage driver breaks SG list into several URBs and the
> error occurs because of a buffer size of URB that cannot be divided
> by the bulk max packet size. The error situation is as follows.
> 
> When USB Storage driver requests 31.5 KB data and has SG list which
> has 3584 bytes buffer followed by 7 4096 bytes buffer for some
> reason. USB Storage driver splits this SG list into several URBs
> because VHCI doesn't support SG and sends them separately. So the
> first URB buffer size is 3584 bytes. When receiving data from device,
> USB 3.0 device sends data packet of 1024 bytes size because the max
> packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
> But the first URB buffer has only 3584 bytes buffer size. So host
> controller terminates the transfer even though there is more data to
> receive. So, vhci needs to support SG transfer to prevent this error.
> 
> In this patch, vhci supports SG regardless of whether the server's
> host controller supports SG or not, because stub driver splits SG
> list into several URBs if the server's host controller doesn't
> support SG.
> 
> To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
> urb->transfer_flags if URB has SG list and this flag will tell stub
> driver to use SG list.
> 
> vhci sends each SG list entry to stub driver. Then, stub driver sees
> the total length of the buffer and allocates SG table and pages
> according to the total buffer length calling sgl_alloc(). After stub
> driver receives completed URB, it again sends each SG list entry to
> vhci.
> 
> If the server's host controller doesn't support SG, stub driver
> breaks a single SG request into several URBs and submits them to
> the server's host controller. When all the split URBs are completed,
> stub driver reassembles the URBs into a single return command and
> sends it to vhci.
> 
> Moreover, in the situation where vhci supports SG, but stub driver
> does not, or vice versa, usbip works normally. Because there is no
> protocol modification, there is no problem in communication between
> server and client even if the one has a kernel without SG support.
> 
> In the case of vhci supports SG and stub driver doesn't, because
> vhci sends only the total length of the buffer to stub driver as
> it did before the patch applied, stub driver only needs to allocate
> the required length of buffers regardless of whether vhci supports
> SG or not.
> 
> If stub driver needs to send data buffer to vhci because of IN pipe,
> stub driver also sends only total length of buffer as metadata and
> then sends real data as vhci does. Then vhci receive data from stub
> driver and store it to the corresponding buffer of SG list entry.
> 
> In the case of stub driver that supports SG, buffer is allocated by
> sgl_alloc(). However, stub driver that does not support SG allocates
> buffer using only kmalloc(). Therefore, if vhci supports SG and stub
> driver doesn't, stub driver has to allocate buffer with kmalloc() as
> much as the total length of SG buffer which is quite huge when vhci
> sends SG request, so it has big overhead in buffer allocation.
> 
> And for the case of stub driver supports SG and vhci doesn't, since
> the USB storage driver checks that vhci doesn't support SG and sends
> the request to stub driver by splitting the SG list into multiple
> URBs, stub driver allocates a buffer with kmalloc() as it did before
> this patch.
> 
> VUDC also works well with this patch. Tests are done with two USB
> gadget created by CONFIGFS USB gadget. Both use the BULK pipe.
> 
>          1. Serial gadget
>          2. Mass storage gadget
> 
>   * Serial gadget test
> 
> Serial gadget on the host sends and receives data using cat command
> on the /dev/ttyGS<N>. The client uses minicom to communicate with
> the serial gadget.
> 
>   * Mass storage gadget test
> 
> After connecting the gadget with vhci, use "dd" to test read and
> write operation on the client side.
> 
> Read  - dd if=/dev/sd<N> iflag=direct of=/dev/null bs=1G count=1
> Write - dd if=<my file path> iflag=direct of=/dev/sd<N> bs=1G count=1
> 

Thanks for the test results.

Were you able to test with USB lowspeed devices?

thanks,
-- Shuah
