Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768ED2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570461033;
	bh=6r8t1dHquGoeni2YRJD6dXFGHQJJSEJgPmcLrD52UVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yhv94qs1teuPDKtUJwvZMvCvaa1CauzoaOeT3eLYMIHNpwwyTQWXktLtQ+NNHOzcZ
	 fuK4JfSqFIEajm3JeZvy00CAMXrLRTcQ1Yu7zxtNxU8b/wGLKjGYLoH7Ei84tR10pO
	 EeCIyMN3HVdjn9uf8MxeLdafNXpEjFCgvPSxgi+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJGPKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGPKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:10:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345042070B;
        Mon,  7 Oct 2019 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570461030;
        bh=6r8t1dHquGoeni2YRJD6dXFGHQJJSEJgPmcLrD52UVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/cmF24hrXBDDYcLA9BZjxFU+liz1gVBG1zCoAhvOiDQMgL7G1v2F+tf6vEL1xHAq
         3IuarbMoRCj6tm7pAYmsv8LZqMLtmy916SylBjscyWkfvWUo3uW0E7uZ1w6CK7O9XB
         N2P8+ebCe91z0A9CNpQGnXWmkmnqmAm378qnwcqk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [BUGFIX PATCH 1/5] selftests: proc: Make va_max 3GB on 32bit arch
Date:   Tue,  8 Oct 2019 00:10:26 +0900
Message-Id: <157046102656.20724.3358140818300189230.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157046101671.20724.9561877942986463668.stgit@devnote2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently proc-self-map-files-002.c sets va_max (max test address
of user virtual address) to 4GB, but it is too big for 32bit
arch and 1UL << 32 is overflow on 32bit long.

Make va_max 3GB on 32bit arch like i386 and arm.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
---
 .../selftests/proc/proc-self-map-files-002.c       |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 47b7473dedef..d517f8c479fb 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <stdlib.h>
+#include <asm/bitsperlong.h>
 
 static void pass(const char *fmt, unsigned long a, unsigned long b)
 {
@@ -44,10 +45,18 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 	exit(1);
 }
 
+#if __BITS_PER_LONG == 32
+# define VA_MAX (3UL << 30)
+#elif __BITS_PER_LONG == 64
+# define VA_MAX (1UL << 32)
+#else
+# define VA_MAX 0
+#endif
+
 int main(void)
 {
 	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-	const unsigned long va_max = 1UL << 32;
+	const unsigned long va_max = VA_MAX;
 	unsigned long va;
 	void *p;
 	int fd;

