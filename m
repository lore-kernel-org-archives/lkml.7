Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36ACA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED899222CC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJSHV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:21:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfJSHV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:21:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLj34-0003FE-Ar; Sat, 19 Oct 2019 09:21:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB35E1C0095;
        Sat, 19 Oct 2019 09:21:13 +0200 (CEST)
Date:   Sat, 19 Oct 2019 07:21:13 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix !CONFIG_PERF_EVENTS build warnings
 and failures
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157146967348.29376.10523588734238269050.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ae79d5588a04aec9dc4b0c6df700d131447306e0
Gitweb:        https://git.kernel.org/tip/ae79d5588a04aec9dc4b0c6df700d131447306e0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 19 Oct 2019 09:15:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 19 Oct 2019 09:15:27 +02:00

perf/core: Fix !CONFIG_PERF_EVENTS build warnings and failures

sparc64 runs into this warning:

  include/linux/security.h:1913:52: warning: 'struct perf_event' declared inside parameter list will not be visible outside of this definition or declaration

which is escalated to a build error in some of the .c files due to -Werror.

Fix it via a forward declaration, like we do for perf_event_attr, the stub inlines
don't actually need to know the structure of this struct.

Fixes: da97e18458fb: ("perf_event: Add support for LSM and SELinux checks")
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/security.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 4df79ff..0a86bfe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1896,6 +1896,7 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 
 #ifdef CONFIG_PERF_EVENTS
 struct perf_event_attr;
+struct perf_event;
 
 #ifdef CONFIG_SECURITY
 extern int security_perf_event_open(struct perf_event_attr *attr, int type);
