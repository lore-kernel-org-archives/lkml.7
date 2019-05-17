Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD37C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8398C20881
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 11:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeKhsA+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfEQLzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 07:55:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfEQLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 07:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rXkFWG2sZI0JZiUykYtZ5IQLTfGZmecX+wilKQtUfZw=; b=OeKhsA+kl9Zt8wO9XRdne3gA5z
        WzKPE/RVonKwesFIN62EoU2OgqVfhBajemChWRIXXW3HixRtxG7GplsPVvaaOZyJW77NA7S4k3pxC
        9yL9nRggfTX1DkTDawLe6r8XN1tc3HAVK5rMyGDjkqLIUmmAevfCUdgCDALOTzVrx3qAB4MT6l4mc
        LsYM51IV5Nsun3Ta43T4kQ1dVkY/0jlI8MeZQh6TiDfNEBCpTOP53olJmMbrzmA7Xj1miGwuYfkFp
        9hPUh/t3Mro5qWZeknulaO/xRK40Nx9F18bLVHPYcF+7MwED0BSagtBuOgXeFu3PwlYZPo59rswgk
        uDZJuoAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hRbRy-00022U-Vm; Fri, 17 May 2019 11:54:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B53B32027F766; Fri, 17 May 2019 13:54:56 +0200 (CEST)
Message-Id: <20190517115418.309516009@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 17 May 2019 13:52:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     yabinc@google.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf/ring_buffer: Add ordering to rb->nest increment
References: <20190517115230.437269790@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how decrementing rb->next too early can cause data_head to
(temporarily) be observed to go backward, so too can this happen when
we increment too late.

This barrier() ensures the rb->head load happens after the increment,
both the one in the 'goto again' path, as the one from
perf_output_get_handle() -- albeit very unlikely to matter for the
latter.

Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
Suggested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/ring_buffer.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -48,6 +48,15 @@ static void perf_output_put_handle(struc
 	unsigned long head;
 
 again:
+	/*
+	 * In order to avoid publishing a head value that goes backwards,
+	 * we must ensure the load of @rb->head happens after we've
+	 * incremented @rb->nest.
+	 *
+	 * Otherwise we can observe a @rb->head value before one published
+	 * by an IRQ/NMI happening between the load and the increment.
+	 */
+	barrier();
 	head = local_read(&rb->head);
 
 	/*


