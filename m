Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA93C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B3920820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbfIEPWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:22:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38739 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbfIEPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:22:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i5tad-0007qi-Pw; Thu, 05 Sep 2019 15:22:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] staging: rtl8723bs: hal: remove redundant variable n
Date:   Thu,  5 Sep 2019 16:22:27 +0100
Message-Id: <20190905152227.4610-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable n is being assigned a value that is never read inside
an if statement block, the assignment is redundant and can be removed.
With this removed, n is only being used for a constant loop bounds
check, so replace n with that value instead and remove n completely.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>

---

V2: remove the variable n completely, thanks to Dan Carpenter for
    spotting this.

---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 032d01834f3f..0f3301091258 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -502,7 +502,7 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
  */
 void rtl8723bs_free_recv_priv(struct adapter *padapter)
 {
-	u32 i, n;
+	u32 i;
 	struct recv_priv *precvpriv;
 	struct recv_buf *precvbuf;
 
@@ -514,9 +514,8 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 	/* 3 2. free all recv buffers */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	if (precvbuf) {
-		n = NR_RECVBUFF;
 		precvpriv->free_recv_buf_queue_cnt = 0;
-		for (i = 0; i < n ; i++) {
+		for (i = 0; i < NR_RECVBUFF; i++) {
 			list_del_init(&precvbuf->list);
 			rtw_os_recvbuf_resource_free(padapter, precvbuf);
 			precvbuf++;
@@ -525,7 +524,6 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 	}
 
 	if (precvpriv->pallocated_recv_buf) {
-		n = NR_RECVBUFF * sizeof(struct recv_buf) + 4;
 		kfree(precvpriv->pallocated_recv_buf);
 		precvpriv->pallocated_recv_buf = NULL;
 	}
-- 
2.20.1

