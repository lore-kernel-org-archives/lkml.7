Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA343C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E1E218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137015;
	bh=DxFVZqZAkMacyyd+DKewznFbDVEOe5YQBXCtJqoZ6vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MPEv5m1nZ6/IV8eJEaAuXUze/9uBeQZ1aznst2Kr/ia9qnzYbkYLsBHVmsioj76UY
	 h4lrxDsbZagh6Zad3rr0NB9sjKXF3SScqt6HVuO/ePkEXfvXDHj+YV3cbVt3Epg8Bp
	 O+bqfYcQmCuioIuNQRW1cIe3EDt+HuDKHMVYU7CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfE2Ngy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2Ngx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:53 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3B4218DA;
        Wed, 29 May 2019 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137012;
        bh=DxFVZqZAkMacyyd+DKewznFbDVEOe5YQBXCtJqoZ6vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcyAyVkdAwfrQAH7RslHIhMN83Gc/WLxwtoDLs+IcXJm5ccMYO3ZcMzrVZ/yD6je7
         XO0Z0WL5wI2XkM6nbMvb0HOqXNF7tkDjbVDjxof3bzUSiz6kyCZkMgloiW0HkApxbr
         qxhIvu9EVKZIwR57TWZJJiOqE+sVZmGyfGP7JgkE=
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
        David Howells <dhowells@redhat.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 08/41] perf beauty: Add generator for 'move_mount' flags argument
Date:   Wed, 29 May 2019 10:35:32 -0300
Message-Id: <20190529133605.21118-9-acme@kernel.org>
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
 create mode 100755 tools/perf/trace/beauty/move_mount_flags.sh

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
-- 
2.20.1

