Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D82C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA1C2339D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329332;
	bh=j+DB4Z07eOWu/26uUDkkDzdXlDw4pAn2qbDCBBstdpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cIEVA82/vwwy18HUaGLmYtUch78Votcdi5gW3lr9+jBMNMu1RXCpkCDme4CIY/js4
	 lVbAG9wOW/1jRxkMSPZ6d8HIt1b8ucqn5o/lT81zjDvHFDXb6sxHTCT7nNCIiYXHAK
	 iEWFVp6MNIPNtqKH2Pqp32UagaQzJpaXs3Lhrouc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfHTT2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfHTT2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:48 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E3B22DA7;
        Tue, 20 Aug 2019 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329328;
        bh=j+DB4Z07eOWu/26uUDkkDzdXlDw4pAn2qbDCBBstdpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3WFABUe1P+5pDz61f2O6fREpls/cPfn7aFcsGGsPac40dMXUMpmJdMlLrMLQdO14
         pFrxcGFHHxIoJT4KH/SpcKRLWsyU9xhJ49WhdVpUKTCxILqONDTT0xUi1XF6Ea8hCk
         AtgYg0KlfdZVBHVs1fp1Yu07rgi0tpkqfbrsTSq8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/17] perf ui browser: Allow specifying message to show when no samples are available to display
Date:   Tue, 20 Aug 2019 16:27:30 -0300
Message-Id: <20190820192733.19180-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'perf top' tool will use that to avoid having a initial blank screen
while collecting the minimum number of samples to sort and display.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-89ciceg8cy4442he3t0jzo3f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c | 2 ++
 tools/perf/ui/browser.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index d227d74b28f8..c797a853d3a0 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -347,6 +347,8 @@ static int __ui_browser__refresh(struct ui_browser *browser)
 	SLsmg_fill_region(browser->y + row + browser->extra_title_lines, browser->x,
 			  browser->rows - row, width, ' ');
 
+	if (browser->nr_entries == 0 && browser->no_samples_msg)
+		__ui__info_window(NULL, browser->no_samples_msg, NULL);
 	return 0;
 }
 
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index dc1444136658..3678eb88f119 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -23,6 +23,7 @@ struct ui_browser {
 	void	      *priv;
 	const char    *title;
 	char	      *helpline;
+	const char    *no_samples_msg;
 	void 	      (*refresh_dimensions)(struct ui_browser *browser);
 	unsigned int  (*refresh)(struct ui_browser *browser);
 	void	      (*write)(struct ui_browser *browser, void *entry, int row);
-- 
2.21.0

