Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F49C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57D821841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCTQwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:52:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33170 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726123AbfCTQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:52:47 -0400
Received: (qmail 4602 invoked by uid 2102); 20 Mar 2019 12:52:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2019 12:52:46 -0400
Date:   Wed, 20 Mar 2019 12:52:46 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     John Stultz <john.stultz@linaro.org>
cc:     fei.yang@intel.com, Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Shen Jing <jingx.shen@intel.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
In-Reply-To: <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1903201247570.1538-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, John Stultz wrote:

> Hey Fei,
>   So while this patch does resolve the issues I was seeing with
> mainline kernels and recent changes to adbd, Josh pointed out that it
> wouldn't resolve the issues I was seeing with older kernels which is
> slightly different (but still related to aio usage).
> 
> On the older kernels I'm hitting scheduling while atomic on reboot,
> which seems to be due to ffs_aio_cancel() taking a spinlock then
> calling usb_ep_dequeue() which might sleep.
> 
> It seems a fix for this was tried earlier with d52e4d0c0c428 ("usb:
> gadget: ffs: Fix BUG when userland exits with submitted AIO
> transfers") which was then reverted by a9c859033f6e.
> 
> Elsewhere it seems the ffs driver takes effort to drop any locks
> before calling usb_ep_dequeue(), so this seems like that should be
> addressed, but it also seems like recent change to the dwc3 driver has
> been made to avoid sleeping in that path (see fec9095bdef4 ("usb:
> dwc3: gadget: remove wait_end_transfer")), which may be why I'm not
> seeing the problem with mainline (and your patch here, of coarse).
> But that also doesn't clarify if its still a potential issue w/
> non-dwc3 platforms.
> 
> So for older kernels, do you have a suggestion of which approach is
> advised?  Does usb_ep_dequeue need to avoid sleeping or do we need to
> rework the ffs_aio_cancel logic?

usb_ep_dequeue can be called in interrupt context, meaning it is never
allowed to sleep.  This is mentioned in the kerneldoc:

/**
 * usb_ep_dequeue - dequeues (cancels, unlinks) an I/O request from an endpoint
 * @ep:the endpoint associated with the request
 * @req:the request being canceled
 *
 * If the request is still active on the endpoint, it is dequeued and
 * eventually its completion routine is called (with status -ECONNRESET);
 * else a negative error code is returned.  This routine is asynchronous,
 * that is, it may return before the completion routine runs.
 *
 * Note that some hardware can't clear out write fifos (to unlink the request
 * at the head of the queue) except as part of disconnecting from usb. Such
 * restrictions prevent drivers from supporting configuration changes,
 * even to configuration zero (a "chapter 9" requirement).
 *
 * This routine may be called in interrupt context.
 */

Alan Stern

