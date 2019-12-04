Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96CCC43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D302073F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLDCuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:50:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33186 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfLDCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:50:22 -0500
Received: from localhost.localdomain (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 57BC2CEC92;
        Wed,  4 Dec 2019 03:59:28 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: uinput - Fix returning EPOLLOUT from uinput_poll
Date:   Wed,  4 Dec 2019 03:50:14 +0100
Message-Id: <20191204025014.5189-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always return EPOLLOUT from uinput_poll to allow polling /dev/uinput
for writable state.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
---
 drivers/input/misc/uinput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 84051f20b18a..fd253781be71 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -695,7 +695,7 @@ static __poll_t uinput_poll(struct file *file, poll_table *wait)
 	if (udev->head != udev->tail)
 		return EPOLLIN | EPOLLRDNORM;
 
-	return 0;
+	return EPOLLOUT | EPOLLWRNORM;
 }
 
 static int uinput_release(struct inode *inode, struct file *file)
-- 
2.23.0

