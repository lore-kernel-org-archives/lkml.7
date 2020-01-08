Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B30C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D9A206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgAHKvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:51:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbgAHKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:51:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008AlHDI055314
        for <linux-kernel@vger.kernel.org>; Wed, 8 Jan 2020 05:51:10 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb92p8nc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 05:51:09 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Wed, 8 Jan 2020 10:51:07 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Jan 2020 10:51:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 008Ap3qv12714138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jan 2020 10:51:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D43364204D;
        Wed,  8 Jan 2020 10:51:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD0D42049;
        Wed,  8 Jan 2020 10:51:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jan 2020 10:51:03 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] btrfs: Use larger zlib buffer for s390 hardware compression
Date:   Wed,  8 Jan 2020 11:51:03 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107143058.GU3929@twin.jikos.cz>
References: <20200107143058.GU3929@twin.jikos.cz>
X-TM-AS-GCONF: 00
x-cbid: 20010810-0008-0000-0000-000003478DA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010810-0009-0000-0000-00004A67D14D
Message-Id: <20200108105103.29028-1-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_03:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to benefit from s390 zlib hardware compression support,
increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
s390 zlib hardware support is enabled on the machine). This brings up
to 60% better performance in hardware on s390 compared to the PAGE_SIZE
buffer and much more compared to the software zlib processing in btrfs.
In case of memory pressure, fall back to a single page buffer during
workspace allocation.
The data compressed with larger input buffers will still conform to zlib
standard and thus can be decompressed also on a systems that uses only
PAGE_SIZE buffer for btrfs zlib.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/zlib.c        | 135 ++++++++++++++++++++++++++++++-----------
 2 files changed, 101 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index ee834ef7beb4..6bd0e75a822c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1285,7 +1285,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 	/* copy bytes from the working buffer into the pages */
 	while (working_bytes > 0) {
 		bytes = min_t(unsigned long, bvec.bv_len,
-				PAGE_SIZE - buf_offset);
+				PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, working_bytes);
 
 		kaddr = kmap_atomic(bvec.bv_page);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index a6c90a003c12..05615a1099db 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -20,9 +20,13 @@
 #include <linux/refcount.h>
 #include "compression.h"
 
+/* workspace buffer size for s390 zlib hardware support */
+#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
+
 struct workspace {
 	z_stream strm;
 	char *buf;
+	unsigned int buf_size;
 	struct list_head list;
 	int level;
 };
@@ -61,7 +65,21 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
 			zlib_inflate_workspacesize());
 	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
 	workspace->level = level;
-	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	workspace->buf = NULL;
+	/*
+	 * In case of s390 zlib hardware support, allocate lager workspace
+	 * buffer. If allocator fails, fall back to a single page buffer.
+	 */
+	if (zlib_deflate_dfltcc_enabled()) {
+		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
+					 __GFP_NOMEMALLOC | __GFP_NORETRY |
+					 __GFP_NOWARN | GFP_NOIO);
+		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
+	}
+	if (!workspace->buf) {
+		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		workspace->buf_size = PAGE_SIZE;
+	}
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
 
@@ -85,6 +103,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
 	unsigned long bytes_left;
+	unsigned int in_buf_pages;
 	unsigned long len = *total_out;
 	unsigned long nr_dest_pages = *out_pages;
 	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
@@ -102,9 +121,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	data_in = kmap(in_page);
-
 	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
@@ -114,12 +130,51 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	pages[0] = out_page;
 	nr_pages = 1;
 
-	workspace->strm.next_in = data_in;
+	workspace->strm.next_in = workspace->buf;
+	workspace->strm.avail_in = 0;
 	workspace->strm.next_out = cpage_out;
 	workspace->strm.avail_out = PAGE_SIZE;
-	workspace->strm.avail_in = min(len, PAGE_SIZE);
 
 	while (workspace->strm.total_in < len) {
+		/*
+		 * Get next input pages and copy the contents to
+		 * the workspace buffer if required.
+		 */
+		if (workspace->strm.avail_in == 0) {
+			bytes_left = len - workspace->strm.total_in;
+			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
+					   workspace->buf_size / PAGE_SIZE);
+			if (in_buf_pages > 1) {
+				int i;
+
+				for (i = 0; i < in_buf_pages; i++) {
+					if (in_page) {
+						kunmap(in_page);
+						put_page(in_page);
+					}
+					in_page = find_get_page(mapping,
+								start >> PAGE_SHIFT);
+					data_in = kmap(in_page);
+					memcpy(workspace->buf + i * PAGE_SIZE,
+					       data_in, PAGE_SIZE);
+					start += PAGE_SIZE;
+				}
+				workspace->strm.next_in = workspace->buf;
+			} else {
+				if (in_page) {
+					kunmap(in_page);
+					put_page(in_page);
+				}
+				in_page = find_get_page(mapping,
+							start >> PAGE_SHIFT);
+				data_in = kmap(in_page);
+				start += PAGE_SIZE;
+				workspace->strm.next_in = data_in;
+			}
+			workspace->strm.avail_in = min(bytes_left,
+						       (unsigned long) workspace->buf_size);
+		}
+
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (ret != Z_OK) {
 			pr_debug("BTRFS: deflate in loop returned %d\n",
@@ -161,33 +216,43 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
 			break;
-
-		/* we've read in a full page, get a new one */
-		if (workspace->strm.avail_in == 0) {
-			if (workspace->strm.total_out > max_out)
-				break;
-
-			bytes_left = len - workspace->strm.total_in;
-			kunmap(in_page);
-			put_page(in_page);
-
-			start += PAGE_SIZE;
-			in_page = find_get_page(mapping,
-						start >> PAGE_SHIFT);
-			data_in = kmap(in_page);
-			workspace->strm.avail_in = min(bytes_left,
-							   PAGE_SIZE);
-			workspace->strm.next_in = data_in;
-		}
+		if (workspace->strm.total_out > max_out)
+			break;
 	}
 	workspace->strm.avail_in = 0;
-	ret = zlib_deflate(&workspace->strm, Z_FINISH);
-	zlib_deflateEnd(&workspace->strm);
-
-	if (ret != Z_STREAM_END) {
-		ret = -EIO;
-		goto out;
+	/*
+	 * Call deflate with Z_FINISH flush parameter providing more output
+	 * space but no more input data, until it returns with Z_STREAM_END.
+	 */
+	while (ret != Z_STREAM_END) {
+		ret = zlib_deflate(&workspace->strm, Z_FINISH);
+		if (ret == Z_STREAM_END)
+			break;
+		if (ret != Z_OK && ret != Z_BUF_ERROR) {
+			zlib_deflateEnd(&workspace->strm);
+			ret = -EIO;
+			goto out;
+		} else if (workspace->strm.avail_out == 0) {
+			/* get another page for the stream end */
+			kunmap(out_page);
+			if (nr_pages == nr_dest_pages) {
+				out_page = NULL;
+				ret = -E2BIG;
+				goto out;
+			}
+			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			if (out_page == NULL) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			cpage_out = kmap(out_page);
+			pages[nr_pages] = out_page;
+			nr_pages++;
+			workspace->strm.avail_out = PAGE_SIZE;
+			workspace->strm.next_out = cpage_out;
+		}
 	}
+	zlib_deflateEnd(&workspace->strm);
 
 	if (workspace->strm.total_out >= workspace->strm.total_in) {
 		ret = -E2BIG;
@@ -231,7 +296,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	workspace->strm.total_out = 0;
 	workspace->strm.next_out = workspace->buf;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = workspace->buf_size;
 
 	/* If it's deflate, and it's got no preset dictionary, then
 	   we can tell zlib to skip the adler32 check. */
@@ -270,7 +335,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 
 		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = PAGE_SIZE;
+		workspace->strm.avail_out = workspace->buf_size;
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
@@ -320,7 +385,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 	workspace->strm.total_in = 0;
 
 	workspace->strm.next_out = workspace->buf;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = workspace->buf_size;
 	workspace->strm.total_out = 0;
 	/* If it's deflate, and it's got no preset dictionary, then
 	   we can tell zlib to skip the adler32 check. */
@@ -364,7 +429,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 			buf_offset = 0;
 
 		bytes = min(PAGE_SIZE - pg_offset,
-			    PAGE_SIZE - buf_offset);
+			    PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, bytes_left);
 
 		kaddr = kmap_atomic(dest_page);
@@ -375,7 +440,7 @@ int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 		bytes_left -= bytes;
 next:
 		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = PAGE_SIZE;
+		workspace->strm.avail_out = workspace->buf_size;
 	}
 
 	if (ret != Z_STREAM_END && bytes_left != 0)
-- 
2.17.1

