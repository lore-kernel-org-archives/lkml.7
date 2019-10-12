Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CBC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE93206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfJLHQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 03:16:23 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60060 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbfJLHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:16:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=zhiyuan2048@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TenwfOo_1570864580;
Received: from localhost(mailfrom:zhiyuan2048@linux.alibaba.com fp:SMTPD_---0TenwfOo_1570864580)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Oct 2019 15:16:20 +0800
From:   Zhiyuan Hou <zhiyuan2048@linux.alibaba.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: sched: act_mirred: drop skb's dst_entry in ingress redirection
Date:   Sat, 12 Oct 2019 15:16:20 +0800
Message-Id: <20191012071620.8595-1-zhiyuan2048@linux.alibaba.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In act_mirred's ingress redirection, if the skb's dst_entry is valid
when call function netif_receive_skb, the fllowing l3 stack process
(ip_rcv_finish_core) will check dst_entry and skip the routing
decision. Using the old dst_entry is unexpected and may discard the
skb in some case. For example dst->dst_input points to dst_discard.

This patch drops the skb's dst_entry before calling netif_receive_skb
so that the skb can be made routing decision like a normal ingress
skb.

Signed-off-by: Zhiyuan Hou <zhiyuan2048@linux.alibaba.com>
---
 net/sched/act_mirred.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 9ce073a05414..6108a64c0cd5 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -18,6 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/if_arp.h>
 #include <net/net_namespace.h>
+#include <net/dst.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
@@ -298,8 +299,10 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 
 	if (!want_ingress)
 		err = dev_queue_xmit(skb2);
-	else
+	else {
+		skb_dst_drop(skb2);
 		err = netif_receive_skb(skb2);
+	}
 
 	if (err) {
 out:
-- 
2.21.0

