Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38062C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B742147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aXF8VKy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfHFAk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:40:27 -0400
Received: from gateway30.websitewelcome.com ([192.185.160.12]:14498 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728870AbfHFAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:40:27 -0400
X-Greylist: delayed 1320 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 20:40:27 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id A3039AA10
        for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2019 19:18:27 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id unBLhxBhu2qH7unBLhyAGl; Mon, 05 Aug 2019 19:18:27 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qYZMHbpehI1ztCaWNIng3GM0OrNZZVH0chvksCa52IE=; b=aXF8VKy/PnWoChp8posGTJQYQO
        QES4o3BfmhJkZeITsi7saNsCzp3XaFt7J/0JKzp0CehFyDRMsa5UDCk+0wdB7aCxpKgQKUSd2ev0+
        Joq03xhyJIQugTEluvwErX8nYNE1zPFjdaoUN3/T6v9EbTD5WKX0LG55UWox6TR2HunSvHMtfn6d2
        PpLaTycJfUq88lzWf9nyp7FHTsuqTJqc+c+ZiSCmfAdy//lHv1+H2hDFBhl0lFFBlkgsXCbMwIqZr
        d1k29yRz4RzwSgqFgrFqBOtaEJ8z+Lh8Lv8l2ZnbYyrK4dwhzEQICvxXmpXvQ0IL290gVvQeIt9R4
        tVDqLOAA==;
Received: from [187.192.11.120] (port=41292 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hunBK-001CRl-Hp; Mon, 05 Aug 2019 19:18:26 -0500
Date:   Mon, 5 Aug 2019 19:18:25 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] dm raid1: Use struct_size() in kzalloc()
Message-ID: <20190806001825.GA6854@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hunBK-001CRl-Hp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:41292
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct mirror_set {
	...
        struct mirror mirror[0];
};

size = sizeof(struct mirror_set) + count * sizeof(struct mirror);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, mirror, count), GFP_KERNEL)

Notice that, in this case, variable len is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/md/dm-raid1.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 5a51151f680d..f7226ab57fc8 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -878,12 +878,9 @@ static struct mirror_set *alloc_context(unsigned int nr_mirrors,
 					struct dm_target *ti,
 					struct dm_dirty_log *dl)
 {
-	size_t len;
 	struct mirror_set *ms = NULL;
 
-	len = sizeof(*ms) + (sizeof(ms->mirror[0]) * nr_mirrors);
-
-	ms = kzalloc(len, GFP_KERNEL);
+	ms = kzalloc(struct_size(ms, mirror, nr_mirrors), GFP_KERNEL);
 	if (!ms) {
 		ti->error = "Cannot allocate mirror context";
 		return NULL;
-- 
2.22.0

