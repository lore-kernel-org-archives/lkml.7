Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6229ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C726A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfJNNsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:48:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732077AbfJNNsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:48:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8970F3EC1D09AFA17FC1;
        Mon, 14 Oct 2019 21:48:52 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 21:48:45 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <rientjes@google.com>, <mhocko@suse.com>, <jgg@ziepe.ca>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <zhongjiang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] mm: mempolicy: fix the absence of the last bit of nodemask
Date:   Mon, 14 Oct 2019 21:49:25 +0800
Message-ID: <1571060965-17794-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <e91614fa-4fc4-5e66-e8a9-3eede916e71f@suse.cz>
References: <e91614fa-4fc4-5e66-e8a9-3eede916e71f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    On Mon 14-10:19 17:12:52, Michal Hocko wrote:
    >>     When I want to use set_mempolicy to get the memory from each node on the numa machine,
    >>     and the MPOL_INTERLEAVE flag seems to achieve this goal.
    >>     However, during the test, it was found that the use result of node was unbalanced.
    >>     The memory was allocated evenly from the nodes except the last node,
    >>     which obviously did not match the expectations.
    >> 
    >>     You can test as follows:
    >> 1.  Create a file that needs to be mmap ped:
    >>     dd if=/dev/zero of=./test count=1024 bs=1M

    >This will already poppulate the page cache and if it fits into memory (which seems to be the case in your example output) then your mmap later will not allocate any new memory.
    >
    >I suspect that using numactl --interleave 0,1 dd if=/dev/zero of=./test count=1024 bs=1M
    >
    >will produce an output much closer to your expectation. Right?

    Yes, you are right. `dd` command will 'populate the page cache and if it fits into memory'.
    As a newcomer who is studying hard in this field,
    I am sorry for this and I don't know much about the mechanism of memory management.
    
    I used `malloc` again in my program to allocate memory and produced the same `confusing` result.

    But as you and Vlastimil Babka said, historical reasons have made the implementation of this interface less intuitive.
    Modifying manual may be a better option.

    Thank you both for your reply and explanation.

