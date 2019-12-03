Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C157C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448AD20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381443;
	bh=h1u15cYGrW4C4rJENba4ROWhpErYUTBqHLGXF8vmgvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RyRkmcd8GOeMrr+XUmO9CLFzKUHzQS31p/M9nUoImLYqT9PWoQZpyRtBxgox8olq7
	 D1v/tPQqNJf04r0H/9PFe/0Do3DNe6etQt3E/CPsDYinpG6O9wwsyFg65G9q3vGtxU
	 eTNT2XfEG6PMERJCLW1jMbOdsH23SNRpkxYkMdjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfLCN5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfLCN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:20 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A30D2084B;
        Tue,  3 Dec 2019 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381439;
        bh=h1u15cYGrW4C4rJENba4ROWhpErYUTBqHLGXF8vmgvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmchED40Yq3f+2bVaa34PlvUmhq9YKNwruZwdwk229lEpauLphxJPfJ5OM/wHZ9Xo
         fZ3nu1TTSebNKp3AMbwFmSH68j+KosWe/M/J3qF1dUpsVQs3jK7abxSPBWQ+RPBAZ/
         nwwl/gBsSJTQAPeoBQPIJaI7zKgSkehVwAFLWWFA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Steve Dickson <steved@redhat.com>,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH 21/23] perf kvm: Clarify the 'perf kvm' -i and -o command line options
Date:   Tue,  3 Dec 2019 10:56:04 -0300
Message-Id: <20191203135606.24902-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'perf kvm' subcommand has options that it in turn passes to other
perf subcommands such as 'report' and 'record', particularly -i and -o
end up setting the same variable that will then be used for 'record's -o
and report '-i', which ends up being confusing, leading some to think
that both -i and -o can be used with 'report'.

Improve the man page to state that -i is used with the post-processing
subcommands while -o is used just with 'record' and that to save the
output of 'report' one should simply redirect its output to a file.

Noticed while reading the https://www.linux-kvm.org/page/Perf_events
page.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steve Dickson <steved@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-tclbttvmgtm525fvmh85f7d9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-kvm.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 6a5bb2b17039..cf95baef7b61 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -68,10 +68,11 @@ OPTIONS
 -------
 -i::
 --input=<path>::
-        Input file name.
+        Input file name, for the 'report', 'diff' and 'buildid-list' subcommands.
 -o::
 --output=<path>::
-        Output file name.
+        Output file name, for the 'record' subcommand. Doesn't work with 'report',
+        just redirect the output to a file when using 'report'.
 --host::
         Collect host side performance profile.
 --guest::
-- 
2.21.0

