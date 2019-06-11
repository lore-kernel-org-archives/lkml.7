Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C0BC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E95208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfFKN7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:59:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387486AbfFKN7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:59:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D69CAE14E088B916F71;
        Tue, 11 Jun 2019 21:59:14 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 21:59:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <olteanv@gmail.com>, <andrew@lunn.ch>,
        <vivien.didelot@gmail.com>, <f.fainelli@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: dsa: sja1105: Make two functions static
Date:   Tue, 11 Jun 2019 21:58:34 +0800
Message-ID: <20190611135834.21080-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/net/dsa/sja1105/sja1105_main.c:1848:6:
 warning: symbol 'sja1105_port_rxtstamp' was not declared. Should it be static?
drivers/net/dsa/sja1105/sja1105_main.c:1869:6:
 warning: symbol 'sja1105_port_txtstamp' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 81e1ba5..9395e8f 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1845,8 +1845,8 @@ static void sja1105_rxtstamp_work(struct work_struct *work)
 }
 
 /* Called from dsa_skb_defer_rx_timestamp */
-bool sja1105_port_rxtstamp(struct dsa_switch *ds, int port,
-			   struct sk_buff *skb, unsigned int type)
+static bool sja1105_port_rxtstamp(struct dsa_switch *ds, int port,
+				  struct sk_buff *skb, unsigned int type)
 {
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_tagger_data *data = &priv->tagger_data;
@@ -1866,8 +1866,8 @@ bool sja1105_port_rxtstamp(struct dsa_switch *ds, int port,
  * the skb and have it available in DSA_SKB_CB in the .port_deferred_xmit
  * callback, where we will timestamp it synchronously.
  */
-bool sja1105_port_txtstamp(struct dsa_switch *ds, int port,
-			   struct sk_buff *skb, unsigned int type)
+static bool sja1105_port_txtstamp(struct dsa_switch *ds, int port,
+				  struct sk_buff *skb, unsigned int type)
 {
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_port *sp = &priv->ports[port];
-- 
2.7.4


