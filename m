Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15372085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKwQvuDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCRWqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:46:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34174 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfCRWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:46:18 -0400
Received: by mail-it1-f194.google.com with SMTP id l4so10951253ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=6A2YBxJA45xd9NzmQX+BRFbH9BDynT0TQ2ND2qZ49GE=;
        b=MKwQvuDq7CYvZe0q6ATzGDi5V0ZeHON7OftWDKMQxFiDhVqeIFid/ohvs8/qdrd7Bz
         HLjD615y7eB3qe56fq+XjvkMmFCyp423d1HBQfmfbvcbnRyjP6q08pqxyrX6DQJ97yKu
         7N+Bwx9AMB3Qj/0j9qtg61i/dECITp6OUYLR/SVNDBi3lru0wTQpjCt9uPlPfdmbmcV5
         fKyYa1DahKrIWKs6uDcp6Cqray/FaJ5JjqR0kzzIqIX1KK0KHPtdfQCQwTftJcyVa5qE
         cTLm1tKjA4rrC0+spx3uZxtVUbJkx1PvF7c/WO7Qzu9n5K0uGZq04evVEGk3XoUd4sHT
         7hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=6A2YBxJA45xd9NzmQX+BRFbH9BDynT0TQ2ND2qZ49GE=;
        b=KJyGxc9/sh8O4E8N/bAg0nx03JfDxCzB6M/4d9DM67r9U6kzni89sIlpx1J9UyAToe
         YflxqjsWwiNtNUy7oX7pxSatIldKTZgWvdvsTZjl+HN73NIduxpwfSEKYKGMbhaNiPVl
         VPlWpyCPIU6YDuBdhlg5u9r8NhzIEqQgmY26/12sXd99wEyyVz+Q88DDaC9DF0fXPs5v
         LIDcbbESkXDAMKPCDo67oYJ50B3oRcSTEeWXDTDGyj36NXn+jmBqmww7+pYrckFe/mGF
         +FD+8lrVeswCG/Tiazap3Cz4Y+9FvRvlO917NrrWEEIj7vjQxyvnlOn3ywmWkq1rVJ3y
         i9tg==
X-Gm-Message-State: APjAAAVvetrx4NstjY9gSV306+lvO6uCtjw5Aslv+I+62+G2m46DlTRP
        87f16aDyfAk2SaJZ5MxEF8pnRZow
X-Google-Smtp-Source: APXvYqzOrb5r9O35d3z/1/JWtsKzWkpxJr6zSzD4J7czC5g+WW7h/T+tScssz0m/TX7SNcE1oIyJ2A==
X-Received: by 2002:a24:2789:: with SMTP id g131mr763068ita.127.1552949177943;
        Mon, 18 Mar 2019 15:46:17 -0700 (PDT)
Received: from AlexPC (CPEac9e17937810-CM64777dd8e660.cpe.net.cable.rogers.com. [174.112.89.107])
        by smtp.gmail.com with ESMTPSA id l20sm4962756ioj.57.2019.03.18.15.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 15:46:17 -0700 (PDT)
From:   <alex.bou9@gmail.com>
To:     "'Kangjie Lu'" <kjlu@umn.edu>
Cc:     <pakki001@umn.edu>, "'Matt Porter'" <mporter@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
References: <20190314061015.11291-1-kjlu@umn.edu>
In-Reply-To: <20190314061015.11291-1-kjlu@umn.edu>
Subject: RE: [PATCH] rapidio: fix a NULL pointer derefenrece when create_workqueue fails
Date:   Mon, 18 Mar 2019 18:46:16 -0400
Message-ID: <002201d4dddc$662129a0$32637ce0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN4sco7z0aobyYW9FNRQRf9ZboAuKLKVOJA
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please correct spelling in the subject line: "dereference"

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


