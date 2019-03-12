Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A997C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D75A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414267;
	bh=w2Xxlh68/zivV7wNzMNtqyFnpEkid43RAbfolX9YNmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQeC3Ji5mx4SX9ACi3m7u7afyTDEHSPFslW+AmH2ZHoOusROBcKfKxpQDodGWEUaz
	 PDRu7AyaajMYeNTavrnXjo0d1+kkM8gnQY/GGwzj9nDzAMuFR7dXgQ4H8YNsltEaF+
	 l0JY8tP2hvPmQm4g4iEHY6UFJTwL8+tgflMMA9+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfCLRLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfCLRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:40 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E339217F5;
        Tue, 12 Mar 2019 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410699;
        bh=w2Xxlh68/zivV7wNzMNtqyFnpEkid43RAbfolX9YNmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdJYq74ZGjN7NLyymcrayWVF07MaUBK5xhVZnyRT6kncIMAFKBpLQHxqaXmIUNv4L
         ohXLNlOLNmyAVNWyk2hx2TnsDB6OOsAJKSMIvyPpnevFJyKhC/YdQ9P/hi2Jun1rEa
         l4Gv2jZTJz8sXw+9h29cv7skGbtIUsGSIh/VOMe0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Alistair Strachan <astrachan@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 001/171] media: uvcvideo: Fix type check leading to overflow
Date:   Tue, 12 Mar 2019 10:06:21 -0700
Message-Id: <20190312170347.997250075@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alistair Strachan <astrachan@google.com>

commit 47bb117911b051bbc90764a8bff96543cbd2005f upstream.

When initially testing the Camera Terminal Descriptor wTerminalType
field (buffer[4]), no mask is used. Later in the function, the MSB is
overloaded to store the descriptor subtype, and so a mask of 0x7fff
is used to check the type.

If a descriptor is specially crafted to set this overloaded bit in the
original wTerminalType field, the initial type check will fail (falling
through, without adjusting the buffer size), but the later type checks
will pass, assuming the buffer has been made suitably large, causing an
overflow.

Avoid this problem by checking for the MSB in the wTerminalType field.
If the bit is set, assume the descriptor is bad, and abort parsing it.

Originally reported here:
https://groups.google.com/forum/#!topic/syzkaller/Ot1fOE6v1d8
A similar (non-compiling) patch was provided at that time.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_driver.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1065,11 +1065,19 @@ static int uvc_parse_standard_control(st
 			return -EINVAL;
 		}
 
-		/* Make sure the terminal type MSB is not null, otherwise it
-		 * could be confused with a unit.
+		/*
+		 * Reject invalid terminal types that would cause issues:
+		 *
+		 * - The high byte must be non-zero, otherwise it would be
+		 *   confused with a unit.
+		 *
+		 * - Bit 15 must be 0, as we use it internally as a terminal
+		 *   direction flag.
+		 *
+		 * Other unknown types are accepted.
 		 */
 		type = get_unaligned_le16(&buffer[4]);
-		if ((type & 0xff00) == 0) {
+		if ((type & 0x7f00) == 0 || (type & 0x8000) != 0) {
 			uvc_trace(UVC_TRACE_DESCR, "device %d videocontrol "
 				"interface %d INPUT_TERMINAL %d has invalid "
 				"type 0x%04x, skipping\n", udev->devnum,


