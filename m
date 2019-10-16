Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25458ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5AC21A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263155;
	bh=jlGR3XPRL+NAmC7s4hIpPBFodatK9NRysbSifcG7A+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bj9QLpHH9o993B8uxKq4jegv3SfTuzsglXZGab5RSofSrrblW1phAqUZFLamiyoAy
	 9k7aY6AyrcpTdMUarAwkfOpXW0v6+k2p+sO7J7PTkjQyXJkK+ris4/UjaHDSb79itn
	 NsC8OUNsa5M1bqVQdzvLowMrRbuM5FmCPLlewEHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438434AbfJPV7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438134AbfJPV6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:20 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA90A21A49;
        Wed, 16 Oct 2019 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263100;
        bh=jlGR3XPRL+NAmC7s4hIpPBFodatK9NRysbSifcG7A+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emHK+C+YqfFohFc8xA1/2Pqg3w/FZFFkdfuyWUXOT45zva7jFJVZnZv5Vvbij0JFz
         mF+c/68/bpOhahR4eBu0dn0cKN2YW25wmW6YfLlsSognLWn4Ua4KqkBGm0h9YhuVy4
         2yGUkRVnD6th7RCILkCTgJHn0eY5MqxkNMu1kvGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Tomoki Sekiyama <tomoki.sekiyama@gmail.com>,
        syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
Subject: [PATCH 5.3 003/112] USB: yurex: Dont retry on unexpected errors
Date:   Wed, 16 Oct 2019 14:49:55 -0700
Message-Id: <20191016214844.568394952@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 32a0721c6620b77504916dac0cea8ad497c4878a upstream.

According to Greg KH, it has been generally agreed that when a USB
driver encounters an unknown error (or one it can't handle directly),
it should just give up instead of going into a potentially infinite
retry loop.

The three codes -EPROTO, -EILSEQ, and -ETIME fall into this category.
They can be caused by bus errors such as packet loss or corruption,
attempting to communicate with a disconnected device, or by malicious
firmware.  Nowadays the extent of packet loss or corruption is
negligible, so it should be safe for a driver to give up whenever one
of these errors occurs.

Although the yurex driver handles -EILSEQ errors in this way, it
doesn't do the same for -EPROTO (as discovered by the syzbot fuzzer)
or other unrecognized errors.  This patch adjusts the driver so that
it doesn't log an error message for -EPROTO or -ETIME, and it doesn't
retry after any errors.

Reported-and-tested-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.1909171245410.1590-100000@iolanthe.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/yurex.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -132,6 +132,7 @@ static void yurex_interrupt(struct urb *
 	switch (status) {
 	case 0: /*success*/
 		break;
+	/* The device is terminated or messed up, give up */
 	case -EOVERFLOW:
 		dev_err(&dev->interface->dev,
 			"%s - overflow with length %d, actual length is %d\n",
@@ -140,12 +141,13 @@ static void yurex_interrupt(struct urb *
 	case -ENOENT:
 	case -ESHUTDOWN:
 	case -EILSEQ:
-		/* The device is terminated, clean up */
+	case -EPROTO:
+	case -ETIME:
 		return;
 	default:
 		dev_err(&dev->interface->dev,
 			"%s - unknown status received: %d\n", __func__, status);
-		goto exit;
+		return;
 	}
 
 	/* handle received message */
@@ -177,7 +179,6 @@ static void yurex_interrupt(struct urb *
 		break;
 	}
 
-exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
 	if (retval) {
 		dev_err(&dev->interface->dev, "%s - usb_submit_urb failed: %d\n",


