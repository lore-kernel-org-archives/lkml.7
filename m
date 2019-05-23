Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E9FC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244FB2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfEWAnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60230 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfEWAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp7-0004Gu-Ak; Wed, 22 May 2019 18:43:09 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbo6-0005Z3-UC; Wed, 22 May 2019 18:42:15 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:12 -0500
Message-Id: <20190523003916.20726-23-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbo6-0005Z3-UC;;;mid=<20190523003916.20726-23-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19f1D+e/1BfTbUenFf81yBjfafK2F1Fs2A=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 22/26] signal: Properly set TRACE_SIGNAL_LOSE_INFO in __send_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any time siginfo is not stored in the signal queue information is
lost.  Therefore set TRACE_SIGNAL_LOSE_INFO every time the code does
not allocate a signal queue entry, and a queue overflow abort is not
triggered.

Fixes: ba005e1f4172 ("tracepoint: Add signal loss events")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index d92b636b4e9d..b2f0cf3a68aa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1131,23 +1131,22 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 			copy_siginfo(&q->info, info);
 			break;
 		}
-	} else if (!is_si_special(info)) {
-		if (sig >= SIGRTMIN && info->si_code != SI_USER) {
-			/*
-			 * Queue overflow, abort.  We may abort if the
-			 * signal was rt and sent by user using something
-			 * other than kill().
-			 */
-			result = TRACE_SIGNAL_OVERFLOW_FAIL;
-			ret = -EAGAIN;
-			goto ret;
-		} else {
-			/*
-			 * This is a silent loss of information.  We still
-			 * send the signal, but the *info bits are lost.
-			 */
-			result = TRACE_SIGNAL_LOSE_INFO;
-		}
+	} else if (!is_si_special(info) &&
+		   sig >= SIGRTMIN && info->si_code != SI_USER) {
+		/*
+		 * Queue overflow, abort.  We may abort if the
+		 * signal was rt and sent by user using something
+		 * other than kill().
+		 */
+		result = TRACE_SIGNAL_OVERFLOW_FAIL;
+		ret = -EAGAIN;
+		goto ret;
+	} else {
+		/*
+		 * This is a silent loss of information.  We still
+		 * send the signal, but the *info bits are lost.
+		 */
+		result = TRACE_SIGNAL_LOSE_INFO;
 	}
 
 out_set:
-- 
2.21.0

