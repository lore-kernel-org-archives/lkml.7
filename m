Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18215C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E946920748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfL3JEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:04:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfL3JEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:04:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 50920F9B19CF0B29D4BF;
        Mon, 30 Dec 2019 17:04:04 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 17:03:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <socketcan@hartkopp.net>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: avoid unnecessary remove in can_remove_proc
Date:   Mon, 30 Dec 2019 17:03:33 +0800
Message-ID: <20191230090333.20664-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If net->can.proc_dir is null, there is no need to
do cleanup in can_remove_proc.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/can/proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/proc.c b/net/can/proc.c
index e6881bf..f84e977 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -471,6 +471,9 @@ void can_init_proc(struct net *net)
  */
 void can_remove_proc(struct net *net)
 {
+	if (!net->can.proc_dir)
+		return;
+
 	if (net->can.pde_version)
 		remove_proc_entry(CAN_PROC_VERSION, net->can.proc_dir);
 
-- 
2.7.4


