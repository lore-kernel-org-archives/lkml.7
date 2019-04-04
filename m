Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D01206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/MpntVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfDDMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:18:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34351 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:18:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so1108271plt.1;
        Thu, 04 Apr 2019 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ygo6qAOZpsS1ZXFgQUAoNBCqunzSPiYi9KaPbRjaf8=;
        b=G/MpntVS9bbdqZxjHUbZYB9h3nVdR4oxFGoJUgFH8DvTnDF0r328iTfAVDm6xwzZhE
         Ky8gfJsYx5c6Wp61cXmqy4d0saPXxOUQTRMp/dWR0OYYFVKkgbLDl3lv1jP9rbZDjKOf
         cZMviQXDGMqYtEGD7n/zy/Vs4WJpLro/Z7SzRe8nlrvySBCCBkS1BaJbeeswLLHeIxIK
         B8B1W1ReLDZ7A+fG8shfW/cWCsy54tzOngwQdKRqU90PTRY/fOqQCCJSQeDy8VEVl9i5
         QQJIZUXnlOOpciZoIz//bh9rSUFv1hae6RDN+FuIhe3INja5vpRU5kArnMBa3+6Ys0nD
         Clxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ygo6qAOZpsS1ZXFgQUAoNBCqunzSPiYi9KaPbRjaf8=;
        b=BfwPJMlQBrgxuPDhoChJ5omKviMY7Xo+CbHc6CYv5gIKfwg+jDo06NOCj41Z5ttR68
         //XdyDNFAYJ6YPVVLukMiSb3lTdnlOLYh0R3DsNO0ZOZ+283x6UN8DQnezs1V6yZ3uvv
         G03MvAGfwU1kjHM1BzCOKNGa43pajMa9o1mWwsUCR1iBl+ocauqk2o/cHYSU30H+3KFW
         h72QBLJj9xcTo/fBMGx4XC4/oz4zhWEHysWUHqO4tcIRSszlF1MNMzBkBm4i+7BuZ+j0
         hwiQJwKncvvyOmL5wL8M5QU2hwI3Y5wvmbvjK7+eiPNioSSAWeAAl5PvPDgHmFovhFbA
         igUw==
X-Gm-Message-State: APjAAAXHWKJ3H1CmNDx/zrRjdzDf7uW94baVI5Ebn9Xz2rrJ5ZYGOBNk
        AtGcqH0OA4dKVPvp0ru80TvbwAWV
X-Google-Smtp-Source: APXvYqz3lSYUTKwJMmrLhVn9/jqfrHptkUHR0DUXGePlQ2Cp9C0tZz3yjJ/b+4SJWyxE/AqYuMjeLg==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr6214431plr.288.1554380309706;
        Thu, 04 Apr 2019 05:18:29 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id o5sm65505287pfa.135.2019.04.04.05.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 05:18:29 -0700 (PDT)
Date:   Thu, 4 Apr 2019 21:18:24 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
Message-ID: <20190404121823.GA3793@localhost.localdomain>
References: <20190401141611.10087-1-suwan.kim027@gmail.com>
 <Pine.LNX.4.44L0.1904011040570.1506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904011040570.1506-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, Apr 01, 2019 at 10:43:24AM -0400, Alan Stern wrote:
> On Mon, 1 Apr 2019, Suwan Kim wrote:
> 
> > Patch "USB: HCD: support giveback of URB in tasklet context"[1]
> > introduced giveback of urb in tasklet context. [1] This patch was
> > applied to ehci but not xhci. [2] This patch significantly reduces
> > the hard irq time of xhci. Especially for uvc driver, the hard irq
> > including the uvc completion function runs quite long but applying
> > this patch reduces the hard irq time of xhci.
> 
> Please read the kerneldoc for usb_submit_urb() and usb_kill_urb(), in 
> particular, the parts that describe how isochronous URBs are treated.  
> Can you guarantee that with this patch applied, xhci-hcd will continue 
> to work as the kerneldoc describes?
> 

I read the description of usb_submit_urb() and usb_kill_urb() and i
think that xhci-hcd with which this patch is applied works as the
description of usb_submit_urb() and usb_kill_urb().

In the case of usb_submit_urb(), xhci spec 4.10.3.1 "Ring Overrun and
Underrun" describes the behavior of xhci when an isochronous ring is
empty due to the late URB submission in driver. (In this patch, empty
isochronous ring can happen due to tasklet scheduling delay in URB
complete function which calls the next usb_submit_urb())

According to the xhci spec, xHC deals with a late isochronous URB
according to the SIA(Start Isoch ASAP) flag of TRB and SIA flag is
set according to URB_ISO_ASAP flag in xhci_queue_isoc_tx().

If the SIA flag is set, xHC will schedule the late isochronous URB in
the next "Endpoint Service Interval Time" (next available frame) and
transmits ischronous URB in that frame.

If the SIA flag is cleared (URB_ISO_ASAP flag is cleared), xHC generates
"Missed Service Error" event and skips the late isochronous URB and
doen't transmit it. When the interrupt handler (xhci_irq) receives
"Missed Service Error" event, it returns the late isochronous URB to
the driver calling usb_hcd_giveback_urb() with -EXDEV error code in
usb_iso_packet_descriptor->status at skip_isoc_td(). So xhci behavior
about the late isochronous URB in spec and implementation is same
with the description of usb_submit_urb().

In the case of usb_kill_urb(), description says that it waits until
the URB complete function finishes and the important point is that
whether the USB complete function is called early or late doesn't
affect the behavior of usb_kill_urb() because __usb_hcd_giveback_urb()
wakes up usb_kill_urb() after calling URB complete function.
So, pending a URB complete function in tasklet doesn't affect the
behavior of xhci in usb_kill_urb().

Regards

Suwan Kim
