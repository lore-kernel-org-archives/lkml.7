Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DEC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4640A2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+sD4Tg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfF2IVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:21:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37776 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfF2IVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 04:21:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so4132966pfa.4;
        Sat, 29 Jun 2019 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HB5G4BCyKAU7NWh04NXHQUYQWJo7mRMg3f1DS79X9is=;
        b=U+sD4Tg2i5EmnQ+E96oYuHmFfjRIZFhu+ImSjldFv+pp7bnarxQt4kZTlckg4DVX+M
         5BwiyO9vyxW50aW05AoE/XIReZ9UkFMhsaXqrral2F+wzcVqDlYG9Mvy5WHbXw3EVJDh
         O+MEOuUIm8CeKDhIpzNb9pUSquazzH3bdV8LKIxTfBVuq8knnPvwv2H4AHzKPX2lgP4s
         trkpZ1ybjg/Y1kuSq/ywv3KuZTsKx+BT4RNyIxMJxKYktCp2UZVQyYwlHdkJpOF55bVO
         qgTm4y/L71e3PxcXX0+KKUtPt/aEITyjaj+U13dkDaAkNQB52CqYfAurITZQgPSEwS/+
         iYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HB5G4BCyKAU7NWh04NXHQUYQWJo7mRMg3f1DS79X9is=;
        b=GvsMbNdKXv/hGaCFh45x2DeiIZnhv2PDkV7YHMYejqqkTNRIO43fmufrSVx/p10P53
         FiREzKoZj7HgDFVShF0+e6Wws8v0ElPcP+a7yRr+QeeYTSkrO7iSS+3rvhLNTof4YiTw
         0fhwF7Poazp/HUnmU4+4U3Ul072Z1hOdEhTRcAxP4jgpnCI6wPVBC5C8SLltcgVRvbAw
         BuNxxj3EVlkY7Wf1OKOwJKdcc4xYKfN0VaSjwRfut2aiYpFgZABhLvIPl1XupMIdBnYt
         1e6Sx8zUCPxYAglPPT86rRJMVnuMOLmx2FRWZ99ZtOzjXczk7bUUh/eUaMsxSMZ9wxCS
         33ag==
X-Gm-Message-State: APjAAAVPlu3TTwLg1uysEYc4/0JOYuUiYDvoPvCAFwke20yt3ai8QChK
        rDZRRF+e376RsKmBBRzt0XvvJKYacYU=
X-Google-Smtp-Source: APXvYqxe+pfvA2fNml3PD0CjRgo9z23VagyA/eh1M1nZFUM5QLw9+cWEf3nEyzTfGxa1nZKlTrc+TA==
X-Received: by 2002:a17:90a:228b:: with SMTP id s11mr17710124pjc.23.1561796503508;
        Sat, 29 Jun 2019 01:21:43 -0700 (PDT)
Received: from localhost.localdomain ([219.91.196.157])
        by smtp.googlemail.com with ESMTPSA id 27sm3834610pgt.6.2019.06.29.01.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jun 2019 01:21:42 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH] dmaengine: at_xdmac: check for non-empty xfers_list before invoking callback
Date:   Sat, 29 Jun 2019 13:50:48 +0530
Message-Id: <1561796448-3321-1-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tx descriptor retrieved from an empty xfers_list may not have valid
pointers to the callback functions.
Avoid calling dmaengine_desc_get_callback_invoke if xfers_list is empty.

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 drivers/dma/at_xdmac.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 627ef3e..b58ac72 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1568,11 +1568,14 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 	struct at_xdmac_desc		*desc;
 	struct dma_async_tx_descriptor	*txd;
 
-	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
-	txd = &desc->tx_dma_desc;
+	if (!list_empty(&atchan->xfers_list)) {
+		desc = list_first_entry(&atchan->xfers_list,
+					struct at_xdmac_desc, xfer_node);
+		txd = &desc->tx_dma_desc;
 
-	if (txd->flags & DMA_PREP_INTERRUPT)
-		dmaengine_desc_get_callback_invoke(txd, NULL);
+		if (txd->flags & DMA_PREP_INTERRUPT)
+			dmaengine_desc_get_callback_invoke(txd, NULL);
+	}
 }
 
 static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
-- 
2.7.4

