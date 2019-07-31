Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C523FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B56206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfGaMwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:52:01 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:23172 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729131AbfGaMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:52:01 -0400
Received: from localhost.localdomain ([176.167.121.156])
        by mwinf5d70 with ME
        id jQrw2000P3NZnML03QrxTn; Wed, 31 Jul 2019 14:51:59 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 31 Jul 2019 14:51:59 +0200
X-ME-IP: 176.167.121.156
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] usb: xhci: dbc: Use GFP_KERNEL instead of GFP_ATOMIC in 'xhci_dbc_alloc_requests()'
Date:   Wed, 31 Jul 2019 14:52:02 +0200
Message-Id: <557765ac7a028fa77f0e1ac6148ef2c0904f8ab7.1564577335.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564577335.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564577335.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use GFP_ATOMIC to allocate 'req'. GFP_KERNEL should be
enough and is already used for another allocation juste a few lines below.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've done my best to check if a spinlock can be hold when reaching this
code. Apparently it is never the case.
But double check to be sure that it is not the kmalloc that should use
GFP_ATOMIC.
---
 drivers/usb/host/xhci-dbgtty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 845939f8a0b8..be726c791323 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -139,7 +139,7 @@ xhci_dbc_alloc_requests(struct dbc_ep *dep, struct list_head *head,
 	struct dbc_request	*req;
 
 	for (i = 0; i < DBC_QUEUE_SIZE; i++) {
-		req = dbc_alloc_request(dep, GFP_ATOMIC);
+		req = dbc_alloc_request(dep, GFP_KERNEL);
 		if (!req)
 			break;
 
-- 
2.20.1

