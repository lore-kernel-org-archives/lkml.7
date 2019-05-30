Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95771C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98D25775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qApFANtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfE3H6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:58:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfE3H6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:58:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7vsaP2900417
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:57:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7vsaP2900417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203075;
        bh=I3DixRfdsSIhpNy4s51n3QWmR/N6SKwRCf4bIQcTc4U=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=qApFANtxRKCGyLb6sAinEqAxriiAY4Ha1Bgxb3dQwDoc/tFBRXpZuiiqBwhUJdbDK
         GRhHWyxylVvTv5bbZ4ohb/B+v4clB5p09dsGMPX6nK+4we5LF6Lz5NGP32j+gyuVeI
         p5g9SfZDKCTfdSCIWsE7SrXbQ722VydxUIaUediluDX2b7u3/uRXDDY6FX37DaLglq
         6P/5EGtwAa8IgQIfPOK8iDL7d+n+BkR9Xl8w/9IatL+hZ9SK90iQFDZdRro2WAYTWo
         Rr8F3IpPbLjKsub6t2ur7hPxW/0ZWjoKHgs/xHofPRWHZLb2WKKoKWb78MFY1t7HEt
         pcY1nvvZ+pEhQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7vsjc2900414;
        Thu, 30 May 2019 00:57:54 -0700
Date:   Thu, 30 May 2019 00:57:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-px7v33suw1k2ehst52l7bwa3@git.kernel.org>
Cc:     adrian.hunter@intel.com, brendan.d.gregg@gmail.com,
        acme@redhat.com, namhyung@kernel.org, dhowells@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com,
        lclaudio@redhat.com, mingo@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, acme@redhat.com,
          brendan.d.gregg@gmail.com, namhyung@kernel.org,
          dhowells@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          jolsa@kernel.org, lclaudio@redhat.com, mingo@kernel.org,
          viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for 'move_mount' flags
 argument
Git-Commit-ID: eefa09b499d12883f2fad46f93379101c8da6fec
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

Commit-ID:  eefa09b499d12883f2fad46f93379101c8da6fec
Gitweb:     https://git.kernel.org/tip/eefa09b499d12883f2fad46f93379101c8da6fec
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 20 May 2019 14:16:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf beauty: Add generator for 'move_mount' flags argument

  $ tools/perf/trace/beauty/move_mount_flags.sh
  static const char *move_mount_flags[] = {
	  [ilog2(0x00000001) + 1] = "F_SYMLINKS",
	  [ilog2(0x00000002) + 1] = "F_AUTOMOUNTS",
	  [ilog2(0x00000004) + 1] = "F_EMPTY_PATH",
	  [ilog2(0x00000010) + 1] = "T_SYMLINKS",
	  [ilog2(0x00000020) + 1] = "T_AUTOMOUNTS",
	  [ilog2(0x00000040) + 1] = "T_EMPTY_PATH",
  };
  $

Will be wired up to the 'perf trace' arg in a followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-px7v33suw1k2ehst52l7bwa3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/move_mount_flags.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/trace/beauty/move_mount_flags.sh b/tools/perf/trace/beauty/move_mount_flags.sh
new file mode 100755
index 000000000000..55e59241daa4
--- /dev/null
+++ b/tools/perf/trace/beauty/move_mount_flags.sh
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
+printf "static const char *move_mount_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([FT]_[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep $regex ${linux_mount} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+printf "};\n"
