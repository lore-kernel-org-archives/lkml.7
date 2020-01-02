Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E61C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5025215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgABIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:15:05 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50424 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727714AbgABIPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:15:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TmarSI6_1577952893;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmarSI6_1577952893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 16:15:02 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] use div64_ul() instead of div_u64() if the divisor is unsigned long 
Date:   Thu,  2 Jan 2020 16:14:39 +0800
Message-Id: <20200102081442.8273-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were first inspired by commit b0ab99e7736a
("sched: Fix possible divide by zero in avg_atom () calculation"),
then refer to the recently analyzed mm code,
we found this suspicious place.
 201                 if (min) {
 202                         min *= this_bw;
 203                         do_div(min, tot_bw);
 204                 }

And we also disassembled and confirmed it:
/usr/src/debug/kernel-4.9.168-016.ali3000/linux-4.9.168-016.ali3000.alios7.x86_64/mm/page-writeback.c: 201
0xffffffff811c37da <__wb_calc_thresh+234>:      xor    %r10d,%r10d
0xffffffff811c37dd <__wb_calc_thresh+237>:      test   %rax,%rax
0xffffffff811c37e0 <__wb_calc_thresh+240>:      je 0xffffffff811c3800 <__wb_calc_thresh+272>
/usr/src/debug/kernel-4.9.168-016.ali3000/linux-4.9.168-016.ali3000.alios7.x86_64/mm/page-writeback.c: 202
0xffffffff811c37e2 <__wb_calc_thresh+242>:      imul   %r8,%rax
/usr/src/debug/kernel-4.9.168-016.ali3000/linux-4.9.168-016.ali3000.alios7.x86_64/mm/page-writeback.c: 203
0xffffffff811c37e6 <__wb_calc_thresh+246>:      mov    %r9d,%r10d    ---> truncates it to 32 bits here
0xffffffff811c37e9 <__wb_calc_thresh+249>:      xor    %edx,%edx
0xffffffff811c37eb <__wb_calc_thresh+251>:      div    %r10
0xffffffff811c37ee <__wb_calc_thresh+254>:      imul   %rbx,%rax
0xffffffff811c37f2 <__wb_calc_thresh+258>:      shr    $0x2,%rax
0xffffffff811c37f6 <__wb_calc_thresh+262>:      mul    %rcx
0xffffffff811c37f9 <__wb_calc_thresh+265>:      shr    $0x2,%rdx
0xffffffff811c37fd <__wb_calc_thresh+269>:      mov    %rdx,%r10

This series use div64_ul() instead of div_u64() if the divisor
is unsigned long, to avoid truncation to 32-bit on 64-bit platforms.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Wen Yang (3):
  mm/page-writeback.c: avoid potential division by zero in
    wb_min_max_ratio()
  mm/page-writeback.c: use div64_ul() for u64-by-unsigned-long divide
  mm/page-writeback.c: improve arithmetic divisions

 mm/page-writeback.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.8.3.1

