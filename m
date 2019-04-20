Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4772FC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA7520869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="Q24btHAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfDTQfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:35:43 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25489 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725920AbfDTQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:35:43 -0400
X-Greylist: delayed 845 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Apr 2019 12:35:42 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1555777235; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=jOTdygbaBc3MNIK+QEDeBIHL51EgYK9ANlqNMKWUa1S7831q+sVySiWH3poGnmcj8TJJOBBNt/XGGtQF2sSmvSnYLvM57MxLgvuPsi0jJchaQ8/U/3vVKktKhHKoS/Msr1vHIZWx8gBmk1oftvBeuF86IntuZxccGChSUY1Rouw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1555777235; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=nKKEQ5f1oa3D1Wd+54DCouDXUJUpRXhHI/GbN5YNV+Y=; 
        b=VCWWwcSQ0MQfvEVE3d/5R+62Tl0GPa28+bEGe9inxxXWloYZKvcKHk1x0YtAnvaTI996uo5d/ae0KxBgAgkdkS+ZNfKYAU5GS3vxEox9Hmg72lywSr6a25wviPxDMFCSookcLVgOC4Mmw1G1afNLhGsfV688jN/cUG1ObNPzFl8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=R6dIYuhJxJ95/saFjkorgrGxdOhMIwIZoEg79xRa/OZCQdLIEkskC5cJtV3p4ciJx6dSWNDftjbs
    qqzVvDTUTG9isE+LfG9gbffgcGECrsZ13cYf+Hvej1xcyMBQE+Hx  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1555777235;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=1105;
        bh=nKKEQ5f1oa3D1Wd+54DCouDXUJUpRXhHI/GbN5YNV+Y=;
        b=Q24btHApiNn552wdGVNZo9UKSnCy/GSxIeszFftyF/BEAeuZe7LPW+P8N2B7WisG
        0bd2QTD7yll2MXiu0u+HQYUsxIos94qJInqzfG+rDmO9Z+MMWYix/XmScLbLk6i/t+3
        vXwIkG9Bw5hRSGsjZcp2HqrPdeCn1DHHndgWtRAw=
Received: from YEHS1XR3054QMS.lenovo.com (123.118.182.142 [123.118.182.142]) by mx.zohomail.com
        with SMTPS id 1555777233734654.2448340674076; Sat, 20 Apr 2019 09:20:33 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm-writecache: remove unused member page_offset in writeback_struct
Date:   Sun, 21 Apr 2019 00:20:17 +0800
Message-Id: <20190420162017.6052-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The structure member page_offset in writeback_struct never has been
used actually. Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
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


