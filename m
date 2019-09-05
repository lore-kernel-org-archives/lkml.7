Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C7721848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbfIEPnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388555AbfIEPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603EE20870;
        Thu,  5 Sep 2019 15:43:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tv9-0007Td-Sk; Thu, 05 Sep 2019 11:43:39 -0400
Message-Id: <20190905154339.780346390@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [for-next][PATCH 03/25] recordmcount: Remove uread()
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <mhelsley@vmware.com>

uread() is only used to initialize the ELF file's pseudo
private-memory mapping while uwrite() and ulseek() work within
the pseudo-mapping and extend it as necessary.  Thus it is not
a complementary function to uwrite() and ulseek(). It also makes
no sense to do cleanups inside uread() when its only caller,
mmap_file(), is doing the relevant allocations and associated
initializations.

Therefore it's clearer to use a plain read() call to initialize the
data in mmap_file() and remove uread().

Link: http://lkml.kernel.org/r/31a87c22b19150cec1c8dc800c8b0873a2741703.1563992889.git.mhelsley@vmware.com

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index ebe98c39f3cd..c0dd46344063 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -89,7 +89,7 @@ succeed_file(void)
 	longjmp(jmpenv, SJ_SUCCEED);
 }
 
-/* ulseek, uread, ...:  Check return value for errors. */
+/* ulseek, uwrite, ...:  Check return value for errors. */
 
 static off_t
 ulseek(int const fd, off_t const offset, int const whence)
@@ -112,17 +112,6 @@ ulseek(int const fd, off_t const offset, int const whence)
 	return file_ptr - file_map;
 }
 
-static size_t
-uread(int const fd, void *const buf, size_t const count)
-{
-	size_t const n = read(fd, buf, count);
-	if (n != count) {
-		perror("read");
-		fail_file();
-	}
-	return n;
-}
-
 static size_t
 uwrite(int const fd, void const *const buf, size_t const count)
 {
@@ -298,7 +287,10 @@ static void *mmap_file(char const *fname)
 	if (file_map == MAP_FAILED) {
 		mmap_failed = 1;
 		file_map = umalloc(sb.st_size);
-		uread(fd_map, file_map, sb.st_size);
+		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
+			perror(fname);
+			fail_file();
+		}
 	}
 	close(fd_map);
 
-- 
2.20.1


