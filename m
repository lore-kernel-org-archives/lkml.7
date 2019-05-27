Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF69C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCC82133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996731;
	bh=RnO4auYTI+mr8Vzp4tSiUkPlwS7Jvrw4n8IsvtHdCb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFVFAFhEU0YxyNxh5cd+OV8hEsZcyqicYU0asWqJHq0ueW2vnfTnIpaK4zFfqNWlG
	 PuVsC/byhcN8O0Cp7TFbJ0Kh2VrdD9m1QWtmRKl3UfrWtQ1W466CMN7pQi7E3/s0iG
	 GH5VcjKD/xdHu6dz0N5O8hSEW8w0dXt6O1t28XaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfE0Wiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfE0Wis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:38:48 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6C2208C3;
        Mon, 27 May 2019 22:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996728;
        bh=RnO4auYTI+mr8Vzp4tSiUkPlwS7Jvrw4n8IsvtHdCb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3SS0EwfXNYMQ/su2BU3zE5kcJhj7ohBQc0vSUYVjH62ban+CzaOBf19tKVsRzWkK
         PRjnYHTgC0cfvpNfA5F44YvgoSX0e+Es1ktThpR9Xe/seg9k2tYELuumNkw0BizfLD
         3SLcTetAcYchyxx82lLK0wKOgyhoFAu2MwjKZTi0=
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
Subject: [PATCH 15/44] perf beauty: Add generator for fsmount's 'attr_flags' arg values
Date:   Mon, 27 May 2019 19:37:01 -0300
Message-Id: <20190527223730.11474-16-acme@kernel.org>
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

  $ tools/perf/trace/beauty/fsmount.sh
  static const char *fsmount_attr_flags[] = {
          [ilog2(0x00000001) + 1] = "RDONLY",
          [ilog2(0x00000002) + 1] = "NOSUID",
          [ilog2(0x00000004) + 1] = "NODEV",
          [ilog2(0x00000008) + 1] = "NOEXEC",
          [ilog2(0x00000010) + 1] = "NOATIME",
          [ilog2(0x00000020) + 1] = "STRICTATIME",
          [ilog2(0x00000080) + 1] = "NODIRATIME",
  }

MOUNT_ATTR__ATIME and MOUNT_ATTR_RELATIME will be special cased in the
fsmount__scnprintf_flags() beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-sl24d7m2ge82mfmrbaf1mb0s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fsmount.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tools/perf/trace/beauty/fsmount.sh

diff --git a/tools/perf/trace/beauty/fsmount.sh b/tools/perf/trace/beauty/fsmount.sh
new file mode 100755
index 000000000000..615cc0fcf4f9
--- /dev/null
+++ b/tools/perf/trace/beauty/fsmount.sh
@@ -0,0 +1,22 @@
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
+# Remove MOUNT_ATTR_RELATIME as it is zeros, handle it a special way in the beautifier
+# Only handle MOUNT_ATTR_ followed by a capital letter/num as __ is special case
+# for things like MOUNT_ATTR__ATIME that is a mask for the possible ATIME handling
+# bits. Special case it as well in the beautifier
+
+printf "static const char *fsmount_attr_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOUNT_ATTR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_mount} | grep -v MOUNT_ATTR_RELATIME | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
-- 
2.20.1

