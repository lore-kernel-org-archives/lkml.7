Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F617208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tpLAxa0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfFQTAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:00:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:00:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ0YS13554435
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:00:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ0YS13554435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798035;
        bh=uGSbMpOT75u6A3P2QUdnrlSEt+kpN9n37vfsQe8DyN4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tpLAxa0ROJbBPGzFlW9tfVU8BwLdcbpP2lw2JH2KYjGqX5J+koLML8JD1llg5SqQU
         J9lIgWN40jBADttk8MPBw9mS75Bx5Mr+IpNq/f07wwY9yvoBWC2LsXFEK7LbzMl0JK
         egWdm6mZBHPq1XCn53NH/5n9WuFw3ySRHQKXJAQhvy2XkutZBYviWXBiIgXc9auFvo
         MY79+n1zV9rKmGC4YYwNB/bYwRpGtVAGV22QBDt0sK/dYl75qBdldF6OHpSFrYJDRc
         o11hi2m9d+dML9XfS5km7fX4St/t6ow1oykgiGTVjHpJOMPIuilpzbzqILpmuGb7cP
         k7fSxjTyjFZTA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ0YQF3554432;
        Mon, 17 Jun 2019 12:00:34 -0700
Date:   Mon, 17 Jun 2019 12:00:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-61d276f428a11f0e4ce5203462fa488e6570684f@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@redhat.com, adrian.hunter@intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          adrian.hunter@intel.com, tglx@linutronix.de
In-Reply-To: <20190520113728.14389-7-adrian.hunter@intel.com>
References: <20190520113728.14389-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add IPC information to perf_sample
Git-Commit-ID: 61d276f428a11f0e4ce5203462fa488e6570684f
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

Commit-ID:  61d276f428a11f0e4ce5203462fa488e6570684f
Gitweb:     https://git.kernel.org/tip/61d276f428a11f0e4ce5203462fa488e6570684f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:12 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:55 -0300

perf tools: Add IPC information to perf_sample

Add counts of instructions and cycles, in order to represent
instructions-per-cycle (IPC).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9e999550f247..1f1da6082806 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -204,6 +204,8 @@ struct perf_sample {
 	u64 period;
 	u64 weight;
 	u64 transaction;
+	u64 insn_cnt;
+	u64 cyc_cnt;
 	u32 cpu;
 	u32 raw_size;
 	u64 data_src;
