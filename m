Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7286920674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404152;
	bh=WxhQkwHJIFJqmiQcam91kuSyvW8HP7Zb7M0NPoHGyNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JU3FS0t/fRmjIiggZtksl03LIM4q+i5849IrqRWuW1L9RJUa+LnaRZMpi9ncGGf0A
	 iGyuKR6+WABZrBqMhkDH9yTs3r2bLWbyr4vgkmO4uOFl2A18rjtpsByQPALLyjalFB
	 225HK6HcvcWoeB1KcM4GjSV6nQS72qGKY3TkcV10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKVFuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbfKVFty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5842068F;
        Fri, 22 Nov 2019 05:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401794;
        bh=WxhQkwHJIFJqmiQcam91kuSyvW8HP7Zb7M0NPoHGyNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dckV56jpcE//8u+3l5nSQZtyoeT5CHOdkrM06c/ScAGQcQobNu4ZETxPsPY4suDSI
         coLm8AVhpwiObYwWg9pr0H0MVAG/Gkqa2VMik05YtNlsjMqYxcqedGBBPuC5qLJKB2
         NpTX7405+8vZ1W4kx7jH0wmuNtVsmyNvEcnOF34Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 041/219] s390/zcrypt: make sysfs reset attribute trigger queue reset
Date:   Fri, 22 Nov 2019 00:46:13 -0500
Message-Id: <20191122054911.1750-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 42a87d4103ae365e18c3be1333592ab583b8ad9d ]

Until now there is no way to reset a AP queue or card. Driving a card
or queue offline and online again does only toggle the 'software'
online state. The only way to trigger a (hardware) reset is by running
hot-unplug/hot-plug for example on the HMC.

This patch makes the queue reset attribute in sysfs writable.
Writing into this attribute triggers a reset on the AP queue's state
machine. So the AP queue is flushed and state machine runs through the
initial states which cause a reset (PQAP(RAPQ)) and a re-registration
to interrupts (PQAP(AQIC)) if available.

The reset sysfs attribute is writable by root only. So only an
administrator is allowed to initiate a reset of AP queues. Please note
that the queue's counter values are left untouched by the reset.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/ap_queue.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 0aa4b3ccc948c..576ac08777c50 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -14,6 +14,9 @@
 #include <asm/facility.h>
 
 #include "ap_bus.h"
+#include "ap_debug.h"
+
+static void __ap_flush_queue(struct ap_queue *aq);
 
 /**
  * ap_queue_enable_interruption(): Enable interruption on an AP queue.
@@ -541,7 +544,25 @@ static ssize_t reset_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR_RO(reset);
+static ssize_t reset_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct ap_queue *aq = to_ap_queue(dev);
+
+	spin_lock_bh(&aq->lock);
+	__ap_flush_queue(aq);
+	aq->state = AP_STATE_RESET_START;
+	ap_wait(ap_sm_event(aq, AP_EVENT_POLL));
+	spin_unlock_bh(&aq->lock);
+
+	AP_DBF(DBF_INFO, "reset queue=%02x.%04x triggered by user\n",
+	       AP_QID_CARD(aq->qid), AP_QID_QUEUE(aq->qid));
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(reset);
 
 static ssize_t interrupt_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
-- 
2.20.1

