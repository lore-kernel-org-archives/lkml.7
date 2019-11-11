Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C77C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1B62184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497115;
	bh=sDbQ88zRwfp5BvP0eivR8CU9Yz9Yt9ySGLC79pNDjOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYj6ODWV9ihSoUCp67QBdUCxJ3l+wa1VOp5UKYEIK2TmSxq0qlpBYkBZY9Ugps9II
	 PSGr85oYzaadIRGNyhdC3MkXfCc2kZYf1zt/rplUOSH7Bvmu/2hr6+yYke51cyCZFk
	 MPPOh3c1SW3mO14+Rm6EoRAyGcCNfcGmFcMkC40I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKKSby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfKKSbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:31:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5492D20856;
        Mon, 11 Nov 2019 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497110;
        bh=sDbQ88zRwfp5BvP0eivR8CU9Yz9Yt9ySGLC79pNDjOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sayiC09kG1DMe1NrFjrOrTbe8+gmOzdR00zW5aTLiRdwbvOEQk9ml5OTbO3Hg4GqS
         WdND9IuXIYcv/i56Wv2tsJL8WiiFvyooTg1o8IEBxHI8MxuiVR69g/Vzyl/QfyT6T9
         1m9G74riBuezSLgYwp+mSp41ZbuqVwYpandMZk7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+0631d878823ce2411636@syzkaller.appspotmail.com
Subject: [PATCH 4.4 01/43] CDC-NCM: handle incomplete transfer of MTU
Date:   Mon, 11 Nov 2019 19:28:15 +0100
Message-Id: <20191111181249.280728992@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 332f989a3b0041b810836c5c3747e59aad7e9d0b ]

A malicious device may give half an answer when asked
for its MTU. The driver will proceed after this with
a garbage MTU. Anything but a complete answer must be treated
as an error.

V2: used sizeof as request by Alexander

Reported-and-tested-by: syzbot+0631d878823ce2411636@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -533,8 +533,8 @@ static void cdc_ncm_set_dgram_size(struc
 	/* read current mtu value from device */
 	err = usbnet_read_cmd(dev, USB_CDC_GET_MAX_DATAGRAM_SIZE,
 			      USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
-			      0, iface_no, &max_datagram_size, 2);
-	if (err < 0) {
+			      0, iface_no, &max_datagram_size, sizeof(max_datagram_size));
+	if (err < sizeof(max_datagram_size)) {
 		dev_dbg(&dev->intf->dev, "GET_MAX_DATAGRAM_SIZE failed\n");
 		goto out;
 	}
@@ -545,7 +545,7 @@ static void cdc_ncm_set_dgram_size(struc
 	max_datagram_size = cpu_to_le16(ctx->max_datagram_size);
 	err = usbnet_write_cmd(dev, USB_CDC_SET_MAX_DATAGRAM_SIZE,
 			       USB_TYPE_CLASS | USB_DIR_OUT | USB_RECIP_INTERFACE,
-			       0, iface_no, &max_datagram_size, 2);
+			       0, iface_no, &max_datagram_size, sizeof(max_datagram_size));
 	if (err < 0)
 		dev_dbg(&dev->intf->dev, "SET_MAX_DATAGRAM_SIZE failed\n");
 


