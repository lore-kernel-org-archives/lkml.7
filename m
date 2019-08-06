Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71BDC41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD9F20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFdzWsHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfHFPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:49:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41949 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfHFPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:49:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so41733019pff.8;
        Tue, 06 Aug 2019 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLXBkV7WG0MxrJ2EH9xc07ZM437sZtw9ICcEpLzf9kI=;
        b=MFdzWsHNxKk6Z2vdrhQb3THarO3cdvBQiex31YYURo3Rj/Gmm/igAQlAgC4AVRdLT9
         8EBwV3/DzSf/EPUDiO0hBYXfuJeqEC1EktCe4LVGQbAlzqlqLJdwhsqe0NhPTjBCeLcp
         lzxyp6P3ursKqCVdaoIZTv+QvjByhn3TUSKURVJkw4EShmEHdCcULVIL90fFNPdFc9CV
         N5C2GAJRMu6l2eyxn3SHkE8yfKoCFtcxj+UPmGiPeGgpe0Icd7VhKO+E0c4MWag5LMX4
         VbxZnBtdIB+Y2zGeG41c7rVqAGPe5cObc6yfofDJWfDhW2nJ6ZHavFF4Jz3cxiXi9TFD
         23yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLXBkV7WG0MxrJ2EH9xc07ZM437sZtw9ICcEpLzf9kI=;
        b=AqT+u+mpfeo/9AFY1ZErb7OrQdUcS0kpthiclb93r35yL3aVZ5wD/ycLNo8PlINX5R
         m+VPCnUs67d8ex+qXCp9vQSfaWrRjDYYsRbxIJLzDmbhNC57z0Bd9FA4EAAza8wskh7m
         FKLKIPW+5nEh14puL6qtjcCAIUYoVR8dF24+h+UibUwk6zj9KKuo/w8aSJKjEc9f9slq
         LvWWME3zdK2IVPLtbvni0mwTnyAPTk6x+Ye1bK3N+lalnmP50tuI/pIZP4ClTRwhcqBj
         tA3DGcK1ClrWU5w5NkI/FbWz7HtiaDxV66yHOY3UnZaIJETa+p6/m4FPNhxxA/ZTVrwa
         B8fQ==
X-Gm-Message-State: APjAAAXzADIVbZn24z3xrBSekuFfzlIWp6OV/ufDogESlbtAUAWLv5Ss
        R04O3v7+uStteftrUy6ApRA=
X-Google-Smtp-Source: APXvYqwQoXneWM7E4lYQImzhnBQlyrAacm8+HY7/dHZbiHZ7twokhEt9Lc3hXTJfDJVyD7vYUFfa6w==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr3622945pgd.13.1565106541492;
        Tue, 06 Aug 2019 08:49:01 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id v185sm99416482pfb.14.2019.08.06.08.48.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:49:00 -0700 (PDT)
Date:   Wed, 7 Aug 2019 00:48:56 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usbip: Implement SG support to vhci-hcd and stub
 driver
Message-ID: <20190806154856.GB3738@localhost.localdomain>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-3-suwan.kim027@gmail.com>
 <eeb617a1-e0e0-f27e-f8c7-e0180bb6e911@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb617a1-e0e0-f27e-f8c7-e0180bb6e911@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:13:54AM -0600, shuah wrote:
> On 8/6/19 6:31 AM, Suwan Kim wrote:
> > There are bugs on vhci with usb 3.0 storage device. In USB, each SG
> > list entry buffer should be divisible by the bulk max packet size.
> > But with native SG support, this problem doesn't matter because the
> > SG buffer is treated as contiguous buffer. But without native SG
> > support, USB storage driver breaks SG list into several URBs and the
> > error occurs because of a buffer size of URB that cannot be divided
> > by the bulk max packet size. The error situation is as follows.
> > 
> > When USB Storage driver requests 31.5 KB data and has SG list which
> > has 3584 bytes buffer followed by 7 4096 bytes buffer for some
> > reason. USB Storage driver splits this SG list into several URBs
> > because VHCI doesn't support SG and sends them separately. So the
> > first URB buffer size is 3584 bytes. When receiving data from device,
> > USB 3.0 device sends data packet of 1024 bytes size because the max
> > packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
> > But the first URB buffer has only 3584 bytes buffer size. So host
> > controller terminates the transfer even though there is more data to
> > receive. So, vhci needs to support SG transfer to prevent this error.
> > 
> > In this patch, vhci supports SG regardless of whether the server's
> > host controller supports SG or not, because stub driver splits SG
> > list into several URBs if the server's host controller doesn't
> > support SG.
> > 
> > To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
> > urb->transfer_flags if URB has SG list and this flag will tell stub
> > driver to use SG list.
> > 
> > vhci sends each SG list entry to stub driver. Then, stub driver sees
> > the total length of the buffer and allocates SG table and pages
> > according to the total buffer length calling sgl_alloc(). After stub
> > driver receives completed URB, it again sends each SG list entry to
> > vhci.
> > 
> > If the server's host controller doesn't support SG, stub driver
> > breaks a single SG request into several URBs and submits them to
> > the server's host controller. When all the split URBs are completed,
> > stub driver reassembles the URBs into a single return command and
> > sends it to vhci.
> > 
> > Moreover, in the situation where vhci supports SG, but stub driver
> > does not, or vice versa, usbip works normally. Because there is no
> > protocol modification, there is no problem in communication between
> > server and client even if the one has a kernel without SG support.
> > 
> > In the case of vhci supports SG and stub driver doesn't, because
> > vhci sends only the total length of the buffer to stub driver as
> > it did before the patch applied, stub driver only needs to allocate
> > the required length of buffers regardless of whether vhci supports
> > SG or not.
> > 
> > If stub driver needs to send data buffer to vhci because of IN pipe,
> > stub driver also sends only total length of buffer as metadata and
> > then sends real data as vhci does. Then vhci receive data from stub
> > driver and store it to the corresponding buffer of SG list entry.
> > 
> > In the case of stub driver that supports SG, buffer is allocated by
> > sgl_alloc(). However, stub driver that does not support SG allocates
> > buffer using only kmalloc(). Therefore, if vhci supports SG and stub
> > driver doesn't, stub driver has to allocate buffer with kmalloc() as
> > much as the total length of SG buffer which is quite huge when vhci
> > sends SG request, so it has big overhead in buffer allocation.
> > 
> > And for the case of stub driver supports SG and vhci doesn't, since
> > the USB storage driver checks that vhci doesn't support SG and sends
> > the request to stub driver by splitting the SG list into multiple
> > URBs, stub driver allocates a buffer with kmalloc() as it did before
> > this patch.
> > 
> > VUDC also works well with this patch. Tests are done with two USB
> > gadget created by CONFIGFS USB gadget. Both use the BULK pipe.
> > 
> >          1. Serial gadget
> >          2. Mass storage gadget
> > 
> >   * Serial gadget test
> > 
> > Serial gadget on the host sends and receives data using cat command
> > on the /dev/ttyGS<N>. The client uses minicom to communicate with
> > the serial gadget.
> > 
> >   * Mass storage gadget test
> > 
> > After connecting the gadget with vhci, use "dd" to test read and
> > write operation on the client side.
> > 
> > Read  - dd if=/dev/sd<N> iflag=direct of=/dev/null bs=1G count=1
> > Write - dd if=<my file path> iflag=direct of=/dev/sd<N> bs=1G count=1
> > 
> 
> Thanks for the test results.
> 
> Were you able to test with USB lowspeed devices?

I tested USB3 super-speed device and USB2 high-speed device.
But I don't have full/low speed device that uses BULK transfer.
In USB spec, low-speed device doesn't support BULK transfer.

Do I add test description about the USB3 super-speed and USB2
high-speed device to the commit log?

Regards
Suwan Kim
