Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B30821929
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lww7NWm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394466AbfITCvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:51:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33653 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388700AbfITCvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:51:48 -0400
Received: by mail-io1-f67.google.com with SMTP id m11so12873642ioo.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KLNKw4tCKcdLAT44IjaioZ3ZpL5CeMupWEppqyZEuqM=;
        b=lww7NWm2Spk5uLAjc9c0kzm5jMwyutinQTf/h3SF1eeZZdmHHJFKhUI03kOAbK0wk1
         D0Bagu5kODj2DORENWGxpb1qoQBqacV3xJ/tIA7b3SE4iOknGgMfDcFOX1OasZ9ov+RX
         LtD6zy4FWd/E+8WFAblQVNbrnISaVGInIvgYQG2J4tDIbTVGH1fwtMo06I+j5O06fyXG
         AsF0fRLekD2yi5OmawZeq65VkKSysU5/xaLsMg+xshiS3P1wz51iUH8ieluzTAM/MfBu
         g+TCW5WILMFP82HC2bFZgBAjeGQSOUNqDufWN2mRry25b51J7ncdN98XJkCTO71DPQWq
         WKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KLNKw4tCKcdLAT44IjaioZ3ZpL5CeMupWEppqyZEuqM=;
        b=CcqIcMfR62P7XlsorJWp3aQ9CmozoIfV3NchLu+Onv3VHzF4VFWRdfHnjMcf6OTOVp
         yxrUfBPUwWPTRZVgAX2NmBkAsfBQULY8VX+mwecITOwhji636D5o6p4eHHy6T6CtKnXX
         raXPDcJ8Qf4vNiqzonNizXqqRdCWmrIma8dg1ke6ynm5AM94e1GiCxDOT8z/PQqpI+OQ
         sLQKjCajD3UFAAHV3TgRIZgTx/1jqiNoO4CH1LsG2cafZU5wBnAqzU9TAG/NFFfZg6pg
         sxW7wDxqP67pDSTt4emd9GEa7GNKYhbGJjutQtySd/RFKDHmglb2Q18gSmRZmZXAflmj
         Q3MA==
X-Gm-Message-State: APjAAAV0HUcwPB41xOodzmbdbp4HSvN+5OTkjbmRNgvdYnUx+NUKJE0l
        1GzV6kT/oYxxJyAkkm/E83k=
X-Google-Smtp-Source: APXvYqzpe1k4MLS+eqvcBWElYxS/s8lKEXGbM7ZJbfdmlMsZ2IZxL/B0hBRgQHd4UEDEkAMCmW0vjw==
X-Received: by 2002:a02:7f8a:: with SMTP id r132mr16390921jac.46.1568947907511;
        Thu, 19 Sep 2019 19:51:47 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c5sm451907ioq.61.2019.09.19.19.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 19:51:47 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix multiple memory leaks on error path
Date:   Thu, 19 Sep 2019 21:51:33 -0500
Message-Id: <20190920025137.29407-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rtl8192_tx on error handling path allocated urbs and also skb should
be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index fe1f279ca368..b62b03802b1b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1422,7 +1422,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 		(struct tx_fwinfo_819x_usb *)(skb->data + USB_HWDESC_HEADER_LEN);
 	struct usb_device *udev = priv->udev;
 	int pend;
-	int status;
+	int status, rt = -1;
 	struct urb *tx_urb = NULL, *tx_urb_zero = NULL;
 	unsigned int idx_pipe;
 
@@ -1566,8 +1566,10 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 		}
 		if (bSend0Byte) {
 			tx_urb_zero = usb_alloc_urb(0, GFP_ATOMIC);
-			if (!tx_urb_zero)
-				return -ENOMEM;
+			if (!tx_urb_zero) {
+				rt = -ENOMEM;
+				goto error;
+			}
 			usb_fill_bulk_urb(tx_urb_zero, udev,
 					  usb_sndbulkpipe(udev, idx_pipe),
 					  &zero, 0, tx_zero_isr, dev);
@@ -1577,7 +1579,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 					 "Error TX URB for zero byte %d, error %d",
 					 atomic_read(&priv->tx_pending[tcb_desc->queue_index]),
 					 status);
-				return -1;
+				goto error;
 			}
 		}
 		netif_trans_update(dev);
@@ -1588,7 +1590,12 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	RT_TRACE(COMP_ERR, "Error TX URB %d, error %d",
 		 atomic_read(&priv->tx_pending[tcb_desc->queue_index]),
 		 status);
-	return -1;
+
+error:
+	dev_kfree_skb_any(skb);
+	usb_free_urb(tx_urb);
+	usb_free_urb(tx_urb_zero);
+	return rt;
 }
 
 static short rtl8192_usb_initendpoints(struct net_device *dev)
-- 
2.17.1

