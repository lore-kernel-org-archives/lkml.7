Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09606C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07EF20692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QTsB8S+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfKSGSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:18:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42318 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfKSGSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:18:41 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ69Ewo139154;
        Tue, 19 Nov 2019 06:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Q8GsBGAZzvdz1chlCabBam/puKDb9LftgXJiL6t52J8=;
 b=QTsB8S+nbyz0m+0XgGYTxorwvs6MtnjMB13fZjy59K7bJy7b7QkEKGuUSBuba2soZtwI
 OWM1SPz2bKge4oZCMIoIgdcYaeaq0prTKDeGCNuqNqkkYH+RuN6Nc7i1rw4PjEFLqQpy
 8WGqNKSbnyALpuNbpUmUq+PhlnntgDS6JssIddswtJkNiRCLmnSa5wmbwmay1k/kjUeR
 xrDY7Pe1Jbs6uLYMIN776uny70X9sXF6sgeSmRLWbGOchEBah9h1fqD8+EZ8fNrMqLs3
 gALVOx0VLtFrmb9UPCljr6B+yuvF/YvDPOKENvHQRWBCqPh+xh4+FVe3FZt65roQoUbq DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqcp7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:18:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ68uhp105749;
        Tue, 19 Nov 2019 06:18:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wbxm3qwxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 06:18:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ6ISqr005177;
        Tue, 19 Nov 2019 06:18:29 GMT
Received: from kili.mountain (/41.210.141.188)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 22:18:27 -0800
Date:   Tue, 19 Nov 2019 09:18:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] dma-debug: clean up put_hash_bucket()
Message-ID: <20191119061819.k6754frfv2wj7swd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=856
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The put_hash_bucket() is a bit cleaner if it takes an unsigned long
directly instead of a pointer to unsigned long.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This patch also makes it slightly easier for Smatch to parse the locking.

 kernel/dma/debug.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index cd6f89aa9f9a..2031ed1ad7fa 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -255,12 +255,10 @@ static struct hash_bucket *get_hash_bucket(struct dma_debug_entry *entry,
  * Give up exclusive access to the hash bucket
  */
 static void put_hash_bucket(struct hash_bucket *bucket,
-			    unsigned long *flags)
+			    unsigned long flags)
 	__releases(&bucket->lock)
 {
-	unsigned long __flags = *flags;
-
-	spin_unlock_irqrestore(&bucket->lock, __flags);
+	spin_unlock_irqrestore(&bucket->lock, flags);
 }
 
 static bool exact_match(struct dma_debug_entry *a, struct dma_debug_entry *b)
@@ -359,7 +357,7 @@ static struct dma_debug_entry *bucket_find_contain(struct hash_bucket **bucket,
 		/*
 		 * Nothing found, go back a hash bucket
 		 */
-		put_hash_bucket(*bucket, flags);
+		put_hash_bucket(*bucket, *flags);
 		range          += (1 << HASH_FN_SHIFT);
 		index.dev_addr -= (1 << HASH_FN_SHIFT);
 		*bucket = get_hash_bucket(&index, flags);
@@ -609,7 +607,7 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 
 	bucket = get_hash_bucket(entry, &flags);
 	hash_bucket_add(bucket, entry);
-	put_hash_bucket(bucket, &flags);
+	put_hash_bucket(bucket, flags);
 
 	rc = active_cacheline_insert(entry);
 	if (rc == -ENOMEM) {
@@ -1002,7 +1000,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 
 	if (!entry) {
 		/* must drop lock before calling dma_mapping_error */
-		put_hash_bucket(bucket, &flags);
+		put_hash_bucket(bucket, flags);
 
 		if (dma_mapping_error(ref->dev, ref->dev_addr)) {
 			err_printk(ref->dev, NULL,
@@ -1084,7 +1082,7 @@ static void check_unmap(struct dma_debug_entry *ref)
 	hash_bucket_del(entry);
 	dma_entry_free(entry);
 
-	put_hash_bucket(bucket, &flags);
+	put_hash_bucket(bucket, flags);
 }
 
 static void check_for_stack(struct device *dev,
@@ -1204,7 +1202,7 @@ static void check_sync(struct device *dev,
 	}
 
 out:
-	put_hash_bucket(bucket, &flags);
+	put_hash_bucket(bucket, flags);
 }
 
 static void check_sg_segment(struct device *dev, struct scatterlist *sg)
@@ -1319,7 +1317,7 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 		}
 	}
 
-	put_hash_bucket(bucket, &flags);
+	put_hash_bucket(bucket, flags);
 }
 EXPORT_SYMBOL(debug_dma_mapping_error);
 
@@ -1392,7 +1390,7 @@ static int get_nr_mapped_entries(struct device *dev,
 
 	if (entry)
 		mapped_ents = entry->sg_mapped_ents;
-	put_hash_bucket(bucket, &flags);
+	put_hash_bucket(bucket, flags);
 
 	return mapped_ents;
 }
-- 
2.11.0

