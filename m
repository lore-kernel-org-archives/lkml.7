Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D21C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD812084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574064737;
	bh=AqMm+IZq6OBAKmv3CBj3UbSD/bAxC/E51HsFBSGWV1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HcBwNigy6vMQss7BKkLqqIP18MtI7cvz+EWUIfQ8rBuLUjBzsLDTynzo6rty2PbNy
	 f7S8NDS2wJ4KW85TyKKTwugZJZdTFHq6mZEiV3FoUgCo2h9m7/1NIwyIeEj81nQjDw
	 XHcuNMzC42l6ZLbJtGNd6BH3LQcfubfBq33hh78A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKRIMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfKRIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:12:15 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 061832075E;
        Mon, 18 Nov 2019 08:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574064734;
        bh=AqMm+IZq6OBAKmv3CBj3UbSD/bAxC/E51HsFBSGWV1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STr4XIwtCgw5TMv7bV3luRlL+F5E0iVxdHJMA2R73h9Ky7V6KBvbz94hlA05fmKn+
         26/R7db/tgBGZZ1vtqso2AqlSnx+6iTWVkRPeDMlKEKGvXn7EyhFotUPdfaZi5cAhI
         oMmGGJa0Doiit5bJOz8zSaJsLpY5iE47GimiPjq8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 3/7] perf probe: Do not show non representive lines by perf-probe -L
Date:   Mon, 18 Nov 2019 17:12:10 +0900
Message-Id: <157406473064.24476.2913278267727587314.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157406469983.24476.13195800716161845227.stgit@devnote2>
References: <157406469983.24476.13195800716161845227.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since perf probe -L shows non representive lines, it can be
mislead users where user can put probes.
This prevents to show such non representive lines so that user
can understand which lines user can probe.

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-finder.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index ef1b320cedf8..f12ad507a822 100644
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

