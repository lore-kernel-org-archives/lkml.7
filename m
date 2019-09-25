Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39CC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E150B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633738AbfIYCDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:03:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:32026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394649AbfIYCDR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:03:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 19:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; 
   d="scan'208";a="213896585"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2019 19:03:14 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Date:   Wed, 25 Sep 2019 10:02:16 +0800
Message-Id: <20190925020218.8288-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series supports the new options "--all-kernel" and "--all-user"
in perf-stat.

For example,

root@kbl:~# perf stat -e cycles,instructions --all-kernel --all-user -a -- sleep 1

 Performance counter stats for 'system wide':

        19,156,665      cycles:k
         7,265,342      instructions:k            #    0.38  insn per cycle
     4,511,186,293      cycles:u
       121,881,436      instructions:u            #    0.03  insn per cycle

       1.001153540 seconds time elapsed


 root@kbl:~# perf stat -a --topdown --all-kernel -- sleep 1

 Performance counter stats for 'system wide':

                                  retiring:k    bad speculation:k     frontend bound:k      backend bound:k
S0-D0-C0           2                 7.6%                 1.8%                40.5%                50.0%
S0-D0-C1           2                15.4%                 3.4%                14.4%                66.8%
S0-D0-C2           2                15.8%                 5.1%                26.9%                52.2%
S0-D0-C3           2                 5.7%                 5.7%                46.2%                42.4%

       1.000771709 seconds time elapsed

More detail information are in the patch descriptions.

Jin Yao (2):
  perf stat: Support --all-kernel and --all-user options
  perf stat: Support topdown with --all-kernel/--all-user

 tools/perf/Documentation/perf-record.txt |   3 +-
 tools/perf/Documentation/perf-stat.txt   |   7 +
 tools/perf/builtin-stat.c                | 200 ++++++++++++++++++++++-
 tools/perf/util/stat-shadow.c            | 167 ++++++++++++++-----
 tools/perf/util/stat.h                   |  23 +++
 5 files changed, 353 insertions(+), 47 deletions(-)

-- 
2.17.1

