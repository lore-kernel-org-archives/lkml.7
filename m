Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2606DC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0815620833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLBIOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:14:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfLBIOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:14:24 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8AA411A6202CFEA882E6;
        Mon,  2 Dec 2019 16:14:17 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Dec 2019
 16:14:07 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <luto@kernel.org>, <adobriyan@gmail.com>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <peterz@infradead.org>, <bigeasy@linutronix.de>, <mhocko@suse.com>,
        <john.ogness@linutronix.de>, <yi.zhang@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH 4.4 0/7] fs/proc: Stop reporting eip and esp in
Date:   Mon, 2 Dec 2019 16:35:12 +0800
Message-ID: <20191202083519.23138-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting eip and esp fields on a non-current task is dangerous,
so backport this series for 4.4 to fix protential oops and info leak
problems. The first 3 patch are depended on the 6/7 patch.

Alexey Dobriyan (1):
  proc: fix coredump vs read /proc/*/stat race

Andy Lutomirski (3):
  sched/core: Allow putting thread_info into task_struct
  sched/core: Add try_get_task_stack() and put_task_stack()
  fs/proc: Stop reporting eip and esp in /proc/PID/stat

Heiko Carstens (1):
  sched/core, x86: Make struct thread_info arch specific again

John Ogness (2):
  fs/proc: Report eip/esp in /prod/PID/stat for coredumping
  fs/proc/array.c: allow reporting eip/esp for all coredumping threads

 fs/proc/array.c             | 18 ++++++++++---
 include/linux/init_task.h   |  9 +++++++
 include/linux/sched.h       | 52 +++++++++++++++++++++++++++++++++++--
 include/linux/thread_info.h |  4 +++
 init/Kconfig                | 10 +++++++
 init/init_task.c            |  7 +++--
 kernel/sched/sched.h        |  4 +++
 7 files changed, 97 insertions(+), 7 deletions(-)

-- 
2.17.2

