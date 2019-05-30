Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9938F2576A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="v4evDbvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfE3HyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:54:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3HyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:54:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7s5TL2899783
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:54:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7s5TL2899783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559202846;
        bh=ISJGxcdQ2x7eF37zluznuz6Qu8JbNfefp/gWFkXGgSg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=v4evDbvMnGYCOWI0c7ef5RMapMaORyD6t4P8WHPqJJpzYRyhmz003JwnNukFOurUw
         PU7ntqYLJSkLh+W2GZJAF8wOptzb24di9cxVL/TK4M5fgiDKuLIGGLwmlf59CFn3OV
         y/dpX9Cc60Q3Z/ZiuLm9pQk8lOwyUQD2bX+VObxxs1azX2wBlgTVwSiE7A1+LQJSGS
         u/BuMd5JnTE8sOdmnwjPC+jphHDSBx4o4WMeE82tLaa2tbxqSvClvJgaCqpxxYMOvM
         TIUiBQg8HhzZch/UcgwJR374gYEIHJJq8A9dmXtw34epX0E2k/E3eqwUHSKCq32LXL
         NXHSQG/kplOZQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7s4Ze2899780;
        Thu, 30 May 2019 00:54:04 -0700
Date:   Thu, 30 May 2019 00:54:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-355200e0f6a9ce14771625014aa469f5ecbd8977@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com
Reply-To: acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@redhat.com, adrian.hunter@intel.com
In-Reply-To: <20190520113728.14389-3-adrian.hunter@intel.com>
References: <20190520113728.14389-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Fix itrace defaults for perf script
Git-Commit-ID: 355200e0f6a9ce14771625014aa469f5ecbd8977
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

Commit-ID:  355200e0f6a9ce14771625014aa469f5ecbd8977
Gitweb:     https://git.kernel.org/tip/355200e0f6a9ce14771625014aa469f5ecbd8977
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:08 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf auxtrace: Fix itrace defaults for perf script

Commit 4eb068157121 ("perf script: Make itrace script default to all
calls") does not work for the case when '--itrace' only is used, because
default_no_sample is not being passed.

Example:

 Before:

  $ perf record -e intel_pt/cyc/u ls
  $ perf script --itrace > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt differ

 After:

  $ perf script --itrace > cmp1.txt
  $ perf script --itrace=cepwx > cmp2.txt
  $ diff -sq cmp1.txt cmp2.txt
  Files cmp1.txt and cmp2.txt are identical

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 4eb068157121 ("perf script: Make itrace script default to all calls")
Link: http://lkml.kernel.org/r/20190520113728.14389-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index fb76b6b232d4..5dd9d1893b89 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1010,7 +1010,8 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	}
 
 	if (!str) {
-		itrace_synth_opts__set_default(synth_opts, false);
+		itrace_synth_opts__set_default(synth_opts,
+					       synth_opts->default_no_sample);
 		return 0;
 	}
 
