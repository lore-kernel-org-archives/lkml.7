Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B059C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786E5214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfLECFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:05:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfLECFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:05:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23EB621744;
        Thu,  5 Dec 2019 02:05:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1icgWa-000oBN-93; Wed, 04 Dec 2019 21:05:48 -0500
Message-Id: <20191205020548.158264878@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 04 Dec 2019 21:05:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 1/3] tracing: Fix __print_hex_dump scope
References: <20191205020459.023316620@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>

undef is needed for parsing __print_hex_dump in traceevent lib.

Link: http://lkml.kernel.org/r/1574762791-14883-1-git-send-email-piotrx.maziarz@linux.intel.com

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7089760d4c7a..472b33d23a10 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -757,6 +757,7 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_str
 #undef __get_bitmask
 #undef __print_array
+#undef __print_hex_dump
 
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
-- 
2.24.0


