Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D5FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5FF21852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368671;
	bh=reQXUjy8fFF9zQCtxWBQ2ghm9fVkmVTwYUqM3mhhiEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWqOsRR2Eiw0SduyQmlWaQ7ylRzjIsOAEhG43r3SeaCw0qYFmBoAmGufDEygWt/Dk
	 OkXJlxLkTELvhBFBvpea0RqFz0NOfWq/RNXG5Ec5scKzH7f7t9vU0goYdyoM30b3qc
	 cRlh/O9+12mynJ4auVI/rTb1f7oves2FaswCViFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbfDDJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731973AbfDDJE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04E821850;
        Thu,  4 Apr 2019 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368667;
        bh=reQXUjy8fFF9zQCtxWBQ2ghm9fVkmVTwYUqM3mhhiEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3fLXDDd/YoYbhlWLrdQ6hOsWQz3HzKKwV6FGG+i3/2w+qT2d/xRga0yn2exKiqOw
         OA8AHhEy1ovIS0iwm77aPrGC0UV367NmfB5/b9sQpiVamuZefj6gqj/kdxfzB5W2jd
         y1/b1BV5IfcU/lw3lNQlO+u1a95hxPN0X7fRgUIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Zeng Tao <prime.zeng@hisilicon.com>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Chen Yu <chenyu56@huawei.com>,
        Jerry Zhang <zhangjerry@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/187] usb: f_fs: Avoid crash due to out-of-scope stack ptr access
Date:   Thu,  4 Apr 2019 10:47:26 +0200
Message-Id: <20190404084608.399499069@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



