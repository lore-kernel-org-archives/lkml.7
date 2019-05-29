Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0EA2190D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137025;
	bh=Jez+rEa5vNrUjLKUgsW7Yz2dNj3JQxcMO7lY0zX91JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/NOmR7eXQHVIViNKJJt8QTr2Oy2q0zLnZH0cCWjZ9wV3m5IHxqkEURCly6B7dtNA
	 5pdvPWdHc1RUdZrBLDYgm4H7vaMPjhyr0MzW/nUs6lEb1Oyf8UjmllO0WGgVhKclj0
	 D/XLcSYKpRROSHdf6z+Z5ffqIRmc31bLEUHYq34w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfE2NhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfE2NhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:37:03 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54FDC218FD;
        Wed, 29 May 2019 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137022;
        bh=Jez+rEa5vNrUjLKUgsW7Yz2dNj3JQxcMO7lY0zX91JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYXmeBKLIXsnuPraWqCrbE4KHvkctjjeSZtwTXDpOxVX5UHOACvc5zzj2NTVMvVoG
         d4I3HAD8WsJVG6TQ2gqeDmTIzs4Ao85kh5Xt+3a4JuBEj68oZ+yMnD3tBqU/cCtg+w
         to75ptApWqY6PG8RUEutvhG6aZtv/iofMyyDzOKs=
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
Subject: [PATCH 10/41] perf beauty: Add generator for fspick's 'flags' arg values
Date:   Wed, 29 May 2019 10:35:34 -0300
Message-Id: <20190529133605.21118-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
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

