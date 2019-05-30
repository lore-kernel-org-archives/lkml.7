Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20329C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6893257C4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bKKPoqu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfE3IBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:01:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfE3IBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:01:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U80whE2900975
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:00:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U80whE2900975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203259;
        bh=1eQg5liXNZvSXKhu93ZVaCskw2LZDwO41JinQoNrQ1c=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=bKKPoqu+zIBER9YzS1X6a4UUbcnVmGd5SaMrNQ+SphcAHScHazPQmowj2tUNq6ycV
         LXdwcQWWjateTLEUzEoUgTzuo4cXO0sunuf1bA6QkInwOO0/PSR439jjx6dboksqWS
         YycMzeUJR9HAjrGEJn0WOz5lH4jaGJW5i3TSmLi3AU/NEZdPSwKmPZze1saGamPDOh
         fEcVyt74iBLQDs4An31MuY/UcPfPQshl5QpP9wcb5hNJTEKah8bSY3ovV2K7z9Pa6b
         SqPn+Sbkus1Qif8O13O4mtEiDMfD0fokOG6RcUUZ7DhrMZE8L8ZvGwJoRXPuaV1RFh
         DqgjazywIPo9w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U80wXV2900972;
        Thu, 30 May 2019 01:00:58 -0700
Date:   Thu, 30 May 2019 01:00:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-u721396rkqmawmt91dwwsntu@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, namhyung@kernel.org,
        brendan.d.gregg@gmail.com, acme@redhat.com
Reply-To: dhowells@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
          acme@redhat.com, brendan.d.gregg@gmail.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
          jolsa@kernel.org, hpa@zytor.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for fsconfig's 'cmd' arg
 values
Git-Commit-ID: d35293004a5e40c330ae5bf3667d716e702fe94a
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

Commit-ID:  d35293004a5e40c330ae5bf3667d716e702fe94a
Gitweb:     https://git.kernel.org/tip/d35293004a5e40c330ae5bf3667d716e702fe94a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 15:07:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:43 -0300

perf beauty: Add generator for fsconfig's 'cmd' arg values

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
 tools/perf/trace/beauty/{fspick.sh => fsconfig.sh} | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/fspick.sh b/tools/perf/trace/beauty/fsconfig.sh
similarity index 55%
copy from tools/perf/trace/beauty/fspick.sh
copy to tools/perf/trace/beauty/fsconfig.sh
index b220e07ef452..83fb24df05c9 100755
--- a/tools/perf/trace/beauty/fspick.sh
+++ b/tools/perf/trace/beauty/fsconfig.sh
@@ -9,9 +9,9 @@ fi
 
 linux_mount=${linux_header_dir}/mount.h
 
-printf "static const char *fspick_flags[] = {\n"
-regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+FSPICK_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+printf "static const char *fsconfig_cmds[] = {\n"
+regex='^[[:space:]]*+FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,[[:space:]]*.*'
 egrep $regex ${linux_mount} | \
 	sed -r "s/$regex/\2 \1/g"	| \
-	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+	xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n"
