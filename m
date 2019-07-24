Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62798204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000018;
	bh=gQ0sO9cXgN/kznbncuXVuL2Tn5qrJBMk4NT5njuP8Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AAg7sMtgSQpg3sJa/idLz9HIKA7SnTu7CC6oiZhJA3YOQZChEoLQ+M9JrRG6zJRM9
	 Z2y+OM20DuY1nkcJI4OVRGDXzp6hYABoJ/UOlGMgFIM9y2sTPIgOfqIZn5i38SPKQn
	 876WMsYSVenABV6IzNZIjsZyMZf0v267E53GX4vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390234AbfGXU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfGXTgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:36:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9813214AF;
        Wed, 24 Jul 2019 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996992;
        bh=gQ0sO9cXgN/kznbncuXVuL2Tn5qrJBMk4NT5njuP8Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAZbwRxE5GSD35uJulipPZ85je8OoZp1RnpRBYbImuFHTH3wisHTO1rGyYPsVrEt+
         pnmRdSnQI8GGxucWJWTD+X4RUq6oZBrVtpw2uP+iuzpK1tHIBTASU8/zZloEYO5meL
         9b0tzVGiusgKU+zNR2KJ5MtMGIfvpu+YTuRIyIyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.2 285/413] bcache: destroy dc->writeback_write_wq if failed to create dc->writeback_thread
Date:   Wed, 24 Jul 2019 21:19:36 +0200
Message-Id: <20190724191756.658501267@linuxfoundation.org>
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

commit f54d801dda14942dbefa00541d10603015b7859c upstream.

Commit 9baf30972b55 ("bcache: fix for gc and write-back race") added a
new work queue dc->writeback_write_wq, but forgot to destroy it in the
error condition when creating dc->writeback_thread failed.

This patch destroys dc->writeback_write_wq if kthread_create() returns
error pointer to dc->writeback_thread, then a memory leak is avoided.

Fixes: 9baf30972b55 ("bcache: fix for gc and write-back race")
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/writeback.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -834,6 +834,7 @@ int bch_cached_dev_writeback_start(struc
 					      "bcache_writeback");
 	if (IS_ERR(dc->writeback_thread)) {
 		cached_dev_put(dc);
+		destroy_workqueue(dc->writeback_write_wq);
 		return PTR_ERR(dc->writeback_thread);
 	}
 	dc->writeback_running = true;


