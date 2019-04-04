Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFBBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC8E2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369232;
	bh=3WYLRSi+nZQj0By4r+xUT2/sDNilbdG7NMqYCEmxrTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sz+BgXwFbhBuwHyKfv87F/v5hXDXr/WbNxBshdZ5tSfmAko6rVvSzrt3sBmp/m0NG
	 jq1nhXHa83Uk+AyQZ+3oodTVnMIXICu1eM2Nn3krn16FFACCAu62k3gXLFQAjSh0X1
	 hj/EjeEp/QppSN1ezJO9Yjq9w5EpEzJhO07hpd20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfDDJNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387613AbfDDJNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57F52054F;
        Thu,  4 Apr 2019 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369226;
        bh=3WYLRSi+nZQj0By4r+xUT2/sDNilbdG7NMqYCEmxrTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnTJxCcelHTa+Vamw6ioY+5orBjbhiOPgLRN6ZK7jOySDsv5xs8hzOla92UNQzdH6
         JmXcZ7STuLS68YwWx5/VQJya13wHTZlH46kSXU0OyJepNyEvoeTJZDUJEBtBJ88MXZ
         0JyMVCpozOuskCaOekLu46XJbfX/Iip4JWaPpMxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 131/246] tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
Date:   Thu,  4 Apr 2019 10:47:11 +0200
Message-Id: <20190404084623.743798071@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aa8f9c517ebce7a0959da064ef2660ea03f133f8 ]

Since we need it to resolve the AIO symbols, otherwise we fail with:

  $ cat /tmp/build/perf/feature/test-all.make.output
  /usr/bin/ld: /tmp/ccEqrj36.o: undefined reference to symbol 'aio_return64@@GLIBC_2.2.5'
  /usr/bin/ld: //usr/lib64/librt.so.1: error adding symbols: DSO missing from command line
  collect2: error: ld returned 1 exit status
  $

When we added the aio support in 'perf record' only the test-libaio.bin
target got the -lrt, i.e. the feature detection slow path. Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 2a07d814747b ("tools build feature: Check if libaio is available")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88cafa1..e6360d47e73a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -218,6 +218,8 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 FEATURE_CHECK_CFLAGS-libpython-version := $(PYTHON_EMBED_CCOPTS)
 FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
+FEATURE_CHECK_LDFLAGS-libaio = -lrt
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables
-- 
2.19.1



