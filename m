Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68223C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A932464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077161;
	bh=3+7wmKB4YLchn/gq4IOx0SBRYWWn2klYIBGCU1dHamg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRGCPaDmvdgUc4eNRy7G20NczPpRbTLqtK9He9gzYk2lqIPU1gjYiwHKrymvxxc/K
	 3Fwmqt40WYjqoZqoEB20iHCGj2uJAzPB83EfPFQnZ4yDa0xP2qvIOQ1Or9ihyAG3Ha
	 0BdaBlr0LkeoEhCxO4lkVG+aDaEKljpJN2ozekDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfLKPMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:12:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbfLKPMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E3424654;
        Wed, 11 Dec 2019 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077140;
        bh=3+7wmKB4YLchn/gq4IOx0SBRYWWn2klYIBGCU1dHamg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoGOnSbDPDSoeQvkpA2CflPacQ+tice8Ok3UM56rJ+z6tKykCoMeThda4/sYOIqVQ
         gpJY+3JtehaQsURp4yW5HRKsFE0yQ/ydEPSh2AxoBaXiwNA7S83HqhgympBx3IIElP
         ft3tc7AdDTJ519R/cnecCzU7Fb4Vt2lwzQbs1XNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 031/105] perf/core: Consistently fail fork on allocation failures
Date:   Wed, 11 Dec 2019 16:05:20 +0100
Message-Id: <20191211150231.320144857@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 697d877849d4b34ab58d7078d6930bad0ef6fc66 ]

Commit:

  313ccb9615948 ("perf: Allocate context task_ctx_data for child event")

makes the inherit path skip over the current event in case of task_ctx_data
allocation failure. This, however, is inconsistent with allocation failures
in perf_event_alloc(), which would abort the fork.

Correct this by returning an error code on task_ctx_data allocation
failure and failing the fork in that case.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20191105075702.60319-1-alexander.shishkin@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 53173883513c1..25942e43b8d48 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11719,7 +11719,7 @@ inherit_event(struct perf_event *parent_event,
 						   GFP_KERNEL);
 		if (!child_ctx->task_ctx_data) {
 			free_event(child_event);
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
-- 
2.20.1



