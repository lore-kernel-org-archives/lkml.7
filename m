Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7FDC17498
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F17217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S55SVB4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbfKEOto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:49:44 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:41496 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fmCmuOAiEUwEwfeCcX
        FYBqOu7taXOPv5Mn5DJrGyiqw=; b=S55SVB4XKcW2KybHxCblxfDEYjf39VXJHa
        9PxmKcMsjybQcsDcQjhwRDdgN6mLTwVVNX4CTcbIApI9QLE3jRBQZADnNtizuIkh
        bGbz570JGl7Ns+z6jp2Rj1ub4+do+qBEKtdk51uzr4WLAIuGDQDSiZhGQP2W92Be
        +6L1Zee4k=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgD3iCLvi8FdNofqJw--.256S3;
        Tue, 05 Nov 2019 22:49:23 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] staging: rtl8192e: fix potential use after free
Date:   Tue,  5 Nov 2019 22:49:11 +0800
Message-Id: <1572965351-6745-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HdxpCgD3iCLvi8FdNofqJw--.256S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr48JF48Ww4fAw1xXrWxXrb_yoW8Jw1UpF
        4rGwnIyrWUZr48u3ykAFWIgryFka1SgF9agay3X3yrZrZxCw1rXryqvFyjqr45CrZ3CF4a
        qFn5Kr15uan8WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXeOXUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBURNkclaD5I2j7AAAsn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable skb is released via kfree_skb() when the return value of
_rtl92e_tx is not zero. However, after that, skb is accessed again to
read its length, which may result in a use after free bug. This patch
fixes the bug by moving the release operation to where skb is never
used later.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f932cb15e4e5..cdcb22f96ed9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1616,14 +1616,15 @@ static void _rtl92e_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 	memcpy((unsigned char *)(skb->cb), &dev, sizeof(dev));
 	skb_push(skb, priv->rtllib->tx_headroom);
 	ret = _rtl92e_tx(dev, skb);
-	if (ret != 0)
-		kfree_skb(skb);
 
 	if (queue_index != MGNT_QUEUE) {
 		priv->rtllib->stats.tx_bytes += (skb->len -
 						 priv->rtllib->tx_headroom);
 		priv->rtllib->stats.tx_packets++;
 	}
+
+	if (ret != 0)
+		kfree_skb(skb);
 }
 
 static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.7.4

