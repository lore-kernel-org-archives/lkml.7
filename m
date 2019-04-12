Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E29EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B5C2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555079025;
	bh=sW7WOurfN/YKudcZ91HQHnX7QRDGOs6xqKiD4zRjRWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lyu/wUmVqQJ64QpmsX0qzXf9w+iP6Wao6Vof3sU9iuQC8HasuY9lx+tTLFs/9DcGy
	 c4PG6o+UC71etWo8egbCQ7CFo8/vzoATprMYvvf3WUnFiMag7s84E/MCGdOCeVbWoO
	 2aPAVfqhAF7ty73dIqNi0Yj46ZXxe+mTFVbJoTqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfDLOXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfDLOXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:23:43 -0400
Received: from quaco.ghostprotocols.net (177-58-174-75.3g.claro.net.br [177.58.174.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CAA320850;
        Fri, 12 Apr 2019 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555079022;
        bh=sW7WOurfN/YKudcZ91HQHnX7QRDGOs6xqKiD4zRjRWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhR1j6xYCM2esj46M+CUouQcMWXnBd0aP5BpAZZxq7lEqm6Jrq36kbp251PBsWbJD
         hUaISWPRHDh1yZX5tOMfgVBjiDQ/FgdXTzGS7wWtSSxrilBODlnBUOypTC11vz3/MX
         7t+Cdw5/8bOlZgVn9HzcTRA6z/aWdoHpSocT15W4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/7] perf stat: Disable DIR_FORMAT feature for 'perf stat record'
Date:   Fri, 12 Apr 2019 11:22:48 -0300
Message-Id: <20190412142250.20595-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Arnaldo reported assertion in perf stat record:

  assertion failed at util/header.c:875

There's no support for this in the 'perf state record' command, disable
the feature for that case.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 258031c017c3 ("perf header: Add DIR_FORMAT feature to describe directory data")
Link: http://lkml.kernel.org/r/20190409100156.20303-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 49ee3c2033ec..c3625ec374e0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1308,6 +1308,7 @@ static void init_features(struct perf_session *session)
 	for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
 		perf_header__set_feat(&session->header, feat);
 
+	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
 	perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
 	perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
 	perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
-- 
2.20.1

