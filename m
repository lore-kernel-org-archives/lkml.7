Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3221019
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980695;
	bh=Usuot9RGkNNbsEIvSvKoOl2tOjJ5kLruZsEODHQ2C/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lb16C927RtlYkPygsJYKl/Kyq9ZX727AEpebksvvy2YdiieXqxMDcUwhKFyqEB2SR
	 1vSFWHhBHEyREpOclH1C/tH7unwDUF1QD/3wyD//BYg3IEAOgfwXaZTokoIY23Uv5E
	 WOdH31Aa90WK+f5vkqt5FseXuiDkVf2Y0ZHvqZV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCGRoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfCGRow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:44:52 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECEB20854;
        Thu,  7 Mar 2019 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980691;
        bh=Usuot9RGkNNbsEIvSvKoOl2tOjJ5kLruZsEODHQ2C/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCzKRssJ16maI+SUIKhDZYedK+DT0dJOaFG17Fhgr+VX3ZAg/y0Bi7kBZrUkk8DmJ
         k0Y3qkAXfN9lT6vPonb79BRiSNZFB/xXLprJ7ym/kQiZqGr47ShyJ66G130JvuVi7N
         kmyY/zlwklByATWxjVt8yq8gzayXK+6Urp+cQekk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        netdev@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/35] perf, bpf: Consider events with attr.bpf_event as side-band events
Date:   Thu,  7 Mar 2019 14:43:59 -0300
Message-Id: <20190307174433.28819-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Events with attr.bpf_event set should be considered as side-band events,
as they carry information about BPF programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
Link: http://lkml.kernel.org/r/20190226002019.3748539-2-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..dd9698ad3d66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4238,7 +4238,8 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch)
+	    attr->context_switch ||
+	    attr->bpf_event)
 		return true;
 	return false;
 }
-- 
2.20.1

