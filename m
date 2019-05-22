Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FFC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C5320856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfEVKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:40:59 -0400
Received: from skyboo.net ([94.40.87.198]:47838 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfEVKk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:40:58 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hTOg3-0003zI-Ln; Wed, 22 May 2019 12:40:56 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Wed, 22 May 2019 12:40:53 +0200
Message-Id: <20190522104053.14577-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190520070558.20142-3-manio@skyboo.net>
References: <20190520070558.20142-3-manio@skyboo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH 3/4 v2] w1: ds2413: when the slave is not responding during read, select it again
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protocol is not allowing to obtain a byte of 0xff for PIO_ACCESS_READ
call. It is very likely that the slave was not addressed properly and
it is just not respoding (leaving the bus in logic high state) during
the read of sampled PIO value.
We cannot just call w1_reset_resume_command() because the problem will
persist, instead try selecting (addressing) the slave again.

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
Changes in v2:
    Optimize the if statement so the most common is checked first.

 drivers/w1/slaves/w1_ds2413.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index d63778c70568..21f08ac8a4e0 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -24,6 +24,7 @@
 #define W1_F3A_FUNC_PIO_ACCESS_READ        0xF5
 #define W1_F3A_FUNC_PIO_ACCESS_WRITE       0x5A
 #define W1_F3A_SUCCESS_CONFIRM_BYTE        0xAA
+#define W1_F3A_INVALID_PIO_STATE           0xFF
 
 static ssize_t state_read(struct file *filp, struct kobject *kobj,
 			  struct bin_attribute *bin_attr, char *buf, loff_t off,
@@ -45,6 +46,7 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 	mutex_lock(&sl->master->bus_mutex);
 	dev_dbg(&sl->dev, "mutex locked");
 
+next:
 	if (w1_reset_select_slave(sl))
 		goto out;
 
@@ -52,10 +54,15 @@ static ssize_t state_read(struct file *filp, struct kobject *kobj,
 		w1_write_8(sl->master, W1_F3A_FUNC_PIO_ACCESS_READ);
 
 		*buf = w1_read_8(sl->master);
-		/* check for correct complement */
 		if ((*buf & 0x0F) == ((~*buf >> 4) & 0x0F)) {
+			/* complement is correct */
 			bytes_read = 1;
 			goto out;
+		} else if (*buf == W1_F3A_INVALID_PIO_STATE) {
+			/* slave didn't respond, try to select it again */
+			dev_warn(&sl->dev, "slave device did not respond to PIO_ACCESS_READ, " \
+					    "reselecting, retries left: %d\n", retries);
+			goto next;
 		}
 
 		if (w1_reset_resume_command(sl->master))
-- 
2.19.0.rc1

