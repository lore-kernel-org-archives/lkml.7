Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE59FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0762241E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfKSQ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:57:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbfKSQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o7-0007Nk-5p; Tue, 19 Nov 2019 17:56:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 85F5B1C19CF;
        Tue, 19 Nov 2019 17:56:48 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:48 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf probe: Do not show non representive lines by
 perf-probe -L
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157406473064.24476.2913278267727587314.stgit@devnote2>
References: <157406473064.24476.2913278267727587314.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157418260850.12247.4435566464230141839.tip-bot2@tip-bot2>
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

Commit-ID:     499144c83d3b7e4f9e83916acfc97bbc3af891dc
Gitweb:        https://git.kernel.org/tip/499144c83d3b7e4f9e83916acfc97bbc3af891dc
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 17:12:10 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 18:59:36 -03:00

perf probe: Do not show non representive lines by perf-probe -L

Since perf probe -L shows non representive lines, it can be mislead
users where user can put probes.  This prevents to show such non
representive lines so that user can understand which lines user can
probe.

  # perf probe -L kernel_read
  <kernel_read@/build/linux-pvZVvI/linux-5.0.0/fs/read_write.c:0>
        0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
           {
        2         mm_segment_t old_fs;
                  ssize_t result;

                  old_fs = get_fs();
        6         set_fs(get_ds());
                  /* The cast to a user pointer is valid due to the set_fs() */
        8         result = vfs_read(file, (void __user *)buf, count, pos);
        9         set_fs(old_fs);
       10         return result;
           }
           EXPORT_SYMBOL(kernel_read);

Committer testing:

Before:

  # perf probe -L kernel_read
  <kernel_read@/usr/src/debug/kernel-5.3.fc30/linux-5.3.8-200.fc30.x86_64/fs/read_write.c:0>
        0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
        1  {
        2         mm_segment_t old_fs;
        3         ssize_t result;

        5         old_fs = get_fs();
        6         set_fs(KERNEL_DS);
                  /* The cast to a user pointer is valid due to the set_fs() */
        8         result = vfs_read(file, (void __user *)buf, count, pos);
        9         set_fs(old_fs);
       10         return result;
           }
           EXPORT_SYMBOL(kernel_read);
  #

See the 1, 3, 5 lines? They shouldn't be there, after this patch:

  # perf probe -L kernel_read
  <kernel_read@/usr/src/debug/kernel-5.3.fc30/linux-5.3.8-200.fc30.x86_64/fs/read_write.c:0>
        0  ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
           {
        2         mm_segment_t old_fs;
                  ssize_t result;

                  old_fs = get_fs();
        6         set_fs(KERNEL_DS);
                  /* The cast to a user pointer is valid due to the set_fs() */
        8         result = vfs_read(file, (void __user *)buf, count, pos);
        9         set_fs(old_fs);
       10         return result;
           }
           EXPORT_SYMBOL(kernel_read);
  #

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Link: http://lore.kernel.org/lkml/157406473064.24476.2913278267727587314.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index ef1b320..f12ad50 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1734,12 +1734,19 @@ static int line_range_walk_cb(const char *fname, int lineno,
 			      void *data)
 {
 	struct line_finder *lf = data;
+	const char *__fname;
+	int __lineno;
 	int err;
 
 	if ((strtailcmp(fname, lf->fname) != 0) ||
 	    (lf->lno_s > lineno || lf->lno_e < lineno))
 		return 0;
 
+	/* Make sure this line can be reversable */
+	if (cu_find_lineinfo(&lf->cu_die, addr, &__fname, &__lineno) > 0
+	    && (lineno != __lineno || strcmp(fname, __fname)))
+		return 0;
+
 	err = line_range_add_line(fname, lineno, lf->lr);
 	if (err < 0 && err != -EEXIST)
 		return err;
