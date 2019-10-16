Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBADFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13992207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264073;
	bh=1USnzs5RkjqPPvOVp/xfb/KzvPZ/0knfAUIbh0OAoNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUvyPgKjKbeixCmwjlMQS2LSQ3YVbdnSwFzO675Jxq0fF27ta3jZ5LYCmVKaaBCA1
	 Yj2Ez8hATbtUDlY76uMuj9wFrQa1jy6V1krJJUmEUN8wcRNrfCD4H95F8rWxtDUJ55
	 FmxFg8Wgr7Q7yNZUbtdOgEnzA8DrsasHp+bgwGa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395304AbfJPVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395256AbfJPVze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:34 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFF921D80;
        Wed, 16 Oct 2019 21:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262933;
        bh=1USnzs5RkjqPPvOVp/xfb/KzvPZ/0knfAUIbh0OAoNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glYAZ8t2S/F+ymjOfdXAG8MhUO9c9lJrvsT3uj0l5PP8R+wuzYi1UN8UDTvbbMDgP
         Yk2i0OubkEZz6q7CHitHN0cCL5uTv7cJIjg4Gusz3Ja4FLwklJ4y+Fu1e6hrMSLXuL
         1hdqSFo990FCLjcddgsklrreTUCyPA5lb2cerGIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 55/92] USB: chaoskey: fix use-after-free on release
Date:   Wed, 16 Oct 2019 14:50:28 -0700
Message-Id: <20191016214838.410672267@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
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
@@ -108,6 +108,7 @@ static void chaoskey_free(struct chaoske
 		usb_free_urb(dev->urb);
 		kfree(dev->name);
 		kfree(dev->buf);
+		usb_put_intf(dev->interface);
 		kfree(dev);
 	}
 }
@@ -157,6 +158,8 @@ static int chaoskey_probe(struct usb_int
 	if (dev == NULL)
 		goto out;
 
+	dev->interface = usb_get_intf(interface);
+
 	dev->buf = kmalloc(size, GFP_KERNEL);
 
 	if (dev->buf == NULL)
@@ -190,8 +193,6 @@ static int chaoskey_probe(struct usb_int
 		strcat(dev->name, udev->serial);
 	}
 
-	dev->interface = interface;
-
 	dev->in_ep = in_ep;
 
 	if (le16_to_cpu(udev->descriptor.idVendor) != ALEA_VENDOR_ID)


