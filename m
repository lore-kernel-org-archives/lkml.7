Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E112E21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153693;
	bh=gIfT0waNeqbgs88hdh1OxL9xvbypfVR98BfhF+DUASQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KH3NW/pn+/a6PJrpPFyKw7DxbnkGHVkXR9QCs12kPu05bqPcxRWc4+HHYkMko1uFM
	 nHHYdvftrZttpVRVx9gpytSEr4ZfrkpZlT669bk0Hwm59SZPBffkw9Cd0QOUN8acl6
	 DrF+cG2TZ5/YRighA2ZULT6Bzngrq6Wa6mCShI/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfKGTIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730827AbfKGTIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:07 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7290A21D6C;
        Thu,  7 Nov 2019 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153686;
        bh=gIfT0waNeqbgs88hdh1OxL9xvbypfVR98BfhF+DUASQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4beYqaqMOPSMwd56IUwXnDcYN8xImv/9tXb3aXuGXMN+pmrPiqCaPyxWmsKjgg5H
         bU4B/HhejeptjZd+6hop+M8bniz5YErCEp3PfjXRSj6be0jTyCcqGujj53afuzhQm5
         1l5qEZX0Yu0jO6W8hJ4ZKZb3lLwhsZ+SGnJyaNTU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 47/63] perf symbols: Remove needless checks for map->groups->machine
Date:   Thu,  7 Nov 2019 15:59:55 -0300
Message-Id: <20191107190011.23924-48-acme@kernel.org>
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

Its sufficient to check if map->groups is NULL before using it to get
->machine value.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-utiepyiv8b1tf8f79ok9d6j8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a4bd61cbc2a0..4ad39cc6368d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1617,7 +1617,7 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (map->groups && map->groups->machine)
+	if (map->groups)
 		machine = map->groups->machine;
 	else
 		machine = NULL;
-- 
2.21.0

