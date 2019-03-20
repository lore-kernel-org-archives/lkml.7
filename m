Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0702721850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfCTNsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:48:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbfCTNsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:48:41 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 76C13600897235FE314D;
        Wed, 20 Mar 2019 21:48:38 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 21:48:30 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <isdn@linux-pingi.de>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: isdn: Make isdn_ppp_mp_discard and isdn_ppp_mp_reassembly static
Date:   Wed, 20 Mar 2019 21:48:06 +0800
Message-ID: <20190320134806.22100-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/isdn/i4l/isdn_ppp.c:1891:16: warning:
 symbol 'isdn_ppp_mp_discard' was not declared. Should it be static?
drivers/isdn/i4l/isdn_ppp.c:1903:6: warning:
 symbol 'isdn_ppp_mp_reassembly' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/isdn/i4l/isdn_ppp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_ppp.c b/drivers/isdn/i4l/isdn_ppp.c
index a7b275e..7e0f419 100644
--- a/drivers/isdn/i4l/isdn_ppp.c
+++ b/drivers/isdn/i4l/isdn_ppp.c
@@ -1888,8 +1888,9 @@ static u32 isdn_ppp_mp_get_seq(int short_seq,
 	return seq;
 }
 
-struct sk_buff *isdn_ppp_mp_discard(ippp_bundle *mp,
-				    struct sk_buff *from, struct sk_buff *to)
+static struct sk_buff *isdn_ppp_mp_discard(ippp_bundle *mp,
+					   struct sk_buff *from,
+					   struct sk_buff *to)
 {
 	if (from)
 		while (from != to) {
@@ -1900,8 +1901,8 @@ struct sk_buff *isdn_ppp_mp_discard(ippp_bundle *mp,
 	return from;
 }
 
-void isdn_ppp_mp_reassembly(isdn_net_dev *net_dev, isdn_net_local *lp,
-			    struct sk_buff *from, struct sk_buff *to)
+static void isdn_ppp_mp_reassembly(isdn_net_dev *net_dev, isdn_net_local *lp,
+				   struct sk_buff *from, struct sk_buff *to)
 {
 	ippp_bundle *mp = net_dev->pb;
 	int proto;
-- 
2.7.0


