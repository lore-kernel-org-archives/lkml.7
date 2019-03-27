Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CB1217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709981;
	bh=NS+9X2C6bQzFbgDo7OKljdwrDJ+gHldbDxJZNL8kSWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KidUxVhEYZVE9eNQjylCsCXA+zcqaVd9GXZlkCjE7suG+RqAZDeS1FOr7ooGRBOIp
	 jZY6d2SN2hN4VhlsU7dtZXaIz6SnKvhczQ5R+/EoL24aCkkH/Ac7pqJpwSGp3gVmR+
	 Cxqy+DgxGpD4MQwWDe1qtC+7Q9ZxvVKXaQ1ILJmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbfC0SGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732193AbfC0SGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31182177E;
        Wed, 27 Mar 2019 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709977;
        bh=NS+9X2C6bQzFbgDo7OKljdwrDJ+gHldbDxJZNL8kSWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvA+n3hlArdx3fxAlic9K13LZRwjzm0lRttj8/BzXwrfPuydq3Tsr1oNWhyJ2WXaL
         +OGOIxCbetXcYB/bcnqF2uy9SJk+wvXtJNrGGc9N5+vTMnY03kNwRd5k3xZC1MdFvE
         RHD750PVivkw62IYw1Ho13vfRvlcgrKIJIm88L54=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 141/262] perf beauty waitid options: Fix up prefix showing logic
Date:   Wed, 27 Mar 2019 13:59:56 -0400
Message-Id: <20190327180158.10245-141-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 1da7e0022784b0e05b49bf73521fa2cc4633af85 ]

When introducing the possibility for selecting if the common prefix to
options such as the waitid ones, i.e. all 'waitid' options start with
'W', so, to make it make it more compact if configured to suppress it,
'perf trace' will do so, other examples include mmap's PROT_ prefix for
its 'prot' argument, etc, which, when showing the syscall argument name
ends up producing duplicated info that clutters the screen, i.e.:

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/20886 mmap(len: 112595, prot: PROT_READ, flags: MAP_PRIVATE, fd: 3) = 0x7f3e986d2000
     0.041 ( 0.005 ms): sleep/20886 mmap(len: 8192, prot: PROT_READ|PROT_WRITE, flags: MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f3e986d0000
  #

So it is possible to suppress that and make it more compact by having
this in your ~/.perfconfig:

  # cat ~/.perfconfig
  [trace]
	show_prefix = no
  #

  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.014 ms): sleep/8009 mmap(len: 112595, prot: READ, flags: PRIVATE, fd: 3) = 0x7ff2373de000
     0.040 ( 0.005 ms): sleep/8009 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7ff2373dc000
  #

To have it look more like strace's output, we instead want to suppress
the arg name and show the prefix, so use:

  # cat ~/.perfconfig
  [trace]
	show_prefix = yes
	show_arg_names = no
  #
  # perf trace -e mmap --max-events 2 sleep 1
     0.000 ( 0.006 ms): sleep/15513 mmap(NULL, 112595, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f7a9b6d3000
     0.020 ( 0.002 ms): sleep/15513 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS) = 0x7f7a9b6d1000
  #

When this logic was introduced a bug came with it when processing the
waitid 'option' arg that ended up expecting 3 strings when just two were
being provided, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c65c83ffe904 ("perf trace: Allow asking for not suppressing common string prefixes")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/trace/beauty/waitid_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index 6897fab40dcc..d4d10b33ba0e 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -11,7 +11,7 @@ static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
 
 #define	P_OPTION(n) \
 	if (options & W##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : #n); \
+		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "",  #n); \
 		options &= ~W##n; \
 	}
 
-- 
2.19.1

