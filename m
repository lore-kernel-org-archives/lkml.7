Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1442CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E64207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640412;
	bh=889MMMOWTKQC9eo1k1KV2liBOhBAgfC465dHDg30NuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S05aSKuailNEh2j6PiQ9xYl3ON1y0lytrNoVo4ApF8fLvJ/RPhvjw9vzC6tbzYxx+
	 RbapjiQIjf+UmcKZB6AYt3W+fLTCdsZX37kRI3rVB18rGkH9k3w+tadyi6bv2xv8vw
	 aSRcxNWxzGAPj6zK87kWmTj8oATIwvNynZRWy7LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfL2R0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbfL2R0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:26:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA34207FD;
        Sun, 29 Dec 2019 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640406;
        bh=889MMMOWTKQC9eo1k1KV2liBOhBAgfC465dHDg30NuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvuz4BJnHSSjAgcAQBDG6Rsped6bZKVYtogWYy8auf8sh476Fyha2c2y4LhKtUGok
         IfvCGgO4h+bqNrIpVG++tXO5T6jx+G9KBla5TJod14bmRUWm+lnYqJvVnGSWLVHb6B
         FkzgqrKqjqiE1xjbfPR/aHGgKb5WbLw38bSJQV6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 4.14 145/161] usbip: Fix error path of vhci_recv_ret_submit()
Date:   Sun, 29 Dec 2019 18:19:53 +0100
Message-Id: <20191229162444.171925711@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suwan Kim <suwan.kim027@gmail.com>

commit aabb5b833872524eaf28f52187e5987984982264 upstream.

If a transaction error happens in vhci_recv_ret_submit(), event
handler closes connection and changes port status to kick hub_event.
Then hub tries to flush the endpoint URBs, but that causes infinite
loop between usb_hub_flush_endpoint() and vhci_urb_dequeue() because
"vhci_priv" in vhci_urb_dequeue() was already released by
vhci_recv_ret_submit() before a transmission error occurred. Thus,
vhci_urb_dequeue() terminates early and usb_hub_flush_endpoint()
continuously calls vhci_urb_dequeue().

The root cause of this issue is that vhci_recv_ret_submit()
terminates early without giving back URB when transaction error
occurs in vhci_recv_ret_submit(). That causes the error URB to still
be linked at endpoint list without “vhci_priv".

So, in the case of transaction error in vhci_recv_ret_submit(),
unlink URB from the endpoint, insert proper error code in
urb->status and give back URB.

Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20191213023055.19933-3-suwan.kim027@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vhci_rx.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -91,16 +91,21 @@ static void vhci_recv_ret_submit(struct
 	usbip_pack_pdu(pdu, urb, USBIP_RET_SUBMIT, 0);
 
 	/* recv transfer buffer */
-	if (usbip_recv_xbuff(ud, urb) < 0)
-		return;
+	if (usbip_recv_xbuff(ud, urb) < 0) {
+		urb->status = -EPROTO;
+		goto error;
+	}
 
 	/* recv iso_packet_descriptor */
-	if (usbip_recv_iso(ud, urb) < 0)
-		return;
+	if (usbip_recv_iso(ud, urb) < 0) {
+		urb->status = -EPROTO;
+		goto error;
+	}
 
 	/* restore the padding in iso packets */
 	usbip_pad_iso(ud, urb);
 
+error:
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
 


