Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EA0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5604A22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfGZOLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:11:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfGZOL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:11:29 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D65FF879E7F7B9D1E28;
        Fri, 26 Jul 2019 22:11:27 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 22:11:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <nishkadg.linux@gmail.com>,
        <mamtashukla555@gmail.com>, <hariprasad.kelam@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 06/10] staging: rtl8723bs: os_dep: remove two set but not used variables
Date:   Fri, 26 Jul 2019 22:09:59 +0800
Message-ID: <20190726140959.15008-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/staging/rtl8723bs//os_dep/osdep_service.c: In function 'rtw_buf_free':
drivers/staging/rtl8723bs//os_dep/osdep_service.c:321:6: warning:
 variable 'ori_len' set but not used [-Wunused-but-set-variable]
drivers/staging/rtl8723bs//os_dep/ioctl_linux.c: In function 'rtw_ioctl_wext_private':
drivers/staging/rtl8723bs//os_dep/ioctl_linux.c:4915:6: warning:
 variable 'num_priv' set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c   | 2 --
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 99e6b10..90c2997 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4912,7 +4912,6 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 	s32 k;
 	const iw_handler *priv;		/* Private ioctl */
 	const struct iw_priv_args *priv_args;	/* Private ioctl description */
-	u32 num_priv;				/* Number of ioctl */
 	u32 num_priv_args;			/* Number of descriptions */
 	iw_handler handler;
 	int temp;
@@ -4948,7 +4947,6 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 
 	priv = rtw_private_handler;
 	priv_args = rtw_private_args;
-	num_priv = ARRAY_SIZE(rtw_private_handler);
 	num_priv_args = ARRAY_SIZE(rtw_private_args);
 
 	if (num_priv_args == 0) {
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 62fdd24..25a8004 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -318,13 +318,9 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 
 void rtw_buf_free(u8 **buf, u32 *buf_len)
 {
-	u32 ori_len;
-
 	if (!buf || !buf_len)
 		return;
 
-	ori_len = *buf_len;
-
 	if (*buf) {
 		*buf_len = 0;
 		kfree(*buf);
-- 
2.7.4


