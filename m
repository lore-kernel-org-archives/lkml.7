Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DA8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996232467D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077305;
	bh=l2UCK3xytwrx03fUcDYomWkfGJOqNbOW2JXE+tt4AjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C+sYL6pKCDhnz95WSHFGu4pLAaDhoV4q0iOoWHXCk+FoG0SIyuz41jTwR8UJb2hYD
	 W7aj7P3NEJ9A0/hsMyPfID9KgbJ1b7bf0Z++DjnSkNuKToWcSYBqNnSW9R12KJes2E
	 zv5AdFgvN2hRrPL5z0HgFUMqrMPFvJSqw2i+0C0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfLKPPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731558AbfLKPOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36422465C;
        Wed, 11 Dec 2019 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077241;
        bh=l2UCK3xytwrx03fUcDYomWkfGJOqNbOW2JXE+tt4AjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agYvdn87DcAXobq2nTMnqkS8i9Kfal+N26DZbJZHvK9JSEp3pIalZmfzTZ6A5Zow8
         tZy5Zm/4R4Dt+x8loGnUW0DN7PNdB15orzqo1gQ4lIkCox/rZQ20jm6LkAxpmEw4Ah
         nVr8wdxHovxXXB4da+pL0bq5wWwyICNFLehPKu9A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 119/134] perf diff: Use llabs() with 64-bit values
Date:   Wed, 11 Dec 2019 10:11:35 -0500
Message-Id: <20191211151150.19073-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 98e93245113d0f5c279ef77f4a9e7d097323ad71 ]

To fix these build errors on a debian mipsel cross build environment:

  builtin-diff.c: In function 'block_cycles_diff_cmp':
  builtin-diff.c:550:6: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    550 |  l = labs(left->diff.cycles);
        |      ^~~~
  builtin-diff.c:551:6: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    551 |  r = labs(right->diff.cycles);
        |      ^~~~

Fixes: 99150a1faab2 ("perf diff: Use hists to manage basic blocks per symbol")
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c37a786779555..265682296836d 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -575,8 +575,8 @@ static int64_t block_cycles_diff_cmp(struct hist_entry *left,
 	if (!pairs_left && !pairs_right)
 		return 0;
 
-	l = labs(left->diff.cycles);
-	r = labs(right->diff.cycles);
+	l = llabs(left->diff.cycles);
+	r = llabs(right->diff.cycles);
 	return r - l;
 }
 
-- 
2.20.1

