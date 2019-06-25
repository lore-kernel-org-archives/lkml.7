Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792E6C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8AD21670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GVFXjoYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfFYITv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:19:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfFYITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:19:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8J95X3526902
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:19:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8J95X3526902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561450750;
        bh=XsqDv1T1rRr5lHY6o0BgkRrJWsnwiR4Jo4jV97xYJtA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GVFXjoYFEEeL+7IarGsEAGJ8z3sX2YFfxmqyQzJqTexVjMvgySyH538NNgYyNKTT+
         Y0XzJs6tes06TqQeJLxqGVdmRckgCE4aEQWPrv6aYPvg6PmY6roVde9iAviA7TKEkc
         QjbPFZo09sFvqSIHCf+QW7Y0r6qCu08G9dH3FubiAX/0EXHjQmgR2GUYdd8yIgpsd+
         aT26nPC42Nk0+Jkc+zLH7/anm114mMRAJtM/AX68zbJ0eLvdJq8OizrO0RHGVYeje9
         3+VpWTUlPfiGkf/iNloM3IJBD4QMurEMQ7dCUlNRRT1iCaIAKblcLdTFRvmAQCqpt6
         lA3UHxy/BIpzw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8J9673526899;
        Tue, 25 Jun 2019 01:19:09 -0700
Date:   Tue, 25 Jun 2019 01:19:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-913a90bc5a3a06b1f04c337320e9aeee2328dd77@git.kernel.org>
Cc:     jolsa@redhat.com, hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        mingo@kernel.org, ravi.bangoria@linux.ibm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vincent.weaver@maine.edu, acme@redhat.com,
        torvalds@linux-foundation.org
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
          hpa@zytor.com, jolsa@redhat.com, mingo@kernel.org,
          eranian@google.com, vincent.weaver@maine.edu,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ravi.bangoria@linux.ibm.com, torvalds@linux-foundation.org,
          acme@redhat.com
In-Reply-To: <20190604042953.914-1-ravi.bangoria@linux.ibm.com>
References: <20190604042953.914-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/ioctl: Add check for the sample_period value
Git-Commit-ID: 913a90bc5a3a06b1f04c337320e9aeee2328dd77
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

Commit-ID:  913a90bc5a3a06b1f04c337320e9aeee2328dd77
Gitweb:     https://git.kernel.org/tip/913a90bc5a3a06b1f04c337320e9aeee2328dd77
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Tue, 4 Jun 2019 09:59:53 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:19:22 +0200

perf/ioctl: Add check for the sample_period value

perf_event_open() limits the sample_period to 63 bits. See:

  0819b2e30ccb ("perf: Limit perf_event_attr::sample_period to 63 bits")

Make ioctl() consistent with it.

Also on PowerPC, negative sample_period could cause a recursive
PMIs leading to a hang (reported when running perf-fuzzer).

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.vnet.ibm.com
Cc: mpe@ellerman.id.au
Fixes: 0819b2e30ccb ("perf: Limit perf_event_attr::sample_period to 63 bits")
Link: https://lkml.kernel.org/r/20190604042953.914-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2e32faac5511..8d1c62df20a7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (perf_event_check_period(event, value))
 		return -EINVAL;
 
+	if (!event->attr.freq && (value & (1ULL << 63)))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
