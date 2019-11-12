Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CAAC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97F121783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLCRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:17:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfKLCRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:17:05 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5C154119CC2F886DE0D0;
        Tue, 12 Nov 2019 10:17:03 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 10:16:59 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <shuah@kernel.org>, <tj@kernel.org>, <guro@fb.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] kselftests: cgroup: Avoid the reuse of fd after it is deallocated
Date:   Mon, 11 Nov 2019 21:16:55 -0500
Message-ID: <20191112021655.52951-1-hewenliang4@huawei.com>
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

It is necessary to set fd to -1 when inotify_add_watch() fails in
cg_prepare_for_wait. Otherwise the fd which has been closed in
cg_prepare_for_wait may be misused in other functions such as
cg_enter_and_wait_for_frozen and cg_freeze_wait.

Fixes: 5313bfe425c8 ("selftests: cgroup: add freezer controller self-tests")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 0fc1b6d4b0f9..62a27ab3c2f3 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -72,6 +72,7 @@ static int cg_prepare_for_wait(const char *cgroup)
 	if (ret == -1) {
 		debug("Error: inotify_add_watch() failed\n");
 		close(fd);
+		fd = -1;
 	}
 
 	return fd;
-- 
2.19.1

