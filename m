Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1652BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9639204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfDPPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:53:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:57632 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfDPPxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:53:40 -0400
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1hGQOt-0001Ss-NH; Tue, 16 Apr 2019 18:53:35 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/1] kernfs: hit a warning in kernfs_get()
Date:   Tue, 16 Apr 2019 18:53:34 +0300
Message-Id: <20190416155335.14627-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit a warning on rather old kernel - RHEL7-based 3.10.0-xxx.
Please don't think it's really near 3.10 - both RedHat and we (Virtuozzo)
backport a lot of things from modern mainstream kernels and do own changes.

  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 63923 at fs/kernfs/dir.c:377 kernfs_get+0x2f/0x40
  CPU: 2 PID: 63923 Comm: kworker/2:7 ve: 0 Kdump: loaded Not tainted
       3.10.0-957.10.1.vz7.85.12 #1 85.12
  ...
  Call Trace:
   [<ffffffffa7f92e67>] dump_stack+0x19/0x1b
   [<ffffffffa78987b8>] __warn+0xd8/0x100
   [<ffffffffa78988fd>] warn_slowpath_null+0x1d/0x20
   [<ffffffffa7aecaff>] kernfs_get+0x2f/0x40
   [<ffffffffa7aed233>] __kernfs_remove+0x113/0x260
   [<ffffffffa7aee201>] kernfs_remove+0x21/0x30
   [<ffffffffa7af1010>] sysfs_remove_dir+0x50/0x80
   [<ffffffffa7b9fb38>] kobject_del+0x18/0x50
   [<ffffffffa7a38a4d>] sysfs_slab_remove+0x3d/0x50
   [<ffffffffa79f1e6b>] do_kmem_cache_release+0x3b/0x70
   [<ffffffffa79f2aa1>] memcg_destroy_kmem_caches+0xb1/0xf0
   [<ffffffffa7a4ed5c>] mem_cgroup_css_free+0x4c/0x280
   [<ffffffffa79377fc>] cgroup_free_fn+0x4c/0x120
   [<ffffffffa78bc222>] process_one_work+0x182/0x440
   [<ffffffffa78bd3d6>] worker_thread+0x126/0x3c0
   [<ffffffffa78c4441>] kthread+0xd1/0xe0

The warning has been triggered only once and so far i'm unable to reproduce it.

i'm not completely sure why __kernfs_remove() believes "pos" should always
have kn->counter > 0 as it holds kernfs_mutex, but kernfs_notify_workfn()
could definitely do a kernfs_put() out of kernfs_mutex.

So i suppose kernfs_put() should be put under kernfs_mutex() in
kernfs_notify_workfn().


Konstantin Khorenko (1):
  kernfs: keep kernfs node alive for __kernfs_remove()

 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.15.1

