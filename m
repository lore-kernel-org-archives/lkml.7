Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905D021882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153360;
	bh=A6Iql8N+O+m9il74NWzX9mn8QN23M1C9KgvywM+bUiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6DHwe2w0jr4GnPgRrAomZeINd86FEtJDgKyV1axccL1JW7kWFkFXC0WXlzhzbOK4
	 DudHbdDdCniHY57KZ+0Ht9OOHWGoKEi3V9QRYYbC8dc8KRFFsbrEnyd/VgYOb24Xh7
	 RUrLJmoHaTbowLFfpU9Q7i1W0ZWI4crIUoP6qK2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfKGTCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKGTCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:02:39 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBD121D79;
        Thu,  7 Nov 2019 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153358;
        bh=A6Iql8N+O+m9il74NWzX9mn8QN23M1C9KgvywM+bUiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJEAip5a08fu0sX4+ol2JPsm8VEJr+3cY+jRvz4RVgR0KGCh+3ZER823XrZ3jB5Dp
         KNxoX7m7yqiFhTI+4POe9D0Jr6MgIFgSUc7LpBj/A5SOUwomCWwZoZbl9hMHcrA1yN
         Yw+07y2NM3IbSsCTvZF4nYkz6b6RqibKARi71GNE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/63] perf kvm: Use evlist layer api when possible
Date:   Thu,  7 Nov 2019 15:59:22 -0300
Message-Id: <20191107190011.23924-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Lubashev <ilubashe@akamai.com>

No need for layer violations when a proper evlist api is available.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1571795693-23558-4-git-send-email-ilubashe@akamai.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 858da896b518..577af4f3297a 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -998,7 +998,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 			done = perf_kvm__handle_stdin();
 
 		if (!rc && !done)
-			err = fdarray__poll(fda, 100);
+			err = evlist__poll(kvm->evlist, 100);
 	}
 
 	evlist__disable(kvm->evlist);
-- 
2.21.0

