Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21954C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DC42087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrRlPsFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfHBQq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:46:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35000 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfHBQq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:46:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so1068491pgv.2;
        Fri, 02 Aug 2019 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1mqBdvsDc6s4db6x0U4o6eITdjucJjl81QWzhyRALs4=;
        b=KrRlPsFQPaTHwv6ALy8LrIS3iw+CR3MEG2IJhcD27934RBG07SICtPtx3jENlAD57J
         aA0Tw27Rk6znTYPYD7mOkTFb6FyBbcLQubJHRz44CgjTqadNlTkBvZg/AYj/xa1EPSqx
         ertzTFw0MMxTwmOjC4VlyvEfTDlxwFz8yGFM5s7zh3LP/lFUumNOFtTl0UoODd9BqqRw
         ytNj6zUjrZnNOUkBTIJxY0e7KIGLGeRHZf6O9+Eti4TqUmC+jNsn9/urE4je7YHv17HH
         KlWnPnXNz+s4ve1VLSvs02iCtECOpxE/k+AmqUgijoNQXlM+RjQFsujYSyPm4lQDVWyA
         lRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1mqBdvsDc6s4db6x0U4o6eITdjucJjl81QWzhyRALs4=;
        b=CZjQoFRDz0HaeG32Yjodk6hXeMC2P/r14EyVI48CQqn86l5B5dRGNDBSxEYYmSUbqa
         bu8OsFxB82F+/Bh3TTuXCzlEHU6jE0rnikKjSyBJToenSFeypkKrl4m+nfL3/l2vdKAQ
         NUQBXzcN5PC/NzujI5d1f3MH3IsrczDOXCckCEdarDkW2jRDoX4wOi5TZphhOBOWbHfn
         QKWEtOcdaCI+osUgUKHAUr3lPJ7beXyrYuXIm3JQloAZjMwCA4KuLH+UmnbbJEQnr0O1
         PpHTE1hEw8Uq1wtz+j255lcIiw2GXKAVEbHyimvm4ceH4AB98RA8iJNswYkIokpcCOdg
         uVeg==
X-Gm-Message-State: APjAAAXmj7LepcpmQJs+QmOVr7UxOtmkiWZDqf0htcwOZu08CJIVdZ8n
        ymrzDAOH4z596jr0wiqcoHE=
X-Google-Smtp-Source: APXvYqzaCAWw06v6g7ecB9r6j15/9spv0X8qUkd3PoQZA+AeFEaKCBAdXSGQo/NyIy5xqPu+6j7vYA==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr5193428pjt.33.1564764388125;
        Fri, 02 Aug 2019 09:46:28 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id x25sm106891927pfa.90.2019.08.02.09.46.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 09:46:27 -0700 (PDT)
Date:   Sat, 3 Aug 2019 01:46:22 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
Message-ID: <20190802164622.GA16516@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
 <7c697904-53e3-b469-c907-25b8fb7859bc@kernel.org>
 <20190729145241.GA4557@localhost.localdomain>
 <787051b9-579d-6da5-9d04-3dd0ae3c770b@kernel.org>
 <20190801063859.GA9587@localhost.localdomain>
 <e581b566-65fb-c4d8-74fc-1c1b35b57b9f@kernel.org>
 <20190802074136.GA19534@localhost.localdomain>
 <a7a00097-64ce-703e-84f3-04f105e46c80@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a00097-64ce-703e-84f3-04f105e46c80@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 07:33:59AM -0600, shuah wrote:
> On 8/2/19 1:41 AM, Suwan Kim wrote:
> > On Thu, Aug 01, 2019 at 08:03:59AM -0600, shuah wrote:
> > > On 8/1/19 12:38 AM, Suwan Kim wrote:
> > > > On Mon, Jul 29, 2019 at 10:32:31AM -0600, shuah wrote:
> > > > > On 7/29/19 8:52 AM, Suwan Kim wrote:
> > > > > > Hi Shuah,
> > > > > > 
> > > > > > On Tue, Jul 23, 2019 at 06:21:53PM -0600, shuah wrote:
> > > > > > > Hi Suwan,
> > > > > > > 
> > > > > > > On 7/5/19 10:43 AM, Suwan Kim wrote:
> > > > > > > > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > > > > > > > doesn't supported SG, so USB storage driver on vhci breaks SG list
> > > > > > > > into multiple URBs and it causes error that a transfer got terminated
> > > > > > > > too early because the transfer length for one of the URBs was not
> > > > > > > > divisible by the maxpacket size.
> > > > > > > > 
> > > > > > > > In this patch, vhci basically support SG and it sends each SG list
> > > > > > > > entry to the stub driver. Then, the stub driver sees the total length
> > > > > > > > of the buffer and allocates SG table and pages according to the total
> > > > > > > > buffer length calling sgl_alloc(). After the stub driver receives
> > > > > > > > completed URB, it again sends each SG list entry to vhci.
> > > > > > > > 
> > > > > > > > If HCD of the server doesn't support SG, the stub driver breaks a
> > > > > > > > single SG reqeust into several URBs and submit them to the server's
> > > > > > > > HCD. When all the split URBs are completed, the stub driver
> > > > > > > > reassembles the URBs into a single return command and sends it to
> > > > > > > > vhci.
> > > > > > > > 
> > > > > > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > > > > > ---
> > > > > > > >      drivers/usb/usbip/stub.h         |   7 +-
> > > > > > > >      drivers/usb/usbip/stub_main.c    |  52 +++++---
> > > > > > > >      drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
> > > > > > > >      drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
> > > > > > > >      drivers/usb/usbip/usbip_common.c |  60 +++++++-- >   drivers/usb/usbip/vhci_hcd.c     |  10 +-
> > > > > > > >      drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
> > > > > > > >      7 files changed, 372 insertions(+), 121 deletions(-)
> > > > > > > 
> > > > > > > While you are working on v3 to fix chekpatch and other issues
> > > > > > > I pointed out, I have more for you.
> > > > > > > 
> > > > > > > What happens when you have mismatched server and client side?
> > > > > > > i.e stub does and vhci doesn't and vice versa.
> > > > > > > 
> > > > > > > Make sure to run checkpatch. Also check spelling errors in
> > > > > > > comments and your commit log.
> > > > > > > 
> > > > > > > I am not sure if your eeror paths are correct. Run usbip_test.sh
> > > > > > > 
> > > > > > > tools/testing/selftests/drivers/usb/usbip
> > > > > > 
> > > > > > I don't know what mismatch you mentioned. Are you saying
> > > > > > "match busid table" at the end of usbip_test.sh?
> > > > > > How does it relate to SG support of this patch?
> > > > > > Could you tell me more about the problem situation?
> > > > > > 
> > > > > 
> > > > > What happens when usbip_host is running a kernel without the sg
> > > > > support and vhci_hcd does? Just make sure this works with the
> > > > > checks for sg support status as a one of your tests for this
> > > > > sg feature.
> > > > 
> > > > Now I understand. Thanks for the details!
> > > > As a result of testing, in the situation where vhci supports SG,
> > > > but stub does not, or vice versa, usbip works normally. Moreover,
> > > > because there is no protocol modification, there is no problem in
> > > > communication between server and client even if the one has a kernel
> > > > without SG support.
> > > > 
> > > > In the case of vhci supports SG and stub doesn't, because vhci sends
> > > > only the total length of the buffer to stub as it did before the
> > > > patch applied, stub only needs to allocate the required length of
> > > > buffers regardless of whether vhci supports SG or not.
> > > > 
> > > > If stub needs to send data buffer to vhci because of IN pipe, stub
> > > > also sends only total length of buffer as metadata and then send real
> > > > data as vhci does. Then vhci receive data from stub and store it to
> > > > the corresponding buffer of SG list entry.
> > > > 
> > > > In the case of stub that supports SG, if SG buffer is requested by
> > > > vhci, buffer is allocated by sgl_alloc(). However, stub that does
> > > > not support SG allocates buffer using only kmalloc(). Therefore, if
> > > > vhci supports SG and stub doesn't, stub has to allocate buffer with
> > > > kmalloc() as much as the total length of SG buffer which is quite
> > > > huge when vhci sends SG request, so it has big overhead in buffer
> > > > allocation.
> > > > 
> > > > And for the case of stub supports SG and vhci doesn't, since the
> > > > USB storage driver checks that vhci doesn't support SG and sends
> > > > the request to stub by splitting the SG list into multiple URBs,
> > > > stub allocates a buffer with kmalloc() as it did before this patch.
> > > > 
> > > > Therefore, everything works normally in a mismatch situation.
> > > 
> > > Looking for you add a test case for that. Please include this
> > > in the commit log.
> > 
> > I'm confused about the test case. Do I add the test case for each
> > SG support status of vhci_hcd and usbip_host in usbip_test.sh?
> > Or, do I implement the test logic in vhci_hcd code that asks if
> > usbip_host supports SG when attaching a remote device?
> > I'm sorry but I don't know what exactly you want to add.
> > 
> 
> What I am asking you do is:
> 
> 1. test with mismatched host and client.

I already tested this case with two different machines. One is the
5.2-rc6 kernel with SG patch and the other is default fedora kernel
version 5.1.20-200.fc29.x86_64. As I said, I run vhci_hcd with SG
and usbip_host without SG and also vice versa.

I tested it with Sandisk USB 3.0 storage deivce and tested read and
write operation which transfer files whose size is over 1G like movie
file. All the opreations work well.

> 2. run usbip_test.sh

One thing goes wrong. But others except the one worked as expected.

==============================================================
List imported devices - expect to see imported devices
Imported USB devices
====================
Port 08: <Port in Use> at Super Speed(5000Mbps)
       SanDisk Corp. : Ultra Flair (0781:5591)
       4-1 -> usbip://localhost:3240/2-6
           -> remote bus/dev 002/003
==============================================================
Import devices from localhost - expect already imported messages
usbip: error: Attach Request for 2-6 failed - Device busy (exported)

==============================================================
Un-import devices
usbip: info: Port 0 is already detached!

usbip: info: Port 1 is already detached!

==============================================================
List imported devices - expect to see none
Imported USB devices
====================
Port 08: <Port in Use> at Super Speed(5000Mbps)
       SanDisk Corp. : Ultra Flair (0781:5591)
       4-1 -> usbip://localhost:3240/2-6
           -> remote bus/dev 002/003
==============================================================

My SanDisk device is bound port 8 but the test script detachs only
port 0 and 1. This error is not related with SG patch but we have to
modifiy the test script to try to detach all the ports.

> These two are separate tests. I am not asking you to add any tests.
> If you want to add it, I am not going say no :)
> 
> How close are you sending the patch?

My work is done. I will send it now.

Regards
Suwan Kim
