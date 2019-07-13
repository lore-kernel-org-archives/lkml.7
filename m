Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF27C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801BA2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cadvFf4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfGMLGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:06:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:06:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB6etY3841141
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:06:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB6etY3841141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016000;
        bh=RzICi9GCKEj2ygzQv5NJHcYbE1HZCtvrNnYQ9WrsqqE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cadvFf4makL2bfrIY+qYspZGiDLW01zqIEkG8U+DU0JFftn6ffbVAWZwp3BdUU13j
         NCMi5PKPmLybtgdILS+F4LgrWjzGCffTyuensV2uiz13S+s4O3cKzsKmOtPXpDk+/T
         tqRGZbQbfot1QUjwoYAFmD6/6hRR/+2SSazpSMrV+ik8Xpx+wVzptMjt+vyOsmH1jW
         ckgFtnTOZFeshEpE2Z20Q7TG7Hf4XWzViwo4m5HrQCjhMaj5B/dq4NTNfyC2Ope+UV
         mEzZ/40FfafyeWFWJODNahuM6lBP82vxiOr77YcjX2GkrEa73VmZZhgG0OMd1DYGX9
         FHpXEv2HlaO5w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB6dFd3841138;
        Sat, 13 Jul 2019 04:06:39 -0700
Date:   Sat, 13 Jul 2019 04:06:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-d8d051df9f906232715282cc0570c94273b197bc@git.kernel.org>
Cc:     adrian.hunter@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, jolsa@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190708055232.5032-2-adrian.hunter@intel.com>
References: <20190708055232.5032-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: export-to-postgresql.py: Fix
 DROP VIEW power_events_view
Git-Commit-ID: d8d051df9f906232715282cc0570c94273b197bc
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

Commit-ID:  d8d051df9f906232715282cc0570c94273b197bc
Gitweb:     https://git.kernel.org/tip/d8d051df9f906232715282cc0570c94273b197bc
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 8 Jul 2019 08:52:31 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:27 -0300

perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view

PostgreSQL can error if power_events_view is not dropped before its
dependent tables e.g.

  Exception: Query failed: ERROR:  cannot drop table mwait because other
  objects depend on it
  DETAIL:  view power_events_view depends on table mwait

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: aba44287a224 ("perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events")
Link: http://lkml.kernel.org/r/20190708055232.5032-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 4447f0d7c754..92713d93e956 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -898,11 +898,11 @@ def trace_end():
 	if is_table_empty("ptwrite"):
 		drop("ptwrite")
 	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
+		do_query(query, 'DROP VIEW power_events_view');
 		drop("mwait")
 		drop("pwre")
 		drop("exstop")
 		drop("pwrx")
-		do_query(query, 'DROP VIEW power_events_view');
 		if is_table_empty("cbr"):
 			drop("cbr")
 
