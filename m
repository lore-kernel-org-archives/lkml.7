Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CBF20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCSVQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:16:29 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:16:29 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N01hu-1gm3aw2RhG-00x1eV; Tue, 19 Mar 2019 22:16:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 3c515: fix integer overflow warning
Date:   Tue, 19 Mar 2019 22:15:58 +0100
Message-Id: <20190319211621.3466443-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Br1gpG0HzUNciC09SPVA7dwsqMQJVJxDJB1m72WcRRx1Em5zUa/
 OC+CWkRvGR/bpqzo6I/UHerAO8gExi8T7J2E806P0Fl9+copCKrCig4gci8qg99Q2dGYOIr
 ZMYEVmGAMLLsp0+mDW5rwXckNuoc2DiNLo4TheWGcRnoXH+aGa5lV7awnLl4QeW1ql0fNYi
 PQLvp4CWZcqYJVoweuq8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQ/zHLbCGm8=:N1aJuCA7ITCWYTSuQ2dLfB
 1W7dEYlSbdCcWk0pNXc6V4g73fSZDRzD7QNS4gtGfnuk6OHhmygyqhUrVf0vDQimoS7iE3prX
 nBfVyNUcCxQ1mQXm0Bhp+dXuFvY0pIYHZvay56iZY7l/iV44qJ1bA3NqeGhB5ceTsBuZvdmyX
 B5lpEfV5qam/RTiCpBkh48x4796egXmbOmbHpsiiSZ7FO+xAOKK3/vnf6TAzjDZqRITByMjyG
 W9GW9tebTnxgkkaLwtSrsGoYyCU7FbwUQ6aHKydKBBMtaGHLDgrnVvQcRMhEOXrI4QVj5EwkG
 HdjAC5a0t/JKWtRMBJM3h7GpVfrQM8tokD3Rc3eFhSD4PcpqkWYCdCELTIIhGd3H+oVeRrryz
 aqckJpP4zmLzpOkraf71xX3/wsfqtfl4S6bh6b9zXyI5kwNG3qzYi4wXQBuYUVAzQoGsPeSg3
 dKSbYiob481TupAxel6ODuytou5HSHK3XqUhkzLR7RQo/bppM95GiTgtrVKgN8pxTl1Vsp4Bu
 LCYpNvSfYsCTQvlsnl6LJH6nSKroUMUnpzHce1B94JP1QzjNm4iSjuismqMVCQWR7RZcw1YWE
 U+uwGPWlRCM04K31qgeFPt53HiR4uiAbegZjD5T9Qwnz7VWip1d9vXRfbeCt845hJ6RU7isOm
 QXTGug0V1cbTblouKZWDEyhn3gio6hKzhocJNDfXr6z9PTItvte194kh2MWd0l3Jwtp4qt5is
 hkowFjjsGA9gfPxYfflAQFjY+NwXRxnlt8EIUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out a harmless signed integer overflow:

drivers/net/ethernet/3com/3c515.c:1530:66: error: implicit conversion from 'int' to 'short' changes value from 32783 to -32753 [-Werror,-Wconstant-conversion]
                new_mode = SetRxFilter | RxStation | RxMulticast | RxBroadcast | RxProm;
                         ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
drivers/net/ethernet/3com/3c515.c:1532:52: error: implicit conversion from 'int' to 'short' changes value from 32775 to -32761 [-Werror,-Wconstant-conversion]
                new_mode = SetRxFilter | RxStation | RxMulticast | RxBroadcast;
                         ~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
drivers/net/ethernet/3com/3c515.c:1534:38: error: implicit conversion from 'int' to 'short' changes value from 32773 to -32763 [-Werror,-Wconstant-conversion]
                new_mode = SetRxFilter | RxStation | RxBroadcast;
                         ~ ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~

Make the variable unsigned to avoid the overflow.

Fixes: Linux-2.1.128pre1
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/3com/3c515.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c515.c b/drivers/net/ethernet/3com/3c515.c
index 808abb6b3671..b15752267c8d 100644
--- a/drivers/net/ethernet/3com/3c515.c
+++ b/drivers/net/ethernet/3com/3c515.c
@@ -1521,7 +1521,7 @@ static void update_stats(int ioaddr, struct net_device *dev)
 static void set_rx_mode(struct net_device *dev)
 {
 	int ioaddr = dev->base_addr;
-	short new_mode;
+	unsigned short new_mode;
 
 	if (dev->flags & IFF_PROMISC) {
 		if (corkscrew_debug > 3)
-- 
2.20.0

