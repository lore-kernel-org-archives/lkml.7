Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BFCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73B7222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKLLR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:17:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfKLLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:17:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBF-0000GJ-KT; Tue, 12 Nov 2019 12:17:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 527BB1C0084;
        Tue, 12 Nov 2019 12:17:53 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:52 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Fix to show calling lines of inlined functions
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157241937995.32002.17899884017011512577.stgit@devnote2>
References: <157241937995.32002.17899884017011512577.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157355747285.29376.5669774786164883917.tip-bot2@tip-bot2>
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

Commit-ID:     86c0bf8539e7f46d91bd105e55eda96e0064caef
Gitweb:        https://git.kernel.org/tip/86c0bf8539e7f46d91bd105e55eda96e0064caef
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 30 Oct 2019 16:09:40 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 08:30:19 -03:00

perf probe: Fix to show calling lines of inlined functions

Fix to show calling lines of inlined functions (where an inline function
is called).

die_walk_lines() filtered out the lines inside inlined functions based
on the address. However this also filtered out the lines which call
those inlined functions from the target function.

To solve this issue, check the call_file and call_line attributes and do
not filter out if it matches to the line information.

Without this fix, perf probe -L doesn't show some lines correctly.
(don't see the lines after 17)

  # perf probe -L vfs_read
  <vfs_read@/home/mhiramat/ksrc/linux/fs/read_write.c:0>
        0  ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
        1  {
        2         ssize_t ret;

        4         if (!(file->f_mode & FMODE_READ))
                          return -EBADF;
        6         if (!(file->f_mode & FMODE_CAN_READ))
                          return -EINVAL;
        8         if (unlikely(!access_ok(buf, count)))
                          return -EFAULT;

       11         ret = rw_verify_area(READ, file, pos, count);
       12         if (!ret) {
       13                 if (count > MAX_RW_COUNT)
                                  count =  MAX_RW_COUNT;
       15                 ret = __vfs_read(file, buf, count, pos);
       16                 if (ret > 0) {
                                  fsnotify_access(file);
                                  add_rchar(current, ret);
                          }

With this fix:

  # perf probe -L vfs_read
  <vfs_read@/home/mhiramat/ksrc/linux/fs/read_write.c:0>
        0  ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
        1  {
        2         ssize_t ret;

        4         if (!(file->f_mode & FMODE_READ))
                          return -EBADF;
        6         if (!(file->f_mode & FMODE_CAN_READ))
                          return -EINVAL;
        8         if (unlikely(!access_ok(buf, count)))
                          return -EFAULT;

       11         ret = rw_verify_area(READ, file, pos, count);
       12         if (!ret) {
       13                 if (count > MAX_RW_COUNT)
                                  count =  MAX_RW_COUNT;
       15                 ret = __vfs_read(file, buf, count, pos);
       16                 if (ret > 0) {
       17                         fsnotify_access(file);
       18                         add_rchar(current, ret);
                          }
       20                 inc_syscr(current);
                  }

Fixes: 4cc9cec636e7 ("perf probe: Introduce lines walker interface")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/157241937995.32002.17899884017011512577.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dwarf-aux.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index ac12890..5544bfb 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -784,7 +784,7 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 	Dwarf_Lines *lines;
 	Dwarf_Line *line;
 	Dwarf_Addr addr;
-	const char *fname, *decf = NULL;
+	const char *fname, *decf = NULL, *inf = NULL;
 	int lineno, ret = 0;
 	int decl = 0, inl;
 	Dwarf_Die die_mem, *cu_die;
@@ -835,13 +835,21 @@ int die_walk_lines(Dwarf_Die *rt_die, line_walk_callback_t callback, void *data)
 			 */
 			if (!dwarf_haspc(rt_die, addr))
 				continue;
+
 			if (die_find_inlinefunc(rt_die, addr, &die_mem)) {
+				/* Call-site check */
+				inf = die_get_call_file(&die_mem);
+				if ((inf && !strcmp(inf, decf)) &&
+				    die_get_call_lineno(&die_mem) == lineno)
+					goto found;
+
 				dwarf_decl_line(&die_mem, &inl);
 				if (inl != decl ||
 				    decf != dwarf_decl_file(&die_mem))
 					continue;
 			}
 		}
+found:
 		/* Get source line */
 		fname = dwarf_linesrc(line, NULL, NULL);
 
