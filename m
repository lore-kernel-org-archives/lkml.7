Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C36C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A98620657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369730;
	bh=PACsLkzXKyzgUvGJctOd20qjyd9vNAIIJYbvV6ZTcGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xpwo/uKhZiEeywAnH9/zs57LPUc8HOMcEjG7zvUstlivpCmiG9c2xBgwYse/94NYH
	 nEy4XS0LcdzsK/vnLwxZeSv2onjw/9hD2K0aZxuzq1D3ABUUWPzc8d0Q0GBYTgIP6P
	 JXfchGi2bKFO04LPamsLomFTc53sWakQKH1+QIAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfDDJQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388025AbfDDJQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC462075E;
        Thu,  4 Apr 2019 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369376;
        bh=PACsLkzXKyzgUvGJctOd20qjyd9vNAIIJYbvV6ZTcGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJEgyA2l6+BtfOCJvmQFbYllyBOW5YhVdAxoW5IabPYuAwO8WFGUugaJdN9E9Y202
         1SgF/1DGPEd8/rGgVu2KKCVb8JM/a9kWtZPev8a3YY8ajJHcBJKgKmI+iDHvGNTEtG
         TCTQSfj4mUhR3G3IWVBW1HlKfzdk8hPwFUJZnyGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 200/246] perf trace: Fixup etcsnoop example
Date:   Thu,  4 Apr 2019 10:48:20 +0200
Message-Id: <20190404084626.190590206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1d59cb1bbd4cbe5a8f8032242cdacea5658129cf ]

Where we don't have "raw_syscalls:sys_enter", so we need to look for a
"*syscalls:sys_enter*" to initialize the offsets for the
__augmented_syscalls__ evsel, which is the case with etcsnoop, that was
segfaulting, fixed:

  # trace -e /home/acme/git/perf/tools/perf/examples/bpf/etcsnoop.c
     0.000 (         ): gnome-shell/2105 openat(dfd: CWD, filename: "/etc/localtime")                       ...
   631.834 (         ): cat/6521 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
   632.637 (         ): bash/6521 openat(dfd: CWD, filename: "/etc/passwd")                          ...
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: b9b6a2ea2baf ("perf trace: Do not hardcode the size of the tracepoint common_ fields")
Link: https://lkml.kernel.org/n/tip-0tjwcit8qitsmh4nyvf2b0jo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2776ff8c3e81..91cdbf504535 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3868,7 +3868,8 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
-			if (strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_enter") == 0) {
+			if (trace.syscalls.events.augmented->priv == NULL &&
+			    strstr(perf_evsel__name(evsel), "syscalls:sys_enter")) {
 				struct perf_evsel *augmented = trace.syscalls.events.augmented;
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
-- 
2.19.1



