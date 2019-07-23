Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B7C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342052239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbfGWPDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:03:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56209 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfGWPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:03:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hpwJu-00078I-HM; Tue, 23 Jul 2019 15:03:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty/isicom: remove redundant assignment to variable word_count
Date:   Tue, 23 Jul 2019 16:03:14 +0100
Message-Id: <20190723150314.14513-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable word_count is being assigned a value that is never read before
a return, the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/isicom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index e04a43e89f6b..fc38f96475bf 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -553,7 +553,6 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 
 	tty = tty_port_tty_get(&port->port);
 	if (tty == NULL) {
-		word_count = byte_count >> 1;
 		while (byte_count > 1) {
 			inw(base);
 			byte_count -= 2;
-- 
2.20.1

