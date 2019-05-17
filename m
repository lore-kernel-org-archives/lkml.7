Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F34C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F380D216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121852;
	bh=jZj/6n3mpIf2w/OtrhvW/oELTv4BP9UkeSsRGPyXXwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDT3pAx/T/IoxBcJUA4FBJEXIN6jsymZJ1YkkYicFq+LbWuwI2I8qpF7NNcybbIzV
	 8YsM2JrxifjMaBBA7lONGWhu4BNQDMUHN+buZKzFOd7KWcHhUKxrazz9YZW5o8z7Iw
	 5iKPytKvaTSTxjDAkBvqh/lRSxofTm4AlvwrDL9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfEQThb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfEQTh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:29 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043AB2173C;
        Fri, 17 May 2019 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121848;
        bh=jZj/6n3mpIf2w/OtrhvW/oELTv4BP9UkeSsRGPyXXwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJGh02FMm229a2RFEiyWou59mKa30xf6XfB1EIfVYwGlg701jxxswmQp50pgVdcM+
         0qaUrgUT9tmtIMWnDJP1m+4cNTJnboxi5oTDR2552q8kQznVi7mU25pUZcVBCq2I+0
         dS+XnpfNmkEpB7DFp1zGzQHsdbU9M1JOad+6AZTs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/73] perf scripts python: exported-sql-viewer.py: Add tree level
Date:   Fri, 17 May 2019 16:35:13 -0300
Message-Id: <20190517193611.4974-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

As preparation for adding support for copying to clipboard, keep track of
what level each item is in tree items.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index fd073e4af8da..48953257a1f0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -456,6 +456,10 @@ class CallGraphLevelItemBase(object):
 		self.query_done = False;
 		self.child_count = 0
 		self.child_items = []
+		if parent_item:
+			self.level = parent_item.level + 1
+		else:
+			self.level = 0
 
 	def getChildItem(self, row):
 		return self.child_items[row]
-- 
2.20.1

