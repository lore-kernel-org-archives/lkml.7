Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094BECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638062190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824530;
	bh=09PfOjI0QwDPOV2fmVFTKSVkY2aW4q25zpHjbkbCs4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fPjtEJ7J2fLVmHl/FCaLXZFpH+2ZsCu3QSLwkWMkIr0d3md+mIuX4FqrAfgLJGL+F
	 dCOxbZy2OotQEhGaamUUOns3kDbePN/6bRtDooR7LWwBTkvs3UHdwg3jWlZIP3LViF
	 1nLV2Vkefp94RTjnXztqj0RzjK94cN7ST8A1oAiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfJKUIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbfJKUIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:48 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F315B222C1;
        Fri, 11 Oct 2019 20:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824527;
        bh=09PfOjI0QwDPOV2fmVFTKSVkY2aW4q25zpHjbkbCs4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fefZm3CDOewNJYGQe37oXv2y90jqd3+qRDgqlXAYA+x7qehrQFCyAuDYOHqgqT1Gs
         NUoJfzqqSWWifhiQFsQBiOwuEsGOJn9O5kDLkR9o0SNPHOV3X0HPYlZ4edBZxPVywA
         vjdTmiT4stdKIg5XIRPQEtGMgX43tPGJFyVVr4js=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 26/69] perf beauty: Make strarray's offset be u64
Date:   Fri, 11 Oct 2019 17:05:16 -0300
Message-Id: <20191011200559.7156-27-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need it for things like MSRs that are sparse and go over MAXINT.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-g8t2d0jr0mg3yimg2qrjkvlt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 4cc4f6b3d4a1..5ad7542b428b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -7,7 +7,7 @@
 #include <sys/types.h>
 
 struct strarray {
-	int	    offset;
+	u64	    offset;
 	int	    nr_entries;
 	const char *prefix;
 	const char **entries;
-- 
2.21.0

