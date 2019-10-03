Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF88C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524821848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118997;
	bh=zBya74pRYDPzIK4cQdHPpJIitnD/nPJtdMLpRb7hGTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xlNKorZl3rB95xTwM1ITmNO90FYDuOQNIDwfyf8IlwgB3HOkHmjW5xnLwhTDlr2UI
	 0OC3tm9SJSJCnY7zAxHQ2LESPTxjE5LmDrF1z40+pY+8DiVDHiA4ahzBTWMBC0uIRN
	 Ij9blrUIvnJS+gw7J46ggl2locxAXKqc6bI4IziQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfJCQJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfJCQJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:09:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AF421783;
        Thu,  3 Oct 2019 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118991;
        bh=zBya74pRYDPzIK4cQdHPpJIitnD/nPJtdMLpRb7hGTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0svhtiM0tjQlmSMgcfpGsQwsgNLpPQElwOoEyb0ASb7nHAaHGPZOBnqXql667WXR9
         xvMoI0U77MF+9UWwuiLCt5oi8cSqBe5JZQlELcR3kL7qlu3na3H0mhOKeQXScZT9zy
         cK0xOYZjfM4xG/Y9vRHzWDSNnUxO23+kD3yaP7Pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 046/185] usbnet: sanity checking of packet sizes and device mtu
Date:   Thu,  3 Oct 2019 17:52:04 +0200
Message-Id: <20191003154448.257669170@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 280ceaed79f18db930c0cc8bb21f6493490bf29c ]

After a reset packet sizes and device mtu can change and need
to be reevaluated to calculate queue sizes.
Malicious devices can set this to zero and we divide by it.
Introduce sanity checking.

Reported-and-tested-by:  syzbot+6102c120be558c885f04@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/usbnet.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -356,6 +356,8 @@ void usbnet_update_max_qlen(struct usbne
 {
 	enum usb_device_speed speed = dev->udev->speed;
 
+	if (!dev->rx_urb_size || !dev->hard_mtu)
+		goto insanity;
 	switch (speed) {
 	case USB_SPEED_HIGH:
 		dev->rx_qlen = MAX_QUEUE_MEMORY / dev->rx_urb_size;
@@ -372,6 +374,7 @@ void usbnet_update_max_qlen(struct usbne
 		dev->tx_qlen = 5 * MAX_QUEUE_MEMORY / dev->hard_mtu;
 		break;
 	default:
+insanity:
 		dev->rx_qlen = dev->tx_qlen = 4;
 	}
 }


