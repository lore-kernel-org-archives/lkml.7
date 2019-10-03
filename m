Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE220862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124043;
	bh=i2eh7RCgOf8VMp1y2DrKW4hUkdVLQC+cbbYV1EkpAKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jR46v5r4jCWTr9l0kRmwnskEWxIKpMJwMGuZKJ5KPZItcHUa8DDRj3fxUhX/SMcxk
	 Q9xIGizlSJyoDgJ0vjdalRnStVP7nvQX/txYkx283Vg98FCBGtk6vXFcOi4lLQ+0Qh
	 T5fiPs2XFGv51kwdXopSMy9pG6YkdK9p4/K2SzYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfJCReB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732907AbfJCQHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:07:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D5721783;
        Thu,  3 Oct 2019 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118833;
        bh=i2eh7RCgOf8VMp1y2DrKW4hUkdVLQC+cbbYV1EkpAKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gn5RzD3TstdAsUwZz48vrHE9OazRkrnBFvd9a23kRkHLuU3JFTFRe8OWj4hl38noc
         Q+VzGXFC0jmPcpSGMyHraDD+49u/NRfCh1dKR239FscvDjgpi+OUlnKEpVntW/OTXL
         /TanHau1P51rPbzzpELroBJMG6JpNv+lpdtnvWFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 026/185] dm zoned: fix invalid memory access
Date:   Thu,  3 Oct 2019 17:51:44 +0200
Message-Id: <20191003154443.487401217@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 0c8e9c2d668278652af028c3cc068c65f66342f4 ]

Commit 75d66ffb48efb30f2dd42f041ba8b39c5b2bd115 ("dm zoned: properly
handle backing device failure") triggers a coverity warning:

*** CID 1452808:  Memory - illegal accesses  (USE_AFTER_FREE)
/drivers/md/dm-zoned-target.c: 137 in dmz_submit_bio()
131             clone->bi_private = bioctx;
132
133             bio_advance(bio, clone->bi_iter.bi_size);
134
135             refcount_inc(&bioctx->ref);
136             generic_make_request(clone);
>>>     CID 1452808:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>     Dereferencing freed pointer "clone".
137             if (clone->bi_status == BLK_STS_IOERR)
138                     return -EIO;
139
140             if (bio_op(bio) == REQ_OP_WRITE && dmz_is_seq(zone))
141                     zone->wp_block += nr_blocks;
142

The "clone" bio may be processed and freed before the check
"clone->bi_status == BLK_STS_IOERR" - so this check can access invalid
memory.

Fixes: 75d66ffb48efb3 ("dm zoned: properly handle backing device failure")
Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-zoned-target.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 1e004d975e786..4694763f9d404 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -133,8 +133,6 @@ static int dmz_submit_bio(struct dmz_target *dmz, struct dm_zone *zone,
 
 	atomic_inc(&bioctx->ref);
 	generic_make_request(clone);
-	if (clone->bi_status == BLK_STS_IOERR)
-		return -EIO;
 
 	if (bio_op(bio) == REQ_OP_WRITE && dmz_is_seq(zone))
 		zone->wp_block += nr_blocks;
-- 
2.20.1



