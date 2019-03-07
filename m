Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AD820652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCGPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:52:43 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCGPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:52:43 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mj8eD-1gY4Ht27Eb-00f8pI; Thu, 07 Mar 2019 16:52:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
Date:   Thu,  7 Mar 2019 16:52:24 +0100
Message-Id: <20190307155230.2923527-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KoZi1R4fOqB4e75Y1+qFioY60GfAUcFHJFAVYc2AriyZz0/erqb
 TrQ2dyp6Sry6PY2weIasG/q5Mz03RsLnzCTaDF3h1v1bUnl3QZy4FoBCgwWw/fvPAxq9J3f
 COaRYcY8vnxERHKwujPeOGJLazgPSoQ3rJecx63RG7MBGyE+O+RwYToSOnx7/0YlVBaOCQw
 3yhpqXqXTyOotWf8HnutA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pXyhY2Zy6Q8=:lG0nQjK2TFzbwaZn7McGMJ
 y9NkbB1V/0BR813bnPC+ghnpAdXImbco0l4VLYfe97XNjcoN8XCIA99Rc7Xxf+o5syrId7rUm
 V10uqUGga40z33UdGQFzdknzqX0Bb8KTtwseuFVfkUfFf19nsuFo3FgdHg9qujnZplecyoFOv
 1nlpcYVYqJg2j4N65RD503/HvI1aPKzggeay0nk4DVHspSwPCz/I1r9+rqhFB9GGwQuDBaIck
 jGqqAvpRlxR3sNywMn+04wpYiaNtAIYIpnXBHygN+G5TZ8a8P4+dmubWey6CwG5ya8LWgw0Og
 PbZfhGXpPF1DNOh/9b/tAknLNbUcA2wn5RPJcaG67Vqs4Ah5WGNjngNKJZsd0nt9RZxH696Qf
 jEqfIanqOQNF1lY/t3vaP96zKpmNONPkOo8NfeNAp+jLyrEW4zVRMND3fO99cTJ75KtG/dHMt
 AzNPAu4/Xnvn5QRFYhyhuQ4IrH40ewaT4oL2j5Jeh3ejrCvm1HAj5wgqcsafBwlIGwcmWzwGz
 ncTcFLpL59m6CfKSbABGX/lpWNE1Lt2p5q8IhjQz4GmIbAlaAuJkrw9yTCUaSJHxW+gX4L7gR
 Gj5Kbadlf8QYtEEnitNXSwEIYVoToowubhm++KLWQefrP0WNkIwc2vJkaNYPVCwN1ndBi0EAX
 d+aq86UmayrZuQti3LBkZlJiqB/Z1eOSst8P6u9zTyE7TfiJBmcDDUYW8MCo6qTNrwSkxzA0A
 F56QomdQcbczv3/YDqBDJrnYfqKlSiG9+W5kyQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enic driver relies on the CONFIG_CPUMASK_OFFSTACK feature to
dynamically allocate a struct member, but this is normally intended for
local variables.

Building with clang, I get a warning for a few locations that check the
address of the cpumask_var_t:

drivers/net/ethernet/cisco/enic/enic_main.c:122:22: error: address of array 'enic->msix[i].affinity_mask' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]

As far as I can tell, the code is still correct, as the truth value of
the pointer is what we need in this configuration. To get rid of
the warning, use cpumask_available() instead of checking the
pointer directly.

Fixes: 322cf7e3a4e8 ("enic: assign affinity hint to interrupts")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use cpumask_available() instead of open-coding a copy
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 9a7f70db20c7..733d9172425b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -119,7 +119,7 @@ static void enic_init_affinity_hint(struct enic *enic)
 
 	for (i = 0; i < enic->intr_count; i++) {
 		if (enic_is_err_intr(enic, i) || enic_is_notify_intr(enic, i) ||
-		    (enic->msix[i].affinity_mask &&
+		    (cpumask_available(enic->msix[i].affinity_mask) &&
 		     !cpumask_empty(enic->msix[i].affinity_mask)))
 			continue;
 		if (zalloc_cpumask_var(&enic->msix[i].affinity_mask,
@@ -148,7 +148,7 @@ static void enic_set_affinity_hint(struct enic *enic)
 	for (i = 0; i < enic->intr_count; i++) {
 		if (enic_is_err_intr(enic, i)		||
 		    enic_is_notify_intr(enic, i)	||
-		    !enic->msix[i].affinity_mask	||
+		    !cpumask_available(enic->msix[i].affinity_mask) ||
 		    cpumask_empty(enic->msix[i].affinity_mask))
 			continue;
 		err = irq_set_affinity_hint(enic->msix_entry[i].vector,
@@ -161,7 +161,7 @@ static void enic_set_affinity_hint(struct enic *enic)
 	for (i = 0; i < enic->wq_count; i++) {
 		int wq_intr = enic_msix_wq_intr(enic, i);
 
-		if (enic->msix[wq_intr].affinity_mask &&
+		if (cpumask_available(enic->msix[wq_intr].affinity_mask) &&
 		    !cpumask_empty(enic->msix[wq_intr].affinity_mask))
 			netif_set_xps_queue(enic->netdev,
 					    enic->msix[wq_intr].affinity_mask,
-- 
2.20.0

