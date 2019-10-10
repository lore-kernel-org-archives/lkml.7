Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3647206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfJJPf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:35:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfJJPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:35:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8494E1E0C49B7AF93035;
        Thu, 10 Oct 2019 23:35:55 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 10 Oct 2019
 23:35:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <shobhitkukreti@gmail.com>,
        <hariprasad.kelam@gmail.com>, <benniciemanuel78@gmail.com>,
        <nishkadg.linux@gmail.com>, <madhumithabiw@gmail.com>,
        <arnd@arndb.de>, <kai.heng.feng@canonical.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: Remove unnecessary null check
Date:   Thu, 10 Oct 2019 23:33:25 +0800
Message-ID: <20191010153325.16836-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Null check before kfree is redundant, so remove it.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 5044f73..74b097a 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1141,8 +1141,7 @@ void rtw_ndev_destructor(struct net_device *ndev)
 {
 	DBG_871X(FUNC_NDEV_FMT "\n", FUNC_NDEV_ARG(ndev));
 
-	if (ndev->ieee80211_ptr)
-		kfree(ndev->ieee80211_ptr);
+	kfree(ndev->ieee80211_ptr);
 }
 
 void rtw_dev_unload(struct adapter *padapter)
-- 
2.7.4


