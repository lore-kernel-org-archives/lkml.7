Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EABC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A0F206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGaOAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:00:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfGaOAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:00:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AFEEC8CB03ECE0FCABD2;
        Wed, 31 Jul 2019 22:00:33 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 22:00:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <nishkadg.linux@gmail.com>,
        <madhumithabiw@gmail.com>, <hdegoede@redhat.com>,
        <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8723bs: remove set but not used variables 'prspbuf' and 'auth'
Date:   Wed, 31 Jul 2019 21:59:53 +0800
Message-ID: <20190731135953.16784-1-yuehaibing@huawei.com>
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

drivers/staging/rtl8723bs/core/rtw_cmd.c: In function rtw_cmd_thread:
drivers/staging/rtl8723bs/core/rtw_cmd.c:405:16: warning: variable prspbuf set but not used [-Wunused-but-set-variable]
drivers/staging/rtl8723bs/core/rtw_cmd.c: In function rtw_joinbss_cmd:
drivers/staging/rtl8723bs/core/rtw_cmd.c:771:6: warning: variable auth set but not used [-Wunused-but-set-variable]

They are never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index addc557..c6565b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -402,7 +402,7 @@ int rtw_cmd_thread(void *context)
 {
 	u8 ret;
 	struct cmd_obj *pcmd;
-	u8 *pcmdbuf, *prspbuf;
+	u8 *pcmdbuf;
 	unsigned long cmd_start_time;
 	unsigned long cmd_process_time;
 	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
@@ -414,7 +414,6 @@ int rtw_cmd_thread(void *context)
 	thread_enter("RTW_CMD_THREAD");
 
 	pcmdbuf = pcmdpriv->cmd_buf;
-	prspbuf = pcmdpriv->rsp_buf;
 
 	pcmdpriv->stop_req = 0;
 	atomic_set(&(pcmdpriv->cmdthd_running), true);
@@ -768,7 +767,7 @@ int rtw_startbss_cmd(struct adapter  *padapter, int flags)
 
 u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 {
-	u8 *auth, res = _SUCCESS;
+	u8 res = _SUCCESS;
 	uint	t_len = 0;
 	struct wlan_bssid_ex		*psecnetwork;
 	struct cmd_obj		*pcmd;
@@ -825,7 +824,6 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 
 	memcpy(psecnetwork, &pnetwork->network, get_wlan_bssid_ex_sz(&pnetwork->network));
 
-	auth = &psecuritypriv->authenticator_ie[0];
 	psecuritypriv->authenticator_ie[0] = (unsigned char)psecnetwork->IELength;
 
 	if ((psecnetwork->IELength-12) < (256-1)) {
-- 
2.7.4


