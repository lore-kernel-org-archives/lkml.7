Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74320205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370771;
	bh=+1l8iLf6Qth8czlK3I4pdhaR5nodkp0FUerYR+6krUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRRqECCuQ2n9TRcr8swB6d4SPYR2YD0OErwgongx8WNzAZGPZqoXuqXmfkwrAdMtg
	 XuSCxDzC1fWj/Hcz34oFLhjvX/6ZLE72zPXD5TYrAkmLOVnvQrfAXC7Aur6H6kV5Pg
	 IZ4dH99bbWQmY5sVs2FsmSRIty0y9UN9EvZYUTK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfDDJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731800AbfDDJD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555012147C;
        Thu,  4 Apr 2019 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368608;
        bh=+1l8iLf6Qth8czlK3I4pdhaR5nodkp0FUerYR+6krUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iwd9Zu3gFDE+IesdEAgH6FXkZywZoZ4Co1ZaC+H2tLvZ0PxzBTeVw9zwVtQt1D6zB
         Ynx2CuF+mBpZ+PMS5OdTa5g7Fghyo3gGB4x5bPrf+HVb5OcOe/3yRryjj2JqMqWBFv
         pJ+oOh7QgPKDIZ24DkUXWA43gz3vx6OVa6rg29SU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <righi.andrea@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/187] kprobes: Prohibit probing on bsearch()
Date:   Thu,  4 Apr 2019 10:47:19 +0200
Message-Id: <20190404084608.017921661@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 02106f883cd745523f7766d90a739f983f19e650 ]

Since kprobe breakpoing handler is using bsearch(), probing on this
routine can cause recursive breakpoint problem.

int3
 ->do_int3()
   ->ftrace_int3_handler()
     ->ftrace_location()
       ->ftrace_location_range()
         ->bsearch() -> int3

Prohibit probing on bsearch().

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998813406.31052.8791425358974650922.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/bsearch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bsearch.c b/lib/bsearch.c
index 18b445b010c3..82512fe7b33c 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);
-- 
2.19.1



