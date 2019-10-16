Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A290FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA5B218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263071;
	bh=E2zSj+5l3fEHkyKOKlJHqKi0v60aNokAkhOX6t/Y5CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DEcnsYa8XsAyzO3Lh4wzefTjAPUC7eni+AWFvI5YnX29FTGCiaKXVW7LQkAC+gfVL
	 ThZuDXNP1Di1ngbohmtfPBeniYZRlmNYOnK3j43nEx65jjMe1D2Ku43wFeO4nu1ca1
	 fPdmZCCc1Nh7677GLHkQ9OqVwVaO4vsipUtOGRQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438056AbfJPV5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391497AbfJPV5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:02 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE9821D7A;
        Wed, 16 Oct 2019 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263021;
        bh=E2zSj+5l3fEHkyKOKlJHqKi0v60aNokAkhOX6t/Y5CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPMWAa8rsGjGtahkYFAXJMkYkB881C4xXExz7Pi8Lh4DTiD998jGYniDe7vZ8uwIa
         DIjtj9Xq6dmZwuc2gIl3kvWJWT7Qgi+QGrYzBiasNKsIW0bKgL36xgC94SIV9Ys7zq
         UAMkvXa39HWmZA2KQztox0oPVzns3kEfOYMxXwwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 22/81] USB: chaoskey: fix use-after-free on release
Date:   Wed, 16 Oct 2019 14:50:33 -0700
Message-Id: <20191016214826.645129419@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 93ddb1f56ae102f14f9e46a9a9c8017faa970003 upstream.

The driver was accessing its struct usb_interface in its release()
callback without holding a reference. This would lead to a
use-after-free whenever the device was disconnected while the character
device was still open.

Fixes: 66e3e591891d ("usb: Add driver for Altus Metrum ChaosKey device (v2)")
Cc: stable <stable@vger.kernel.org>     # 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191009153848.8664-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/chaoskey.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -98,6 +98,7 @@ static void chaoskey_free(struct chaoske
 		usb_free_urb(dev->urb);
 		kfree(dev->name);
 		kfree(dev->buf);
+		usb_put_intf(dev->interface);
 		kfree(dev);
 	}
 }
@@ -145,6 +146,8 @@ static int chaoskey_probe(struct usb_int
 	if (dev == NULL)
 		goto out;
 
+	dev->interface = usb_get_intf(interface);
+
 	dev->buf = kmalloc(size, GFP_KERNEL);
 
 	if (dev->buf == NULL)
@@ -174,8 +177,6 @@ static int chaoskey_probe(struct usb_int
 			goto out;
 	}
 
-	dev->interface = interface;
-
 	dev->in_ep = in_ep;
 
 	if (le16_to_cpu(udev->descriptor.idVendor) != ALEA_VENDOR_ID)


