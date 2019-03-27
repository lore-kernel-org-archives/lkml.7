Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD973C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F522075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfC0H3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:29:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:5823 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732384AbfC0H3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 00:29:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,276,1549958400"; 
   d="scan'208";a="144234337"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2019 00:29:46 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf scripts python: exported-sql-viewer.py: Fix python3 support
Date:   Wed, 27 Mar 2019 09:28:26 +0200
Message-Id: <20190327072826.19168-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327072826.19168-1-adrian.hunter@intel.com>
References: <20190327072826.19168-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike python2, python3 strings are not compatible with byte strings. That
results in disassembly not working for the branches reports. Fixup those
places overlooked in the port to python3.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
---
 .../perf/scripts/python/exported-sql-viewer.py  | 17 +++++++++++++----
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
-- 
2.17.1

