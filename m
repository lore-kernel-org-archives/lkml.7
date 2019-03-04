Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB65CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C92C20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfCDUik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:38:40 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCDUij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:38:39 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M58OQ-1gzntI03fA-0018L2; Mon, 04 Mar 2019 21:38:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Zhu Yanjun <Yanjun.Zhu@windriver.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Xin Long <lucien.xin@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ignore sysctl_devconf_inherit_init_net without SYSCTL
Date:   Mon,  4 Mar 2019 21:38:03 +0100
Message-Id: <20190304203822.2094613-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TnilO3lewj64uim7MWi4MdhUWNKmPKRRsNaiZ6G5qnw+GpZyr9I
 ov8XwQyobzhZNYM++/l4Rwiehs/Y4doVZ+94G8h2KoSdzpT9+mBU/YJIWGvZfJEVGXgg/eK
 ft0xb6UpP3xauuapeFIKsULHPCAkW/NhyqeCOktfzPfEfI45qUhnQqmE9MZlAXv+15OMdzW
 V2YfeiOfMkZHdk+Hiztnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lJYKhv6F69k=:OALJeCLsYLqy9GJB33e9xm
 kBqCpfFgvsYLHVMjT7ioRkYDQUELqdhVchJXJahMQ0GjIrqFodZoHnIILJQi1dUMF8Utvfsbv
 i1hk5K/uuS9uw5ithkzgpDpwas9eS9S9bw+UhnS67uPb/HGXZCMXC8TT1oaUYrf4HqYw1mZti
 3iQqMHiA7oNuozK5LAiWTbh3+bLStmCuaoNae0TCjUtrbmrWs6Neq67ZIlJh5G9/SDs1vHMFd
 chcnl9I24Sg2dMMH7FQEclKBiz6nJ0bEzorYuD3JPK8MCK7dQ23iWIQ7bIZYuzijJdBXkpcCq
 52efS3WIzpuANOv3j0lyjV9y6bObGIqCplotpQa5R48OZMLBKawGy8bZWPs21sBIqLYU9d9d+
 e/mopFQkPRsIlzmTEzVZH+0ah0EhEJ/v1EsYvLsujDDIaY12PQtIWCZNzRB2lQhG6KffK5Dml
 u01BY5a3fzWCz/YjAkQQ6deCnoZ8C1tWW9JqRJsAoiA5PfvGJ4H60qXMZbT5xnt5+Fruvdqo4
 sk4sg1O+zqLqUnM4EtmomumPrYh/3MkHrBOaAxvUoVlAwXmHy4JmJoxjUr/0jcuqL2tgbYezB
 VjH67AnxCbeCyDQpjqtZjWBlge15U8S/5+PJy/vuxYxTgrI8jVdFW+NJ+wc2e1ENNMu/CLQVw
 wsXrQR0Ek2JVc0C9jvZ30H0/jJSB3R06/gw/Li5C3lr3KjAcpAhu6lan4y1G/1wSZA6rsuz9g
 rblxa7QzxDfvhOdcy+Ds30Mq9bpfvP0QBoCLDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SYSCTL is turned off, we get a link failure for
the newly introduced tuning knob.

net/ipv6/addrconf.o: In function `addrconf_init_net':
addrconf.c:(.text+0x31dc): undefined reference to `sysctl_devconf_inherit_init_net'

Add an IS_ENABLED() check to fall back to the default behavior
(sysctl_devconf_inherit_init_net=0) here.

Fixes: 856c395cfa63 ("net: introduce a knob to control whether to inherit devconf config")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv4/devinet.c  | 4 +++-
 net/ipv6/addrconf.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index cd9033245b98..eb514f312e6f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2614,7 +2614,9 @@ static __net_init int devinet_init_net(struct net *net)
 	tbl[0].extra2 = net;
 #endif
 
-	if (sysctl_devconf_inherit_init_net != 2 && !net_eq(net, &init_net)) {
+	if ((!IS_ENABLED(CONFIG_SYSCTL) ||
+	     sysctl_devconf_inherit_init_net != 2) &&
+	    !net_eq(net, &init_net)) {
 		memcpy(all, init_net.ipv4.devconf_all, sizeof(ipv4_devconf));
 		memcpy(dflt, init_net.ipv4.devconf_dflt, sizeof(ipv4_devconf_dflt));
 	}
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index da5a21050ba9..4ae17a966ae3 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6905,7 +6905,8 @@ static int __net_init addrconf_init_net(struct net *net)
 	if (!dflt)
 		goto err_alloc_dflt;
 
-	if (sysctl_devconf_inherit_init_net == 1 && !net_eq(net, &init_net)) {
+	if (IS_ENABLED(CONFIG_SYSCTL) &&
+	    sysctl_devconf_inherit_init_net == 1 && !net_eq(net, &init_net)) {
 		memcpy(all, init_net.ipv6.devconf_all, sizeof(ipv6_devconf));
 		memcpy(dflt, init_net.ipv6.devconf_dflt, sizeof(ipv6_devconf_dflt));
 	}
-- 
2.20.0

