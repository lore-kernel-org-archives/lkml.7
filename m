Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6948BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3414D22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033375;
	bh=2/S1hdU4cTruU/hKmKnpGuGjMHYqBrbHfZvNHrsHGH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nm2RciJoWADv7V4zH+Yv7gUxz3GB70gWL+4Qc/JHwC5S06TIh3jTyWcczEOS2Y0Js
	 dP7VDgl97uO7xBbZcgdFqGWEvo72gGETSOPYbzXEeXZhla5MhvyRa9fjDCUkGt7qJR
	 o7lzZROmyk0/VWfF13XAeLTHBl98qe8F+N8b7R3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbfGYFmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390954AbfGYFmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:42:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662AF21850;
        Thu, 25 Jul 2019 05:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033368;
        bh=2/S1hdU4cTruU/hKmKnpGuGjMHYqBrbHfZvNHrsHGH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEps97Fg4f5FxG2oDx6HUc+98Id6IfbNlxtc8SHmK4XZKGhEhJYrJrgI3k7KKTQJO
         0qA+9q/xnwnzv2z2cx+NDZaAGWE4eVcYaztatG8oOFaQSaSE7flpiwR4RYGHW3F+JN
         cATMvNLjytPDrPVcxUD+3BFIuLPkhHvlf46D+/34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 185/271] bcache: Revert "bcache: free heap cache_set->flush_btree in bch_journal_free"
Date:   Wed, 24 Jul 2019 21:20:54 +0200
Message-Id: <20190724191710.984600453@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
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
@@ -842,7 +842,6 @@ void bch_journal_free(struct cache_set *
 	free_pages((unsigned long) c->journal.w[1].data, JSET_BITS);
 	free_pages((unsigned long) c->journal.w[0].data, JSET_BITS);
 	free_fifo(&c->journal.pin);
-	free_heap(&c->flush_btree);
 }
 
 int bch_journal_alloc(struct cache_set *c)


