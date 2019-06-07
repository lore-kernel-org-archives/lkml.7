Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12566C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DBD20840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922681;
	bh=CEg1spDROT8I4kU1zXMKX9TQSs6MvE3Zy6f+1mgUizM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMA9vxl4b6W/rv7Eq9N6YXNfb3/wZI0b90NDKAvWKbsm4rm0GUu6nft3+FY+cyIQA
	 V5U2t6y7kAqy1IN3gzCfXVoe0dArcq991bfCnnm3oAEEBubQcMKwGntiKpuKVdl2O7
	 qmubLqk8eL1V47GMk2nHniBnbsamDAuwbqTh/TXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfFGPuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732204AbfFGPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:50:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E5321473;
        Fri,  7 Jun 2019 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922643;
        bh=CEg1spDROT8I4kU1zXMKX9TQSs6MvE3Zy6f+1mgUizM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAGuFe/zEgJD3F8/ZI9hEiVonZl9voUBn84HpIlyX1/QPJFuJwbuXCjDmTIj5gN42
         hh3SL9IH5D5jdiSJMlZheEwOfTajdW19P0KEI6pk51kaQ7tzzjF2hYrRNcM4SUNQZZ
         Vqtfz7/rbc5ixuVoq6f3SuCj9YYa4eW2Koeuj+7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Collier <osdevtc@gmail.com>
Subject: [PATCH 5.1 66/85] staging: wlan-ng: fix adapter initialization failure
Date:   Fri,  7 Jun 2019 17:39:51 +0200
Message-Id: <20190607153856.591661914@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Collier <osdevtc@gmail.com>

commit a67fedd788182764dc8ed59037c604b7e60349f1 upstream.

Commit e895f00a8496 ("Staging: wlan-ng: hfa384x_usb.c Fixed too long
code line warnings.") moved the retrieval of the transfer buffer from
the URB from the top of function hfa384x_usbin_callback to a point
after reposting of the URB via a call to submit_rx_urb. The reposting
of the URB allocates a new transfer buffer so the new buffer is
retrieved instead of the buffer containing the response passed into
the callback. This results in failure to initialize the adapter with
an error reported in the system log (something like "CTLX[1] error:
state(Request failed)").

This change moves the retrieval to just before the point where the URB
is reposted so that the correct transfer buffer is retrieved and
initialization of the device succeeds.

Signed-off-by: Tim Collier <osdevtc@gmail.com>
Fixes: e895f00a8496 ("Staging: wlan-ng: hfa384x_usb.c Fixed too long code line warnings.")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wlan-ng/hfa384x_usb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -3119,7 +3119,9 @@ static void hfa384x_usbin_callback(struc
 		break;
 	}
 
+	/* Save values from the RX URB before reposting overwrites it. */
 	urb_status = urb->status;
+	usbin = (union hfa384x_usbin *)urb->transfer_buffer;
 
 	if (action != ABORT) {
 		/* Repost the RX URB */
@@ -3136,7 +3138,6 @@ static void hfa384x_usbin_callback(struc
 	/* Note: the check of the sw_support field, the type field doesn't
 	 *       have bit 12 set like the docs suggest.
 	 */
-	usbin = (union hfa384x_usbin *)urb->transfer_buffer;
 	type = le16_to_cpu(usbin->type);
 	if (HFA384x_USB_ISRXFRM(type)) {
 		if (action == HANDLE) {


