Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10576C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FF12070E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKODUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:20:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbfKODUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:20:41 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 251A92404E01104A0712;
        Fri, 15 Nov 2019 11:20:38 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 11:20:28 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <viro@zeniv.linux.org.uk>, <rostedt@goodmis.org>,
        <oleg@redhat.com>, <mchehab+samsung@kernel.org>, <corbet@lwn.net>,
        <tytso@mit.edu>, <jmorris@namei.org>
CC:     <yukuai3@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <chenxiang66@hisilicon.com>,
        <xiexiuqi@huawei.com>
Subject: [PATCH 0/3] fix potential infinite loop in debugfs_remove_recursive
Date:   Fri, 15 Nov 2019 11:27:49 +0800
Message-ID: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch add a new enum type for 'dentry_d_lock_class'.The second
patch use the new enum type in 'simple_empty' to avoid confusion for
lockdep. The last patch fix potential infinite loop in
debugfs_remove_recursive by using 'simple_empty' instead of 'list_empty'.

yu kuai (3):
  dcache: add a new enum type for 'dentry_d_lock_class'
  fs/libfs.c: use 'spin_lock_nested' when taking 'd_lock' for dentry in
    simple_empty
  debugfs: fix potential infinite loop in debugfs_remove_recursive

 fs/debugfs/inode.c     | 7 +++++--
 fs/libfs.c             | 4 ++--
 include/linux/dcache.h | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.7.4

