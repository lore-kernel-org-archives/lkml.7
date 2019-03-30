Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F21C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D101A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbfC3Aqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:46:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44388 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfC3Aqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:46:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hA28i-0004OW-Q7; Sat, 30 Mar 2019 00:46:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] n_tty: check for negative and zero space return from tty_write_room
Date:   Sat, 30 Mar 2019 00:46:28 +0000
Message-Id: <20190330004628.12093-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The return from tty_write_room could potentially be negative if
a tty write_room driver returns an error number (not that any seem
to do). Rather than just check for a zero return, also check for
a -ve return. This avoids the unsigned nr being set to a large unsigned
value on the assignment from variable space and can lead to overflowing
the buffer buf.  Better to be safe than assume all write_room
implementations in tty drivers are going to do the right thing.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: return the error code from tty_write_room rather than zero,
thanks to Dan Carpenter for suggesting this improvement.

---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9cdb0fa3c4bf..f9c584244f72 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -550,9 +550,9 @@ static ssize_t process_output_block(struct tty_struct *tty,
 	mutex_lock(&ldata->output_lock);
 
 	space = tty_write_room(tty);
-	if (!space) {
+	if (space <= 0) {
 		mutex_unlock(&ldata->output_lock);
-		return 0;
+		return space;
 	}
 	if (nr > space)
 		nr = space;
-- 
2.20.1

