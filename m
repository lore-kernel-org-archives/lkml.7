Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D9FC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C592173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419834;
	bh=itg0pRBq/p3azo6nmW418GBxQc+VG7W3lq2wVKW9NnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JiM5NpHNGTVsJh+BuR0Lm/9W7fVHLgdiRlFv78BAmmbirOu+PWbqfZCrxaYHiO9qx
	 N8QL3VOxUtZkJIP6f23Z9U+tjxvkmoAp92Q52M07wTL7wzK1GmPymWiXuX6OpGGJz+
	 1oAAXR0MOVQsfUqJstB3QWfvY4b3zFZ5pWfzxXkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391924AbfGRDRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403761AbfGRDOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:44 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8549A2077C;
        Thu, 18 Jul 2019 03:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419683;
        bh=itg0pRBq/p3azo6nmW418GBxQc+VG7W3lq2wVKW9NnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLOI3EBEXIENbcn0+ATg2Jzz3Yz9GuQOQsqmIYot/eJjtFsgAwJ5GxC4iOKpuLD8q
         Ifv+CtWSzFuiatuYkiRBqw273L/T+PLZBJgMRsvInw5sJmllp4cjXyVgBrzAxtUifr
         VxO5iWjzIyAgBzuUfO+x8OXZe8yIw8Ma+iNH5v1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kiruthika Varadarajan <Kiruthika.Varadarajan@harman.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 21/40] usb: gadget: ether: Fix race between gether_disconnect and rx_submit
Date:   Thu, 18 Jul 2019 12:02:17 +0900
Message-Id: <20190718030047.194518068@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030039.676518610@linuxfoundation.org>
References: <20190718030039.676518610@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kiruthika Varadarajan <Kiruthika.Varadarajan@harman.com>

commit d29fcf7078bc8be2b6366cbd4418265b53c94fac upstream.

On spin lock release in rx_submit, gether_disconnect get a chance to
run, it makes port_usb NULL, rx_submit access NULL port USB, hence null
pointer crash.

Fixed by releasing the lock in rx_submit after port_usb is used.

Fixes: 2b3d942c4878 ("usb ethernet gadget: split out network core")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kiruthika Varadarajan <Kiruthika.Varadarajan@harman.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/u_ether.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -207,11 +207,12 @@ rx_submit(struct eth_dev *dev, struct us
 		out = dev->port_usb->out_ep;
 	else
 		out = NULL;
-	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (!out)
+	{
+		spin_unlock_irqrestore(&dev->lock, flags);
 		return -ENOTCONN;
-
+	}
 
 	/* Padding up to RX_EXTRA handles minor disagreements with host.
 	 * Normally we use the USB "terminate on short read" convention;
@@ -232,6 +233,7 @@ rx_submit(struct eth_dev *dev, struct us
 
 	if (dev->port_usb->is_fixed)
 		size = max_t(size_t, size, dev->port_usb->fixed_out_len);
+	spin_unlock_irqrestore(&dev->lock, flags);
 
 	skb = alloc_skb(size + NET_IP_ALIGN, gfp_flags);
 	if (skb == NULL) {


