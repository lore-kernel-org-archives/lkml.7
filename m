Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA12FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF0B2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfCENwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbfCENws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A9020848;
        Tue,  5 Mar 2019 13:52:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUw-00031F-L2; Tue, 05 Mar 2019 08:52:46 -0500
Message-Id: <20190305135246.491956639@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 5/6] tracing: Use str_has_prefix() in synth_event_create()
References: <20190305135223.360347148@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Since we now have a str_has_prefix() that returns the length, we can
use that instead of explicitly calculating it.

Link: http://lkml.kernel.org/r/03418373fd1e80030e7394b8e3e081c5de28a710.1549309756.git.tom.zanussi@linux.intel.com

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 66386ba1425f..5b03b9a869bb 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1316,8 +1316,8 @@ static int synth_event_create(int argc, const char **argv)
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
-		len = sizeof(SYNTH_SYSTEM "/") - 1;
-		if (strncmp(name, SYNTH_SYSTEM "/", len))
+		len = str_has_prefix(name, SYNTH_SYSTEM "/");
+		if (len == 0)
 			return -EINVAL;
 		name += len;
 	}
-- 
2.20.1


