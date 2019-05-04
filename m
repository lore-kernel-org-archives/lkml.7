Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BEBC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD1F206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 16:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEDQMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 12:12:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39170 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEDQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 12:12:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hMxHI-00035w-5A; Sat, 04 May 2019 16:12:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: fix undefined behaviour of a shift of an int by more than 31 places
Date:   Sat,  4 May 2019 17:12:43 +0100
Message-Id: <20190504161243.18879-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the shift of two enum ints by more than 31 places on
can result in undefined behaviour with 64 bit longs. Fix this by
casting the ints to unsigned long before the shift.

Addresses-Coverity: ("Bad shift operation")
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/i3c/master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 1412abcff010..752256d4078f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -385,8 +385,9 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~(I3C_ADDR_SLOT_STATUS_MASK << (bitpos % BITS_PER_LONG));
-	*ptr |= status << (bitpos % BITS_PER_LONG);
+	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
+		  (bitpos % BITS_PER_LONG));
+	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
-- 
2.20.1

