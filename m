Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F8C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC2C216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808452;
	bh=4sgLjmnTO7CXBqVDep4HdViPQQ11wQ5oh3DTj7yzDrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a4GGOJ0kHtCElIgWzISRpWEIKPE1yxSYuxfNePDpF14mb8ols1fpM9zm6lI64+emM
	 tRbQJftALyDBotREgNzdW4RGzt6s8CyCiTA7TYXXiHP7iOhNFyN6TsTlYX/h7tkYqX
	 sWrqwnE5S27Rg7lcWAX8e+CYFGDOzSUPxHVM2VtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfHNSrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbfHNSr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:26 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0372084F;
        Wed, 14 Aug 2019 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808446;
        bh=4sgLjmnTO7CXBqVDep4HdViPQQ11wQ5oh3DTj7yzDrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVe/rDjt3hXO3O9u26UDtC8NZWEjheqeUiKxRFzN9ezXTZD9Z8Lnm7zbJnAfHu3va
         QiYltiJNzMqGJV5HtVhH750Og9BDH6lVyUKejRM9l2zOdU9POoBy7e0y1sBWKxgpOS
         7Gz5BViRmljBnbBpOL4U8TKrizW9uwtKUuFHZ9Wc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 28/28] perf ui: No need to set ui_browser to 1 twice
Date:   Wed, 14 Aug 2019 15:40:51 -0300
Message-Id: <20190814184051.3125-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to do it only when fallbacking from GTK to the TUI.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dda0acxqef1k72n9z4myjbjt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 44fe824e96cd..3bc7c9a6fae9 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -89,9 +89,9 @@ void setup_browser(bool fallback_to_pager)
 		printf("GTK browser requested but could not find %s\n",
 		       PERF_GTK_DSO);
 		sleep(1);
+		use_browser = 1;
 		/* fall through */
 	case 1:
-		use_browser = 1;
 		if (ui__init() == 0)
 			break;
 		/* fall through */
-- 
2.21.0

