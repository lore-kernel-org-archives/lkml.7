Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EDA218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfC2Ump (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:42:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfC2Ump (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:42:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKgceL3938845
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:42:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKgb0P3938842;
        Fri, 29 Mar 2019 13:42:37 -0700
Date:   Fri, 29 Mar 2019 13:42:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-606bd60ab6fbcb7f73deeef4fa37cfd5e447a200@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
          hpa@zytor.com, adrian.hunter@intel.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20190327072826.19168-3-adrian.hunter@intel.com>
References: <20190327072826.19168-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Fix
 python3 support
Git-Commit-ID: 606bd60ab6fbcb7f73deeef4fa37cfd5e447a200
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

Commit-ID:  606bd60ab6fbcb7f73deeef4fa37cfd5e447a200
Gitweb:     https://git.kernel.org/tip/606bd60ab6fbcb7f73deeef4fa37cfd5e447a200
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 27 Mar 2019 09:28:26 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 15:53:16 -0300

perf scripts python: exported-sql-viewer.py: Fix python3 support

Unlike python2, python3 strings are not compatible with byte strings.
That results in disassembly not working for the branches reports. Fixup
those places overlooked in the port to python3.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
Link: http://lkml.kernel.org/r/20190327072826.19168-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0cf30956064a..74ef92f1d19a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2908,9 +2908,13 @@ class LibXED():
 		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
 		if not ok:
 			return 0, ""
+		if sys.version_info[0] == 2:
+			result = inst.buffer.value
+		else:
+			result = inst.buffer.value.decode()
 		# Return instruction length and the disassembled instruction text
 		# For now, assume the length is in byte 166
-		return inst.xedd[166], inst.buffer.value
+		return inst.xedd[166], result
 
 def TryOpen(file_name):
 	try:
@@ -2926,9 +2930,14 @@ def Is64Bit(f):
 	header = f.read(7)
 	f.seek(pos)
 	magic = header[0:4]
-	eclass = ord(header[4])
-	encoding = ord(header[5])
-	version = ord(header[6])
+	if sys.version_info[0] == 2:
+		eclass = ord(header[4])
+		encoding = ord(header[5])
+		version = ord(header[6])
+	else:
+		eclass = header[4]
+		encoding = header[5]
+		version = header[6]
 	if magic == chr(127) + "ELF" and eclass > 0 and eclass < 3 and encoding > 0 and encoding < 3 and version == 1:
 		result = True if eclass == 2 else False
 	return result
