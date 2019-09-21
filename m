Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E7CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDF62086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569069773;
	bh=gQXVQJ/NlVmpWr450yV++iCsAk4StET/GO+VaP6Cy6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oCUfejoRVuNKOkQphGbnzIYiTXW4t7tfx7klgMw2M07CVSyD07c1vKZPqOBF13ho+
	 ylgZZ0VHUYdchQ8DDYCvI3ZbxgHGBwWSZkOM2SsodO0LG9+O2he5eil57YRFFuAQNj
	 J2uIjmeF3GCWFzBub77ViypOcWunKTEPN4YyR1H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407641AbfIUMmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 08:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407592AbfIUMmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 08:42:52 -0400
Received: from quaco.ghostprotocols.net (user.186-235-137-39.acesso10.net.br [186.235.137.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B325218AE;
        Sat, 21 Sep 2019 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569069771;
        bh=gQXVQJ/NlVmpWr450yV++iCsAk4StET/GO+VaP6Cy6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFglO/igycgdzN3uyrLK4JWsJoJfTNQlQ3acCqqXrDsjjKHHJRs6Tx7wmOAhAikZf
         4X322rpnG0jRgzNOqhuk5YSUAEiF05rrGt77j0+1XofekQXScwSahDGwsv6l2v50dp
         g3TWig88Z1fx4v4/q3S8NmBl4huOU6KdIBTfNjsg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/10] perf tests: Fix static build test
Date:   Sat, 21 Sep 2019 09:42:31 -0300
Message-Id: <20190921124240.15741-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Disable the potentional shared library features, which breaks static
build if they are enabled and detected: jvmti and vdso libraries.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190905090924.GA1949@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6b3afed5d910..c850d1664c56 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -100,7 +100,7 @@ make_install_info   := install-info
 make_install_pdf    := install-pdf
 make_install_prefix       := install prefix=/tmp/krava
 make_install_prefix_slash := install prefix=/tmp/krava/
-make_static         := LDFLAGS=-static
+make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
 
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
-- 
2.21.0

