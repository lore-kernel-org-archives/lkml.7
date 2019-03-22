Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39711C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1075C218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfCVO2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:28:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbfCVO2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:28:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2487A7850B8F5480BC1;
        Fri, 22 Mar 2019 22:27:59 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:27:53 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <paulmck@linux.ibm.com>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] rcu/tree: Make rcu_check_gp_start_stall static
Date:   Fri, 22 Mar 2019 22:26:59 +0800
Message-ID: <20190322142659.12368-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

kernel/rcu/tree.c:2643:1: warning:
 symbol 'rcu_check_gp_start_stall' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acd6ccf..ed3ef40 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2639,7 +2639,7 @@ EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
  * This function checks for grace-period requests that fail to motivate
  * RCU to come out of its idle mode.
  */
-void
+static void
 rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 			 const unsigned long gpssdelay)
 {
-- 
2.7.0


