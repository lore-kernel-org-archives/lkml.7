Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78732ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBD520872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263471;
	bh=Ps6NmP/D8fXdxR8ZOVo76LcBO9W4BYztQcwG3GJzoT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuMbP/n1wv8DsQ4D7YK8pFBbgmF/3LRlLsf5wq/A4ite/Ow/2sJ2cCd5ZAPplLqzu
	 r1/b+AyCmoQssUFVoEJpbsBFhBRgl38Y9R0th26//3Anol2l9RmqorWs6MIsVkNnlV
	 nQN9d0ps6OMfnkM8t09jmChm7ADAnV75Pr0V4GHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438380AbfJPV7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391450AbfJPV6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:12 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 148F121D7C;
        Wed, 16 Oct 2019 21:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263091;
        bh=Ps6NmP/D8fXdxR8ZOVo76LcBO9W4BYztQcwG3GJzoT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mv5KpKqDv1R4K/N82A5Db61Gp1s0m6cJW7AZB9YiYcAwgTFxA7JBY7Qo7gyvUXlJc
         g6m5uPAFm4vUOzMpcupFNRjB01PZlD3BhzGXdAppEUrLzg7OiSe/VKBdo3AOPS5WQc
         jU0plV7YhYGYEXy3E3R/UibcE6lePlUOvKr5th7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Torez Smith <torez@redhat.com>,
        Bill Kuzeja <william.kuzeja@stratus.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.3 012/112] xhci: Prevent deadlock when xhci adapter breaks during init
Date:   Wed, 16 Oct 2019 14:50:04 -0700
Message-Id: <20191016214847.128250484@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Kuzeja <William.Kuzeja@stratus.com>

commit 8de66b0e6a56ff10dd00d2b0f2ae52e300178587 upstream.

The system can hit a deadlock if an xhci adapter breaks while initializing.
The deadlock is between two threads: thread 1 is tearing down the
adapter and is stuck in usb_unlocked_disable_lpm waiting to lock the
hcd->handwidth_mutex. Thread 2 is holding this mutex (while still trying
to add a usb device), but is stuck in xhci_endpoint_reset waiting for a
stop or config command to complete. A reboot is required to resolve.

It turns out when calling xhci_queue_stop_endpoint and
xhci_queue_configure_endpoint in xhci_endpoint_reset, the return code is
not checked for errors. If the timing is right and the adapter dies just
before either of these commands get issued, we hang indefinitely waiting
for a completion on a command that didn't get issued.

This wasn't a problem before the following fix because we didn't send
commands in xhci_endpoint_reset:

commit f5249461b504 ("xhci: Clear the host side toggle manually when
    endpoint is soft reset")

With the patch I am submitting, a duration test which breaks adapters
during initialization (and which deadlocks with the standard kernel) runs
without issue.

Fixes: f5249461b504 ("xhci: Clear the host side toggle manually when endpoint is soft reset")
Cc: <stable@vger.kernel.org> # v4.17+
Cc: Torez Smith <torez@redhat.com>
Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
Signed-off-by: Torez Smith <torez@redhat.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/1570190373-30684-7-git-send-email-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3095,6 +3095,7 @@ static void xhci_endpoint_reset(struct u
 	unsigned int ep_index;
 	unsigned long flags;
 	u32 ep_flag;
+	int err;
 
 	xhci = hcd_to_xhci(hcd);
 	if (!host_ep->hcpriv)
@@ -3154,7 +3155,17 @@ static void xhci_endpoint_reset(struct u
 		xhci_free_command(xhci, cfg_cmd);
 		goto cleanup;
 	}
-	xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id, ep_index, 0);
+
+	err = xhci_queue_stop_endpoint(xhci, stop_cmd, udev->slot_id,
+					ep_index, 0);
+	if (err < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_free_command(xhci, cfg_cmd);
+		xhci_dbg(xhci, "%s: Failed to queue stop ep command, %d ",
+				__func__, err);
+		goto cleanup;
+	}
+
 	xhci_ring_cmd_db(xhci);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
@@ -3168,8 +3179,16 @@ static void xhci_endpoint_reset(struct u
 					   ctrl_ctx, ep_flag, ep_flag);
 	xhci_endpoint_copy(xhci, cfg_cmd->in_ctx, vdev->out_ctx, ep_index);
 
-	xhci_queue_configure_endpoint(xhci, cfg_cmd, cfg_cmd->in_ctx->dma,
+	err = xhci_queue_configure_endpoint(xhci, cfg_cmd, cfg_cmd->in_ctx->dma,
 				      udev->slot_id, false);
+	if (err < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		xhci_free_command(xhci, cfg_cmd);
+		xhci_dbg(xhci, "%s: Failed to queue config ep command, %d ",
+				__func__, err);
+		goto cleanup;
+	}
+
 	xhci_ring_cmd_db(xhci);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 


