Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C4C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EAE2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfCRJ2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:03 -0400
Received: from skyboo.net ([94.40.87.198]:39050 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbfCRJ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:58 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1h5oYl-0002IU-JA; Mon, 18 Mar 2019 10:27:56 +0100
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Mon, 18 Mar 2019 10:27:36 +0100
Message-Id: <20190318092737.8170-2-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190318092737.8170-1-manio@skyboo.net>
References: <20190318092737.8170-1-manio@skyboo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, zbr@ioremap.net, greg@kroah.com, jeff.dagenais@gmail.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH 1/2] w1: ds2408: add a missing reset when retrying in output_write()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have success in 'Channel Access Write' but reading back the latch
state has failed, then the code continues but without doing a proper
slave reset. This was leading to protocol errors as the slave treats
the next 'Channel Access Write' as the continuation of previous command.

This commit is fixing this, and because we have to reset no matter if
the actual write or the readback checking is failing then the resetting
is done on the beginning of the loop.

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/w1/slaves/w1_ds2408.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index b535d5ec35b6..562ee2d861e8 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -158,6 +158,13 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 		goto error;
 
 	while (retries--) {
+		/* do a reset/resume on every new retry call
+		   except the first one */
+		if (retries < W1_F29_RETRIES - 1) {
+			if (w1_reset_resume_command(sl->master))
+				goto error;
+		}
+
 		w1_buf[0] = W1_F29_FUNC_CHANN_ACCESS_WRITE;
 		w1_buf[1] = *buf;
 		w1_buf[2] = ~(*buf);
@@ -165,12 +172,8 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 
 		readBack = w1_read_8(sl->master);
 
-		if (readBack != W1_F29_SUCCESS_CONFIRM_BYTE) {
-			if (w1_reset_resume_command(sl->master))
-				goto error;
-			/* try again, the slave is ready for a command */
+		if (readBack != W1_F29_SUCCESS_CONFIRM_BYTE)
 			continue;
-		}
 
 #ifdef CONFIG_W1_SLAVE_DS2408_READBACK
 		/* here the master could read another byte which
-- 
2.19.0.rc1

