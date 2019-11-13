Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A0C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CCD222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKMKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:34:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:41300 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfKMKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:34:30 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iUpyi-0006Tj-Ft; Wed, 13 Nov 2019 13:34:24 +0300
To:     Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: KSM WARN_ON_ONCE(page_mapped(page)) in remove_stable_node()
Message-ID: <ecaf193e-25fb-18fb-d7f7-92531ee92439@virtuozzo.com>
Date:   Wed, 13 Nov 2019 13:34:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------351C813EF078A7303C7FB05B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------351C813EF078A7303C7FB05B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

When remove_stable_node() races with __mmput() and squeezes in between ksm_exit() and exit_mmap(),
the WARN_ON_ONCE(page_mapped(page)) in remove_stable_node() could be triggered.

Should we just remove the warning? It seems to be safe to do, all callers are able to handle -EBUSY,
or there is a better way to fix this?



It's easily reproducible with the following script:
(ksm_test.c attached)

	#!/bin/bash

	gcc -lnuma -O2 ksm_test.c -o ksm_test
	echo 1 > /sys/kernel/mm/ksm/run
	./ksm_test &
	sleep 1
	echo 2 > /sys/kernel/mm/ksm/run

and the patch bellow which provokes that race.

---
 include/linux/ksm.h      | 4 +++-
 include/linux/mm_types.h | 1 +
 kernel/fork.c            | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e48b1e453ff5..18384ea472f8 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -33,8 +33,10 @@ static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 
 static inline void ksm_exit(struct mm_struct *mm)
 {
-	if (test_bit(MMF_VM_MERGEABLE, &mm->flags))
+	if (test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
 		__ksm_exit(mm);
+		mm->ksm_wait = 1;
+	}
 }
 
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 270aa8fd2800..3df8290528c2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -463,6 +463,7 @@ struct mm_struct {
 
 		/* Architecture-specific MM context */
 		mm_context_t context;
+		unsigned long ksm_wait;
 
 		unsigned long flags; /* Must use atomic bitops to access */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 5fb7e1fa0b05..be6ef4e046f0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1074,6 +1074,10 @@ static inline void __mmput(struct mm_struct *mm)
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
+
+	if (mm->ksm_wait)
+		schedule_timeout_uninterruptible(10*HZ);
+
 	khugepaged_exit(mm); /* must run before exit_mmap */
 	exit_mmap(mm);
 	mm_put_huge_zero_page(mm);
-- 
2.23.0

--------------351C813EF078A7303C7FB05B
Content-Type: text/x-csrc; charset=UTF-8;
 name="ksm_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ksm_test.c"

#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <numaif.h>
#include <sys/types.h>
#include <sys/wait.h>


//#define NR_NODES 4
#define NR_NODES 1

#define MAP_SIZE 4096

#define NR_THREADS 1024

pid_t pids[NR_THREADS];

int merge_and_migrate(void)
{
        void *p;
        unsigned long rnd;
        unsigned long old_node, new_node;
        pid_t p_pid, pid;
        int j;

        p = mmap(NULL, MAP_SIZE, PROT_READ|PROT_WRITE,
                MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
        if (p == MAP_FAILED)
                perror("mmap"), exit(1);

        memset(p, 0xff, MAP_SIZE);
        if (madvise(p, MAP_SIZE, MADV_MERGEABLE))
                perror("madvise"), exit(1);
	sleep(1000000);

        while (1) {
                sleep(0);
                rnd = rand() % 2;
                switch (rnd) {
                case 0: {
                        rnd = rand() % 128;
                        memset(p, rnd, MAP_SIZE);
                        break;
                }
                case 1: {
                        j = rand()%NR_NODES;
                        old_node = 1 << j;
                        new_node = 1<<((j+1)%NR_NODES);

                        migrate_pages(0, NR_NODES, &old_node, &new_node);
                        break;
                }
                }
        }
        return 0;
}

int main(void)
{
        int i,ret,j;
        pid_t pid;
        int wstatus;
        unsigned long old_node, new_node;

        for (i = 0; i < NR_THREADS; i++) {
                pid = fork();
                if (pid < 0) {
                        perror("fork");
                        return 1;
                }
                if (pid) {
                        pids[i] = pid;
                        continue;
                } else
                        merge_and_migrate();
        }

        while (1) {
                pid = waitpid(-1, &wstatus, WNOHANG);
                if (pid < 0) {
                        perror("waitpid failed");
                        return 1;
                }
                if (pid) {
                        for (i = 0; i< NR_THREADS; i++) {
                                if (pids[i] == pid) {
                                        pid = fork();
                                        if (pid < 0) {
                                                perror("fork in while");
                                                return 1;
                                        }
                                        if (pid) {
                                                pids[i] = pid;
                                                break;
                                        } else
                                                merge_and_migrate();
                                }
                        }
                        continue; /*while(1)*/
                }
                i = rand()%NR_THREADS;
                kill(pids[i], SIGKILL);
        }
        return 0;
}

--------------351C813EF078A7303C7FB05B--
