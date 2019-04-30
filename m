Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1C5C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5646C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cqwBqPWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfD3Fwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:52:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3Fwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:52:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3U5qGZC1243722
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 22:52:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3U5qGZC1243722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556603537;
        bh=qvyI4MHuo+x0OKG4E4+YTMoKqkwoXa9SSpGjeRGi9Xs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cqwBqPWvPUZVfCQT6NsgX+iOFavClUlXjCrN8Nj2stkaY2ZSgvxWou0igE1OYMLRa
         ZvHFDRS4ZZG20DOvk9/QxG7f72NamXkB6SOJca6hSJ/cbCuMlifeZMd07CQTzLUZzN
         nnByW5QvIC+kQhDxrkV0MePDOIa2tF4888EIDAOVke7cAWyjdR01yByLua0Ewltnw/
         I0KR7XGA8DcQrDhFDuIFxr8zWMl6LRGFXr2uvcYBK2xVhyPWLY2XXxmuz1XfL9nyFG
         A1AMAeXTXMukmrq7AR7utjWUFv+h/9axs8y48RSx3uGRZidCyb8duXw4VhsfBlmOdn
         pgdKNJMu7dElg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3U5qGMo1243719;
        Mon, 29 Apr 2019 22:52:16 -0700
Date:   Mon, 29 Apr 2019 22:52:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tobin C. Harding" <tipbot@zytor.com>
Message-ID: <tip-8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        tobin@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
          hpa@zytor.com, tglx@linutronix.de, vincent.guittot@linaro.org,
          peterz@infradead.org, rafael.j.wysocki@intel.com,
          mingo@kernel.org, viresh.kumar@linaro.org, tobin@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190430001144.24890-1-tobin@kernel.org>
References: <20190430001144.24890-1-tobin@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/cpufreq: Fix kobject memleak
Git-Commit-ID: 8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
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

Commit-ID:  8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
Gitweb:     https://git.kernel.org/tip/8bf7ab9c79f3d1a5f02ebac369f656de9ec0aca8
Author:     Tobin C. Harding <tobin@kernel.org>
AuthorDate: Tue, 30 Apr 2019 10:11:44 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 06:24:09 +0200

sched/cpufreq: Fix kobject memleak

Currently the error return path from kobject_init_and_add() is not
followed by a call to kobject_put() - which means we are leaking
the kobject.

Fix it by adding a call to kobject_put() in the error path of
kobject_init_and_add().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Add call to kobject_put() in error path of kobject_init_and_add().
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tobin C. Harding <tobin@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: http://lkml.kernel.org/r/20190430001144.24890-1-tobin@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5c41ea367422..3638d2377e3c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -771,6 +771,7 @@ out:
 	return 0;
 
 fail:
+	kobject_put(&tunables->attr_set.kobj);
 	policy->governor_data = NULL;
 	sugov_tunables_free(tunables);
 
