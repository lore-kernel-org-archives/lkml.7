Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA2C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3879F21734
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000235;
	bh=sFckYkiWGAE7EeWjN8SGcOWGU+aX2nOc+kIauULy8C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/2/JfDZvcYYV9SiFNY5NIzx2qmDcdalOglqlfQ9HyyXwoMNtMqmqPjC5FE2UR+AD
	 9qYBWhczbZzp8QF92mq6WCPcRQ1+SgfwE9zvctP4QGXuC4Sqh7YZrf1oJB5IKqL0ed
	 B0YFJuWWJWjxlD9lmwrxrdfbDh/Y9iKw5FFv3pXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbfGXTbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388518AbfGXTbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:31:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4298E229F4;
        Wed, 24 Jul 2019 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996702;
        bh=sFckYkiWGAE7EeWjN8SGcOWGU+aX2nOc+kIauULy8C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHEmiHE8WeIrpdVvmrJLuO1lcoKy6mqM14JeRq+PWB9ozMdmGAcZTIxqMfFY6Angw
         JuuLhTnlsz7EAk4Jn0b4/9QNLipBBE6rL0Nimnqg7KoHQLJNI5mL33/xifqu5MQ/Ti
         IE0kiZcMmm7NUpbvwaxMnZr4eS1M+3hVZ9eLGP1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 187/413] bcache: check CACHE_SET_IO_DISABLE in allocator code
Date:   Wed, 24 Jul 2019 21:17:58 +0200
Message-Id: <20190724191748.098005704@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e775339e1ae1205b47d94881db124c11385e597c ]

If CACHE_SET_IO_DISABLE of a cache set flag is set by too many I/O
errors, currently allocator routines can still continue allocate
space which may introduce inconsistent metadata state.

This patch checkes CACHE_SET_IO_DISABLE bit in following allocator
routines,
- bch_bucket_alloc()
- __bch_bucket_alloc_set()
Once CACHE_SET_IO_DISABLE is set on cache set, the allocator routines
may reject allocation request earlier to avoid potential inconsistent
metadata.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/alloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index f8986effcb50..6f776823b9ba 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -393,6 +393,11 @@ long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait)
 	struct bucket *b;
 	long r;
 
+
+	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
+	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &ca->set->flags)))
+		return -1;
+
 	/* fastpath */
 	if (fifo_pop(&ca->free[RESERVE_NONE], r) ||
 	    fifo_pop(&ca->free[reserve], r))
@@ -484,6 +489,10 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 {
 	int i;
 
+	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
+	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags)))
+		return -1;
+
 	lockdep_assert_held(&c->bucket_lock);
 	BUG_ON(!n || n > c->caches_loaded || n > MAX_CACHES_PER_SET);
 
-- 
2.20.1



