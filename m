Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F23C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E40520840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDAOn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:43:26 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44340 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726617AbfDAOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:43:25 -0400
Received: (qmail 3078 invoked by uid 2102); 1 Apr 2019 10:43:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Apr 2019 10:43:24 -0400
Date:   Mon, 1 Apr 2019 10:43:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     mathias.nyman@linux.intel.com, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: host: xhci: Support running urb giveback in
 tasklet context
In-Reply-To: <20190401141611.10087-1-suwan.kim027@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904011040570.1506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019, Suwan Kim wrote:

> Patch "USB: HCD: support giveback of URB in tasklet context"[1]
> introduced giveback of urb in tasklet context. [1] This patch was
> applied to ehci but not xhci. [2] This patch significantly reduces
> the hard irq time of xhci. Especially for uvc driver, the hard irq
> including the uvc completion function runs quite long but applying
> this patch reduces the hard irq time of xhci.

Please read the kerneldoc for usb_submit_urb() and usb_kill_urb(), in 
particular, the parts that describe how isochronous URBs are treated.  
Can you guarantee that with this patch applied, xhci-hcd will continue 
to work as the kerneldoc describes?

Alan Stern

