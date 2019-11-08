Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D756C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDBE2067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfKHAOc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:14:32 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:42683 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHAOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:14:32 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xA80E98b032382
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Nov 2019 09:14:09 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80E95o006960;
        Fri, 8 Nov 2019 09:14:09 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80BoBi012271;
        Fri, 8 Nov 2019 09:14:09 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-10172970; Fri, 8 Nov 2019 09:08:09 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0439.000; Fri, 8
 Nov 2019 09:08:08 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH 1/3] procfs: refactor kpage_*_read() in fs/proc/page.c
Thread-Topic: [PATCH 1/3] procfs: refactor kpage_*_read() in fs/proc/page.c
Thread-Index: AQHVlciYTszf+OoxZUWdkxf4BbqNCg==
Date:   Fri, 8 Nov 2019 00:08:07 +0000
Message-ID: <20191108000855.25209-2-t-fukasawa@vx.jp.nec.com>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
In-Reply-To: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kpagecount_read(), kpageflags_read(), and kpagecgroup_read()
have duplicate code. This patch moves it into a common function.

Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
---
 fs/proc/page.c | 133 +++++++++++++++++++++------------------------------------
 1 file changed, 48 insertions(+), 85 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 7c952ee..a49b638 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -21,20 +21,19 @@
 #define KPMMASK (KPMSIZE - 1)
 #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
 
-/* /proc/kpagecount - an array exposing page counts
- *
- * Each entry is a u64 representing the corresponding
- * physical page count.
+typedef u64 (*read_page_data_fn_t)(struct page *page);
+
+/*
+ * This is general function to read various data on pages.
  */
-static ssize_t kpagecount_read(struct file *file, char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t kpage_common_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos, read_page_data_fn_t read_fn)
 {
 	u64 __user *out = (u64 __user *)buf;
 	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
 	ssize_t ret = 0;
-	u64 pcount;
 
 	pfn = src / KPMSIZE;
 	count = min_t(size_t, count, (max_pfn * KPMSIZE) - src);
@@ -48,12 +47,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 		 */
 		ppage = pfn_to_online_page(pfn);
 
-		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
-			pcount = 0;
-		else
-			pcount = page_mapcount(ppage);
-
-		if (put_user(pcount, out)) {
+		if (put_user(read_fn(ppage), out)) {
 			ret = -EFAULT;
 			break;
 		}
@@ -71,6 +65,30 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+/* /proc/kpagecount - an array exposing page counts
+ *
+ * Each entry is a u64 representing the corresponding
+ * physical page count.
+ */
+
+static u64 page_count_data(struct page *page)
+{
+	u64 pcount;
+
+	if (!page || PageSlab(page) || page_has_type(page))
+		pcount = 0;
+	else
+		pcount = page_mapcount(page);
+
+	return pcount;
+}
+
+static ssize_t kpagecount_read(struct file *file, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	return kpage_common_read(file, buf, count, ppos, page_count_data);
+}
+
 static const struct file_operations proc_kpagecount_operations = {
 	.llseek = mem_lseek,
 	.read = kpagecount_read,
@@ -203,43 +221,15 @@ u64 stable_page_flags(struct page *page)
 	return u;
 };
 
+static u64 page_flags_data(struct page *page)
+{
+	return stable_page_flags(page);
+}
+
 static ssize_t kpageflags_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	u64 __user *out = (u64 __user *)buf;
-	struct page *ppage;
-	unsigned long src = *ppos;
-	unsigned long pfn;
-	ssize_t ret = 0;
-
-	pfn = src / KPMSIZE;
-	count = min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
-	if (src & KPMMASK || count & KPMMASK)
-		return -EINVAL;
-
-	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
-		ppage = pfn_to_online_page(pfn);
-
-		if (put_user(stable_page_flags(ppage), out)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		pfn++;
-		out++;
-		count -= KPMSIZE;
-
-		cond_resched();
-	}
-
-	*ppos += (char __user *)out - buf;
-	if (!ret)
-		ret = (char __user *)out - buf;
-	return ret;
+	return kpage_common_read(file, buf, count, ppos, page_flags_data);
 }
 
 static const struct file_operations proc_kpageflags_operations = {
@@ -248,49 +238,22 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
 };
 
 #ifdef CONFIG_MEMCG
-static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static u64 page_cgroup_data(struct page *page)
 {
-	u64 __user *out = (u64 __user *)buf;
-	struct page *ppage;
-	unsigned long src = *ppos;
-	unsigned long pfn;
-	ssize_t ret = 0;
 	u64 ino;
 
-	pfn = src / KPMSIZE;
-	count = min_t(unsigned long, count, (max_pfn * KPMSIZE) - src);
-	if (src & KPMMASK || count & KPMMASK)
-		return -EINVAL;
-
-	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
-		ppage = pfn_to_online_page(pfn);
-
-		if (ppage)
-			ino = page_cgroup_ino(ppage);
-		else
-			ino = 0;
-
-		if (put_user(ino, out)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		pfn++;
-		out++;
-		count -= KPMSIZE;
+	if (page)
+		ino = page_cgroup_ino(page);
+	else
+		ino = 0;
 
-		cond_resched();
-	}
+	return ino;
+}
 
-	*ppos += (char __user *)out - buf;
-	if (!ret)
-		ret = (char __user *)out - buf;
-	return ret;
+static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	return kpage_common_read(file, buf, count, ppos, page_cgroup_data);
 }
 
 static const struct file_operations proc_kpagecgroup_operations = {
-- 
1.8.3.1

