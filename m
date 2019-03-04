Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A740FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7654A20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfCDNO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:14:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:47481 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfCDNO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:14:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 05:14:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="151870631"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2019 05:14:53 -0800
Subject: [PATCH] perf probe: Fix getting the kernel map
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com> <20190226142009.GC26786@kernel.org>
 <3b233ff2-e87a-1c61-d516-6c4cdecb4f01@intel.com>
 <8e798942-0e71-c88f-866f-88e55177e286@linux.alibaba.com>
 <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
 <ab136937-2af8-d3bc-634a-17d06c42a5c7@linux.alibaba.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2ed432de-e904-85d2-5c36-5897ddc5b23b@intel.com>
Date:   Mon, 4 Mar 2019 15:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ab136937-2af8-d3bc-634a-17d06c42a5c7@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4d99e4136580 ("perf machine: Workaround missing maps for x86
PTI entry trampolines"), perf tools has been creating more than one kernel
map, however 'perf probe' assumed there could be only one.

Fix by using machine__kernel_map() to get the main kernel map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/probe-event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e86f8be89157..6cd96f9b346d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -157,8 +157,10 @@ static struct map *kernel_get_module_map(const char *module)
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
-	if (!module)
-		module = "kernel";
+	if (!module) {
+		pos = machine__kernel_map(host_machine);
+		return map__get(pos);
+	}
 
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		/* short_name is "[module]" */
-- 
2.19.1

