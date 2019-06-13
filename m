Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AC8C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7743206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5JSD5n4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfFMPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:32:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39353 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfFMKqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:46:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so2933934pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pd2UgfTEjIEqeOaghBSIw7YbVcG8PFXXSl39qx+Thxw=;
        b=C5JSD5n4A9lSn7ivR28GTiLFczd6Q2dkFHL4BmaZvwF4xDTrtWHt8tMYismMcyg2uL
         y1rFeektXyRR2wpeaWJlCDw1NHIRjkzD34s2ptRzp0+/Kdf9Frgc3DRtKp5qJoZUw6qa
         MGIqdLmFUHu3zMfzfxWlOd0dAMEDV1H4hxiRRuzK5tN8W6+kg02efURm2aAv+duHDcf8
         +IFdFr0OGdxP7AgFi8gJcL6BB204Je13VF+cOBZwXJouh1qpMrXK6UFIl/Czaepdx8av
         jlgK12fmk34hSjNQaRWPPXxw29ULIxRdwPKsqdpk0lUjzURt+yKoJfflmG/sTo6897ho
         QCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pd2UgfTEjIEqeOaghBSIw7YbVcG8PFXXSl39qx+Thxw=;
        b=pjEto1hij6WNywomA1TO/Kui0ZbWRkBwyM4B6pKJxineCfwNlYKWFIDHtDhR5Sq7Dt
         VMXI+1FuW7Fl+zH1FQG8HBO+b452mpRA0//UH367dEBu2hJnaiRlZyoRnUjDarF8oXis
         N9b/KeYOOKA8IAd+eXCWLPpJDaMHejQDpQUm2URUtgCJ5kH6d3ZrC1iIfS/4XvgdKaFO
         GZoshcuBzRXfVek7gvrADTjDchKzdY05pUe4SQTakp69v8wskm2LT6AT2d8nePcc2ZOq
         nfwN7WQdSAt6b+n9XmlgTAnC9lm4nb9x6Y/pMRHP1mxeTKITysirwy8jksqBARIEOL2k
         Fc1w==
X-Gm-Message-State: APjAAAWBcPqIXz7x1M2hcOxrQFM9lOy3+tSCSEKX6byHRr1me+1/axLn
        MH/VD9wRMjya0F06J4j/LA==
X-Google-Smtp-Source: APXvYqyzzGjKho8nXPrUGm5asBy3qMNefeXotTwKcWnKkde5GEq3MJbTFtzDQgF+NAQZL9mqvTXLkA==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr24314348plf.137.1560422767994;
        Thu, 13 Jun 2019 03:46:07 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:7825:dd90:9051:d949:55f9:678b])
        by smtp.gmail.com with ESMTPSA id a13sm2813285pgh.6.2019.06.13.03.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 03:46:07 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv4 3/3] mm/gup_benchemark: add LONGTERM_BENCHMARK test in gup fast path
Date:   Thu, 13 Jun 2019 18:45:02 +0800
Message-Id: <1560422702-11403-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
References: <1560422702-11403-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a GUP_LONGTERM_BENCHMARK ioctl to test longterm pin in gup fast
path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 mm/gup_benchmark.c                         | 11 +++++++++--
 tools/testing/selftests/vm/gup_benchmark.c | 10 +++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 7dd602d..83f3378 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -6,8 +6,9 @@
 #include <linux/debugfs.h>
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_FAST_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -53,6 +54,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = get_user_pages_fast(addr, nr, gup->flags & 1,
 						 pages + i);
 			break;
+		case GUP_FAST_LONGTERM_BENCHMARK:
+			nr = get_user_pages_fast(addr, nr,
+					(gup->flags & 1) | FOLL_LONGTERM,
+					 pages + i);
+			break;
 		case GUP_LONGTERM_BENCHMARK:
 			nr = get_user_pages(addr, nr,
 					    (gup->flags & 1) | FOLL_LONGTERM,
@@ -96,6 +102,7 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
 
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
+	case GUP_FAST_LONGTERM_BENCHMARK:
 	case GUP_LONGTERM_BENCHMARK:
 	case GUP_BENCHMARK:
 		break;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index c0534e2..ade8acb 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -15,8 +15,9 @@
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_FAST_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
+#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -37,7 +38,7 @@ int main(int argc, char **argv)
 	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUSH")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTlLUSH")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -54,6 +55,9 @@ int main(int argc, char **argv)
 		case 'T':
 			thp = 0;
 			break;
+		case 'l':
+			cmd = GUP_FAST_LONGTERM_BENCHMARK;
+			break;
 		case 'L':
 			cmd = GUP_LONGTERM_BENCHMARK;
 			break;
-- 
2.7.5

