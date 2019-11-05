Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SUBJ_OBFU_PUNCT_FEW,SUBJ_OBFU_PUNCT_MANY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A88C17486
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FAA21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbfKEN7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:59:36 -0500
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:36711 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbfKEN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:59:35 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 08:59:35 EST
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id xA5DneLi023521
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 5 Nov 2019 14:49:40 +0100
Date:   Tue, 5 Nov 2019 14:49:39 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     linux1394-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: code cleanup after vm_map_pages_zero
 introduction
Message-ID: <20191105144939.3b38ce48@kant>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 22660db89262 turned fw_iso_buffer_map_vma into a one-liner.
There is no need to keep this in the core-iso.c collection of buffer
management functions; put it inline into the sole user, the character
device file driver.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/core-cdev.c |    3 ++-
 drivers/firewire/core-iso.c  |    7 -------
 drivers/firewire/core.h      |    2 --
 3 files changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1694,7 +1694,8 @@ static int fw_device_op_mmap(struct file
 	if (ret < 0)
 		goto fail;
 
-	ret = fw_iso_buffer_map_vma(&client->buffer, vma);
+	ret = vm_map_pages_zero(vma, client->buffer.pages,
+				client->buffer.page_count);
 	if (ret < 0)
 		goto fail;
 
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -91,13 +91,6 @@ int fw_iso_buffer_init(struct fw_iso_buf
 }
 EXPORT_SYMBOL(fw_iso_buffer_init);
 
-int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
-			  struct vm_area_struct *vma)
-{
-	return vm_map_pages_zero(vma, buffer->pages,
-					buffer->page_count);
-}
-
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
 			   struct fw_card *card)
 {
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -158,8 +158,6 @@ void fw_node_event(struct fw_card *card,
 int fw_iso_buffer_alloc(struct fw_iso_buffer *buffer, int page_count);
 int fw_iso_buffer_map_dma(struct fw_iso_buffer *buffer, struct fw_card *card,
 			  enum dma_data_direction direction);
-int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
-			  struct vm_area_struct *vma);
 
 
 /* -topology */


-- 
Stefan Richter
-======---== =-== --=-=
http://arcgraph.de/sr/
