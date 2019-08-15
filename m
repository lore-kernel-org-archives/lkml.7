Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16393C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D184D2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1kdlT60Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfHOJVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:21:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfHOJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:21:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9KtTN2270943
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:20:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9KtTN2270943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860856;
        bh=i6A/28iwIBUJHa3y2ozSH6Drz8wmQPMXfjLx+p5iyHI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=1kdlT60Q7l+3zAqw+30XfZm7G0+fj0kWDSlvatD8NWnGjDzjdvO2WIF7CrJk+TMH7
         1JZKSFN2hL6EUaMZV/0RLx45ny4+JUEtiaLp5oAq+GEQ0YOUUItd+TklYJ9xevSuHd
         WyQgpqKgbZ5QCUg0Gn71RWAA1cViijzuVqnhBu4/5QEkILxVoGMZGEnDAcQzBm0GM/
         0JEU2l9C3d2+DLexeYV0HQMaNqn0O2g4ANiUQy9HM9z+hQIWBXhWihXNEPVlLOHGCy
         E0lLwD7cbp7p59daXyCgm7PlPtdpCaLpJRbOwgndoqkfW3O/H5bBU9jrODmj0+wAfx
         ++oe7AwdPfgAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9KsYo2270940;
        Thu, 15 Aug 2019 02:20:54 -0700
Date:   Thu, 15 Aug 2019 02:20:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5w0hmlk3zfvysxvpsh763k9w@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
          jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Set display thread COMM to help with
 debugging
Git-Commit-ID: 1205a2719e52b6b52e0f9c0011554419da0377a0
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

Commit-ID:  1205a2719e52b6b52e0f9c0011554419da0377a0
Gitweb:     https://git.kernel.org/tip/1205a2719e52b6b52e0f9c0011554419da0377a0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Aug 2019 11:20:42 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf top: Set display thread COMM to help with debugging

When we want to attach just to the thread that updates the display it
helps having its COMM stand out, so change it from the default "perf" to
"perf-top-UI".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5w0hmlk3zfvysxvpsh763k9w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1a4615a5f6c9..94e34853a238 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -601,6 +601,8 @@ static void *display_thread_tui(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	perf_top__sort_new_samples(top);
 
 	/*
@@ -651,6 +653,8 @@ static void *display_thread(void *arg)
 	 */
 	unshare(CLONE_FS);
 
+	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
+
 	display_setup_sig();
 	pthread__unblock_sigwinch();
 repeat:
