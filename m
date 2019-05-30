Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E342C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4A82575D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mRzFu6kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfE3Hxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:53:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3Hxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:53:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7rJ262899483
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:53:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7rJ262899483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559202800;
        bh=YfQ9Px04MhXyZi64XIhHmkWwVFOe1S0gn9p4ooynpg0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mRzFu6kUABaux3rNYbvwbz87tK1HtD/Wz4PTJbeLUh/TiiSMAjS8d/AqAJhTNOu/0
         Qshfy8lL2AfO9dqLu+yMLQ+X749XIkEext9LYDTRmt8fNB5dGvZ9tGdo0Uy1D9CaRm
         jVSe7At7ER8qfWNi/R8mLHPMSuhvno5B5P8ww65edT+UqVhSCKgjUK+9yiJuvTRkvD
         Q9JfySHz5JVa8HQkVfq7+mH6ZYiVVkzOmn8v+QccmgdoZzY77DnwaqI4jolgSJqzVZ
         PoUGYxPU37Jpfg9WmWRcDG6INW7UK5p1p5lp3Z53K2MseQ8++OJHUXQ20YMtmP4hjn
         ziKl3kBPwmu3g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7rJm52899480;
        Thu, 30 May 2019 00:53:19 -0700
Date:   Thu, 30 May 2019 00:53:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-26f19c2eb7e54015564ff133b91983a74e84541b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@redhat.com
In-Reply-To: <20190520113728.14389-2-adrian.hunter@intel.com>
References: <20190520113728.14389-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix itrace defaults for perf script
Git-Commit-ID: 26f19c2eb7e54015564ff133b91983a74e84541b
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

Commit-ID:  26f19c2eb7e54015564ff133b91983a74e84541b
Gitweb:     https://git.kernel.org/tip/26f19c2eb7e54015564ff133b91983a74e84541b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:07 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf intel-pt: Fix itrace defaults for perf script

Commit 4eb068157121 ("perf script: Make itrace script default to all
calls") does not work because 'use_browser' is being used to determine
whether to default to periodic sampling (i.e. better for perf report).
The result is that nothing but CBR events display for perf script when
no --itrace option is specified.

Fix by using 'default_no_sample' and 'inject' instead.

Example:

 Before:

  $ perf record -e intel_pt/cyc/u ls
  $ perf script > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt differ

 After:

  $ perf script > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.20+
Fixes: 90e457f7be08 ("perf tools: Add Intel PT support")
Link: http://lkml.kernel.org/r/20190520113728.14389-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6d288237887b..03b1da6d1da4 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2588,7 +2588,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&pt->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		if (use_browser != -1) {
+		if (!session->itrace_synth_opts->default_no_sample &&
+		    !session->itrace_synth_opts->inject) {
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
 		}
