Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8ACC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E07420851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCIDNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:13:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbfCIDNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:13:23 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8701EA4BE16447BC2733;
        Sat,  9 Mar 2019 11:13:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 9 Mar 2019 11:13:16 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <Larry.Finger@lwfinger.net>, <gregkh@linuxfoundation.org>,
        <straube.linux@gmail.com>, <jananis37@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead of memcmp()
Date:   Sat, 9 Mar 2019 11:26:00 +0800
Message-ID: <20190309032600.98732-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using is_zero_ether_addr() instead of directly use
memcmp() to determine if the ethernet address is all
zeros.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 714f7a70ed64..beae367df93b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
 	struct list_head *phead, *plist;
 	struct wlan_network *pnetwork = NULL;
-	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
 
-	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
+	if (is_zero_ether_addr(addr)) {
 		pnetwork = NULL;
 		goto exit;
 	}
-- 
2.20.1

