Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1153206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZhprceM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfHAGjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:39:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34145 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:39:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so31732899plt.1;
        Wed, 31 Jul 2019 23:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/uNHjFQQtBHfzovEd+z7lkr1IKWySLScT/Efu+sULMI=;
        b=IZhprceMx77po8KiF+5hoSXeGhYdgBLo02BFGl8KUJo9zmqcReo6xF4caM37UFfXNX
         0Cac0h6dngefETmtiyP7z3NDMcPousn1zRUrTSYH772sMxzz571wkIaquuuN7B5JCRtJ
         5uDf5q+NFJcvfnSnm97W0Nlku7+kvb2srV6xx/pB9a3w9NfQJU2oj/BaFEJHl8qVGw5+
         o/sz4ADnMlbe3B8GL79Rk7z/7WUqsoWGAw/iulV/bVdoojvoyMyi3BL6CM+LcA+yUmuT
         HWVNLrM2FXHPhQMvAzZHTDhRuALFZ5rFHwlheRo97E/FFslVjI9zYGzWtVY8BYdxXNQM
         B+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/uNHjFQQtBHfzovEd+z7lkr1IKWySLScT/Efu+sULMI=;
        b=GNwYta7DcZ6jS8bGAgBVx/HluQIACs1Jzz748OdEi6CoCQtwWOX+YWYj6+OSSqZ7J2
         cCucCT+ksZIAs4iFIlEhXDBt5lFdoOZpk6tZff725TkvPHMZGup935Y0HaFQfG+WIkWr
         hEgoLUcXFL2elEgEuXAuGLLxVxXAMvXr64tt5yYOVQutWHJN/l/gPsy8Wt5oZbO5dpxT
         demZvRjk8agZkZ1aDFfG1AkxvuGMnHVjeZHZkzMyk4HN4BXnKqjZ9aJfK2Twz8bbnzvw
         Mr//VcAJfW4zvc6qjlsBCZRF27s1pNDZiSE3CNsUnNfPPcW94lQKCSFb9mNt+vm/+EPr
         6jmw==
X-Gm-Message-State: APjAAAVivI5S4qeZqjd2/clLrkE2Fp6MumjwaqhJZC30F6xdqDxT1YqW
        cz+K9Y6WwrKzkwos/+KxNtM=
X-Google-Smtp-Source: APXvYqz9T2LCjOg0ggKr5YsLBZ+tiRA9nNpZSzZ5AfwoSKdoVoukjBgeAfECiUoA9iRNbjETu+kHuA==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr120559329plt.247.1564641545350;
        Wed, 31 Jul 2019 23:39:05 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.125])
        by smtp.gmail.com with ESMTPSA id 11sm1707301pgo.43.2019.07.31.23.39.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 23:39:04 -0700 (PDT)
Date:   Thu, 1 Aug 2019 15:38:59 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
Message-ID: <20190801063859.GA9587@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
 <7c697904-53e3-b469-c907-25b8fb7859bc@kernel.org>
 <20190729145241.GA4557@localhost.localdomain>
 <787051b9-579d-6da5-9d04-3dd0ae3c770b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787051b9-579d-6da5-9d04-3dd0ae3c770b@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:32:31AM -0600, shuah wrote:
> On 7/29/19 8:52 AM, Suwan Kim wrote:
> > Hi Shuah,
> > 
> > On Tue, Jul 23, 2019 at 06:21:53PM -0600, shuah wrote:
> > > Hi Suwan,
> > > 
> > > On 7/5/19 10:43 AM, Suwan Kim wrote:
> > > > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > > > doesn't supported SG, so USB storage driver on vhci breaks SG list
> > > > into multiple URBs and it causes error that a transfer got terminated
> > > > too early because the transfer length for one of the URBs was not
> > > > divisible by the maxpacket size.
> > > > 
> > > > In this patch, vhci basically support SG and it sends each SG list
> > > > entry to the stub driver. Then, the stub driver sees the total length
> > > > of the buffer and allocates SG table and pages according to the total
> > > > buffer length calling sgl_alloc(). After the stub driver receives
> > > > completed URB, it again sends each SG list entry to vhci.
> > > > 
> > > > If HCD of the server doesn't support SG, the stub driver breaks a
> > > > single SG reqeust into several URBs and submit them to the server's
> > > > HCD. When all the split URBs are completed, the stub driver
> > > > reassembles the URBs into a single return command and sends it to
> > > > vhci.
> > > > 
> > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > ---
> > > >    drivers/usb/usbip/stub.h         |   7 +-
> > > >    drivers/usb/usbip/stub_main.c    |  52 +++++---
> > > >    drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
> > > >    drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
> > > >    drivers/usb/usbip/usbip_common.c |  60 +++++++-- >   drivers/usb/usbip/vhci_hcd.c     |  10 +-
> > > >    drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
> > > >    7 files changed, 372 insertions(+), 121 deletions(-)
> > > 
> > > While you are working on v3 to fix chekpatch and other issues
> > > I pointed out, I have more for you.
> > > 
> > > What happens when you have mismatched server and client side?
> > > i.e stub does and vhci doesn't and vice versa.
> > > 
> > > Make sure to run checkpatch. Also check spelling errors in
> > > comments and your commit log.
> > > 
> > > I am not sure if your eeror paths are correct. Run usbip_test.sh
> > > 
> > > tools/testing/selftests/drivers/usb/usbip
> > 
> > I don't know what mismatch you mentioned. Are you saying
> > "match busid table" at the end of usbip_test.sh?
> > How does it relate to SG support of this patch?
> > Could you tell me more about the problem situation?
> > 
> 
> What happens when usbip_host is running a kernel without the sg
> support and vhci_hcd does? Just make sure this works with the
> checks for sg support status as a one of your tests for this
> sg feature.

Now I understand. Thanks for the details!
As a result of testing, in the situation where vhci supports SG,
but stub does not, or vice versa, usbip works normally. Moreover,
because there is no protocol modification, there is no problem in
communication between server and client even if the one has a kernel
without SG support.

In the case of vhci supports SG and stub doesn't, because vhci sends
only the total length of the buffer to stub as it did before the
patch applied, stub only needs to allocate the required length of
buffers regardless of whether vhci supports SG or not.

If stub needs to send data buffer to vhci because of IN pipe, stub
also sends only total length of buffer as metadata and then send real
data as vhci does. Then vhci receive data from stub and store it to
the corresponding buffer of SG list entry.

In the case of stub that supports SG, if SG buffer is requested by
vhci, buffer is allocated by sgl_alloc(). However, stub that does
not support SG allocates buffer using only kmalloc(). Therefore, if
vhci supports SG and stub doesn't, stub has to allocate buffer with
kmalloc() as much as the total length of SG buffer which is quite
huge when vhci sends SG request, so it has big overhead in buffer
allocation.

And for the case of stub supports SG and vhci doesn't, since the
USB storage driver checks that vhci doesn't support SG and sends
the request to stub by splitting the SG list into multiple URBs,
stub allocates a buffer with kmalloc() as it did before this patch.

Therefore, everything works normally in a mismatch situation.
I will send the v3 soon.

Regards
Suwan Kim
