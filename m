Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30170C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5C2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198873;
	bh=OBNQ/TWhknx53Y4e0SQtL38O30mzkQx+LTCNyVXyWSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g5vxoJvYUhJuSBhVzyMPxyfR52bcqjImCgkjOJHVy+q3a2n8DEY42lGwnStRrDwOg
	 MZ+TFBouEwE20T7sd3+213nNCa+I242YHVad/o8IIcs4QQ9tQVQ0+NOtTBt8RBZEuz
	 zniPFdfX13y2hQsGl5BwesHyLny3Lj9ipm1dtq7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfGONyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbfGONy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:54:29 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77DB52081C;
        Mon, 15 Jul 2019 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198868;
        bh=OBNQ/TWhknx53Y4e0SQtL38O30mzkQx+LTCNyVXyWSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGHCInWQcagB8AbAgd5e1dwYf2SIXdPaj3F8XQWI1WdKihdUQKmMV/u4seWISLmrS
         mvosTw36AYIHOsmvZDwh2HhM8Qf8JLrldI4Yz6MzZymSmfe5ojOQllokFBnvXB1SvW
         dTVwwlUW7/VUPJfeeO1xq6RLu6g9kjyKPwIYzW7E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 123/249] tools build: Fix the zstd test in the test-all.c common case feature test
Date:   Mon, 15 Jul 2019 09:44:48 -0400
Message-Id: <20190715134655.4076-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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

