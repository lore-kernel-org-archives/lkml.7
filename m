Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE93C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 21:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8EF206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 21:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfEEVuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 17:50:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56846 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEEVuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 17:50:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hNP1Y-0000Xw-70; Sun, 05 May 2019 21:50:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] taprio: add null check on sched_nest to avoid potential null pointer dereference
Date:   Sun,  5 May 2019 22:50:19 +0100
Message-Id: <20190505215019.4639-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to nla_nest_start_noflag can return a null pointer and currently
this is not being checked and this can lead to a null pointer dereference
when the null pointer sched_nest is passed to function nla_nest_end. Fix
this by adding in a null pointer check.

Addresses-Coverity: ("Dereference null return value")
Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/sched/sch_taprio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 539677120b9f..9ecfb8f5902a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1087,6 +1087,8 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto done;
 
 	sched_nest = nla_nest_start_noflag(skb, TCA_TAPRIO_ATTR_ADMIN_SCHED);
+	if (!sched_nest)
+		goto options_error;
 
 	if (dump_schedule(skb, admin))
 		goto admin_error;
-- 
2.20.1

