Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A68FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0418222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328208;
	bh=A0jLC1IlRQB0LFEcIe3UywHn0Y+uSCnGZxvjS8ibFgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKDLd216b+dVuEKUzOc98WunprAbci9QbdWePlszgrY2RHB1QHsAc1HKp2rMYCXH6
	 d/o6ylnpq5SpDhTj3hwXhNoJbjYpo9wydxvnwCm5ggNToNxX2BCi/fbtIve/BYwjU8
	 w9jg5/QojwqfgjdiJfqx1YOgyoBkNLlN+n4s0WCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440229AbfJQQD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfJQQDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:03:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5446621D7C;
        Thu, 17 Oct 2019 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328205;
        bh=A0jLC1IlRQB0LFEcIe3UywHn0Y+uSCnGZxvjS8ibFgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxnQNEWBtzDvsh1YfDnXeUDeRmgQeaS7jB3nUzKej55q3OcKMZP3bA/bRUj+tmH4A
         zPNpxstjA1t3pS8c/fFdUGxk9ho10TCAoHWTDGIV4sq+u6YhIgIIv4wf5IFuyVsnJx
         F1B7mYJmITc7y5xVt91eShHi6JvLgqiq+KHvJtkg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/11] perf tools: Fix mode setting in copyfile_mode_ns()
Date:   Thu, 17 Oct 2019 13:02:55 -0300
Message-Id: <20191017160301.20888-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017160301.20888-1-acme@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

slow_copyfile() opens the file by name, so "write" permissions must not
be removed in copyfile_mode_ns() before calling slow_copyfile().

Example:

 Before:

  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -k /proc/kcore
  Couldn't add /proc/kcore

 After:

  $ sudo chmod +r /proc/kcore
  $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
  $ tools/perf/perf buildid-cache -v -k /proc/kcore
  kcore added to build-id cache directory /home/ahunter/.debug/[kernel.kcore]/37e340b1b5a7cf4f57ba8de2bc777359588a957f/2019100709562289

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20191007070221.11158-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/copyfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
index 3fa0db136667..47e03de7c235 100644
--- a/tools/perf/util/copyfile.c
+++ b/tools/perf/util/copyfile.c
@@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
 	if (tofd < 0)
 		goto out;
 
-	if (fchmod(tofd, mode))
-		goto out_close_to;
-
 	if (st.st_size == 0) { /* /proc? do it slowly... */
 		err = slow_copyfile(from, tmp, nsi);
+		if (!err && fchmod(tofd, mode))
+			err = -1;
 		goto out_close_to;
 	}
 
+	if (fchmod(tofd, mode))
+		goto out_close_to;
+
 	nsinfo__mountns_enter(nsi, &nsc);
 	fromfd = open(from, O_RDONLY);
 	nsinfo__mountns_exit(&nsc);
-- 
2.21.0

