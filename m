Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B58C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD202073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfKZJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:42:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbfKZJmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:42:49 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 208C286972AA68386C43;
        Tue, 26 Nov 2019 17:42:46 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 26 Nov 2019
 17:42:38 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <cj.chengjian@huawei.com>, <bobo.shaobowang@huawei.com>,
        <mark.rutland@arm.com>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>, <wcohen@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mtk.manpages@gmail.com>,
        <wezhang@redhat.com>
Subject: [PATCH] sys_personality: Streamline code in sys_personality()
Date:   Tue, 26 Nov 2019 17:40:45 +0800
Message-ID: <20191126094045.134654-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYSCALL_DEFINE1 in kernel/exec_domain.c looks like verbose,
ksys_personality() can make it more concise.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 kernel/exec_domain.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index 33f07c5f2515..f7a0512ddc23 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -37,10 +37,5 @@ module_init(proc_execdomains_init);
 
 SYSCALL_DEFINE1(personality, unsigned int, personality)
 {
-	unsigned int old = current->personality;
-
-	if (personality != 0xffffffff)
-		set_personality(personality);
-
-	return old;
+	return ksys_personality(personality);
 }
-- 
2.20.1

