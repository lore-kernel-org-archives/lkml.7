Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCA2C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1C82173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034434;
	bh=UlYKvOGtGTt17g3wOtIGwzWI9n/dKukFpkEWI2OHxlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unQKRMaUn29jKlONjAMwhj6HXpyStPgorPpqxmqbLSJiXSbEeMiWlXHKDPfl6xDhu
	 rgcjIMongkYL1LpIx23j9H+d+oocz0DDecJjjl49ZB/70FeShx57PL1KBFbYaUYCvW
	 jTxhpdjFAPSRx8GkP5YeuIRIggYXk/0vJQ3283ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfGBC1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfGBC1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAADC21841;
        Tue,  2 Jul 2019 02:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034428;
        bh=UlYKvOGtGTt17g3wOtIGwzWI9n/dKukFpkEWI2OHxlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2lbkTTXfjoWqgd0vCp8zwJnKBhULRobcY9dve80IRpAxMEUuKk8zADwiYtq02iju
         iKr7r7WEo9covJRy5R5kgCGAMf42DSBUbxK3/u52m6LVC9macLh4VCvZUr0FZh5em0
         FxlyGDEdaKOr6X2/CqeBSdRDSR316l8Yomqb2x+M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/43] perf ctype: Remove now unused 'spaces' variable
Date:   Mon,  1 Jul 2019 23:25:47 -0300
Message-Id: <20190702022616.1259-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We can left justify just fine using the 'field width' modifier in %s
printf, ditch this variable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2td8u86mia7143lbr5ttl0kf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ctype.c      | 4 ----
 tools/perf/util/sane_ctype.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index 8d90bf8d0d70..75c0da59c230 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -35,10 +35,6 @@ const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------";
-const char *spaces =
-	"                                                                     "
-	"                                                                     "
-	"                                                                     ";
 const char *dots =
 	"....................................................................."
 	"....................................................................."
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index 894594fdedfb..a2bb3890864f 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -3,7 +3,6 @@
 #define _PERF_SANE_CTYPE_H
 
 extern const char *graph_dotted_line;
-extern const char *spaces;
 extern const char *dots;
 
 /* Sane ctype - no locale, and works with signed chars */
-- 
2.20.1

