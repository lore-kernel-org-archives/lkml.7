Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33235C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1393021721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfJIJqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:46:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56423 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfJIJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:46:07 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iI8Xj-0007JB-Go; Wed, 09 Oct 2019 09:46:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wfx: fix swapped arguments in memset call
Date:   Wed,  9 Oct 2019 10:46:02 +0100
Message-Id: <20191009094602.19663-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The memset appears to have the 2nd and 3rd arguments in the wrong
order, fix this by swapping these around into the correct order.

Addresses-Coverity: ("Memset fill truncated")
Fixes: 4f8b7fabb15d ("staging: wfx: allow to send commands to chip")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wfx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 8de16ad7c710..761ad9b4f27e 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -226,7 +226,7 @@ static ssize_t wfx_send_hif_msg_write(struct file *file, const char __user *user
 	// wfx_cmd_send() chekc that reply buffer is wide enough, but do not
 	// return precise length read. User have to know how many bytes should
 	// be read. Filling reply buffer with a memory pattern may help user.
-	memset(context->reply, sizeof(context->reply), 0xFF);
+	memset(context->reply, 0xFF, sizeof(context->reply));
 	request = memdup_user(user_buf, count);
 	if (IS_ERR(request))
 		return PTR_ERR(request);
-- 
2.20.1

