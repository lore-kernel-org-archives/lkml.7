Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A18C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B791B24666
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfK3BlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 20:41:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3BlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:41:17 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 569BD39B753B849EAA34;
        Sat, 30 Nov 2019 09:41:15 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:41:06 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH V2 0/3] fix potential infinite loop in debugfs_remove_recursive
Date:   Sat, 30 Nov 2019 10:02:22 +0800
Message-ID: <20191130020225.20239-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this patchset is to fix potential infinite loop in
debugfs_remove_recursive. Al Viro want to refactor it
(https://lore.kernel.org/lkml/20191115184209.GT26530@ZenIV.linux.org.uk/).
I can't really tell if it's better. Since debugfs_remove_recursive is
still using 'simple_empty', whitch is wrong, I'm sending this patchset
just in case.

The first patch add a new enum type for 'dentry_d_lock_class'.The second
patch use the new enum type in 'simple_empty' to avoid confusion for
lockdep. The last patch fix potential infinite loop in
debugfs_remove_recursive by using 'simple_empty' instead of 'list_empty'.

changes in V2:
rename the new enum type in the first patch, add some comments.


yu kuai (3):
  dcache: add a new enum type for 'dentry_d_lock_class'
  fs/libfs.c: use 'spin_lock_nested' when taking 'd_lock' for dentry in
    simple_empty
  debugfs: fix potential infinite loop in debugfs_remove_recursive

 fs/debugfs/inode.c     |  7 +++++--
 fs/libfs.c             |  4 ++--
 include/linux/dcache.h | 11 ++++++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.17.2

