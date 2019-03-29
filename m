Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5432C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30162184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866738;
	bh=SkJNJd+wJX0ueJU247e9GspNYRCEhJUKJSkJnCs/It8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwW6uM2tlN6D0ydLDX/+i5+QgSgTEMGMqI1OzI4qlM9FOo5hzOUjcmxlUl+puhTjD
	 1fYzWYd0yRRzKSreDyBLW1LDPFO1t8JaA+sJKOFL0wW7SAIBWfyLQaz5mllJBOJMLo
	 tQro0h96+sa9W3A1e7VC1TlaDDlJhcYyosUFPLeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfC2Ni5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbfC2Niy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:54 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2466D2183F;
        Fri, 29 Mar 2019 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866733;
        bh=SkJNJd+wJX0ueJU247e9GspNYRCEhJUKJSkJnCs/It8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yiGLETrG+bpHgLmPkxYTlwCnDRzZrtqIce9DLvZNuQFWtcNgw6gOt96/KDg2F21Y1
         uGMzn01V0bHKkLxKqcIszPiWwnSFHtlMu95UW1B2Nf/wD7fWYwQWGBXLAJWWWtTdsd
         VNpDV5CFckbeh2QZXGS2L6o7mltoU3ZPerBsxvw4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/13] perf scripts python: exported-sql-viewer.py: Fix python3 support
Date:   Fri, 29 Mar 2019 10:38:00 -0300
Message-Id: <20190329133801.21004-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Unlike python2, python3 strings are not compatible with byte strings.
That results in disassembly not working for the branches reports. Fixup
those places overlooked in the port to python3.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
Link: http://lkml.kernel.org/r/20190327072826.19168-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

