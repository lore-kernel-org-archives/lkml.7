Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B810DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD6206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUOp+UuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLVOo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 09:44:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfLVOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 09:44:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so13428772wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xq8XOuNVwP6TXYqxslzoWH+d6Qc1GRFVBZ8VHe5rsUw=;
        b=VUOp+UuEQxDij0F4nExpHqCRVRsxEQM1tGiJ5uLll7rb7JUqhSHfB6cAGt4kkIE1KD
         g0KfTvSU+orI2QKcWOfOrWQRbHNBaLs+sh00EAd/uK9+iBXucw3WBQCwuRpgW6lhOYiJ
         FGBUpfEzeIsLPJyP/Vzby8paLhkIG6tbX90OraTyFPp7Amr5ZfPSWw83ft1EYc4NBwf0
         ERCMmveQXw8uKAgWOobzWEKPiwwrpUnfur/cip6KjQ3iuVXtfRaTJpJeYNCnujVS+tIp
         lIAdRKRQKEmETP9rYYEHWozaPU0VnocOfZ3QSwb7gwBpkq/OTgxdihYbdutZCfTqXhqK
         wNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xq8XOuNVwP6TXYqxslzoWH+d6Qc1GRFVBZ8VHe5rsUw=;
        b=rtRVyKXUfPqe+3pKnIQHJ9FvNDmWpW7toRczyn9lvsLfk94BkgFQhU4x6rVBr1CeY8
         8FYpa5/G5QgXBPAlipyrs/mUVYiOazzlXdK8jFGWmfN6kVw8wuqkQ2qOQxJPc3YZ1ouk
         +qlLgN0IweLT28xlZL8my1ri8DyrNCTgog8g9NfVr7FTjGRf8Xxk7wmD+EOsWNLdzpwK
         svVmZfbK3HtycGhW37QA/M9tzBiFKA7Yp5aO+cX2oIqcK7W4IQx6vkfeufD/0rzTJAKc
         9DEZOIwMegtNcBgm5V4RixBiVrG+WJ7cUN7IwThgyeRxowGpsh4//nziZ4lgEoBC8xIr
         9G8w==
X-Gm-Message-State: APjAAAVQGI9eXZDHGqEV2JPa9PwUzwRpJIdALLD7b3fhHMqAhLweN7/0
        2A0WmfquRhr5AlCRx+bfew==
X-Google-Smtp-Source: APXvYqzp5ccBwsIw955eyU8ldfXK+Qkd6Bq3iUk5jt5V1wOiKphQaP8OLlVENJkZP4uiBmaE5b+MnQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr27907928wmd.7.1577025864176;
        Sun, 22 Dec 2019 06:44:24 -0800 (PST)
Received: from avx2 ([46.53.254.212])
        by smtp.gmail.com with ESMTPSA id c195sm18653673wmd.45.2019.12.22.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 06:44:23 -0800 (PST)
Date:   Sun, 22 Dec 2019 17:44:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 3/3] ELF, coredump: allow process with empty address
 space to coredump
Message-ID: <20191222144421.GC24341@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmapping whole address space at once with

	munmap(0, (1ULL<<47) - 4096)

or equivalent will create empty coredump.

It is silly way to exit, however registers content may still be useful.

The right to coredump is fundamental right of a process!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c                                  |   10 +++++-
 tools/testing/selftests/exec/Makefile            |    1 
 tools/testing/selftests/exec/coredump-zero-vma.c |   38 +++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1595,6 +1595,10 @@ static int fill_files_note(struct memelfnote *note)
 	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
 		return -EINVAL;
 	size = round_up(size, PAGE_SIZE);
+	/*
+	 * "size" can be 0 here legitimately.
+	 * Let it ENOMEM and omit NT_FILE section which will be empty anyway.
+	 */
 	data = kvmalloc(size, GFP_KERNEL);
 	if (ZERO_OR_NULL_PTR(data))
 		return -ENOMEM;
@@ -2257,9 +2261,13 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
+	/*
+	 * Zero vma process will get ZERO_SIZE_PTR here.
+	 * Let coredump continue for register state at least.
+	 */
 	vma_filesz = kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)),
 			      GFP_KERNEL);
-	if (ZERO_OR_NULL_PTR(vma_filesz))
+	if (!vma_filesz)
 		goto end_coredump;
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -8,6 +8,7 @@ TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
+TEST_GEN_PROGS += coredump-zero-vma
 TEST_GEN_PROGS += recursion-depth
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/exec/coredump-zero-vma.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2019 Alexey Dobriyan
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that unmapping whole address space at once doesn't do anything funny. */
+#include <stddef.h>
+#include <sys/mman.h>
+#include <sys/resource.h>
+
+#ifdef __x86_64__
+static const size_t len = ((size_t)1 << 47) - 4096;
+#endif
+
+#ifdef __x86_64__
+int main(void)
+{
+	setrlimit(RLIMIT_CORE, &(struct rlimit){RLIM_INFINITY, RLIM_INFINITY});
+	munmap(NULL, len);
+	/* And... it's gone! */
+	return 1;
+}
+#else
+int main(void)
+{
+	return 4;
+}
+#endif
