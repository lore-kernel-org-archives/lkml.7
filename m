Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62582C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342F921881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zFMci2Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfGCOMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:12:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfGCOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:12:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EC1UL3321878
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:12:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EC1UL3321878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163121;
        bh=clgwfR70k3CRMS8eNuSd1/twSx97ptGN0/tJ30tFoEs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=zFMci2Dv50100H6uproXk9+mlSgpRfjHrmAc4RHcFSwn6pMpru9VISuj9OD9GnuqG
         BlLTcBHjdlt46X16tSlz1Dmj0QQ2s1KGRi3SJhWRg56pqYI0/xkP/S6raeEBjzRPCf
         +bUdwamnq/YeMvlFIxo0W2F5HnvdodB6q9PaGTcvKbuy2zmBROODWtiAaZ4YfzzhLL
         w/460bSDps2jryiDzc1wYtNNtkGyI3VIXF0LA4CFqjaj/RIkuBbISGfiBk58epp3Gg
         fRratxN6pZHLykyRyEr6zed7yRZnsf8qwJe3u5SivqzxbSeEihQhT+e6PMWEfQxaaJ
         c2kVTuJfWvx/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EC0Qu3321875;
        Wed, 3 Jul 2019 07:12:00 -0700
Date:   Wed, 3 Jul 2019 07:12:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-347078mgj3d2jfygtxs4ntti@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools x86 machine: Add missing util.h to pick up
 'page_size'
Git-Commit-ID: af41949d9e022f4e37d476505e406c87479862ab
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af41949d9e022f4e37d476505e406c87479862ab
Gitweb:     https://git.kernel.org/tip/af41949d9e022f4e37d476505e406c87479862ab
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 18:01:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 18:01:47 -0300

tools x86 machine: Add missing util.h to pick up 'page_size'

We're getting it by sheer luck, add that util.h to get the 'page_size'
definition.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-347078mgj3d2jfygtxs4ntti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
index 4520ac53caa9..0e508f26f83a 100644
--- a/tools/perf/arch/x86/util/machine.c
+++ b/tools/perf/arch/x86/util/machine.c
@@ -3,6 +3,7 @@
 #include <linux/string.h>
 #include <stdlib.h>
 
+#include "../../util/util.h"
 #include "../../util/machine.h"
 #include "../../util/map.h"
 #include "../../util/symbol.h"
