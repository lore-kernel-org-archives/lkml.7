Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF2C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0E821783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142093;
	bh=NW5M5tG5jivL/ewIrjwbSjVjsD2EhZihRfAaDgW/z/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvOlmC30FEipBp+ZAG+tBpWOnn0WpD1W9JZA6/3TPCkXGXHHTncjpue9M4ElY19CP
	 zmBrmfOooDY8c6YY3bI7SUylDCH7mlaLC/T/4UHOtSpLDqqCo2hIFK+ewY2X8Qwyo7
	 p6efV67p03JX4cxjrYaJhCInPOIBgYpAFlQb1anI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfKSFlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:41:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbfKSFl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:41:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E835208C3;
        Tue, 19 Nov 2019 05:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142088;
        bh=NW5M5tG5jivL/ewIrjwbSjVjsD2EhZihRfAaDgW/z/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aC0GfEfeBVjSxwLumRx/mQieGcsx+Cd3v7HGiRNQ2AMY/xEMI7r4SZSWQGIz/+Xx5
         Qnut76C4b/6fEsFKKBZD+F01m6UVwpciDCHcZfDZkR2PTmDunG5a9pF42Enz/CNkJQ
         t+ZT0xbU17qRDH5k+Je4IUpQ7ZShFJG0jQe45E9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 383/422] firmware: dell_rbu: Make payload memory uncachable
Date:   Tue, 19 Nov 2019 06:19:40 +0100
Message-Id: <20191119051423.887664218@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

[ Upstream commit 6aecee6ad41cf97c0270f72da032c10eef025bf0 ]

The dell_rbu driver takes firmware update payloads and puts them in memory so
the system BIOS can find them after a reboot.  This sometimes fails (though
rarely), because the memory containing the payload is in the CPU cache but
never gets written back to main memory before the system is rebooted (CPU
cache contents are lost on reboot).

With this patch, the payload memory will be changed to uncachable to ensure
that the payload is actually in main memory before the system is rebooted.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/dell_rbu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index fb8af5cb7c9bf..ccefa84f73057 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
+#include <asm/set_memory.h>
 
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
@@ -181,6 +182,11 @@ static int create_packet(void *data, size_t length)
 			packet_data_temp_buf = NULL;
 		}
 	}
+	/*
+	 * set to uncachable or it may never get written back before reboot
+	 */
+	set_memory_uc((unsigned long)packet_data_temp_buf, 1 << ordernum);
+
 	spin_lock(&rbu_data.lock);
 
 	newpacket->data = packet_data_temp_buf;
@@ -349,6 +355,8 @@ static void packet_empty_list(void)
 		 * to make sure there are no stale RBU packets left in memory
 		 */
 		memset(newpacket->data, 0, rbu_data.packetsize);
+		set_memory_wb((unsigned long)newpacket->data,
+			1 << newpacket->ordernum);
 		free_pages((unsigned long) newpacket->data,
 			newpacket->ordernum);
 		kfree(newpacket);
-- 
2.20.1



