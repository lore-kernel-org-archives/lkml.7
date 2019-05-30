Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3602576C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PXtXDXkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfE3HzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:55:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3HzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:55:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7sm7Z2899831
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:54:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7sm7Z2899831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559202889;
        bh=LK8Cf6X9rKPqO355G3EsTQDa9jTgl+V8xjJ9X6E7rlU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PXtXDXkkm2adzMjd6a6jg1FP5mexo3GxOYTcQGPgXPXAo8nR4Bgepola5KEkFKjo9
         L5G6c0ubnYFv29xQK3Wji9BGmPqKvS/yX8hS8/Ghwicmkm7HiGQrNXNFjkoAce84jG
         9kS6v9WyaNmtYV4wZi07qzsOBGNoy3T8hna/66Dn6kS2ck+JYTuBBhH2SgMt3KfncG
         8dBb1Pe19l3xnyUDfSzQH8Qwey4xZdEoo5uK9hb4bbJ9zLVy5A05KQp5aRDqs1c/hX
         llCbSHqDOlSYpARSMH9FNHPefiBVIpLAXrFKP0M5DUKu/hdko+xuAHwm1Z5EQlNeEy
         2KrwWzUnsqKVA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7smGU2899828;
        Thu, 30 May 2019 00:54:48 -0700
Date:   Thu, 30 May 2019 00:54:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a2d8a1585e35444789c1c8cf7e2e51fb15589880@git.kernel.org>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, jolsa@redhat.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20190520113728.14389-4-adrian.hunter@intel.com>
References: <20190520113728.14389-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Fix itrace defaults for perf script
 intel-pt documentation
Git-Commit-ID: a2d8a1585e35444789c1c8cf7e2e51fb15589880
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

Commit-ID:  a2d8a1585e35444789c1c8cf7e2e51fb15589880
Gitweb:     https://git.kernel.org/tip/a2d8a1585e35444789c1c8cf7e2e51fb15589880
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:09 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf intel-pt: Fix itrace defaults for perf script intel-pt documentation

Fix intel-pt documentation to reflect the change of itrace defaults for
perf script.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 4eb068157121 ("perf script: Make itrace script default to all calls")
Link: http://lkml.kernel.org/r/20190520113728.14389-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/intel-pt.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 115eaacc455f..60d99e5e7921 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -88,16 +88,16 @@ smaller.
 
 To represent software control flow, "branches" samples are produced.  By default
 a branch sample is synthesized for every single branch.  To get an idea what
-data is available you can use the 'perf script' tool with no parameters, which
-will list all the samples.
+data is available you can use the 'perf script' tool with all itrace sampling
+options, which will list all the samples.
 
 	perf record -e intel_pt//u ls
-	perf script
+	perf script --itrace=ibxwpe
 
 An interesting field that is not printed by default is 'flags' which can be
 displayed as follows:
 
-	perf script -Fcomm,tid,pid,time,cpu,event,trace,ip,sym,dso,addr,symoff,flags
+	perf script --itrace=ibxwpe -F+flags
 
 The flags are "bcrosyiABEx" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end, and
@@ -713,7 +713,7 @@ Having no option is the same as
 
 which, in turn, is the same as
 
-	--itrace=ibxwpe
+	--itrace=cepwx
 
 The letters are:
 
