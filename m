Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F98C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82B820721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfLIGgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:36:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfLIGgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:36:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B54BC5A4011FE2D5488;
        Mon,  9 Dec 2019 14:36:15 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Dec 2019
 14:36:05 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <rostedt@goodmis.org>, <acme@redhat.com>, <tstoyanov@vmware.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>
Subject: [PATCH] tools lib traceevent: Fix memory leakage in filter_event
Date:   Mon, 9 Dec 2019 01:35:49 -0500
Message-ID: <20191209063549.59941-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is necessary to call free_arg(arg) when add_filter_type returns NULL in
the function of filter_event.

Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/lib/traceevent/parse-filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index f3cbf86e51ac..20eed719542e 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1228,8 +1228,10 @@ filter_event(struct tep_event_filter *filter, struct tep_event *event,
 	}
 
 	filter_type = add_filter_type(filter, event->id);
-	if (filter_type == NULL)
+	if (filter_type == NULL) {
+		free_arg(arg);
 		return TEP_ERRNO__MEM_ALLOC_FAILED;
+	}
 
 	if (filter_type->filter)
 		free_arg(filter_type->filter);
-- 
2.19.1

