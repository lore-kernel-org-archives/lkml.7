Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB022C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7893B22ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996989;
	bh=bS0+cZVBNXT5EHX0ujiCyDSgPNBBhbRO0aYOZsxFEcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LlRhOOEZDV2hiDznLSa0Y3+RaH7BF/rxJQlkOwL/w0gwh/Jhm24XAlzcDgOX1/oUa
	 mcTAi9ASu53UeaGHAoLGk2DQBvkb19XC/dlMJjlDitSbedBMfwZTmPpW8F6j+3uXOI
	 mWyTkP3sIm8tcIeVUxbk0Y4UwWkDa1xnTeBZWax0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfGXTg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbfGXTgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:36:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086CF20449;
        Wed, 24 Jul 2019 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996982;
        bh=bS0+cZVBNXT5EHX0ujiCyDSgPNBBhbRO0aYOZsxFEcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RS4xcazwpiQtsh5z3XSVYRc4o0HANoionLRhT2FpKYWmG46iS+WE2JdIpQxEfNLXJ
         daIWs1a1+vI+k6mq8rvHvQwMzQQKzomvCzxiiI2IkP47v3Pmjlr++ihb1ihwEGZsj4
         2wr2IDwNaA0mbFCwj6J+XCxM7NJKOO2HebzKecTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.2 282/413] bcache: Revert "bcache: free heap cache_set->flush_btree in bch_journal_free"
Date:   Wed, 24 Jul 2019 21:19:33 +0200
Message-Id: <20190724191756.459354778@linuxfoundation.org>
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

From: Coly Li <colyli@suse.de>

commit ba82c1ac1667d6efb91a268edb13fc9cdaecec9b upstream.

This reverts commit 6268dc2c4703aabfb0b35681be709acf4c2826c6.

This patch depends on commit c4dc2497d50d ("bcache: fix high CPU
occupancy during journal") which is reverted in previous patch. So
revert this one too.

Fixes: 6268dc2c4703 ("bcache: free heap cache_set->flush_btree in bch_journal_free")
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
Cc: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/journal.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -843,7 +843,6 @@ void bch_journal_free(struct cache_set *
 	free_pages((unsigned long) c->journal.w[1].data, JSET_BITS);
 	free_pages((unsigned long) c->journal.w[0].data, JSET_BITS);
 	free_fifo(&c->journal.pin);
-	free_heap(&c->flush_btree);
 }
 
 int bch_journal_alloc(struct cache_set *c)


