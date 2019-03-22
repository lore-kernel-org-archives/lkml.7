Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732DD218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfCVOSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:18:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfCVOSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:18:50 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2Nm2-1h8yMD23P4-003uZd; Fri, 22 Mar 2019 15:18:23 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tuong Lien <tuong.t.lien@dektech.com.au>,
        LUU Duc Canh <canh.d.luu@dektech.com.au>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        GhantaKrishnamurthy MohanKrishna 
        <mohan.krishna.ghanta.krishnamurthy@ericsson.com>,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: avoid a clang -Wuninitialized warning
Date:   Fri, 22 Mar 2019 15:18:13 +0100
Message-Id: <20190322141819.641588-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:isPCzBhvBx3WDuN6GcMetSXY3KKMQE5Qy8ClvkDoQMtqCW2QSCS
 zJbJGzhns+yFA8NDcWzL5ef9mNt+odyqtu+FbC8CJamiuVm/w7ldWVZaXiop7SSTZaVOL0q
 g8hmgHk+efsJDBwy8q1nK8e+5JjGzO0DWJcB93LLQ8KNYd1CuNOYXdrdz2WPJwH9+oD7jJZ
 bRQ3QepvGxgKxEhLCYZRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UJWe9zz0h2g=:+i9wq1l6kMcEl2JqILUoLU
 //5nDcNHN4DOU3RGyaz3NaI4TpNtOV5XEe5DCEfUv1xbSyy3rabT6IvQjV2RLI4MnKeA3M7IB
 cdry58oT0zf7L8Ag0xXLmgMJABZ1fokBU6fK3aLYbpgJHoQQqladmd8OBChYDW6LS0R8su7c2
 b0C9Ag38ZMIfm+4vfOKSU5Sjqu4Wn3YzOJ+sxc9OfRo54JOjRwgwNzF3i18MecgXq2VdPS+57
 +/rWPh7e4Xs2CYw3c3fq9bn8hWbUITjuL8hwy0T6Ni1NuxtU7MQx+hq0KrmAJkOgc5mCWEUFk
 ubHnWmA8ZC/EBktK5U8HpSHPWgRjs8zVZ6ly2phKU0z9tPeoxrA2K/GeN7DJ9wkeRaOTagDFl
 /VWIwlBtjitxTxPPs99cB9MSElhLX6GtORi4MQPjpi8MAtX7aaRlaAfFtXRenQL1PVCWXBVBj
 vly/kVIJVfHhtzC38twY3bb6FcFAX+zHWTmIWntUcISTQ6iktansdBgCRp1Pa5KNmblPhHvKK
 bMma2oGtOKsB8aJBSWaxySV6E/FGUY15FfRL55O6DvO1AnKnaFDrhqNUP7v4169ffDSXdKtZ2
 lHHNFMUeNxu7yU1ZyI088ruYRDnFkJxmhCwzdeUfYIs3iCasTWUjPlHsueDVPwV7k4ODg8nYi
 V6k6psiif8TWsd3ShyM1zRkUfU+xr24wGHa+ADhUREzxL+Nq68jBU2MZRRYFIRfJifUvF+cQN
 KgUJ1Dl42h/bA9ttf5Jfc6yJuB1cO63PN3ovPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang notices that we pass 'maddr' into the tipc_bearer_xmit() function
without having initialized it first:

net/tipc/node.c:831:6: error: variable 'maddr' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
        if (!tipc_link_is_establishing(l)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/node.c:847:46: note: uninitialized use occurs here
        tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
                                                    ^~~~~
net/tipc/node.c:831:2: note: remove the 'if' if its condition is always true
        if (!tipc_link_is_establishing(l)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/node.c:821:31: note: initialize the variable 'maddr' to silence this warning
        struct tipc_media_addr *maddr;
                                     ^
                                      = NULL

This is harmless because it won't use 'maddr' if the
queue is empty, but it's better to make that explicit
and not even call the function in that case.

As clang is able to inline the check, it then notices that
the code is safe.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/tipc/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 2dc4919ab23c..ca4cafd00a38 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -844,7 +844,8 @@ static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
 	tipc_node_write_unlock(n);
 	if (delete)
 		tipc_mon_remove_peer(n->net, n->addr, old_bearer_id);
-	tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
+	if (!skb_queue_empty(&xmitq))
+		tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
 	tipc_sk_rcv(n->net, &le->inputq);
 }
 
-- 
2.20.0

