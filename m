Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0364DC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81AC21670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054266;
	bh=HwWEg1V8losBJnhzjsLe+Bz2pPRLx7nitKHwcUkeCbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mz9mn7kSBRUUd9/ntwhHtDet2LRLHR14RNZnakS6NOk0SePP+vnxVbF2fgJfF4uD4
	 8EW23ft/NFoD8uA2VRRZzY1hWI+6BqByHvgZrEQ98+G/n+He5xjKSMGSMLsNb7Qa+Y
	 0qAJ5qP/KzEvEnEQPpoT6Ydl5yBdEIG/4Knf8ej8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfFTSLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfFTSK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:10:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73D521537;
        Thu, 20 Jun 2019 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054257;
        bh=HwWEg1V8losBJnhzjsLe+Bz2pPRLx7nitKHwcUkeCbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZySbnw+pgjwKefn94/+9ifT3ceY+ZahgOe+uPKkeZjCs5o8iMe0YVVI/vshQwh1i1
         TJ/mVYHwR3vHWwVadB0zMViIJjYq5ykSj+yJyiXcJn+wqT761vC3Vh03Yn/o1Es3TK
         AwPs5e7Kql8i0C7P02zEBSAXlX48RkoQX/aVGckI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yabin Cui <yabinc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/61] perf/ring_buffer: Add ordering to rb->nest increment
Date:   Thu, 20 Jun 2019 19:57:23 +0200
Message-Id: <20190620174342.214763059@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3f9fbe9bd86c534eba2faf5d840fd44c6049f50e ]

Similar to how decrementing rb->next too early can cause data_head to
(temporarily) be observed to go backward, so too can this happen when
we increment too late.

This barrier() ensures the rb->head load happens after the increment,
both the one in the 'goto again' path, as the one from
perf_output_get_handle() -- albeit very unlikely to matter for the
latter.

Suggested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: mark.rutland@arm.com
Cc: namhyung@kernel.org
Fixes: ef60777c9abd ("perf: Optimize the perf_output() path by removing IRQ-disables")
Link: http://lkml.kernel.org/r/20190517115418.309516009@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 31edf1f39cca..d32b9375ec0e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -49,6 +49,15 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
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
-- 
2.20.1



