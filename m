Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E022C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF04206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="GRu2KSI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfDYNct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:32:49 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25553 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDYNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556199131; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=At2x4vebEAgK7hoNKunQr56UAxaT7/A/Cyga60KogNJLKh93kilW0EBN7078DKhz7g+cp4Olo019Jss+3d8ljtGGfkMXQt2RajrhfACGAx5bE4qmiGvDCarCeDryAE8Qo31TBnYUuR/v91i5t+evyjF54KK3saDVNRou/hG7M4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1556199131; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=wODFec/thj0T68IsEhuxexZ2+WdDj5zjbEhGJrl69D0=; 
        b=P1oRYPI1yN1BQvV1gbxB7YufIB2RryoKAGmTEsM1+10DcZmzDE7gJMtR8MJ6EihfV7leugbL17AY/SEuhGEJmB5/w9DNH7VULCtKoZhlvVvJMaHAYPo8WEci+PY69BybynpI1rqiBCaTHm8QcAmhwlh2KstIk8ILLatAQ+Sg/Qo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=SF2vsqsBxj9Sf4N2lBkTu5M9zp8aQ1WxfgSk9S3mug+pZldPSYhvLe7rLFWY7eMkcK2TBdR/5Xqk
    y7DqU9SoFsnDepMSZaQzD5jAQjjn3A+EfhJzj6mebeGCrN7gNegW  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1556199131;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1153; bh=wODFec/thj0T68IsEhuxexZ2+WdDj5zjbEhGJrl69D0=;
        b=GRu2KSI6H0NMwrnVkgI4tT8VnQy66J6oe4pH/YUYlY84WxwcAAmYspGpTWFEd7sC
        BlXvXskIA4m0jvsf3tR3UBq+KbiKUJGpPjEo66Zbn0pivSNfbEx9tceZfXNBJn41+3o
        ETmJpZRcKB9OVcXuRBkDrtA36sjHknPDgm/JswDs=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.108.196 [123.120.108.196]) by mx.zohomail.com
        with SMTPS id 1556199130070500.40209280949193; Thu, 25 Apr 2019 06:32:10 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 3/4] dm writecache: remove unused member page_offset in writeback_struct
Date:   Thu, 25 Apr 2019 21:31:19 +0800
Message-Id: <20190425133120.13088-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190425133120.13088-1-yehs2007@zoho.com>
References: <20190425133120.13088-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The stucture member page_offset in writeback_struct never has been
used actually. Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-writecache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index cfbbfbc..ddf1732 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -190,7 +190,6 @@ struct writeback_struct {
 	struct dm_writecache *wc;
 	struct wc_entry **wc_list;
 	unsigned wc_list_n;
-	unsigned page_offset;
 	struct page *page;
 	struct wc_entry *wc_list_inline[WB_LIST_INLINE];
 	struct bio bio;
@@ -1481,7 +1480,6 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 		bio->bi_end_io = writecache_writeback_endio;
 		bio_set_dev(bio, wc->dev->bdev);
 		bio->bi_iter.bi_sector = read_original_sector(wc, e);
-		wb->page_offset = PAGE_SIZE;
 		if (max_pages <= WB_LIST_INLINE ||
 		    unlikely(!(wb->wc_list = kmalloc_array(max_pages, sizeof(struct wc_entry *),
 							   GFP_NOIO | __GFP_NORETRY |
-- 
1.8.3.1


