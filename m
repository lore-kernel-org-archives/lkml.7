Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0510C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957BA21781
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887328;
	bh=x6hLt6z0ctPoVuvek0M26yoPRBeU6LO5WwNb4a7OFWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lviFTkLbRThpgehZwS5nmYepTamba40nmewLOyweP8s6ZdHrgtdSLY/jLA2IYsEvL
	 OT0QviI1ufYiH03uP52kN0KsIIYBn6XF9ufmb5Ugsw0drJwUCSTXS9C/aMcWyIXVR2
	 xgp2m2jJQAx7kiQs3iRWX6D8eNDCRPnnQss3/EAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfK0UmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfK0UmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:42:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A73621781;
        Wed, 27 Nov 2019 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887323;
        bh=x6hLt6z0ctPoVuvek0M26yoPRBeU6LO5WwNb4a7OFWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ncqz5ZPm/kFEyZpuElx6Xh/lx+yLb7MuYaHRrhDk/zt2zrWgmkV/5BfVuWo7Gd2LW
         DFgcZgm8ypfhThVfxwgFmH6LzbYzw8PlP9DicR1ooNc2hqwmqur6O94043FyDvEla0
         yKvzoK0Pi7kggooutelToausZxQwrOImCpZUTRcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Duncan Laurie <dlaurie@chromium.org>,
        Vadim Bendebury <vbendeb@chromium.org>,
        Stefan Reinauer <reinauer@chromium.org>,
        Furquan Shaikh <furquan@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 024/151] gsmi: Fix bug in append_to_eventlog sysfs handler
Date:   Wed, 27 Nov 2019 21:30:07 +0100
Message-Id: <20191127203016.022159357@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

[ Upstream commit 655603de68469adaff16842ac17a5aec9c9ce89b ]

The sysfs handler should return the number of bytes consumed, which in the
case of a successful write is the entire buffer.  Also fix a bug where
param.data_len was being set to (count - (2 * sizeof(u32))) instead of just
(count - sizeof(u32)).  The latter is correct because we skip over the
leading u32 which is our param.type, but we were also incorrectly
subtracting sizeof(u32) on the line where we were actually setting
param.data_len:

	param.data_len = count - sizeof(u32);

This meant that for our example event.kernel_software_watchdog with total
length 10 bytes, param.data_len was just 2 prior to this change.

To test, successfully append an event to the log with gsmi sysfs.
This sample event is for a "Kernel Software Watchdog"

> xxd -g 1 event.kernel_software_watchdog
0000000: 01 00 00 00 ad de 06 00 00 00

> cat event.kernel_software_watchdog > /sys/firmware/gsmi/append_to_eventlog

> mosys eventlog list | tail -1
14 | 2012-06-25 10:14:14 | Kernl Event | Software Watchdog

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
Reviewed-by: Stefan Reinauer <reinauer@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Tested-by: Furquan Shaikh <furquan@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
Reviewed-by: Justin TerAvest <teravest@chromium.org>
[zwisler: updated changelog for 2nd bug fix and upstream]
Signed-off-by: Ross Zwisler <zwisler@google.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/google/gsmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index c463871609764..98cdfc2ee0dff 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -480,11 +480,10 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 	if (count < sizeof(u32))
 		return -EINVAL;
 	param.type = *(u32 *)buf;
-	count -= sizeof(u32);
 	buf += sizeof(u32);
 
 	/* The remaining buffer is the data payload */
-	if (count > gsmi_dev.data_buf->length)
+	if ((count - sizeof(u32)) > gsmi_dev.data_buf->length)
 		return -EINVAL;
 	param.data_len = count - sizeof(u32);
 
@@ -504,7 +503,7 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
-	return rc;
+	return (rc == 0) ? count : rc;
 
 }
 
-- 
2.20.1



