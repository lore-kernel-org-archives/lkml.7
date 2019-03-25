Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D020854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfCYMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:49:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbfCYMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:49:46 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYNW6-1hUvqI2maA-00VPkJ; Mon, 25 Mar 2019 13:49:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vishal Kulkarni <vishal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Arjun Vynipadath <arjun@chelsio.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] chelsio: use BUG() instead of BUG_ON(1)
Date:   Mon, 25 Mar 2019 13:49:16 +0100
Message-Id: <20190325124930.1435409-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PNTkGRuCd5wNhzroBHRqUL0XYRFAORHUb1U4ZwjFcxgkNSiS2LB
 rVcKnQH4LVKiDbYxw1e/7Gsd/nC5I7tg5SUjRhlZqqvd0tzPLSOHbuscZeG/yx/lvKueyjo
 rr3nGP2YXQnh6kayprJ+1hf8G2P4wMw8gdMhY5GWHN/HdXKuz7tCo+6vok8eNrC4y/g6HS2
 PDs7QpBijpHhAxgmF5f7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7DwBwJLjbCI=:4ROudwibWg1irKYwbIhP98
 LUlgwQTKvCWSigbJOJ+h7n9vHGnhOSeF4ZirJvw+7DF9TvuDPpIMI+P5dZE0G/+EQ/1XdsFbi
 YFXcyLkH6HsCAIlb6Q9sq3H7ihDRulq6c1U8qYcbkzs9GbedMQn+Oge4AmssPDNeMSoSujYwl
 x2SssNGAb1jfiOdwT8qrG5SiaWu1QA4epTAxf8ovDPesMBI0opUuCRbOUnsg7rPsPr85pha8r
 FV/1G70/ywa/iIX/OTMi1D8Nu06ubkyfRDb47RH/nTpHgE+rGfh7+MbVT1EC99IARBoXr2DAO
 H+mRR3QKCVsXzyoTXniwGJAxNMlGODcrqvFIwEDZLZDTanIxwhIuRf1eeemxqAUMNVCmRkAZU
 ncNN3+DVuUNRePOyC2YXpRarHlVk44LlNcagdrnsMF0LOfo3PzHSPowaDIBV6LscOm0uCAg0e
 gYFHevJdHjLokyglFo+ixbbVZ3N1ZF4/pqWXzbLemkOetmPz0uw8c2agNEbjCn01cja4JGGI7
 7pjzfb5D6V4jQ6uspYjXlRgABV5EwQ7AxmDavPilBS9DTUSJQ7aKStnk6NhamE+f0VK8nozpI
 CJMgIPWxCT+DEZqSG0qa0v8QVs7kEZBjLn2DJsaLyZ8FynUAerRTewTQ9j/42D3Zt5Z2SRNtr
 yasIDn02M7HHTKcBOHLuIx5kWJBDrhCAU1KycO1esZ1fA5uyRmq7jEwGZdKf/eMJ6JWl4luoK
 3Izktbv7a/rGdF7/OUPtFd2Yt8nZUIIFezZ+bQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns about possible bugs in a dead code branch after
BUG_ON(1) when CONFIG_PROFILE_ALL_BRANCHES is enabled:

 drivers/net/ethernet/chelsio/cxgb4/sge.c:479:3: error: variable 'buf_size' is used uninitialized whenever 'if'
      condition is false [-Werror,-Wsometimes-uninitialized]
                BUG_ON(1);
                ^~~~~~~~~
 include/asm-generic/bug.h:61:36: note: expanded from macro 'BUG_ON'
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                   ^~~~~~~~~~~~~~~~~~~
 include/linux/compiler.h:48:23: note: expanded from macro 'unlikely'
 #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/net/ethernet/chelsio/cxgb4/sge.c:482:9: note: uninitialized use occurs here
        return buf_size;
               ^~~~~~~~
 drivers/net/ethernet/chelsio/cxgb4/sge.c:479:3: note: remove the 'if' if its condition is always true
                BUG_ON(1);
                ^
 include/asm-generic/bug.h:61:32: note: expanded from macro 'BUG_ON'
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                               ^
 drivers/net/ethernet/chelsio/cxgb4/sge.c:459:14: note: initialize the variable 'buf_size' to silence this warning
        int buf_size;
                    ^
                     = 0

Use BUG() here to create simpler code that clang understands
correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 3130b43bba52..02959035ed3f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -2620,7 +2620,7 @@ static inline struct port_info *ethqset2pinfo(struct adapter *adap, int qset)
 	}
 
 	/* should never happen! */
-	BUG_ON(1);
+	BUG();
 	return NULL;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 88773ca58e6b..b3da81e90132 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -476,7 +476,7 @@ static inline int get_buf_size(struct adapter *adapter,
 		break;
 
 	default:
-		BUG_ON(1);
+		BUG();
 	}
 
 	return buf_size;
-- 
2.20.0

