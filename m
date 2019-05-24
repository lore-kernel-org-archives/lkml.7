Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FCC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40D92075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bOeWLx4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbfEXILW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:11:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbfEXILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:11:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O88urr118516
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 24 May 2019 01:08:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O88urr118516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558685336;
        bh=/g2qr/niuIcpb3juF6H+paxatAK0nWwxC7eMCGVMUWY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bOeWLx4EGKIfw7OmyYR7jw0m68++5ZHEeCOxptrGm4fsynTfxKpOPA+GXaLt5iGxF
         t5FF21U2gwy2iR9pY0gi+/HBp0zaMWeqYz3OTtyFiJrpdhzIoZ4+rlxkSkkAQ+IXau
         8ALC+iwgXelRPirBY7xYBH1sL6hKxWV+klclt4rKDprKcIaSlBt3cittWKGpkKh/M0
         mdZstIPdenbxtGyhZn7mIGNNRGwiq6hlDtPzePnfzZFDBfvyogZ1DIWmrQj8yqj+sd
         ZtOsYJ6110TgtsZdEuiQZbBbJ5GgCelyjpWq8bPB9lBw2C9Vt5B4FIXZ8+pxIQDrxz
         OYlUe5iZq3O7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O88tuU118513;
        Fri, 24 May 2019 01:08:55 -0700
Date:   Fri, 24 May 2019 01:08:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-3f9fbe9bd86c534eba2faf5d840fd44c6049f50e@git.kernel.org>
Cc:     yabinc@google.com, eranian@google.com, mingo@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        tglx@linutronix.de, vincent.weaver@maine.edu, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, vincent.weaver@maine.edu, eranian@google.com,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, torvalds@linux-foundation.org, acme@redhat.com,
          tglx@linutronix.de, yabinc@google.com
In-Reply-To: <20190517115418.309516009@infradead.org>
References: <20190517115418.309516009@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ring_buffer: Add ordering to rb->nest
 increment
Git-Commit-ID: 3f9fbe9bd86c534eba2faf5d840fd44c6049f50e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3f9fbe9bd86c534eba2faf5d840fd44c6049f50e
Gitweb:     https://git.kernel.org/tip/3f9fbe9bd86c534eba2faf5d840fd44c6049f50e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 17 May 2019 13:52:32 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 09:00:10 +0200

perf/ring_buffer: Add ordering to rb->nest increment

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
---
 kernel/events/ring_buffer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 009467a60578..4b5f8d932400 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -48,6 +48,15 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
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
