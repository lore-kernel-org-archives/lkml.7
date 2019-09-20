Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE73C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B4720644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437351AbfITGJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437301AbfITGJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C85533D6A4A6715913D1;
        Fri, 20 Sep 2019 14:09:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, Robert Richter <rric@kernel.org>
Subject: [PATCH 17/32] oprofile: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:29 +0800
Message-ID: <20190920062544.180997-18-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Robert Richter <rric@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/oprofile/oprofile_perf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/oprofile/oprofile_perf.c b/drivers/oprofile/oprofile_perf.c
index 4b150a754890..98a63a5f8763 100644
--- a/drivers/oprofile/oprofile_perf.c
+++ b/drivers/oprofile/oprofile_perf.c
@@ -46,8 +46,8 @@ static void op_overflow_handler(struct perf_event *event,
 	if (id != num_counters)
 		oprofile_add_sample(regs, id);
 	else
-		pr_warning("oprofile: ignoring spurious overflow "
-				"on cpu %u\n", cpu);
+		pr_warn("oprofile: ignoring spurious overflow on cpu %u\n",
+			cpu);
 }
 
 /*
@@ -88,8 +88,8 @@ static int op_create_counter(int cpu, int event)
 
 	if (pevent->state != PERF_EVENT_STATE_ACTIVE) {
 		perf_event_release_kernel(pevent);
-		pr_warning("oprofile: failed to enable event %d "
-				"on CPU %d\n", event, cpu);
+		pr_warn("oprofile: failed to enable event %d on CPU %d\n",
+			event, cpu);
 		return -EBUSY;
 	}
 
-- 
2.20.1

