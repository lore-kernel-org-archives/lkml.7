Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C40122309
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfKSBoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:44:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfKSBon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:43 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F9D0F7A586CDEA13F47;
        Tue, 19 Nov 2019 09:44:41 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 09:44:36 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <rostedt@goodmis.org>, <acme@redhat.com>, <tstoyanov@vmware.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] tools lib traceevent: Fix memory leakage in copy_filter_type
Date:   Mon, 18 Nov 2019 20:44:15 -0500
Message-ID: <20191119014415.57210-1-hewenliang4@huawei.com>
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

