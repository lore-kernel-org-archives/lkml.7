Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4B1C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FC82133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996725;
	bh=NlkLu9RjQ8AyUEpx1kdxPzJMzLPBwfYdjqnmfeIBWUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvC8OcKX7Y4MyCi80ceBDwpAApC09bNnw+/NK3KY+jQZvwRSXgb+kihmbPVN/0XhY
	 vajPe89g8GzI36VXQ0mPhKKP0e+xkK8kB23cLtxtLxT40oZ7eXAiOYTcz6WyjNJhI3
	 EXJxKRaoDi3FEv/exTzmjUnjROLCMBG7YBlGtO98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfE0Wio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfE0Wil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:38:41 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 825DA21530;
        Mon, 27 May 2019 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996720;
        bh=NlkLu9RjQ8AyUEpx1kdxPzJMzLPBwfYdjqnmfeIBWUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcusDAidS8prrhruaNRB0Q/ycrAv4NMAbAP6/i/lVa+JJPe5TeeObRS3S6Q6LV8Lw
         DR56oF7RO8oSh67EldtJJ756KIbudrNAaMhWaoEsIZoY8VNIodnW0a+31Sv1/nEIoH
         5VoN4O59vUL7nllebIhTbS6DZPLNiAcWFrRrLYCQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 13/44] perf beauty: Add generator for fsconfig's 'cmd' arg values
Date:   Mon, 27 May 2019 19:36:59 -0300
Message-Id: <20190527223730.11474-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/fsconfig.sh
  static const char *fsconfig_cmds[] = {
          [0] = "SET_FLAG",
          [1] = "SET_STRING",
          [2] = "SET_BINARY",
          [3] = "SET_PATH",
          [4] = "SET_PATH_EMPTY",
          [5] = "SET_FD",
          [6] = "CMD_CREATE",
          [7] = "CMD_RECONFIGURE",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-u721396rkqmawmt91dwwsntu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fsconfig.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/fsconfig.sh

diff --git a/tools/perf/trace/beauty/fsconfig.sh b/tools/perf/trace/beauty/fsconfig.sh
new file mode 100755
index 000000000000..83fb24df05c9
--- /dev/null
+++ b/tools/perf/trace/beauty/fsconfig.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 1 ] ; then
+	linux_header_dir=tools/include/uapi/linux
+else
+	linux_header_dir=$1
+fi
+
+linux_mount=${linux_header_dir}/mount.h
+
+printf "static const char *fsconfig_cmds[] = {\n"
+regex='^[[:space:]]*+FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,[[:space:]]*.*'
+egrep $regex ${linux_mount} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

