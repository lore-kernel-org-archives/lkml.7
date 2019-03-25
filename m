Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1033F20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfCYQE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbfCYQE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:04:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 656B63086211;
        Mon, 25 Mar 2019 16:04:56 +0000 (UTC)
Received: from jlaw-desktop.bos.redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38255909FF;
        Mon, 25 Mar 2019 16:04:53 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] kbuild: strip whitespace in cmd_record_mcount findstring
Date:   Mon, 25 Mar 2019 12:04:38 -0400
Message-Id: <20190325160438.8982-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 25 Mar 2019 16:04:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC_FLAGS_FTRACE may contain trailing whitespace that interferes with
findstring.

For example, commit 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on
GCC 4.9 and newer") introduced a change such that on my ppc64le box,
CC_FLAGS_FTRACE="-pg -mprofile-kernel ".  (Note the trailing space.)
When cmd_record_mcount is now invoked, findstring fails as the ftrace
flags were found at very end of _c_flags, without the trailing space.

  _c_flags=" ... -pg -mprofile-kernel"
  CC_FLAGS_FTRACE="-pg -mprofile-kernel "
                                       ^
    findstring is looking for this extra space

Remove the redundant whitespaces from CC_FLAGS_FTRACE in
cmd_record_mcount to avoid this problem.

Fixes: 6977f95e63b9 ("powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer").
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---

Standard disclaimer: I'm not a kbuild expert, but this works around the
problem I reported where ftrace and livepatch self-tests were failing as
specified object files were not run through the recordmcount.pl script:

ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-March/187298.html

 scripts/Makefile.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2554a15ecf2b..74d402b5aa3c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -199,10 +199,10 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
-cmd_record_mcount =						\
-	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
-	     "$(CC_FLAGS_FTRACE)" ]; then			\
-		$(sub_cmd_record_mcount)			\
+cmd_record_mcount =							\
+	if [ "$(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags))" =	\
+	     "$(strip $(CC_FLAGS_FTRACE))" ]; then			\
+		$(sub_cmd_record_mcount)				\
 	fi
 endif # CC_USING_RECORD_MCOUNT
 endif # CONFIG_FTRACE_MCOUNT_RECORD
-- 
2.20.1

