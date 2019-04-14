Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB659C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACFE20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmwP6E+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfDNMgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:36:17 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43645 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfDNMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:36:17 -0400
Received: by mail-wr1-f48.google.com with SMTP id k17so13412530wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+yjaPlTeMXwUBxOC+PlfXzWVaMIZn2Rm82fFQI/PAN0=;
        b=FmwP6E+EtbpDBj471yuvgUuKbG6K8JTm93+cLtzxB26lffal0uaoJ9amEitIIKfS2K
         8qYiQtGMBhefxqU9WwBPNFVVEX1l21g2xlm1IO7FQxedoFJNqedZn/VIJKytGxyoq0xI
         a6ibYrZWtfHl5eA3tsGFKAIZl9A9ugdEHlbC7b1aKJaQZIklm2a1asNrSBmmj6JJvSK6
         LJzu30DhTOlRS2a7r3l48YY/zl/u0dAQrqW1JPTYlXeCJS5UQnwP0PkfDHFxa9ZUKxMA
         Pmnrh13l6L3pkHZ0F/eTv9ulnnjzGgJtny+OIUj7nC/mnqUO9bD2hALKnBLwbEIbBiqf
         +qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+yjaPlTeMXwUBxOC+PlfXzWVaMIZn2Rm82fFQI/PAN0=;
        b=PY053dYR8wAs3G8KWpDhhGcHoDNt+etfhbZugkwhltSoMsu+IwzGpCQEYKeQ7bI1im
         iOyo2OKYiE5SwSYfHjfwJixlfobrzmN206fn3pfGSE7OXSokP/rJfqWNfK4iO00mQWLa
         3ZCBJ5qSwhiHQ6Ac58M8FafFSSXprbtmTBsc77e7/D/E7I/P4Q1WYRisPjMQUjoZZxPd
         AhXs6US6NH4Cp0kmg9+rT7lzlXw3rInnOLBebOvAyhMQlmO8KUJlEx47VTKnWrQW4TRQ
         7V8EG6nzt2qrtMIc/C4JPSV3e/naTgdaWlWVr79evJhuX6U8DN9eXD0GQAtjaOcPWxbE
         s0OA==
X-Gm-Message-State: APjAAAWZy+8iWa2HHHQBaz6CcZP35H2S5zZNyonyf4Clr9q83YciSRUG
        vkh1j9tgeWC1rFLZJ98NZC0w004=
X-Google-Smtp-Source: APXvYqynZ7Wx/X9itnWSu9v7NMgF5msEvZXa/nsPj2nFar/ZrsoNNNIE7eiml0m0u3JmVC+sq+6wXQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr42838001wrn.109.1555245375083;
        Sun, 14 Apr 2019 05:36:15 -0700 (PDT)
Received: from avx2 ([46.53.240.140])
        by smtp.gmail.com with ESMTPSA id g12sm52228113wrw.40.2019.04.14.05.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 05:36:14 -0700 (PDT)
Date:   Sun, 14 Apr 2019 15:36:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: fix map_files test on F29
Message-ID: <20190414123612.GB12971@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F29 bans mapping first 64KB even for root making test fail.
Iterate from address 0 until mmap() works.

Gentoo (root):

	openat(AT_FDCWD, "/dev/zero", O_RDONLY) = 3
	mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0

Gentoo (non-root):

	openat(AT_FDCWD, "/dev/zero", O_RDONLY) = 3
	mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EPERM (Operation not permitted)
	mmap(0x1000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x1000

F29 (root):

	openat(AT_FDCWD, "/dev/zero", O_RDONLY) = 3
	mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x1000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x2000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x3000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x4000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x5000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x6000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x7000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x8000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x9000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0xa000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0xb000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0xc000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0xd000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0xe000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0xf000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
	mmap(0x10000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x10000

Now all proc tests succeed on F29 if run as root, at last!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-self-map-files-002.c |   20 ++++++++---------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -46,12 +46,9 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 
 int main(void)
 {
-	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-#ifdef __arm__
-	unsigned long va = 2 * PAGE_SIZE;
-#else
-	unsigned long va = 0;
-#endif
+	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+	const unsigned long va_max = 1UL << 32;
+	unsigned long va;
 	void *p;
 	int fd;
 	unsigned long a, b;
@@ -60,10 +57,13 @@ int main(void)
 	if (fd == -1)
 		return 1;
 
-	p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
-	if (p == MAP_FAILED) {
-		if (errno == EPERM)
-			return 4;
+	for (va = 0; va < va_max; va += PAGE_SIZE) {
+		p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+		if (p == (void *)va)
+			break;
+	}
+	if (va == va_max) {
+		fprintf(stderr, "error: mmap doesn't like you\n");
 		return 1;
 	}
 
