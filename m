Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9355C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D043229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996529;
	bh=9T3ggQroFXS+ozFglygL7PVZfvxOBqLm3bkcwDSiRos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lUeUfbqv7banaiId3aqaVfOOHc385MqChoDdr/iKO17y15ch1nNw6qsWWA5uG0NfS
	 D+rpafzek1LcpRyrzz7JDQ6H4GudS3mjM3Aj7tVJ0JhuybP6Ovbdf8+ezPQyIU7j9Z
	 FfJC69f27Y4gD6SnEVC/UQdPdD52uR+y4OviHSkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfGXT2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbfGXT2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:28:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EF721951;
        Wed, 24 Jul 2019 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996525;
        bh=9T3ggQroFXS+ozFglygL7PVZfvxOBqLm3bkcwDSiRos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fq39ZxkryQRgm1CwOnDeXJb+4KAd0c3uZtH2THMxwYS4dU4KutakBk6PprZVyLnEY
         pQTtoypUKIqIaPLGblUQqHN+9I1litX7h3N5Vyt9PCPmoLLORKSZV4ZUljIJMHRJvU
         vjAgLeI3oZssJ8hlMZHbRd4tZ/4MJF1HL1nkFjTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 120/413] tools build: Fix the zstd test in the test-all.c common case feature test
Date:   Wed, 24 Jul 2019 21:16:51 +0200
Message-Id: <20190724191743.821939385@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3469fa84c1631face938efc42b3f488a2c2504e0 ]

We were renanimg 'main' to 'main_zstd' but then using 'main_libzstd();'
in the main() for test-all.c, causing this:

  $ cat /tmp/build/perf/feature/test-all.make.output
  test-all.c: In function ‘main’:
  test-all.c:236:2: error: implicit declaration of function ‘main_test_libzstd’; did you mean ‘main_test_zstd’? [-Werror=implicit-function-declaration]
    main_test_libzstd();
    ^~~~~~~~~~~~~~~~~
    main_test_zstd
  cc1: all warnings being treated as errors
  $

I.e. what was supposed to be the fast path feature test was _always_
failing, duh, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Fixes: 3b1c5d965971 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
Link: https://lkml.kernel.org/n/tip-ma4abk0utroiw4mwpmvnjlru@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/build/feature/test-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index a59c53705093..939ac2fcc783 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -182,7 +182,7 @@
 # include "test-disassembler-four-args.c"
 #undef main
 
-#define main main_test_zstd
+#define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
 
-- 
2.20.1



