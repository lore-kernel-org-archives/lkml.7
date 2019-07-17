Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6EC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC034208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="l+xAj5q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfGQXJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:09:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:09:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN8Ui11726105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:08:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN8Ui11726105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404910;
        bh=hb+KP5XrPFyskcG8spUCTyJRglpAKy0Yf7tWeYOw4Ac=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=l+xAj5q4fUuAUj4JM2qdXwNfBJ5EltsxINMb0i/VUAoeaew45wODLThJ0Ku1z/h1L
         l9El1Z3ZPWv/GsDgK6jdNfGXveTBTHXFMOGUZZ3WXTZDpb/t8XSMh6KWT+YzpuYAaa
         PQHgK25rSObi3nxeuevzCO1c2g8/OyudpKDiXp1Daj8my082pCWMo9ckXvEKq/vKiz
         ETk5GBGxNqmoJp6MLu/kkGf0V3SDyEya8tiqUZExakCjfNXICPkSF22RNN11c4+423
         bYhpjd+cqqM6WkH4OofFoJ/wA7xlrTNCmxxsjThbMqUaYGe97DTEN8J29iqQpbeFnR
         Oyl5AIB2r4awg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN8TiQ1726102;
        Wed, 17 Jul 2019 16:08:29 -0700
Date:   Wed, 17 Jul 2019 16:08:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-916c31fff946fae0e05862f9b2435fdb29fd5090@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, ravi.bangoria@linux.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mamatha4@linux.vnet.ibm.com,
        kamalesh@linux.vnet.ibm.com
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          ravi.bangoria@linux.ibm.com, acme@redhat.com,
          kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          mamatha4@linux.vnet.ibm.com, jolsa@redhat.com
In-Reply-To: <20190611030109.20228-1-ravi.bangoria@linux.ibm.com>
References: <20190611030109.20228-1-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf version: Fix segfault due to missing
 OPT_END()
Git-Commit-ID: 916c31fff946fae0e05862f9b2435fdb29fd5090
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

Commit-ID:  916c31fff946fae0e05862f9b2435fdb29fd5090
Gitweb:     https://git.kernel.org/tip/916c31fff946fae0e05862f9b2435fdb29fd5090
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Tue, 11 Jun 2019 08:31:09 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 15 Jul 2019 07:59:05 -0300

perf version: Fix segfault due to missing OPT_END()

'perf version' on powerpc segfaults when used with non-supported
option:
  # perf version -a
  Segmentation fault (core dumped)

Fix this.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Tested-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190611030109.20228-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index f470144d1a70..bf114ca9ca87 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -19,6 +19,7 @@ static struct version version;
 static struct option version_options[] = {
 	OPT_BOOLEAN(0, "build-options", &version.build_options,
 		    "display the build options"),
+	OPT_END(),
 };
 
 static const char * const version_usage[] = {
