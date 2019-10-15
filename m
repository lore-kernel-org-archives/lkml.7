Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12624ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CA82067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfJOLzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:55:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729411AbfJOLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:55:23 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8496D818DE099A0C078F;
        Tue, 15 Oct 2019 19:55:21 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 19:55:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jarias.linux@gmail.com>,
        <julia.lawall@lip6.fr>, <colin.king@canonical.com>,
        <hdegoede@redhat.com>, <hariprasad.kelam@gmail.com>,
        <nachukannan@gmail.com>, <pakki001@umn.edu>,
        <hardiksingh.k@gmail.com>, <nishkadg.linux@gmail.com>,
        <dan.carpenter@oracle.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] staging: rtl8723bs: remove unnecessary null check
Date:   Tue, 15 Oct 2019 19:55:11 +0800
Message-ID: <20191015115511.26560-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191015114053.23496-1-yuehaibing@huawei.com>
References: <20191015114053.23496-1-yuehaibing@huawei.com>
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
v2: remove unnecessary 'hwxmits'
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 7011c2a..6d193f1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2206,12 +2206,9 @@ s32 rtw_alloc_hwxmits(struct adapter *padapter)
 
 void rtw_free_hwxmits(struct adapter *padapter)
 {
-	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-	hwxmits = pxmitpriv->hwxmits;
-	if (hwxmits)
-		kfree(hwxmits);
+	kfree(pxmitpriv->hwxmits);
 }
 
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
-- 
2.7.4


