Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D5CC004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A464F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Dm1QEsQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGILcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:32:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGILcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:32:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BW5eo1893066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:32:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BW5eo1893066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562671926;
        bh=CoVYh7RQcHEdJFMYLr9zPdY9n2b7cEdPgptgdwzXnfg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Dm1QEsQ+Fq1Hag7BRArKTqkJnnd4qQBjORuW08MQn2E+9Jv3jqJCojithRfGloQ8P
         /ZG1Aj8J5YPwRnrpzk7t8XMYNn+CWBc5IyDd/djok0NjxGU5btxpLpAa0csi1f1p+r
         lMQpG9Y0r4S8NTYzrMPUyXoBv3QFD5dqlLJ93HfL0us3XMf2PiTD8WjFzTXec84raO
         OriH1vy5mu1rgKdKB08ZYcouk46IBlamUr5VAtoTSn1i5LVLY1RhTDl7v+51vcD9yt
         dTlgQJ08iZRgUpL6C1sMFKJ4R+CUtQwzqHZVqTQMI/j9Cl8mp+UUwK4YE7ayu56Dz6
         4lF3RG/+Iss0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BW5nj1893063;
        Tue, 9 Jul 2019 04:32:05 -0700
Date:   Tue, 9 Jul 2019 04:32:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f9nexro58q62l3o9hez8hr0i@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com,
          namhyung@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate TUI browser: Do not use member from
 variable within its own initialization
Git-Commit-ID: d5b2179d6a675ee8cdbd3250d42f1e32d5a45fb1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190709113205.SNlO_erwnHoGjL36-7PlJavQhMGkpZ8an4dW74Tlpzo@z>

Commit-ID:  d5b2179d6a675ee8cdbd3250d42f1e32d5a45fb1
Gitweb:     https://git.kernel.org/tip/d5b2179d6a675ee8cdbd3250d42f1e32d5a45fb1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 May 2019 16:02:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 6 Jul 2019 16:59:11 -0300

perf annotate TUI browser: Do not use member from variable within its own initialization

Some compilers will complain when using a member of a struct to
initialize another member, in the same struct initialization.

For instance:

  debian:8      Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  oraclelinux:7 clang version 3.4.2 (tags/RELEASE_34/dot2-final)

Produce:

  ui/browsers/annotate.c:104:12: error: variable 'ops' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
                                              (!ops.current_entry ||
                                                ^~~
  1 error generated.

So use an extra variable, initialized just before that struct, to have
the value used in the expressions used to init two of the struct
members.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: c298304bd747 ("perf annotate: Use a ops table for annotation_line__write()")
Link: https://lkml.kernel.org/n/tip-f9nexro58q62l3o9hez8hr0i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 98d934a36d86..b0d089a95dac 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -97,11 +97,12 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct annotation *notes = browser__annotation(browser);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
+	const bool is_current_entry = ui_browser__is_current_entry(browser, row);
 	struct annotation_write_ops ops = {
 		.first_line		 = row == 0,
-		.current_entry		 = ui_browser__is_current_entry(browser, row),
+		.current_entry		 = is_current_entry,
 		.change_color		 = (!notes->options->hide_src_code &&
-					    (!ops.current_entry ||
+					    (!is_current_entry ||
 					     (browser->use_navkeypressed &&
 					      !browser->navkeypressed))),
 		.width			 = browser->width,
