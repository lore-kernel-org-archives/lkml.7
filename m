Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E123BC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EFB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436933AbfFKWXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:23:06 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:28995 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436797AbfFKWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:22:14 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 11 Jun 2019 15:22:09 -0700
Received: from rlwimi.localdomain (unknown [10.129.220.121])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C5B4441BAC;
        Tue, 11 Jun 2019 15:22:12 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v2 02/13] recordmcount: Remove uread()
Date:   Tue, 11 Jun 2019 15:21:44 -0700
Message-ID: <a9af0192fd910026082eace685a037009a2f3049.1560285597.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1560285597.git.mhelsley@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uread() is only used to initialize the ELF file's pseudo
private-memory mapping while uwrite() and ulseek() work within
the pseudo-mapping and extend it as necessary.  Thus it is not
a complementary function to uwrite() and ulseek(). It also makes
no sense to do cleanups inside uread() when its only caller,
mmap_file(), is doing the relevant allocations and associated
initializations.

Therefore it's clearer to use a plain read() call to initialize the
data in mmap_file() and remove uread().

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
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

