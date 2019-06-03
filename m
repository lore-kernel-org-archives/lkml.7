Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41B7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74A426780
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g1cRVTrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfFCN1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:27:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:27:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DQmU8609321
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:26:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DQmU8609321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568409;
        bh=trzlAEPtfBI6MOgqoM8F/vp1VErbqdkcLcQtH0PBhXo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=g1cRVTrJOEiRfM5iYRFgyi1H56E9yeENd3pRkVoj0m4h4bI/7Wapu4+COlidzKqWp
         DLoMs2muiag/yKPf7f6KWcGNTreU6pEqGzl/1PyKvSq4NG08SuUXw0lxb9yGkHrzfw
         o5b/l+D1j1s1pynZSfN4z9jbTY5U/2US0G7yb71ffXsFr33M4BaFL6etOz68d5ZWWt
         lgnOSEF5HOJnWzTL/4O7F/ctKqd9AX+PF58ypPBFYaTSi5XOGm7/fx/3Pn+etE3Dm0
         hHJvICkJFzT+yVum5f0u3Fhodh664Pt+ojC+qC3CRXR2tmEC/CSwFjz7gMG2cpPL8B
         O2ots5fy94Rzw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DQmml609318;
        Mon, 3 Jun 2019 06:26:48 -0700
Date:   Mon, 3 Jun 2019 06:26:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-21b0dbc5e8b050e40a93a1f8cdef277502a4fc90@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, namhyung@kernel.org,
        torvalds@linux-foundation.org, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de, acme@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, gregkh@linuxfoundation.org,
          peterz@infradead.org
In-Reply-To: <20190512155518.21468-4-jolsa@kernel.org>
References: <20190512155518.21468-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Get rid of x86_pmu::event_attrs
Git-Commit-ID: 21b0dbc5e8b050e40a93a1f8cdef277502a4fc90
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

Commit-ID:  21b0dbc5e8b050e40a93a1f8cdef277502a4fc90
Gitweb:     https://git.kernel.org/tip/21b0dbc5e8b050e40a93a1f8cdef277502a4fc90
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:12 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:22 +0200

perf/x86: Get rid of x86_pmu::event_attrs

Nobody is using that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-4-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       | 3 ---
 arch/x86/events/perf_event.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..0c5a2c783374 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1850,9 +1850,6 @@ static int __init init_hw_perf_events(void)
 			x86_pmu_caps_group.attrs = tmp;
 	}
 
-	if (x86_pmu.event_attrs)
-		x86_pmu_events_group.attrs = x86_pmu.event_attrs;
-
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
 	else
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a6ac2f4f76fc..1599008f156a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -631,7 +631,6 @@ struct x86_pmu {
 	int		attr_rdpmc_broken;
 	int		attr_rdpmc;
 	struct attribute **format_attrs;
-	struct attribute **event_attrs;
 	struct attribute **caps_attrs;
 
 	ssize_t		(*events_sysfs_show)(char *page, u64 config);
