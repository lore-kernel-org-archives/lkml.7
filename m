Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE0C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48273222C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572955912;
	bh=81u2VMBen3B/7k/5sAtqBanmflObbTNuEldBN2Pu/uQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sKyf24q9MIG8w8yIF5ZmtQmwTTI3ZKlHYBkHF0LItUxxBHu2qYjeUC1qT0HTOALkm
	 lGlQfOoQxhlMRFrkwsc3DPPPsb+m8ZXLxHvQWvPZxBNHfcAx3h1jWkeUis3BhEXk85
	 8VTKJVnfghgD+nRdCdmwiNJb3vamOIG33lIUVDDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfKEMLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:11:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfKEMLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:11:51 -0500
Received: from linux-8ccs.suse.de (tmo-106-21.customers.d1-online.com [80.187.106.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC53205C9;
        Tue,  5 Nov 2019 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572955910;
        bh=81u2VMBen3B/7k/5sAtqBanmflObbTNuEldBN2Pu/uQ=;
        h=From:To:Cc:Subject:Date:From;
        b=L1gSlu2yMnfCGlOAPLbXw8nEDWD0CGRSXmhgvCpNiwTESuZOYbvSkHdL/cEZOkQ3Z
         aCBc+yywUP0aYVXymIgu3Bj+jLIznsa+FjCUXKBLkau7HHKE/aRhH0+zNOaUx7Acn4
         uyZWwWHd8XcwoBFkhNDMJXC/wizJqOa9uoHN/5bc=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] scripts/nsdeps: make sure to pass all module source files to spatch
Date:   Tue,  5 Nov 2019 13:11:03 +0100
Message-Id: <20191105121103.31200-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nsdeps script passes a list of the module source files to
generate_deps_for_ns() as a space delimited string named $mod_source_files,
which then passes it to spatch. But since $mod_source_files is not encased
in quotes, each source file in that string is treated as a separate shell
function argument (as $2, $3, $4, etc.).  However, the spatch invocation
only refers to $2, so only the first file out of $mod_source_files is
processed by spatch.

This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
get inserted) when a module is composed of many source files and the
"main" module file containing the MODULE_LICENSE() statement is not the
first file listed in $mod_source_files. Fix this by encasing
$mod_source_files in quotes so that the entirety of the string is
treated as a single argument and can be referred to as $2.

In addition, put quotes in the variable assignment of mod_source_files
to prevent any shell interpretation and field splitting.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

v2: put quotes around mod_source_files variable assignment as suggested by Masahiro.

 scripts/nsdeps | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index dda6fbac016e..04cea0921673 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -31,12 +31,12 @@ generate_deps() {
 	local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
 	local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
 	if [ ! -f "$ns_deps_file" ]; then return; fi
-	local mod_source_files=`cat $mod_file | sed -n 1p                      \
+	local mod_source_files="`cat $mod_file | sed -n 1p                      \
 					      | sed -e 's/\.o/\.c/g'           \
-					      | sed "s|[^ ]* *|${srctree}/&|g"`
+					      | sed "s|[^ ]* *|${srctree}/&|g"`"
 	for ns in `cat $ns_deps_file`; do
 		echo "Adding namespace $ns to module $mod_name (if needed)."
-		generate_deps_for_ns $ns $mod_source_files
+		generate_deps_for_ns $ns "$mod_source_files"
 		# sort the imports
 		for source_file in $mod_source_files; do
 			sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
-- 
2.16.4

