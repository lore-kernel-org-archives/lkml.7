Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49320652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCGQAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:00:41 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:35995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:00:40 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MfL5v-1gZlkv3lSl-00gs6s; Thu, 07 Mar 2019 17:00:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>, Wenwen Wang <wang6495@umn.edu>,
        Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ethtool: reduce stack usage with clang
Date:   Thu,  7 Mar 2019 16:58:35 +0100
Message-Id: <20190307160017.3120362-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T2IDOyorbgsgPpj+Bqgq7HPPcnC7R+qzlnvnoj1X7TcTxjdySDI
 zUZqAMZ2WK3VCIVGfBHlgrFIEUlgcDCSazoE08hDgh6ahBC6cP8CCFRId4uFTDA0yyz5GVV
 fhjgtjkGgIz0T2t1cUSq9vZQVBM3jQD7T7FRyvoHOeglKsVoGWI2uLgWrmtK4k4hzJLCynU
 7O6UE/gzzy14hkOMjclzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M8mJxqWzkoo=:dx+1+v6weoaqHui1MVb2w9
 XKlalBcOz+yGzVOqhaVoAr8gvjnwDPXzMMWpkPsP4rsckKA1q+tBqBZilIBWISce754bCwx0P
 fTL9Qqj2ODSlLE1kyXJdFSzgLJCwsXLU99QwJAh5OL7eeP4HnVzY3Jzj55xtZYkXuXkikcn3j
 g2N/XMp9vaIllMmzHZD3i+SXkMCXOw4gnWsB6qyHOQhbA/IUjlaHgexPo8TDnlevYhdU44WFO
 E2EcBXwlPaheZ+C89iXmwkdMgS0Wz1nzSdzpH1H9bsnh578wFkhvoTSSwidj8y5qbjdIxyGsL
 qhvRTx+KRNyhC1WFbArMmbL0MkQWRFwLtn4GGc0e159wKxBp7ef/iGUpu5tufI2Kkm11Z5R7s
 JTUIdGm6S9Su8nYJQ+pRacQ3okDSU+qdUyU3XFYmoutl87tchUpIvTVrM5bEglnhnkbpSuYKr
 sadmFUq+6KZB1SmYRZD1PfFYTjhxIsZ6fDPY53lev4AUrHkd77CW4Y5cpTCzZXgbZ6Gjt38YL
 HVis3cZUOl6yPZuAVkr6esdi5n9GHzrScHzOxBmIamMltA0d7TKDYkr5y0/wOpb4u1YlHHL04
 Dlm5vepNoZfCCwofvpOU5M2QvAwIi0KKSpWw2xD0WpEpBj2gBQlDnomIKykA2Lf51tZoGhClJ
 H9yl/35o6EsWcFQf2IYgDZBmyeF2PurPiSsth3+UD5M7L/Q/Nr7/tYAoMpocH8dWX1SVVZuVp
 P5LljWTwfEnRDprZv9eeMIMl6d8JRJLk4/4F9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang inlines the dev_ethtool() more aggressively than gcc does, leading
to a larger amount of used stack space:

net/core/ethtool.c:2536:24: error: stack frame size of 1216 bytes in function 'dev_ethtool' [-Werror,-Wframe-larger-than=]

Marking the sub-functions that require the most stack space as
noinline_for_stack gives us reasonable behavior on all compilers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: don't annotate dev_ethtool itself, as pointed out by Michal Kubecek
---
 net/core/ethtool.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index d4918ffddda8..b1eb32419732 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -2319,9 +2319,10 @@ static int ethtool_set_tunable(struct net_device *dev, void __user *useraddr)
 	return ret;
 }
 
-static int ethtool_get_per_queue_coalesce(struct net_device *dev,
-					  void __user *useraddr,
-					  struct ethtool_per_queue_op *per_queue_opt)
+static noinline_for_stack int
+ethtool_get_per_queue_coalesce(struct net_device *dev,
+			       void __user *useraddr,
+			       struct ethtool_per_queue_op *per_queue_opt)
 {
 	u32 bit;
 	int ret;
@@ -2349,9 +2350,10 @@ static int ethtool_get_per_queue_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static int ethtool_set_per_queue_coalesce(struct net_device *dev,
-					  void __user *useraddr,
-					  struct ethtool_per_queue_op *per_queue_opt)
+static noinline_for_stack int
+ethtool_set_per_queue_coalesce(struct net_device *dev,
+			       void __user *useraddr,
+			       struct ethtool_per_queue_op *per_queue_opt)
 {
 	u32 bit;
 	int i, ret = 0;
@@ -2405,7 +2407,7 @@ static int ethtool_set_per_queue_coalesce(struct net_device *dev,
 	return ret;
 }
 
-static int ethtool_set_per_queue(struct net_device *dev,
+static int noinline_for_stack ethtool_set_per_queue(struct net_device *dev,
 				 void __user *useraddr, u32 sub_cmd)
 {
 	struct ethtool_per_queue_op per_queue_opt;
-- 
2.20.0

