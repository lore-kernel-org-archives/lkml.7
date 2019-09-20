Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1F20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394671AbfITGKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:10:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437343AbfITGJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DA00D7A163A68B1A4E34;
        Fri, 20 Sep 2019 14:09:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:09:02 +0800
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
CC:     <wangkefeng.wang@huawei.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH 20/32] sh/intc: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:32 +0800
Message-ID: <20190920062544.180997-21-wangkefeng.wang@huawei.com>
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/sh/intc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 46f0f322d4d8..8485e812d9b2 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -100,8 +100,8 @@ static void __init intc_register_irq(struct intc_desc *desc,
 		primary = 1;
 
 	if (!data[0] && !data[1])
-		pr_warning("missing unique irq mask for irq %d (vect 0x%04x)\n",
-			   irq, irq2evt(irq));
+		pr_warn("missing unique irq mask for irq %d (vect 0x%04x)\n",
+			irq, irq2evt(irq));
 
 	data[0] = data[0] ? data[0] : intc_get_mask_handle(desc, d, enum_id, 1);
 	data[1] = data[1] ? data[1] : intc_get_prio_handle(desc, d, enum_id, 1);
-- 
2.20.1

