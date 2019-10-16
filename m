Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C60DECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9AE20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263208;
	bh=NA5sy7uLif2TDblpX2/ruEnix2VOEuhXrq7hRlnEMZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K13QCIM5MnVwAA5DRuPpO6wlVkx3kUl2AHYpCYroREbyadZk3bHlP/BHbPDgt4tSo
	 cm4mAbBY3n5wo39bndSS9jiek07G54vSxULSuDFoNdo7uCjjZMoIS6h12vpqngpHg+
	 K1xnm4y8JozZt7B9mNlXDj2tuZNHnDOIJldufOTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438703AbfJPWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438368AbfJPV7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:59:02 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29851222BD;
        Wed, 16 Oct 2019 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263142;
        bh=NA5sy7uLif2TDblpX2/ruEnix2VOEuhXrq7hRlnEMZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLEy2D7LoU9ekO/vBc55EnfUqpZ/HtE9xxBm4ao01Bai1sEg6Sq3+aQHNBFzlWuD7
         MQTYhVeqdbIQ575mTzr//IU7YjyhYrZGOWUUfvXe56WOuJT+VDJFreG86ITtkYg+0H
         QHp15a3K96tioWz8+zOH62u4bbAx5DtxjjWyFx1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.3 066/112] perf llvm: Dont access out-of-scope array
Date:   Wed, 16 Oct 2019 14:50:58 -0700
Message-Id: <20191016214902.131334634@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

commit 7d4c85b7035eb2f9ab217ce649dcd1bfaf0cacd3 upstream.

The 'test_dir' variable is assigned to the 'release' array which is
out-of-scope 3 lines later.

Extend the scope of the 'release' array so that an out-of-scope array
isn't accessed.

Bug detected by clang's address sanitizer.

Fixes: 07bc5c699a3d ("perf tools: Make fetch_kernel_version() publicly available")
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/20190926220018.25402-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/llvm-utils.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -231,14 +231,14 @@ static int detect_kbuild_dir(char **kbui
 	const char *prefix_dir = "";
 	const char *suffix_dir = "";
 
+	/* _UTSNAME_LENGTH is 65 */
+	char release[128];
+
 	char *autoconf_path;
 
 	int err;
 
 	if (!test_dir) {
-		/* _UTSNAME_LENGTH is 65 */
-		char release[128];
-
 		err = fetch_kernel_version(NULL, release,
 					   sizeof(release));
 		if (err)


