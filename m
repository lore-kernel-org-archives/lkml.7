Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1900C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FD3206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfHUMYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:24:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfHUMYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:24:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6924D7FB78D749D043E3;
        Wed, 21 Aug 2019 20:24:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 20:23:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <ebiggers@google.com>,
        <contact@christina-quast.de>, <payal.s.kshirsagar.98@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: rtl8192u: ieee80211: remove set but not used variable 'data_len'
Date:   Wed, 21 Aug 2019 20:22:50 +0800
Message-ID: <20190821122250.71404-1-yuehaibing@huawei.com>
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

drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c:
 In function ieee80211_ccmp_encrypt:
drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c:162:6:
 warning: variable data_len set but not used [-Wunused-but-set-variable]

It is not used since commit eb0e7bf3ca94 ("staging:
rtl8192u: ieee80211: ieee80211_crypt_ccmp.c: Use crypto API ccm(aes)")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index aecee42..a43a5d6 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -159,7 +159,7 @@ static int ccmp_init_iv_and_aad(struct rtl_80211_hdr_4addr *hdr,
 static int ieee80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct ieee80211_ccmp_data *key = priv;
-	int data_len, i;
+	int i;
 	u8 *pos;
 	struct rtl_80211_hdr_4addr *hdr;
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
@@ -169,7 +169,6 @@ static int ieee80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	    skb->len < hdr_len)
 		return -1;
 
-	data_len = skb->len - hdr_len;
 	pos = skb_push(skb, CCMP_HDR_LEN);
 	memmove(pos, pos + CCMP_HDR_LEN, hdr_len);
 	pos += hdr_len;
-- 
2.7.4


