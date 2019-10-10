Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3BCC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0B7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ns1C9fer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJJW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:28:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47009 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfJJW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:28:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so3465822plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=czQOnB8XGZh1drUQRgi49wj4hvdzWXuEnHlZa/FCwwU=;
        b=ns1C9ferSuxgAAnBlGRzPcG45QzbuNtsvk+IK5P1sm83hU4nWyKG3yPWsMyzZXdJNg
         8L1U7n6L7l4F27SGwiKO6AYQpuWZI4sK4uTbAnc7s2SBIwcp+kTcvUBjhNMO/NTpQrCV
         vOvaL9h3TsQnCeixMAb107cO508lsauqPytIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=czQOnB8XGZh1drUQRgi49wj4hvdzWXuEnHlZa/FCwwU=;
        b=MGt3trtFpncdJD+pJJ1f41vOx3JWD8ZQqJ+0NGSZXJTegwobnhICnVX3GvpOxrxIvK
         0IcPA/8R64q7nkSiq2gm2LAvnGQVzWYz7en7ldIwlPdS6IawL63Dqe9GVVtliUzH1/ry
         WLVrCKFGeqvX2Y94pJ/jhlfvL8ApNiwoOSC3S3Lh7Wez/KoJIyGXK1nRf69WdOwQu5Nw
         4xWeFbOTRcY2y9hgKp9Fhef9X/gvTHVmnLBiytA7WBsom9wYu6RhsC10t/Q2HUwiZ6+6
         1Zv6DxftpoyEkXPk4IN+mSDBoc9YmTEov4ksgHwjtxkiWShGF3SHYnrRwtt+Dph8y3uC
         X6Tg==
X-Gm-Message-State: APjAAAUnYNx3LodY4T1oByx9S3ZcCFYJMw8G+iOPHZnctHNjN8PwdY4C
        JfoAxJF/dlzoofWEKycnVZWPaw==
X-Google-Smtp-Source: APXvYqyCnXy+P7NSDVP2SOlCeFKxu9djHVTFcrtbCYrEpGlSGxw5IkNB0B1GwgRZrimv5eyU3qcR6A==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr11623587pln.309.1570746517679;
        Thu, 10 Oct 2019 15:28:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q143sm3147254pfq.103.2019.10.10.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:28:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] usb: core: Remove redundant vmap checks
Date:   Thu, 10 Oct 2019 15:28:29 -0700
Message-Id: <20191010222829.21940-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010222829.21940-1-keescook@chromium.org>
References: <20191010222829.21940-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the vmap area checks are being performed in the DMA
infrastructure directly, there is no need to repeat them in USB.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/core/hcd.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index f225eaa98ff8..281568d464f9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd_uses_dma(hcd)) {
-			if (is_vmalloc_addr(urb->setup_packet)) {
-				WARN_ONCE(1, "setup packet is not dma capable\n");
-				return -EAGAIN;
-			} else if (object_is_on_stack(urb->setup_packet)) {
+			if (object_is_on_stack(urb->setup_packet)) {
 				WARN_ONCE(1, "setup packet is on stack\n");
 				return -EAGAIN;
 			}
@@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_PAGE;
-			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
-				WARN_ONCE(1, "transfer buffer not dma capable\n");
-				ret = -EAGAIN;
 			} else if (object_is_on_stack(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer is on stack\n");
 				ret = -EAGAIN;
-- 
2.17.1

