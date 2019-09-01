Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6F4C3A5A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5493D233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340759;
	bh=Jb1Et4bkfQj1QBHRSEuF1HC4NzDF9Z4bgRF6wQLDC2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fFWBprJWe6eb7vy6yPpwtEFnuKbzG/xzWhydqMSCgOECFaGWROqVX+KHcCMgr8W73
	 pHLJ2WOEFiCvFJj7AaXPM47gHqrTYny9nqNKDIpAQPn97gx9Ogn/xINZyZQsNiEbPH
	 r3VG8hUGEqNtUy4mIcB+2CftbCxNWvxsXaMPCSbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfIAMZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbfIAMZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D538321897;
        Sun,  1 Sep 2019 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340752;
        bh=Jb1Et4bkfQj1QBHRSEuF1HC4NzDF9Z4bgRF6wQLDC2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAhOemNOL595EsX1kLjVq+f1wlYv+rVXF2J6aVNn6hb/G0/1Zwo9Z0sxwmyLJmWST
         +JT6c0ZwlMNiY33p+cckKjpSIZg4HbVS4rMfND+L29M1qDPUlXEjs/v1aFpHiazDVr
         bKxH41XlE6iagPVip1ZOycPd4lv18CqhOhRaKybA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 46/47] objtool: Update sync-check.sh from perf's check-headers.sh
Date:   Sun,  1 Sep 2019 09:23:25 -0300
Message-Id: <20190901122326.5793-47-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow using the -I trick that will be needed for checking the x86
insn decoder files.

Without the specific -I lines we still get the same warnings as before:

  $ make -C tools/objtool/ clean ; make -C tools/objtool/
  make: Entering directory '/home/acme/git/perf/tools/objtool'
    CLEAN    objtool
  find  -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
  rm -f arch/x86/inat-tables.c fixdep
  <SNIP>
    LD       objtool-in.o
  make[1]: Leaving directory '/home/acme/git/perf/tools/objtool'
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/inat.h' differs from latest version at 'arch/x86/include/asm/inat.h'
  diff -u tools/arch/x86/include/asm/inat.h arch/x86/include/asm/inat.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/insn.h' differs from latest version at 'arch/x86/include/asm/insn.h'
  diff -u tools/arch/x86/include/asm/insn.h arch/x86/include/asm/insn.h
  Warning: Kernel ABI header at 'tools/arch/x86/lib/inat.c' differs from latest version at 'arch/x86/lib/inat.c'
  diff -u tools/arch/x86/lib/inat.c arch/x86/lib/inat.c
  Warning: Kernel ABI header at 'tools/arch/x86/lib/insn.c' differs from latest version at 'arch/x86/lib/insn.c'
  diff -u tools/arch/x86/lib/insn.c arch/x86/lib/insn.c
  /home/acme/git/perf/tools/objtool
    LINK     objtool
  make: Leaving directory '/home/acme/git/perf/tools/objtool'
  $

The next patch will add the -I lines for those files.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: http://lore.kernel.org/lkml/20190830193109.p7jagidsrahoa4pn@treble
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-vu3p38mnxlwd80rlsnjkqcf2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/objtool/sync-check.sh | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 66f1575b80f3..6fa87de1c765 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -12,18 +12,39 @@ arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 '
 
-check()
-{
-	local file=$1
+check_2 () {
+  file1=$1
+  file2=$2
 
-	diff ../$file ../../$file > /dev/null ||
-		echo "Warning: synced file at 'tools/objtool/$file' differs from latest kernel version at '$file'"
+  shift
+  shift
+
+  cmd="diff $* $file1 $file2 > /dev/null"
+
+  test -f $file2 && {
+    eval $cmd || {
+      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
+      echo diff -u $file1 $file2
+    }
+  }
+}
+
+check () {
+  file=$1
+
+  shift
+
+  check_2 tools/$file $file $*
 }
 
 if [ ! -d ../../kernel ] || [ ! -d ../../tools ] || [ ! -d ../objtool ]; then
 	exit 0
 fi
 
+cd ../..
+
 for i in $FILES; do
   check $i
 done
+
+cd -
-- 
2.21.0

