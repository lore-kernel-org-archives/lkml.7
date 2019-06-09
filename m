Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F07CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8D206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099605;
	bh=ZcLssnyOfkxmB9qyxEeI2BuQ1gjRBtkNZDE8hNOJYnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aYyMsoNsnwJ4hQhuKboa4Nl1LJMRLcw8qVioNpodwE4uNjkMoJ0L3zX3K8Jz8ikmO
	 LRoUGO9aVxjHXhDYq2//lheoHpHOz0cV2LopJ1QJV7UPq02BWPy0U5fR0o2VB4W6aS
	 qoM1eptCDuFZ+Ayxa6kHTrjoqx+D3caTohmHHLqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfFIRAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbfFIRAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:00:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A574204EC;
        Sun,  9 Jun 2019 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099600;
        bh=ZcLssnyOfkxmB9qyxEeI2BuQ1gjRBtkNZDE8hNOJYnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOYFAB0pWJoWnCGYLoO0izIewVkhzS2NAFNjC8m6kS5o2Nz2sJOf6BUQRT/ByrLGP
         ZHLwRGrU1HN55oja31fHsQ0nFN+yopBFynIb20hZGPTW24d68U39vwLB6ef7ixczDI
         2PCfjqL7rsfnvrAAbKB64z5dMX+tdLhFZc4pJ2QE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 091/241] perf tools: No need to include bitops.h in util.h
Date:   Sun,  9 Jun 2019 18:40:33 +0200
Message-Id: <20190609164150.412945999@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 6dcca6df4b73d409628c7b4464c63d4eb9d4d13a upstream.

When we switched to the kernel's roundup_pow_of_two we forgot to remove
this include from util.h, do it now.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 91529834d1de ("perf evlist: Use roundup_pow_of_two")
Link: http://lkml.kernel.org/n/tip-kfye5rxivib6155cltx0bw4h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[bwh: Backported to 4.4 as dependency of "tools include: Adopt linux/bits.h":
 - Include <linux/compiler.h> in util/string.c to avoid build regression
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/string.c |    1 +
 tools/perf/util/util.h   |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -1,4 +1,5 @@
 #include "util.h"
+#include <linux/compiler.h>
 #include "linux/string.h"
 
 #define K 1024LL
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -76,7 +76,6 @@
 #include <sys/ttydefaults.h>
 #include <api/fs/tracing_path.h>
 #include <termios.h>
-#include <linux/bitops.h>
 #include <termios.h>
 
 extern const char *graph_line;


