Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C72C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B182176D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888993;
	bh=u1csPlVEfQUnMjHvNXx4OmNGhAz9+OVPfxVfdGG03Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFD5r19tgSfUh84gUUDC19D1gm3hQZiPyyUlPatneTLvjrVuxIa+Aw/9wNVOaKeSL
	 06M3SO35LcvxMJ12O4cd/UF+BhXPWSNzOERXqy/0Mtd17el+dU+Wzr319OwU6AWpYK
	 ekNG7FSFzY7/e67tixhXTLV2Q87Syi8mhTlyZv9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbfK0VJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732932AbfK0VJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:09:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F44D2154A;
        Wed, 27 Nov 2019 21:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888988;
        bh=u1csPlVEfQUnMjHvNXx4OmNGhAz9+OVPfxVfdGG03Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CujEas5bHANZktUexxTr307KvXe5PNeAL272XrUKOEQAEioNry1DPWBTJf5/p241u
         gioZ/1mrZu/e1kdzzyKbhqP7y4JY3yIOhD0Yqrv37ONJsKzLXA1Ejo1aH7soo7Jx+8
         1/MHjKP3cEypTi6nqC6ZMONrUJoVw8FoqulSiQ1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.3 39/95] ath10k: Fix a NULL-ptr-deref bug in ath10k_usb_alloc_urb_from_pipe
Date:   Wed, 27 Nov 2019 21:31:56 +0100
Message-Id: <20191127202904.566910219@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Peng <benquike@gmail.com>

commit bfd6e6e6c5d2ee43a3d9902b36e01fc7527ebb27 upstream.

The `ar_usb` field of `ath10k_usb_pipe_usb_pipe` objects
are initialized to point to the containing `ath10k_usb` object
according to endpoint descriptors read from the device side, as shown
below in `ath10k_usb_setup_pipe_resources`:

for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
        endpoint = &iface_desc->endpoint[i].desc;

        // get the address from endpoint descriptor
        pipe_num = ath10k_usb_get_logical_pipe_num(ar_usb,
                                                endpoint->bEndpointAddress,
                                                &urbcount);
        ......
        // select the pipe object
        pipe = &ar_usb->pipes[pipe_num];

        // initialize the ar_usb field
        pipe->ar_usb = ar_usb;
}

The driver assumes that the addresses reported in endpoint
descriptors from device side  to be complete. If a device is
malicious and does not report complete addresses, it may trigger
NULL-ptr-deref `ath10k_usb_alloc_urb_from_pipe` and
`ath10k_usb_free_urb_to_pipe`.

This patch fixes the bug by preventing potential NULL-ptr-deref.

Signed-off-by: Hui Peng <benquike@gmail.com>
Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[groeck: Add driver tag to subject, fix build warning]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/usb.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -38,6 +38,10 @@ ath10k_usb_alloc_urb_from_pipe(struct at
 	struct ath10k_urb_context *urb_context = NULL;
 	unsigned long flags;
 
+	/* bail if this pipe is not initialized */
+	if (!pipe->ar_usb)
+		return NULL;
+
 	spin_lock_irqsave(&pipe->ar_usb->cs_lock, flags);
 	if (!list_empty(&pipe->urb_list_head)) {
 		urb_context = list_first_entry(&pipe->urb_list_head,
@@ -55,6 +59,10 @@ static void ath10k_usb_free_urb_to_pipe(
 {
 	unsigned long flags;
 
+	/* bail if this pipe is not initialized */
+	if (!pipe->ar_usb)
+		return;
+
 	spin_lock_irqsave(&pipe->ar_usb->cs_lock, flags);
 
 	pipe->urb_cnt++;


