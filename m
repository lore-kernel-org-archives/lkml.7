Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA6C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E521530
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996716;
	bh=Jez+rEa5vNrUjLKUgsW7Yz2dNj3JQxcMO7lY0zX91JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKIvilPusiCUOcfIGaQ8rvuHREvGEVRdicoOZpgYhIkPwvoRbgKfHuT+NLdVgZRhu
	 QqDlEzVu9+VNIxpmFzYRctFFSlZRNj01ZEYBwMFDYpgvetovXfA0ZCCGrceuVkCnjO
	 yprH9KCzsoN5DGFiG2UH+Jm2yZgjdK7WZRMtJYWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfE0Wif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfE0Wib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:38:31 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB66D214D8;
        Mon, 27 May 2019 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996711;
        bh=Jez+rEa5vNrUjLKUgsW7Yz2dNj3JQxcMO7lY0zX91JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sk5UlC5pZ412jRpMvxkb6UImTV5NQZVyxpyjrH6LG+MAUGGnWv55rKeULevPWS30S
         LEcjUkDogkJq9n6eFtU/P+vFqynuzLc0/FMoiUYYJit1/4hD/Cd1ABzBSmrSJG4pkv
         A15GUVuUGzY7+um+xinN7ty6dwEN1PlQL+///su4=
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
Subject: [PATCH 11/44] perf beauty: Add generator for fspick's 'flags' arg values
Date:   Mon, 27 May 2019 19:36:57 -0300
Message-Id: <20190527223730.11474-12-acme@kernel.org>
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

  $ tools/perf/trace/beauty/fspick.sh
  static const char *fspick_flags[] = {
          [ilog2(0x00000001) + 1] = "CLOEXEC",
          [ilog2(0x00000002) + 1] = "SYMLINK_NOFOLLOW",
          [ilog2(0x00000004) + 1] = "NO_AUTOMOUNT",
          [ilog2(0x00000008) + 1] = "EMPTY_PATH",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8i16btocq1ax2u6542ya79t5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fspick.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/fspick.sh

diff --git a/tools/perf/trace/beauty/fspick.sh b/tools/perf/trace/beauty/fspick.sh
new file mode 100755
index 000000000000..b220e07ef452
--- /dev/null
+++ b/tools/perf/trace/beauty/fspick.sh
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
+printf "static const char *fspick_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSPICK_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_mount} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

