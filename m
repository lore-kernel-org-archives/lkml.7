Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE5AC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BA3206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfD0DdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:33:14 -0400
Received: from www.osadl.org ([62.245.132.105]:38461 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbfD0DdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:33:13 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3R3WuZF012005;
        Sat, 27 Apr 2019 05:32:56 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     David Lin <dtwlin@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: greybus: use proper return type for  wait_for_completion_timeout
Date:   Sat, 27 Apr 2019 05:27:25 +0200
Message-Id: <1556335645-7583-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long (0 on timeout or
remaining jiffies) not int. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem located with experimental API conformance checking cocci script

Patch was compile-tested with: x86_64_defconfig + GREYBUS=m

Patch is against 5.1-rc6 (localversion-next is next-20190426)

 drivers/staging/greybus/uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index b3bffe9..ff18112 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -323,7 +323,7 @@ static int send_break(struct gb_tty *gb_tty, u8 state)
 
 static int gb_uart_wait_for_all_credits(struct gb_tty *gb_tty)
 {
-	int ret;
+	unsigned long ret;
 
 	if (gb_tty->credits == GB_UART_FIRMWARE_CREDITS)
 		return 0;
-- 
2.1.4

