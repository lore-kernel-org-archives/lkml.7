Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC1E25352
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oK11hvET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfE3IFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:05:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:05:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U84lFU2903073
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:04:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U84lFU2903073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203488;
        bh=nxMWLK9eu8VhBiwAJ+merniho+j1TlKRUXI+fpuR2YM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=oK11hvETURCyNPhEt6cVqrKaFR1EzWe8mdoodDpDOqusfztm96Xqj8cxTOJ8X8LgB
         p9c5BSPmpzCnuN5Y47BSozpRf4ULc/ap6ntgWaw8GD0GFJdCS5ez+J9cD1bJBGQd7Q
         brYCN2MJSzzVohumO2rGMb1QPjWbhZxqdIdXkLLWu87oRnClZD3kU5cW25s3CfWkXm
         ywxrKXRvhkOreQx87UtzxZnfiqXeTTuOUTq1See5bRcbiiUPSgpPFo2jam2Hn+AxIg
         J1Ga5je3hVIvEZ5TZVwL4i0Z5D5o54f/juDqZzt9+xrs+kqVVZnKqSnMca0v+Cq05P
         3VyWVo5KG8FFg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U84jTZ2903070;
        Thu, 30 May 2019 01:04:45 -0700
Date:   Thu, 30 May 2019 01:04:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-drq9h7s8gcv8b87064fp6lb0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        brendan.d.gregg@gmail.com, adrian.hunter@intel.com,
        lclaudio@redhat.com, christian@brauner.io, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          brendan.d.gregg@gmail.com, lclaudio@redhat.com,
          adrian.hunter@intel.com, christian@brauner.io
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty clone: Handle CLONE_PIDFD
Git-Commit-ID: ee364dcdcd008530883efc0e690fc8e85622f9b5
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

Commit-ID:  ee364dcdcd008530883efc0e690fc8e85622f9b5
Gitweb:     https://git.kernel.org/tip/ee364dcdcd008530883efc0e690fc8e85622f9b5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 16:51:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf trace beauty clone: Handle CLONE_PIDFD

In addition to the older flags. This will allow something like this to
be implemented in 'perf trace"

  perf trace -e clone/PIDFD in flags/

I.e. ask for strace like tracing, system wide, looking for 'clone'
syscalls that have the CLONE_PIDFD bit set in the 'flags' arg.

For now we'll just see PIDFD if it is set in the 'flags' arg.

Cc: Christian Brauner <christian@brauner.io>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-drq9h7s8gcv8b87064fp6lb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index 6eb9a6636171..1a8d3be2030e 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -25,6 +25,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(FS);
 	P_FLAG(FILES);
 	P_FLAG(SIGHAND);
+	P_FLAG(PIDFD);
 	P_FLAG(PTRACE);
 	P_FLAG(VFORK);
 	P_FLAG(PARENT);
