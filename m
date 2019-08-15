Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46BAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A152186A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cyKBh3eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfHOJRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:17:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfHOJRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:17:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9HAUk2270406
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:17:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9HAUk2270406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860630;
        bh=QsQ9Yiodl0WBhxVGnVERq90Isva7wVbnssFaKcqW+7M=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=cyKBh3eWhf19mIquSSarpr0RJ5YZ3bwU7cuk/SFPnhHSKkB7M6W+fqQBQ7sSiRSTA
         m1VJ5Y8cmEo9G7DHuMTQsSEmmcbCQ/GTV8wNzgdayadRLNY3wOyZha16GHjBNnkei1
         mzAbfrWM/BjOhi//m4H3gsOrXHTGQxqTi4hPr+0lcYeT2w7eN/LMw5zORVDAjehAQo
         kMxwjiL1oTLZgby4IzlXzV+xnIRQECDcaYUFlI/lFz0GVCPkAn7S2TQoCjEMPtS67Q
         Lf0fkMRa7rCyoCkUy1r17kHjoiizUO2nhXwo1Gbj+CA4oq/WGsezIbdknThCl2drnS
         qlZBleaQxPHuQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9H9RT2270403;
        Thu, 15 Aug 2019 02:17:09 -0700
Date:   Thu, 15 Aug 2019 02:17:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jo209zac9rut0dz1rqvbdlgm@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
        lclaudio@redhat.com, tglx@linutronix.de, treeze.taeung@gmail.com,
        mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, treeze.taeung@gmail.com, jolsa@kernel.org,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com, lclaudio@redhat.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf config: Honour $PERF_CONFIG env var to specify
 alternate .perfconfig
Git-Commit-ID: 61a461fcbd62d42c29a1ea6a9cc3838ad9f49401
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

Commit-ID:  61a461fcbd62d42c29a1ea6a9cc3838ad9f49401
Gitweb:     https://git.kernel.org/tip/61a461fcbd62d42c29a1ea6a9cc3838ad9f49401
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Jul 2019 11:20:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf config: Honour $PERF_CONFIG env var to specify alternate .perfconfig

We had this comment in Documentation/perf_counter/config.c, i.e. since
when we got this from the git sources, but never really did that
getenv("PERF_CONFIG"), do it now as I need to disable whatever
~/.perfconfig root has so that tests parsing tool output are done for
the expected default output or that we specify an alternate config file
that when read will make the tools produce expected output.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")
Link: https://lkml.kernel.org/n/tip-jo209zac9rut0dz1rqvbdlgm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 97e2628ea5dd..d4e4d53e8b44 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -441,6 +441,9 @@ int main(int argc, const char **argv)
 
 	srandom(time(NULL));
 
+	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
+	config_exclusive_filename = getenv("PERF_CONFIG");
+
 	err = perf_config(perf_default_config, NULL);
 	if (err)
 		return err;
