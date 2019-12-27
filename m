Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12567C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EE020882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="zZHHlQae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfL0NFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:05:48 -0500
Received: from ms11p00im-qufo17281801.me.com ([17.58.38.55]:50028 "EHLO
        ms11p00im-qufo17281801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbfL0NFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1577451343; bh=ioN8aTVcTztS0k/o+gYtFU7PV4Hxo3SbxQ0MbxEyeHU=;
        h=From:To:Subject:Date:Message-Id;
        b=zZHHlQaeZvMyENCQcJtvQm7YEsI4/iZ1TQJ2KXSnKRlJg01O16MGB6TMuPbxvOc2A
         u2q624sRhcDR5toBq+yidTEFaidSMNSISLx4Z/36DVvwY+blSZ38U8cqVq4eXITyFP
         FJ0MWpIJvrdHCNGwB/fDvEzd7lcC35dzFSY5ovBh+gvzoI1HdTvnPRc2TqPJTGXZC9
         sipFc/Y19uekD3/sx+WOEptYdKwffaIuUDvANc89FOtAQ6Q6XnQwGWmy7keBF+QU4p
         wMAQ35N9dsWOsX16pf0sHCyf9u6JcKMdDbY1TYUCdLFrFCjNOK6qgo0wtcFbE3nYGP
         aic3PnGYyRq/g==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281801.me.com (Postfix) with ESMTPSA id 0B2C81005DA;
        Fri, 27 Dec 2019 12:55:42 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf vendor events amd: latest PMU events for zen1/zen2 
Date:   Fri, 27 Dec 2019 07:55:33 -0500
Message-Id: <20191227125536.1091387-1-vijaythakkar@me.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912270111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches brings the PMU events for AMD family 17h series
of processors up to date with the latest versions of the AMD processor
programming reference manuals.

The first patch changes the pmu events mapfile to be more selective for
the model number rather than blanket detecting all f17h processors to
have the same events directory. This is required for the later patch
where we add events for zen2 based processors.

The second patch adds the PMU events for zen2.

Finally the third patch updates the zen1 PMU events to be in accordance
with the latest PPR version and bumps up the events version to v2.

Vijay Thakkar (3):
  perf vendor events amd: restrict model detection for zen1 based
    processors
  perf vendor events amd: add Zen2 events
  perf vendor events amd: update Zen1 events to V2

 .../x86/{amdfam17h => amdzen1}/branch.json    |   0
 .../x86/{amdfam17h => amdzen1}/cache.json     |   0
 .../pmu-events/arch/x86/amdzen1/core.json     | 129 ++++++
 .../floating-point.json                       |  56 +++
 .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
 .../x86/{amdfam17h => amdzen1}/other.json     |   0
 .../pmu-events/arch/x86/amdzen2/branch.json   |  56 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 375 ++++++++++++++++++
 .../arch/x86/{amdfam17h => amdzen2}/core.json |   0
 .../arch/x86/amdzen2/floating-point.json      | 128 ++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 349 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 137 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
 13 files changed, 1251 insertions(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/core.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (63%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (93%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen2}/core.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.24.1

