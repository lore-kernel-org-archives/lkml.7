Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576C8C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3463A2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 06:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfHRGkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 02:40:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40248 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 02:40:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id z64so3128690ywe.7;
        Sat, 17 Aug 2019 23:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NQ/5tyRI3jdXbSjfHy7ZyjCm7NzWYQeUYMxyiQB6M1o=;
        b=l7ilRmV6p4oCxqL3EmBI89oNvUWejzBTwy8wIgRGF+iDDgKPl+/o+IJCE6cAzB8yv/
         8t3N/uLbQtnz7bTVJclE897WmA2MDMzDAgGV839hIpHvmP/sevMXnUtym+XYSlqISxx0
         GhrpIhYWOp15jH96S5KKSUvjje6ulmgKRosXgg2VHH9yotDsPOR67StEPkPZ/xpRsLFd
         ZDmrV0BL/RbyqR79CLaJxHY7dD3wgFfYyeSw46Uc7GLigZ6C9KOeCHyy+G7sD3gYjFdw
         l/7JgjBoeJR/pOqCt5uE0mx3FtWBz7VpSrRYvXQOYsx9zVegZByBrHmGKwuYPXPkyAjZ
         L0ug==
X-Gm-Message-State: APjAAAWTSmhBPuT0q9oZpB/orYD0Tl7FxCTIAnSlSN0fN8pJNHYqX2aX
        2BCrcMMwRogYMjznHFWTZNQ=
X-Google-Smtp-Source: APXvYqwxrdza2Vm5Vc0ndYx+SuHQoeMX8GKmXom6rOakCaE2A8DWDUBkOe6QuiaAGIjYVNQmNxfYTw==
X-Received: by 2002:a81:5f82:: with SMTP id t124mr12559223ywb.513.1566110409630;
        Sat, 17 Aug 2019 23:40:09 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id r19sm2801463ywa.109.2019.08.17.23.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 23:40:08 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:TI VPE/CAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: ti-vpe: Add cleanup in vpdma_list_cleanup()
Date:   Sun, 18 Aug 2019 01:40:04 -0500
Message-Id: <1566110404-3900-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs in this function, no cleanup is executed, leading to
memory/resource leaks. To fix this issue, introduce two labels to perform
the cleanup work.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/media/platform/ti-vpe/vpdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti-vpe/vpdma.c
index fd37d79..53d27cd 100644
--- a/drivers/media/platform/ti-vpe/vpdma.c
+++ b/drivers/media/platform/ti-vpe/vpdma.c
@@ -445,23 +445,25 @@ int vpdma_list_cleanup(struct vpdma_data *vpdma, int list_num,
 
 	ret = vpdma_map_desc_buf(vpdma, &abort_list.buf);
 	if (ret)
-		return ret;
+		goto free_desc;
 	ret = vpdma_submit_descs(vpdma, &abort_list, list_num);
 	if (ret)
-		return ret;
+		goto unmap_desc;
 
 	while (vpdma_list_busy(vpdma, list_num) && --timeout)
 		;
 
 	if (timeout == 0) {
 		dev_err(&vpdma->pdev->dev, "Timed out cleaning up VPDMA list\n");
-		return -EBUSY;
+		ret = -EBUSY;
 	}
 
+unmap_desc:
 	vpdma_unmap_desc_buf(vpdma, &abort_list.buf);
+free_desc:
 	vpdma_free_desc_buf(&abort_list.buf);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(vpdma_list_cleanup);
 
-- 
2.7.4

