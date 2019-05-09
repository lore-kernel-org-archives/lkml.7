Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BCC004C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF01216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEIDUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfEIDUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:20:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8EC33092649;
        Thu,  9 May 2019 03:20:22 +0000 (UTC)
Received: from hp-dl380pg8-02.lab.eng.pek2.redhat.com (hp-dl380pg8-02.lab.eng.pek2.redhat.com [10.73.8.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8E295C221;
        Thu,  9 May 2019 03:20:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuehaibing@huawei.com, xiyou.wangcong@gmail.com,
        weiyongjun1@huawei.com, eric.dumazet@gmail.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V3 1/2] tuntap: fix dividing by zero in ebpf queue selection
Date:   Wed,  8 May 2019 23:20:17 -0400
Message-Id: <1557372018-18544-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 09 May 2019 03:20:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need check if tun->numqueues is zero (e.g for the persist device)
before trying to use it for modular arithmetic.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 96f84061620c6("tun: add eBPF based queue selection method")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e9ca1c0..dc62fc3 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -596,13 +596,18 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
 	struct tun_prog *prog;
+	u32 numqueues;
 	u16 ret = 0;
 
+	numqueues = READ_ONCE(tun->numqueues);
+	if (!numqueues)
+		return 0;
+
 	prog = rcu_dereference(tun->steering_prog);
 	if (prog)
 		ret = bpf_prog_run_clear_cb(prog->prog, skb);
 
-	return ret % tun->numqueues;
+	return ret % numqueues;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
-- 
1.8.3.1

