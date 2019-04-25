Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200EDC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC79320652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="pufhpuS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfDYNcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:32:24 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25537 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfDYNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:32:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556199121; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=cY+qHUXOf2S6vyM/XhThuZi9vGqTZMzxVlPeHaAnTyP6Qr9XzXnj3AmitDQO6cycu/+pS98zkrqr82WX1g7waehvZwDV0LGfIKWi2ZPBeKB5QOQWoMBybajp6mGTIYUDQZdKHXcUt/ReEjMC2iK2WetUWmjJ+iTS3FN/PGyfs/k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1556199121; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=cSRe7l+7NHYLxsspQXMBRG3597YKc7qO0X5rg5y/+RY=; 
        b=G02+5U6c4czPjD1fARKvxOwDezbOvkRcD0OEUJveOjJBb7gahkzbIS9YtNVsTD7J3gIEOyuS1y/lvOVS299Qq2bKN9GH1gtEB+NprvMBa9SWYIkiU6SwxwbIda8iKxD0gXVWSU+nRIQemDfsZtYh7kg8w0aT1/rqv6p8J6H/zJ4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=XFLN65CC7SIISwN3jELEZJCdeQY5Seq9WrORRYsBd1gijWbAYj1Kj+7stK4qCG2SiD1VpdGIJzAz
    ZhtzERePuZwabu/jHpAC3HAayMOsLi7PVVt5f18w4xw6ToCMCvvO  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1556199121;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1691; bh=cSRe7l+7NHYLxsspQXMBRG3597YKc7qO0X5rg5y/+RY=;
        b=pufhpuS+t0AY2/ZxGhlmZwdz4FCEBaMEF+PviIHmS34DFiDFpXDAGcER3jd2HY+2
        NmraWFkrKgLXFErriFa81bUJg+ycST1MOpgRLQrqCymizq25cnbuFKd2cltQhVRUaSc
        75VZTqG3tzmUZwKv8SrVFfxXrRkMSl5ZS69xQUzU=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.108.196 [123.120.108.196]) by mx.zohomail.com
        with SMTPS id 1556199121085320.6293241445237; Thu, 25 Apr 2019 06:32:01 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 1/4] dm writecache: remove needless dereferences in __writecache_writeback_pmem()
Date:   Thu, 25 Apr 2019 21:31:17 +0800
Message-Id: <20190425133120.13088-2-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190425133120.13088-1-yehs2007@zoho.com>
References: <20190425133120.13088-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

bio is already available so there is no need to access it in terms of
the wb pointer.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-writecache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index f782287..5b4d1c1 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1478,9 +1478,9 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 		bio = bio_alloc_bioset(GFP_NOIO, max_pages, &wc->bio_set);
 		wb = container_of(bio, struct writeback_struct, bio);
 		wb->wc = wc;
-		wb->bio.bi_end_io = writecache_writeback_endio;
-		bio_set_dev(&wb->bio, wc->dev->bdev);
-		wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
+		bio->bi_end_io = writecache_writeback_endio;
+		bio_set_dev(bio, wc->dev->bdev);
+		bio->bi_iter.bi_sector = read_original_sector(wc, e);
 		wb->page_offset = PAGE_SIZE;
 		if (max_pages <= WB_LIST_INLINE ||
 		    unlikely(!(wb->wc_list = kmalloc_array(max_pages, sizeof(struct wc_entry *),
@@ -1507,12 +1507,12 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 			wb->wc_list[wb->wc_list_n++] = f;
 			e = f;
 		}
-		bio_set_op_attrs(&wb->bio, REQ_OP_WRITE, WC_MODE_FUA(wc) * REQ_FUA);
+		bio_set_op_attrs(bio, REQ_OP_WRITE, WC_MODE_FUA(wc) * REQ_FUA);
 		if (writecache_has_error(wc)) {
 			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(&wb->bio);
+			bio_endio(bio);
 		} else {
-			submit_bio(&wb->bio);
+			submit_bio(bio);
 		}
 
 		__writeback_throttle(wc, wbl);
-- 
1.8.3.1


