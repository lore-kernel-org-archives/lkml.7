Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8209CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589DB20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfDOPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:18:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39390 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726522AbfDOPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:18:31 -0400
Received: (qmail 4942 invoked by uid 2102); 15 Apr 2019 11:18:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Apr 2019 11:18:30 -0400
Date:   Mon, 15 Apr 2019 11:18:30 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kento.A.Kobayashi@sony.com
cc:     bvanassche@acm.org, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>, <oneukum@suse.com>,
        <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>, <Jacky.Cao@sony.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: uas: fix usb subsystem hang after power off hub
 port
In-Reply-To: <AE5419EAB4965843B3C0C1FE29F1FFE5899C80@JPYOKXMS103.jp.sony.com>
Message-ID: <Pine.LNX.4.44L0.1904151107350.1575-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 Kento.A.Kobayashi@sony.com wrote:

> Hi
> 
> >The unbind happens from inside the SCSI EH callback.  If that really is not allowed, we'll need to change it.  Or we can just change it regardless, since the effort required is pretty small.
> >
> >Kento, please try the patch below.  Does it help with your problem?
> 
> Thank you for suggestion about this problem.
> I confirmed your patch fixes this problem.

Good; I will submit it.

> I think you change policy for error handler to not calling unbind, right?

That's right.

> In addition, I have a question about this patch.
> Could you please tell me why it should not be allowed that the unbind is occurred from eh callback?

The SCSI core does not handle unbind properly when it occurs inside an 
error handler callback.  If you want to know more about why the SCSI 
core behaves this way, you should ask the SCSI developers -- I don't 
know the answer.

> This patch will ignore all error which is returned from usb_reset_and_verify_device.
> But my patch will ignore error only being returned ENODEV case.
> I think side effect of your patch is bigger than my patch.

The only other errors that usb_reset_and_verify_device() can return are 
EINVAL and EISDIR.  These error codes occur in three situations:

	The device has already been disconnected;

	The device has no parent hub (it is a root hub);

	The device is currently suspended.

The first situation is just as bad as -ENODEV.  The second cannot
happen for a USB mass storage device.  The third can happen only if an
error occurs when usb_reset_device() tries to carry out a resume, and
that's also just as bad as -ENODEV.

So although the side effects are larger than with your patch, they are 
not any worse.  Furthermore, they handle correctly some situations that 
your patch does not handle.

> So I want to know why the unbind is occurred from eh callback should not be allowed.

Ask the SCSI developers.

Alan Stern

