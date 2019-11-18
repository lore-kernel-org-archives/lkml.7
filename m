Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7366FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525EB20718
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 03:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfKRDmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 22:42:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbfKRDmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 22:42:50 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2A31BA40426FC01916C5;
        Mon, 18 Nov 2019 11:42:48 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 18 Nov 2019
 11:42:37 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <rostedt@goodmis.org>, <acme@redhat.com>, <tstoyanov@vmware.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, <hushiyuan@huawei.com>
Subject: [PATCH] tools lib traceevent: Fix memory leakage in copy_filter_type
Date:   Sun, 17 Nov 2019 22:42:29 -0500
Message-ID: <20191118034229.63591-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191113154044.5b591bf8@gandalf.local.home>
References: <20191113154044.5b591bf8@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is necessary to free the memory that we have allocated when error occurs.

Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filter_type()")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/parse-filter.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 552592d153fb..f3cbf86e51ac 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1473,8 +1473,10 @@ static int copy_filter_type(struct tep_event_filter *filter,
 	if (strcmp(str, "TRUE") == 0 || strcmp(str, "FALSE") == 0) {
 		/* Add trivial event */
 		arg = allocate_arg();
-		if (arg == NULL)
+		if (arg == NULL) {
+			free(str);
 			return -1;
+		}
 
 		arg->type = TEP_FILTER_ARG_BOOLEAN;
 		if (strcmp(str, "TRUE") == 0)
@@ -1483,8 +1485,11 @@ static int copy_filter_type(struct tep_event_filter *filter,
 			arg->boolean.value = 0;
 
 		filter_type = add_filter_type(filter, event->id);
-		if (filter_type == NULL)
+		if (filter_type == NULL) {
+			free(str);
+			free_arg(arg);
 			return -1;
+		}
 
 		filter_type->filter = arg;
 
-- 
2.19.1

