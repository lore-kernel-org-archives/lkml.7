Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A0ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0CB214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824432;
	bh=m7rLihyLxHENX11pjE5KD6UUviF2wU0gGlPPdtrJlsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xHZtFYCmEWrES1eDTZ2EhZLYE5ToHG769H+zhuBkYXAkaON4beXgJN9WOyAQT6oIZ
	 ulGhjsS1DiPFKsOn9gPgaYRZ3vu0EnqELIeJc6qSTy4t/qcnXJcPOPCSoSnWaOmOLn
	 sl3igsEa+JJcrXyMVUG9zulbMPzuXyTIhaammIQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfJKUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfJKUHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:10 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A8821D7F;
        Fri, 11 Oct 2019 20:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824430;
        bh=m7rLihyLxHENX11pjE5KD6UUviF2wU0gGlPPdtrJlsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8I/z25HVeKgvd9kuLNbsXBGvz9a5H8CDdwjQaX3VMMQXTpdbJ4xLL5Gf7RvMNj4x
         L0Db51dHpWXUz80b2j9n9DQgL5WOo0QUHwtwIFziT3MnZ7yuQOABDVxYni3OCDfww1
         mYjnkut5e+N7UXYmCXdhCl9p7aC/inVp8VZuwJWo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/69] perf scripts python: exported-sql-viewer.py: Add LookupModel()
Date:   Fri, 11 Oct 2019 17:04:59 -0300
Message-Id: <20191011200559.7156-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add LookupModel() to find a model in the model cache without creating it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 61b3911d91e6..18ad04654adc 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -341,6 +341,15 @@ def LookupCreateModel(model_name, create_fn):
 	model_cache_lock.release()
 	return model
 
+def LookupModel(model_name):
+	model_cache_lock.acquire()
+	try:
+		model = model_cache[model_name]
+	except:
+		model = None
+	model_cache_lock.release()
+	return model
+
 # Find bar
 
 class FindBar():
-- 
2.21.0

