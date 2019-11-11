Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07CDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8B121655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497480;
	bh=c4RuBJhyzM3zyLNU5pk/iyhEZ9dtvngZ2jD3A35UNrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AJwIk5uwOogXbeLS+bGsLTuGhnK6L+Wz85UBOzm2r3B9b91mql63jcDYGCUaHNkgs
	 1UlotixWGLFXqZAuTjfcD+cSopxeBCcge1xhtIgwsr/3xuzSS4LbXwrAxkljZSsmry
	 odJG06NGYqgu0A225gSgw7M9EwMGWgFbU48vvl6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfKKSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfKKShu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:37:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38975214E0;
        Mon, 11 Nov 2019 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497469;
        bh=c4RuBJhyzM3zyLNU5pk/iyhEZ9dtvngZ2jD3A35UNrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MopxoB3N4svQKlpzZvo+rk6X20cDa+GHbswzP1iikChhc1ErXW6yGpa83Kf9QTYRT
         7qMJRli27tdyH02UfVEEdH/MIAbaWyoKbdAUI1UCl0UQiWq9h+q8g3JBytO8r//EO1
         9Dn3nia+qMOsQ+Kp9fhUQ7LdnU+T7F03PA4uDovY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 4.14 065/105] usbip: Fix vhci_urb_enqueue() URB null transfer buffer error path
Date:   Mon, 11 Nov 2019 19:28:35 +0100
Message-Id: <20191111181445.305954541@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

commit 2c904963b1dd2acd4bc785b6c72e10a6283c2081 upstream.

Fix vhci_urb_enqueue() to print debug msg and return error instead of
failing with BUG_ON.

Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_hcd.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -716,8 +716,10 @@ static int vhci_urb_enqueue(struct usb_h
 	}
 	vdev = &vhci_hcd->vdev[portnum-1];
 
-	/* patch to usb_sg_init() is in 2.5.60 */
-	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
+	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
+		dev_dbg(dev, "Null URB transfer buffer\n");
+		return -EINVAL;
+	}
 
 	spin_lock_irqsave(&vhci->lock, flags);
 


