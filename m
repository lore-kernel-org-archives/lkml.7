Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D25C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5515F20678
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574757287;
	bh=sT2P3jcqZzwiE0tNd5Vyi3LpzVl1tf4SHap4G4TGsII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KD7Kxj2m8JgfPtm0MAaLL06UdlXeqMKT2C4MRobcYiX0JtFew9Mt2GjEJPeYtPRRt
	 zD5pwZLaZy9c5bwIOp9ClLIvTzmaAHjl0SrRT1QStjuHOcmSPSlF8Tl273MYvVDv/J
	 Ppt+UEemBX1ZpYNyHMwNdYP1cakTkVoHKpe+im4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKZIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfKZIeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:34:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C4A2084B;
        Tue, 26 Nov 2019 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574757285;
        bh=sT2P3jcqZzwiE0tNd5Vyi3LpzVl1tf4SHap4G4TGsII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfZpVpvX8X+lMwMJgdU9bHtkdDLkwzeKwc/Bp7aDaSoVyvLvj8J8VDWweWFxZZrGv
         70DszgLZzGiyF0/BaIp6X/yLCBSt/mjt/ADdh0P603MBclyOPHE4/k8LJJRDIw2g0h
         aNXtvNgVX0wfZPVDcGbiIc74AUf1+Sehl8Mod3BM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH v4 4/4] selftests/ftrace: Fix multiple kprobe testcase
Date:   Tue, 26 Nov 2019 17:34:42 +0900
Message-Id: <157475728194.3389.8125594709546416519.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157475724667.3389.15752644047898709246.stgit@devnote2>
References: <157475724667.3389.15752644047898709246.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple kprobe event testcase to work it correctly.
There are 2 bugfixes.
 - Since `wc -l FILE` returns not only line number but also
   FILE filename, following "if" statement always failed.
   Fix this bug by replacing it with 'cat FILE | wc -l'
 - Since "while do-done loop" block with pipeline becomes a
   subshell, $N local variable is not update outside of
   the loop.
   Fix this bug by using actual target number (256) instead
   of $N.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
index 5862eee91e1d..6e3dbe5f96b7 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -20,9 +20,9 @@ while read i; do
   test $N -eq 256 && break
 done
 
-L=`wc -l kprobe_events`
-if [ $L -ne $N ]; then
-  echo "The number of kprobes events ($L) is not $N"
+L=`cat kprobe_events | wc -l`
+if [ $L -ne 256 ]; then
+  echo "The number of kprobes events ($L) is not 256"
   exit_fail
 fi
 

