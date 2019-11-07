Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB0C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4DB21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153477;
	bh=2lsZm4/HRIBdTLTkWSg2Y9RalodS/OSHq4ZaIU+nbl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mtXFkctqRCcPQCfyokTD4PeTZxSnGaBWhKRsc9SD/iIzbmpaq7cFsQO1JedfJGSIF
	 S93gccU8Gtqt34U2eQdByazAgg8uD1d9GzvAMMUF9sNtLmesh+ellkjMnCloVEpTHA
	 gLYbS2nmkpBpo45L69nBh79UGQJIU+LubQezJxPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfKGTEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfKGTEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:35 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1788221882;
        Thu,  7 Nov 2019 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153474;
        bh=2lsZm4/HRIBdTLTkWSg2Y9RalodS/OSHq4ZaIU+nbl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xija3YerK4pawCbJ1NP+Y06XLUSbZtXR11rkvxGBwAKsfBoQRG3yrJSqEo7bSo81B
         mHZyrL3IA6sj73L8AUVmqsdm1RxWIwcIsgjTJPJwJZinmAfU4wGvi93YFCXbRnE8N2
         briFzpSXvuLdKn3EtZRUePc2Sn5mo+YxiwYbQq0k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 29/63] perf map: Allow map__next() to receive a NULL arg
Date:   Thu,  7 Nov 2019 15:59:37 -0300
Message-Id: <20191107190011.23924-30-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like free(), return NULL in that case, will simplify the
for_each_entry_safe() iterators.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pbde2ucn49khnrebclys9pny@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c9ba49566981..86d8d187f872 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -1007,7 +1007,7 @@ struct map *maps__first(struct maps *maps)
 	return NULL;
 }
 
-struct map *map__next(struct map *map)
+static struct map *__map__next(struct map *map)
 {
 	struct rb_node *next = rb_next(&map->rb_node);
 
@@ -1016,6 +1016,11 @@ struct map *map__next(struct map *map)
 	return NULL;
 }
 
+struct map *map__next(struct map *map)
+{
+	return map ? __map__next(map) : NULL;
+}
+
 struct kmap *__map__kmap(struct map *map)
 {
 	if (!map->dso || !map->dso->kernel)
-- 
2.21.0

