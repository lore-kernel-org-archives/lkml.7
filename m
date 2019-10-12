Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3616C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA612089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 12:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfJLMTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 08:19:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbfJLMTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 08:19:17 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0092D04704ABFA6B4F2;
        Sat, 12 Oct 2019 20:19:13 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 12 Oct 2019
 20:19:07 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <rientjes@google.com>, <mhocko@suse.com>, <jgg@ziepe.ca>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <zhongjiang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: mempolicy: fix the absence of the last bit of nodemask
Date:   Sat, 12 Oct 2019 20:19:48 +0800
Message-ID: <1570882789-20579-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    When I want to use set_mempolicy to get the memory from each node on the numa machine,
    and the MPOL_INTERLEAVE flag seems to achieve this goal.
    However, during the test, it was found that the use result of node was unbalanced.
    The memory was allocated evenly from the nodes except the last node,
    which obviously did not match the expectations.

    You can test as follows:
1.  Create a file that needs to be mmap ped:
    dd if=/dev/zero of=./test count=1024 bs=1M

2.  Use `numactl -H` to see that your test machine has several nodes,
    and then change the macro NUM_NODES to the corresponding number of nodes
    in the test program.

3.  Compile the following program:
    gcc numa_alloc_test.c -lnuma

    #include <stdio.h>
    #include <stdlib.h>
    #include <stdint.h>
    #include <numaif.h>
    #include <unistd.h>
    #include <numaif.h>
    #include <sys/mman.h>
    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>

    // rewrite these macro as `numactl -H` showed
    // The number of nodes on which machine the program runs
    #define NUM_NODES 2

    // memory we want to alloc from multinode averagely
    #define ALLOC_MEM_SIZE (1 << 30)
    void print_node_memusage()
    {
        for (int i=0; i < NUM_NODES; i++) {
            FILE *fp;
            char buf[1024];

            snprintf(buf, sizeof(buf),
                "cat /sys/devices/system/node/node%lu/meminfo | grep MemUsed", i);

            if ((fp = popen(buf, "r")) == NULL) {
                perror("popen");
                exit(-1);
            }

            while(fgets(buf, sizeof(buf), fp) != NULL) {
                printf("%s", buf);
            }

            if(pclose(fp))  {
                perror("pclose");
                exit(-1);
            }
        }
    }

    int main()
    {
        unsigned long num_nodes = NUM_NODES;
        unsigned long nodes_mask = (1 << NUM_NODES) - 1;
        // use MPOL_INTERLEAVE flag in order to balanced memory allocation
        set_mempolicy(MPOL_INTERLEAVE, &nodes_mask, num_nodes);

        // print info of nodes' memused before memory allocation
        print_node_memusage();

        int fd = open("./test", O_RDWR);
        unsigned long *addr = mmap(NULL, ALLOC_MEM_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);

        // trigger page fault and page alloc
        for (unsigned long i=0; i < ALLOC_MEM_SIZE/sizeof(unsigned long); i++) {
            addr[i] = i;
        }

        // print info of nodes' memused before memory allocation
        print_node_memusage();
        munmap(addr, ALLOC_MEM_SIZE);
        return 0;
    }

4.  execution procedures:
    ./a.out
5.  observe the output:
    On my `2 nodes` arm64 test environment, the test result is as follows:
    # ./a.out
    Node 0 MemUsed:         1313952 kB
    Node 1 MemUsed:          267620 kB
    Node 0 MemUsed:         2365500 kB (use 1GB)
    Node 1 MemUsed:          267832 kB (do not used)

    Besides, I found the same problem at https://bugzilla.kernel.org/show_bug.cgi?id=201433,
    so I feel it is necessary to track and fix this issue.

    I tracked the impact of set_mempolicy and memory allocation strategy on the alloc_pages
    process (MPOL_INTERLEAVE node pages allocation is implemented in `alloc_page_interleave`),
    and found that the memory allocation is based on nodemask (`interleave_nodes` -> `next_node_in`),
    so the problem may be in the nodemask setting: evetually, i found the nodemask is set
    in the `get_nodes` function.

    mm/mempolicy.c: `get_nodes` function
    --maxnode causes nodemask to ignore the last node. I think this needs to be changed,
    except that it also handles the case where the maxnode that the user passed in is 1.

    After the modification, the test result is normal.
    # ./a.out
    Node 0 MemUsed:          508044 kB
    Node 1 MemUsed:         1239276 kB
    Node 0 MemUsed:         1034196 kB (use 513MB)
    Node 1 MemUsed:         1768492 kB (use 516MB)

Signed-off-by: z00417012 <zhangpan26@huawei.com>
---
 mm/mempolicy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967b..a23509f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1328,9 +1328,11 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 	unsigned long nlongs;
 	unsigned long endmask;
 
-	--maxnode;
 	nodes_clear(*nodes);
-	if (maxnode == 0 || !nmask)
+	/*
+	 * If the user specified only one node, no need to set nodemask
+	 */
+	if (maxnode - 1 == 0 || !nmask)
 		return 0;
 	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
 		return -EINVAL;
-- 
2.7.4

