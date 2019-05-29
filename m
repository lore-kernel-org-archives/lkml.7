Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19200C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00D220883
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137065;
	bh=cDlfEZs1l+f0STyQCqge3nbRzvyG+r7j9TDAE+O5Tb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j+XQgGDMhGG93S9G40Pz03C+oZeD+cjluvjWVxtSDgSj6/SxlXC2CXo9ckiW7GOvl
	 5AT/v5B0DSpag2U0KI+onPevf2/S0KOeiScJffpeA3gdWTPToi2HoHADHV7noSyJCI
	 +Fe0X2OX7A3jFbVTq4eC4M1Xjva/640kQaDd/MSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfE2Nho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbfE2Nhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:37:41 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C93221902;
        Wed, 29 May 2019 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137061;
        bh=cDlfEZs1l+f0STyQCqge3nbRzvyG+r7j9TDAE+O5Tb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpgaAyN/sib5HcsXXnTDPToDgg9u+LyhXEmph2FQMMgU/w2kc2bL0egNJ72hhfVJ3
         gDj8Pq/XXma9NHOyjaeu3FVUmx/6C6ONnZ7kTVL5kysfuWRaaJXLd5hKEJCZWFzKw6
         i+EgzThhUQ1JUxnK7b3HSR8J6SVPLLq4BUux6RJM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 18/41] perf beauty: Add generator for sync_file_range's 'flags' arg values
Date:   Wed, 29 May 2019 10:35:42 -0300
Message-Id: <20190529133605.21118-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ tools/perf/trace/beauty/sync_file_range.sh
  static const char *sync_file_range_flags[] = {
          [ilog2(1) + 1] = "WAIT_BEFORE",
          [ilog2(2) + 1] = "WRITE",
          [ilog2(4) + 1] = "WAIT_AFTER",
  };
  $

When all are the above are present, then we have something called
SYNC_FILE_RANGE_WRITE_AND_WAIT, that will be special cased in the
upcoming scnprintf beautifier for this flags arg.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uf2vd7bc8fkz65j7yit8dh84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sync_file_range.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/perf/trace/beauty/sync_file_range.sh

diff --git a/tools/perf/trace/beauty/sync_file_range.sh b/tools/perf/trace/beauty/sync_file_range.sh
new file mode 100755
index 000000000000..7a9282d04e44
--- /dev/null
+++ b/tools/perf/trace/beauty/sync_file_range.sh
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
+linux_fs=${linux_header_dir}/fs.h
+
+printf "static const char *sync_file_range_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_fs} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

