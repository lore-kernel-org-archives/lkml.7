Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8657EC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EB6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414276;
	bh=bKiqyoYmGVvV5lzX/aq/3CU7xQ9T9ZPyHBc6dc9MhRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ErhykZyLXoxOlWeJZyHY3J3OzEs4Zh89XMh6xF0iyWhfCszf1mPTrSPcc25/z7xUa
	 CZqDcTVWJIPLKC+t42+ahhaFwoMT1Uwi6J3mqV7TJBjOZyJ+Q3Hgf3kmx8kNV/ILtV
	 jfS0d+nRWcyCLUrcHtUlJU3cb42K6VjK9rqmW9nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfCLRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfCLRLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:34 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B9521841;
        Tue, 12 Mar 2019 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410693;
        bh=bKiqyoYmGVvV5lzX/aq/3CU7xQ9T9ZPyHBc6dc9MhRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgbWpzDh7Xsc85Teepno+OdgPb20wws8N6PcDGGti6/gee9fLk4MLb9040bhLdMOY
         0vqiFQ3jobc08DuUCPdyIIFii4ZhUDN8z+SlPZUamxI4zux4cwnZnfPaR4tCVc5wmZ
         6a8qfzy6mt2C/xRD0xFAUCcjccFdfom5SAoWo6nk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Alistair Strachan <astrachan@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 01/25] media: uvcvideo: Fix type check leading to overflow
Date:   Tue, 12 Mar 2019 10:08:39 -0700
Message-Id: <20190312170403.731808196@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1106,11 +1106,19 @@ static int uvc_parse_standard_control(st
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


