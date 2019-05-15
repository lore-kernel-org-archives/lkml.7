Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D7C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612520862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/iBtmpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEOAcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:32:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46696 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEOAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:32:08 -0400
Received: by mail-pf1-f202.google.com with SMTP id d9so456356pfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RTskpJzrqjSfKamQuryjYgpBB8UNg8rBhhyvKDtP8Jc=;
        b=v/iBtmppsGFx8fleVlGl5FyzcENGHfuP9fHcZoab0NyXIBDYPrxa5R32Jvgpl7IU6F
         xXjqQZdjrTjRiyYIwg1LJfSqon7Gau5FSrRXq7C84LbOwMIC/DyhUk23yNOdp6647IQj
         pJHSJlvQD8aItNKPUtiF4HEz14o0wFtx7cDJ1fgmKWvokxJma08MNDOeRRtSsSSJm5VV
         vxIlYi3Z0x8CfQJS0gcZ7kVdnCRkbt7tVhJx3w1hEAEMWq5HQctSS2j9xy4lqNiq7K80
         mXoaW5Ytl9RJfZYE8A1Qk3ZF/iauoztRI0B4B8d21HU+sXtfhrH6fj0R0o1kcY+zwOJa
         oLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RTskpJzrqjSfKamQuryjYgpBB8UNg8rBhhyvKDtP8Jc=;
        b=m4ooY08/MqXpumpiXfzvpsqwC7qh4CaGiJ0ORqizfPVE5qgzp/3mkBOtIqD8Z/G66C
         W9arQrFVaxWMm8ywxKl5mHtblDX9W033iZcOrBwmx1WCWaThVIcTFZfMwmX36io8lW7h
         aBfD31dLNjYyp9V3Ks0E4lwFNbOFOI/WjJXPOAA+w7Q6fg5zmcgVHdlH3eUaX1PF0gUM
         /2n1PskHR8e5AJCSlwOtt58p/slxz0qe6mND+sQISOK2DPT1k41fC1URIoONX5JKiqUW
         H+9pwH7qocig14hGdy96CEqMtFCnBEIYb3rA7GeTMYeN2U3taKanJciKj+QSrbD2nxpL
         H+7g==
X-Gm-Message-State: APjAAAUnJofggfPLlw4YYhSoXW2rMpzZLiH0TeTkmlOEGQexQPlBi02o
        EK56dsF9NBma1VzJMbFhYyMBrMbnJg==
X-Google-Smtp-Source: APXvYqxXVEDKuBgb5OQ4XZpudHbVkE8PutAYv0Z8IBFEIzSl+Wtc/MG9h9QzPY0Stjw+V/+iaO6JvwQotSs=
X-Received: by 2002:a63:4006:: with SMTP id n6mr41416529pga.424.1557880327498;
 Tue, 14 May 2019 17:32:07 -0700 (PDT)
Date:   Tue, 14 May 2019 17:30:59 -0700
Message-Id: <20190515003059.23920-1-yabinc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased data_head.
From:   Yabin Cui <yabinc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In perf_output_put_handle(), an IRQ/NMI can happen in below location and
write records to the same ring buffer:
	...
	local_dec_and_test(&rb->nest)
	...                          <-- an IRQ/NMI can happen here
	rb->user_page->data_head = head;
	...

In this case, a value A is written to data_head in the IRQ, then a value
B is written to data_head after the IRQ. And A > B. As a result,
data_head is temporarily decreased from A to B. And a reader may see
data_head < data_tail if it read the buffer frequently enough, which
creates unexpected behaviors.

This can be fixed by moving dec(&rb->nest) to after updating data_head,
which prevents the IRQ/NMI above from updating data_head.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 kernel/events/ring_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 674b35383491..0b9aefe13b04 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -54,8 +54,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	 * IRQ/NMI can happen here, which means we can miss a head update.
 	 */
 
-	if (!local_dec_and_test(&rb->nest))
+	if (local_read(&rb->nest) > 1) {
+		local_dec(&rb->nest);
 		goto out;
+	}
 
 	/*
 	 * Since the mmap() consumer (userspace) can run on a different CPU:
@@ -86,6 +88,13 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
 	smp_wmb(); /* B, matches C */
 	rb->user_page->data_head = head;
 
+	/*
+	 * Clear rb->nest after updating data_head. This prevents IRQ/NMI from
+	 * updating data_head before us. If that happens, we will expose a
+	 * temporarily decreased data_head.
+	 */
+	local_set(&rb->nest, 0);
+
 	/*
 	 * Now check if we missed an update -- rely on previous implied
 	 * compiler barriers to force a re-read.
-- 
2.21.0.1020.gf2820cf01a-goog

