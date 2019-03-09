Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296A2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D8E206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCIT5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:57:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIT5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:57:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JuvVD3202830
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:56:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JuvQe3202827;
        Sat, 9 Mar 2019 11:56:57 -0800
Date:   Sat, 9 Mar 2019 11:56:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t2eu1rqx710k6jr4814mlzg7@git.kernel.org>
Cc:     namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, lclaudio@redhat.com, acme@redhat.com,
        wangnan0@huawei.com
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          hpa@zytor.com, lclaudio@redhat.com, tglx@linutronix.de,
          acme@redhat.com, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty msg_flags: Add missing %s lost when
 adding prefix suppression logic
Git-Commit-ID: c3b81a500f35241a4c16febe0a015e572cf2c492
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c3b81a500f35241a4c16febe0a015e572cf2c492
Gitweb:     https://git.kernel.org/tip/c3b81a500f35241a4c16febe0a015e572cf2c492
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 1 Mar 2019 15:45:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 15:45:35 -0300

perf beauty msg_flags: Add missing %s lost when adding prefix suppression logic

When the prefix suppresion/enabling logic was added, I forgot to add an
extra %, which ended up chopping off the strings:

Before:

  # perf trace -e *mmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  DNS Res~ver #3/14587 sendmmsg(106<socket:[3462393]>, 0x7f252b0fcaf0, 2, MSG_) = 2
  chronyd/1053 recvmmsg(4, 0x558542ca5740, 4, MSG_, NULL) = 1
  DNS Res~ver #2/14445 sendmmsg(106<socket:[3461475]>, 0x7f252ab09af0, 2, MSG_) = 2
  DNS Res~ver #2/14444 sendmmsg(146<socket:[3457863]>, 0x7f2521a7aaf0, 2, MSG_) = 2
  DNS Res~ver #2/14445 sendmmsg(106<socket:[3461475]>, 0x7f252ab09af0, 2, MSG_) = 2
  DNS Res~ver #3/14587 sendmmsg(148<socket:[3460636]>, 0x7f252b0fcaf0, 2, MSG_) = 2
  DNS Res~ver #2/14444 sendmmsg(146<socket:[3457863]>, 0x7f2521a7aaf0, 2, MSG_) = 2
  ^C#

After:

  # perf trace -e *mmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  NetworkManager/17467 sendmmsg(22<socket:[3466493]>, 0x7f28927f9bb0, 2, MSG_NOSIGNAL) = 2
  pool/17478 sendmmsg(10<socket:[3466523]>, 0x7f2769f95e90, 2, MSG_NOSIGNAL) = 2
  DNS Res~ver #3/14587 sendmmsg(121<socket:[3466132]>, 0x7f252b0fcaf0, 2, MSG_NOSIGNAL) = 2
  chronyd/1053 recvmmsg(4, 0x558542ca5740, 4, MSG_DONTWAIT, NULL) = 1
  Socket Thread/17433 sendmmsg(121<socket:[3460903]>, 0x7f252668baf0, 2, MSG_NOSIGNAL) = 2
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Link: https://lkml.kernel.org/n/tip-t2eu1rqx710k6jr4814mlzg7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/msg_flags.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index d66c66315987..ea68db08b8e7 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -29,7 +29,7 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 		return scnprintf(bf, size, "NONE");
 #define	P_MSG_FLAG(n) \
 	if (flags & MSG_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
 		flags &= ~MSG_##n; \
 	}
 
