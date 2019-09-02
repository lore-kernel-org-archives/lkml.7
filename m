Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED818215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfIBIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:17:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56378 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfIBIRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:17:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hWA-0008HP-G5; Mon, 02 Sep 2019 10:16:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D68D61C0DF6;
        Mon,  2 Sep 2019 10:16:44 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:44 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] objtool: Update sync-check.sh from perf's check-headers.sh
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190830193109.p7jagidsrahoa4pn@treble>
References: <20190830193109.p7jagidsrahoa4pn@treble>
MIME-Version: 1.0
Message-ID: <156741220469.17404.17592526465433413478.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2ffd84ae973b5ad16be96840574bb1142fda268a
Gitweb:        https://git.kernel.org/tip/2ffd84ae973b5ad16be96840574bb1142fda268a
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Sat, 31 Aug 2019 17:29:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:52 -03:00

objtool: Update sync-check.sh from perf's check-headers.sh

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
index 66f1575..6fa87de 100755
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
