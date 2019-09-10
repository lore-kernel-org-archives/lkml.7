Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC45C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 02:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF9A21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 02:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbfIJCcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 22:32:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392735AbfIJCcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 22:32:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98B1043E833CED385D60;
        Tue, 10 Sep 2019 10:32:39 +0800 (CST)
Received: from huawei.com (10.175.104.217) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 10:32:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <adobriyan@gmail.com>, <tglx@linutronix.de>,
        <akpm@linux-foundation.org>, <dhowells@redhat.com>,
        <cyphar@cyphar.com>, <christian@brauner.io>,
        <aubrey.li@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linmiaohe@huawei.com>, <mingfangsen@huawei.com>
Subject: [PATCH] proc:fix confusing macro arg name
Date:   Tue, 10 Sep 2019 10:17:47 +0800
Message-ID: <20190910021747.11216-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.21.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.217]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

state_size and ops are in the wrong position, fix it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/proc_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index a705aa2d03f9..0640be56dcbd 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -58,8 +58,8 @@ extern int remove_proc_subtree(const char *, struct proc_dir_entry *);
 struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent, const struct seq_operations *ops,
 		unsigned int state_size, void *data);
-#define proc_create_net(name, mode, parent, state_size, ops) \
-	proc_create_net_data(name, mode, parent, state_size, ops, NULL)
+#define proc_create_net(name, mode, parent, ops, state_size) \
+	proc_create_net_data(name, mode, parent, ops, state_size, NULL)
 struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		int (*show)(struct seq_file *, void *), void *data);
-- 
2.21.GIT

