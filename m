Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B179C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4CB20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139731;
	bh=lxqNWmtCEWwxbT8z65OMDeOYqqTkUNoXwIjwqMJtuVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LYlbGBTwNsN/Z08i6J95w3IAFK3qkOIUgtZB2/0Zid649dbvJcKfoQ9rxHf2Rha+v
	 mIRp0upaPvGvuzts9cYNANsKCL1INm5jXri1+xrmmYNOKRBnBhLQHEM8iFSlDnKoGU
	 d0Gp1JDLisFhYDQUsD07fe2TqIJIFDKsh0vNADbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfDAR2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbfDAR2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A302063F;
        Mon,  1 Apr 2019 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139727;
        bh=lxqNWmtCEWwxbT8z65OMDeOYqqTkUNoXwIjwqMJtuVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvICA7wr+yo6/1aVsC3Cf9RDqKWcu82uoVcHV5b42HfJizngDLMvTAhkIkfWGMptZ
         e0ciADnTZAX/9AsBbpE2VPicCvJ+t2iIqmwzRfIukLVenDXCXx6TMNLY+Ju/8ZW+ac
         VoQSNbNGHDYmWBLkrmzIT99FKVbHymsbOmYjbDB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Radoslav Gerganov <rgerganov@vmware.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 53/56] USB: gadget: f_hid: fix deadlock in f_hidg_write()
Date:   Mon,  1 Apr 2019 19:03:09 +0200
Message-Id: <20190401170106.784441663@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radoslav Gerganov <rgerganov@vmware.com>

commit 072684e8c58d17e853f8e8b9f6d9ce2e58d2b036 upstream.

In f_hidg_write() the write_spinlock is acquired before calling
usb_ep_queue() which causes a deadlock when dummy_hcd is being used.
This is because dummy_queue() callbacks into f_hidg_req_complete() which
tries to acquire the same spinlock. This is (part of) the backtrace when
the deadlock occurs:

  0xffffffffc06b1410 in f_hidg_req_complete
  0xffffffffc06a590a in usb_gadget_giveback_request
  0xffffffffc06cfff2 in dummy_queue
  0xffffffffc06a4b96 in usb_ep_queue
  0xffffffffc06b1eb6 in f_hidg_write
  0xffffffff8127730b in __vfs_write
  0xffffffff812774d1 in vfs_write
  0xffffffff81277725 in SYSC_write

Fix this by releasing the write_spinlock before calling usb_ep_queue()

Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Tested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org # 4.11+
Fixes: 749494b6bdbb ("usb: gadget: f_hid: fix: Move IN request allocation to set_alt()")
Signed-off-by: Radoslav Gerganov <rgerganov@vmware.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_hid.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -340,20 +340,20 @@ try_again:
 	req->complete = f_hidg_req_complete;
 	req->context  = hidg;
 
+	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
+
 	status = usb_ep_queue(hidg->in_ep, hidg->req, GFP_ATOMIC);
 	if (status < 0) {
 		ERROR(hidg->func.config->cdev,
 			"usb_ep_queue error on int endpoint %zd\n", status);
-		goto release_write_pending_unlocked;
+		goto release_write_pending;
 	} else {
 		status = count;
 	}
-	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 
 	return status;
 release_write_pending:
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
-release_write_pending_unlocked:
 	hidg->write_pending = 0;
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
 


