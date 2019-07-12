Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F5C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0573F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934788;
	bh=kkrwADmsFdGw9iAWHFHMsOpjY/8rQPkoENMN+/bHssM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0rgpYd90ykBBY5lerIa2Ue64cnyFGK/srhGl5YkSiVHl1RMJAW9StFHNFrPvXoXm
	 OX1CeEKKBkFXrkW7k5HBB3KjF5D/Hbl+2xYjOs7I99l5rtZgFo8hnOwZaU7O6mv01O
	 I90EAqNky8NqyFXPvLG1GEuoYc/T10rawOZBBTwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfGLMdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbfGLMdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:33:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1942084B;
        Fri, 12 Jul 2019 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934782;
        bh=kkrwADmsFdGw9iAWHFHMsOpjY/8rQPkoENMN+/bHssM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=remSjPOWea30y1Fwx9ZqFJRA8B4iiGvTB9lj7vmamFW2VQEd38zFJkBWQiK9BQphP
         Mkim8nuTd+l7cWTSlqDalVpU8PrlM2mQJSZQj0A2w3S3DuETVnK7KinpGv6HbYnO9d
         kKu1zceA4nuUB7t8IcxfX7KV697zOoxCyzTKdLjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kiruthika Varadarajan <Kiruthika.Varadarajan@harman.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 5.2 29/61] usb: gadget: ether: Fix race between gether_disconnect and rx_submit
Date:   Fri, 12 Jul 2019 14:19:42 +0200
Message-Id: <20190712121622.182500408@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
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
@@ -186,11 +186,12 @@ rx_submit(struct eth_dev *dev, struct us
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
@@ -214,6 +215,7 @@ rx_submit(struct eth_dev *dev, struct us
 
 	if (dev->port_usb->is_fixed)
 		size = max_t(size_t, size, dev->port_usb->fixed_out_len);
+	spin_unlock_irqrestore(&dev->lock, flags);
 
 	skb = __netdev_alloc_skb(dev->net, size + NET_IP_ALIGN, gfp_flags);
 	if (skb == NULL) {


