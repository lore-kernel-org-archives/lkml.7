Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7CF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7GDNxkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCRWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:44:09 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:32992 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCRWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:44:08 -0400
Received: by mail-it1-f195.google.com with SMTP id f186so17846098ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=iLqHCSLsLvKuQmQ3KuSNufoEe0+TFmNnyPuUfZN4AXs=;
        b=r7GDNxkwGzHvhd2Toy7SFyuUWXSwIlWi9mJVvy6oIZMzVecOkTEJVTuhGqFZAQl9hc
         Afc65WCDJrwK6UGBH7AaUJX+UwYE7gCwon2KH6R8rDlsjVix0pYiFOpiu9xAVSjDnzKt
         62JORpzWI2eJ4rgg+O+kc5/v6GAXrQOJKXmlC7A46OTogRn6C/2Kt6YlLWbMklCM5Sj3
         BFgxqkdRTzVErfLfPp0IU/pyX64L9ArmPrZ3SUxYPILok7Krb6FGXGiVHaxpwKKwZjel
         M9LIZjwLS8JkqTrBPJqMDrH7QZWxkOnKhXzeumAtzr7pG+fgKs0AQg5GpRuIctYqfgym
         y4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=iLqHCSLsLvKuQmQ3KuSNufoEe0+TFmNnyPuUfZN4AXs=;
        b=CygTLDjMfboce5g2dUrvwpQVEE/QZJlt4zLO+5tMelzcs6lVAAkOPDa3fbuZO75tXQ
         QiG58HQRcvpDyz71eqaUTQNqJptSrIOU92FT/3svTlv2SdOxDFW7VN8LblZ0PmD1XB5J
         pLfuYA5w6QuOY6ccqW2jCUZ6nAJQE7x8yoZnf1QEyFNGn5l3xaLMZsdaAeM7zOpsb1jK
         C4kiyJAtihEIX61+vadxQWSuBP0FdjYKPKQAveh5lFoEfbZgKWBZxTcXQthBSH/IwlSA
         Z/gsXbp8fbp1rTpqaFp7bONdQQOTqnR0dUOt2LmTZJDwuX6HbmpOjKhn2IIz96y96x1J
         XqaQ==
X-Gm-Message-State: APjAAAW2BcGMwCWvcF0S3b/U5KCCrn1G0/g8y0yQd5KYSWWUx1WBxAKJ
        TwnnueGmNy+sUxV6IGFwTec=
X-Google-Smtp-Source: APXvYqy2kYa/TYdW/guqGaDGRXJN0urmUFXr8u3XFgdGv6oVZg12tzQy+NqhFTitcKlayd9fhwknAg==
X-Received: by 2002:a24:ddc6:: with SMTP id t189mr864817itf.30.1552949047673;
        Mon, 18 Mar 2019 15:44:07 -0700 (PDT)
Received: from AlexPC (CPEac9e17937810-CM64777dd8e660.cpe.net.cable.rogers.com. [174.112.89.107])
        by smtp.gmail.com with ESMTPSA id g64sm388485itg.44.2019.03.18.15.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:44:06 -0700 (PDT)
From:   <alex.bou9@gmail.com>
To:     "'Kangjie Lu'" <kjlu@umn.edu>
Cc:     <pakki001@umn.edu>, "'Matt Porter'" <mporter@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
References: <20190314061015.11291-1-kjlu@umn.edu>
In-Reply-To: <20190314061015.11291-1-kjlu@umn.edu>
Subject: RE: [PATCH] rapidio: fix a NULL pointer derefenrece when create_workqueue fails
Date:   Mon, 18 Mar 2019 18:44:05 -0400
Message-ID: <002101d4dddc$183d9660$48b8c320$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN4sco7z0aobyYW9FNRQRf9ZboAuKLKVDvA
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>  

-----Original Message-----
From: Kangjie Lu <kjlu@umn.edu> 
Sent: Thursday, March 14, 2019 2:10 AM
To: kjlu@umn.edu
Cc: pakki001@umn.edu; Matt Porter <mporter@kernel.crashing.org>; Alexandre
Bounine <alex.bou9@gmail.com>; linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix a NULL pointer derefenrece when
create_workqueue fails

In case create_workqueue fails, the fix releases resources and
returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/rapidio/rio_cm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index cf45829585cb..b29fc258eeba 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2147,6 +2147,14 @@ static int riocm_add_mport(struct device *dev,
 	mutex_init(&cm->rx_lock);
 	riocm_rx_fill(cm, RIOCM_RX_RING_SIZE);
 	cm->rx_wq = create_workqueue(DRV_NAME "/rxq");
+	if (!cm->rx_wq) {
+		riocm_error("failed to allocate IBMBOX_%d on %s",
+			    cmbox, mport->name);
+		rio_release_outb_mbox(mport, cmbox);
+		kfree(cm);
+		return -ENOMEM;
+	}
+
 	INIT_WORK(&cm->rx_work, rio_ibmsg_handler);
 
 	cm->tx_slot = 0;
-- 
2.17.1


