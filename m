Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3531C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8461D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDVG5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:57:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfDVG5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:57:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F1EBF3C6B258EAFB355;
        Mon, 22 Apr 2019 14:57:05 +0800 (CST)
Received: from SZXY1W004751141.china.huawei.com (10.40.99.192) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 22 Apr 2019 14:56:58 +0800
From:   Zhenliang Wei <weizhenliang@huawei.com>
To:     <ebiederm@xmission.com>, <oleg@redhat.com>, <colona@arista.com>,
        <akpm@linux-foundation.org>, <christian@brauner.io>,
        <arnd@arndb.de>, <tglx@linutronix.de>, <deepa.kernel@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <weizhenliang@huawei.com>
Subject: [PATCH v2] signal: trace_signal_deliver when signal_group_exit
Date:   Mon, 22 Apr 2019 14:56:23 +0800
Message-ID: <20190422065623.49364-1-weizhenliang@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.40.99.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following commit, removing SIGKILL from each thread signal mask
and executing "goto fatal" directly will skip the call to
"trace_signal_deliver". At this point, the delivery tracking of the SIGKILL
signal will be inaccurate.

commit cf43a757fd4944 ("signal: Restore the stop PTRACE_EVENT_EXIT")

Therefore, we need to add trace_signal_deliver before "goto fatal"
after executing sigdelset.

Note: The action[SIGKILL] must be SIG_DFL, and SEND_SIG_NOINFO matches
the fact that SIGKILL doesn't have any info.

Signed-off-by: Zhenliang Wei <weizhenliang@huawei.com>
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 227ba170298e..0f69ada376ef 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2441,6 +2441,7 @@ bool get_signal(struct ksignal *ksig)
 	if (signal_group_exit(signal)) {
 		ksig->info.si_signo = signr = SIGKILL;
 		sigdelset(&current->pending.signal, SIGKILL);
+		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL);
 		recalc_sigpending();
 		goto fatal;
 	}
-- 
2.14.1.windows.1


