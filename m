Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762AC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9892182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEJDCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:02:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfEJDCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:02:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B59A487FC2F1D446DB16;
        Fri, 10 May 2019 11:02:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 11:02:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] dsa: tag_brcm: Fix build error without CONFIG_NET_DSA_TAG_BRCM_PREPEND
Date:   Fri, 10 May 2019 11:00:28 +0800
Message-ID: <20190510030028.31564-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error:

net/dsa/tag_brcm.c:211:16: error: brcm_prepend_netdev_ops undeclared here (not in a function); did you mean brcm_netdev_ops?
 DSA_TAG_DRIVER(brcm_prepend_netdev_ops);
                ^
./include/net/dsa.h:708:10: note: in definition of macro DSA_TAG_DRIVER
  .ops = &__ops,       \
          ^~~~~
./include/net/dsa.h:701:36: warning: dsa_tag_driver_brcm_prepend_netdev_ops defined but not used [-Wunused-variable]
 #define DSA_TAG_DRIVER_NAME(__ops) dsa_tag_driver ## _ ## __ops
                                    ^
./include/net/dsa.h:707:30: note: in expansion of macro DSA_TAG_DRIVER_NAME
 static struct dsa_tag_driver DSA_TAG_DRIVER_NAME(__ops) = {  \
                              ^~~~~~~~~~~~~~~~~~~
net/dsa/tag_brcm.c:211:1: note: in expansion of macro DSA_TAG_DRIVER
 DSA_TAG_DRIVER(brcm_prepend_netdev_ops);

Like the CONFIG_NET_DSA_TAG_BRCM case,
brcm_prepend_netdev_ops and DSA_TAG_PROTO_BRCM_PREPEND
should be wrappeed by CONFIG_NET_DSA_TAG_BRCM_PREPEND.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: b74b70c44986 ("net: dsa: Support prepended Broadcom tag")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/dsa/tag_brcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index d52db5f..9c31141 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -206,10 +206,10 @@ static const struct dsa_device_ops brcm_prepend_netdev_ops = {
 	.rcv	= brcm_tag_rcv_prepend,
 	.overhead = BRCM_TAG_LEN,
 };
-#endif
 
 DSA_TAG_DRIVER(brcm_prepend_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM_PREPEND);
+#endif
 
 static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM)
-- 
2.7.4


