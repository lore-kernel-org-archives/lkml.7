Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77800C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CA22C7D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033611;
	bh=2FTCZ8GaL62WVSaOP6GV+yF95ekypWreRV9cXFynotM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibXOp7ZlSjJJoVemsuQ2KUfZoez8XD5ZKqd42fKoSlHWLLurcnwiDiayFKUyCsr0V
	 20XcFj3tcoxDUEMwNu0Iw6rjIMxU2BDxu3WUzeaUbAS9RIJ6pWw4ZVbz8JJtK/f35B
	 pbbZuuuOYCXcPaS4z+EB+hmdKgsT0CohUaoJ3S5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391476AbfGYFqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbfGYFqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:46:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD9E22BEB;
        Thu, 25 Jul 2019 05:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033604;
        bh=2FTCZ8GaL62WVSaOP6GV+yF95ekypWreRV9cXFynotM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHpKHA3nn2dnj7MEMGcew1cMke3VH3KeYES6CR+715SW3FGSzx5at/q9dOxCl++1q
         VT5rUQFv5NoZvLo16mrBw4JR10mLgHACSs7+EMmVjkD4yZdlrqw7+414JlNKd0zOWU
         obo6EKDd1fQhOOEslwYRuaU98vX/Jj/VBH/x/j7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 266/271] blk-throttle: fix zero wait time for iops throttled group
Date:   Wed, 24 Jul 2019 21:22:15 +0200
Message-Id: <20190724191718.027335460@linuxfoundation.org>
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

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit 3a10f999ffd464d01c5a05592a15470a3c4bbc36 upstream.

After commit 991f61fe7e1d ("Blk-throttle: reduce tail io latency when
iops limit is enforced") wait time could be zero even if group is
throttled and cannot issue requests right now. As a result
throtl_select_dispatch() turns into busy-loop under irq-safe queue
spinlock.

Fix is simple: always round up target time to the next throttle slice.

Fixes: 991f61fe7e1d ("Blk-throttle: reduce tail io latency when iops limit is enforced")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-throttle.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -892,13 +892,10 @@ static bool tg_with_in_iops_limit(struct
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	u64 tmp;
 
-	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
+	jiffy_elapsed = jiffies - tg->slice_start[rw];
 
-	/* Slice has just started. Consider one slice interval */
-	if (!jiffy_elapsed)
-		jiffy_elapsed_rnd = tg->td->throtl_slice;
-
-	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
+	/* Round up to the next throttle slice, wait time must be nonzero */
+	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
 
 	/*
 	 * jiffy_elapsed_rnd should not be a big value as minimum iops can be


