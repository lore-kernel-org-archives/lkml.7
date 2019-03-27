Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7FDC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3A120700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713352;
	bh=a77kpqXoeb+g1/SfDu1TbcRTnSgzK9lqIwAi3XK8eP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XiAq0A2BikOk4bvNAetIDawECZBA/DSaU3iKQpomfI/hDOyZsWEUCcAu5X4y8SS1F
	 dLRZ9pH6IZxAk2rLvyBa9QRcvMXplm4SChC7V+73/W0cB1hT2G8jmGoidRJgDcyiwd
	 ATUK83mGT19J+OAMwyGx+dJ3CJxPrlq+LhCJgpFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfC0SNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388978AbfC0SNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD202184D;
        Wed, 27 Mar 2019 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710422;
        bh=a77kpqXoeb+g1/SfDu1TbcRTnSgzK9lqIwAi3XK8eP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dojKmoMfRkBjP2ldrN+HUAkMAtVE33xxAeksxA5eUbRb2IqVC9Sxh/pFYVgoxtjLB
         rYJ1/gyB3sIWKUFSyEQSaXJ5a5Q9GlxCCDOLhfLJl1VlMfPLOaIJ5RHwg6jRWz1LYx
         dKgyEYol4vDONlAqmUWWeTXOAFqdLK8fTpVav0JQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>,
        Jerry Zhang <zhangjerry@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 111/192] usb: f_fs: Avoid crash due to out-of-scope stack ptr access
Date:   Wed, 27 Mar 2019 14:09:03 -0400
Message-Id: <20190327181025.13507-111-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit 54f64d5c983f939901dacc8cfc0983727c5c742e ]

Since the 5.0 merge window opened, I've been seeing frequent
crashes on suspend and reboot with the trace:

[   36.911170] Unable to handle kernel paging request at virtual address ffffff801153d660
[   36.912769] Unable to handle kernel paging request at virtual address ffffff800004b564
...
[   36.950666] Call trace:
[   36.950670]  queued_spin_lock_slowpath+0x1cc/0x2c8
[   36.950681]  _raw_spin_lock_irqsave+0x64/0x78
[   36.950692]  complete+0x28/0x70
[   36.950703]  ffs_epfile_io_complete+0x3c/0x50
[   36.950713]  usb_gadget_giveback_request+0x34/0x108
[   36.950721]  dwc3_gadget_giveback+0x50/0x68
[   36.950723]  dwc3_thread_interrupt+0x358/0x1488
[   36.950731]  irq_thread_fn+0x30/0x88
[   36.950734]  irq_thread+0x114/0x1b0
[   36.950739]  kthread+0x104/0x130
[   36.950747]  ret_from_fork+0x10/0x1c

I isolated this down to in ffs_epfile_io():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/function/f_fs.c#n1065

Where the completion done is setup on the stack:
  DECLARE_COMPLETION_ONSTACK(done);

Then later we setup a request and queue it, and wait for it:
  if (unlikely(wait_for_completion_interruptible(&done))) {
    /*
    * To avoid race condition with ffs_epfile_io_complete,
    * dequeue the request first then check
    * status. usb_ep_dequeue API should guarantee no race
    * condition with req->complete callback.
    */
    usb_ep_dequeue(ep->ep, req);
    interrupted = ep->status < 0;
  }

The problem is, that we end up being interrupted, dequeue the
request, and exit.

But then the irq triggers and we try calling complete() on the
context pointer which points to now random stack space, which
results in the panic.

Alan Stern pointed out there is a bug here, in that the snippet
above "assumes that usb_ep_dequeue() waits until the request has
been completed." And that:

    wait_for_completion(&done);

Is needed right after the usb_ep_dequeue().

Thus this patch implements that change. With it I no longer see
the crashes on suspend or reboot.

This issue seems to have been uncovered by behavioral changes in
the dwc3 driver in commit fec9095bdef4e ("usb: dwc3: gadget:
remove wait_end_transfer").

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Zeng Tao <prime.zeng@hisilicon.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc: Chen Yu <chenyu56@huawei.com>
Cc: Jerry Zhang <zhangjerry@google.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vincent Pelletier <plr.vincent@gmail.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux USB List <linux-usb@vger.kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 31e8bf3578c8..aa15593a3ac4 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1008,6 +1008,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 			 * condition with req->complete callback.
 			 */
 			usb_ep_dequeue(ep->ep, req);
+			wait_for_completion(&done);
 			interrupted = ep->status < 0;
 		}
 
-- 
2.19.1

