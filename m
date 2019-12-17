Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7C6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D182465E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594137;
	bh=pLEDdjZX7H5IDJpVmYUF785gx5AOW3S7JPYVszYVPk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wDpmxFlBNUFrizRiFTbDZM04AKpgW+gpvocS4BC3BMQOFxmIFbc0cT6xtBBinB8R2
	 VHljj5Xot3slN9a5PpUnMs9IrM8beFol528ZCOkZWBgN5jB3VlOsxBtm4f3ZZ7Zvwq
	 R+p+lnMQuaYW/VdHTMAuXpCfYAdILVy0WtHAM5xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfLQOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQOsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:48:54 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F46124672;
        Tue, 17 Dec 2019 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594133;
        bh=pLEDdjZX7H5IDJpVmYUF785gx5AOW3S7JPYVszYVPk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKIfmaxO4nVTIUgYwP+OgSdJSUzG9qFp0abVBcD3Z9YYq3Mngq4CcFG2nHC/8kFu3
         q1bLSb3ccbOac7nzz/CxfM+/rH5OnXXK6mSt3k7+qlgvkkhw3pZDBjsiZAEG4S66aq
         iNcYFeqZhCJQLRrH3rot5CZrjGoMjb15PUAtFOIw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/12] perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
Date:   Tue, 17 Dec 2019 11:48:17 -0300
Message-Id: <20191217144828.2460-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to set actions->ms.map since 599a2f38a989 ("perf hists browser:
Check sort keys before hot key actions"), as in that patch we bail out
if map is NULL.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 599a2f38a989 ("perf hists browser: Check sort keys before hot key actions")
Link: https://lkml.kernel.org/n/tip-wp1ssoewy6zihwwexqpohv0j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d4d3558fdef4..cfc6172ecab7 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3062,6 +3062,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 				continue;
 			}
+			actions->ms.map = map;
 			top = pstack__peek(browser->pstack);
 			if (top == &browser->hists->dso_filter) {
 				/*
-- 
2.21.0

