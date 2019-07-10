Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C7C004EF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6D220844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfGJI7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:59:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:35463 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGJI7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102495"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:22 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] perf db-export: Comm tidy-up and export switch events
Date:   Wed, 10 Jul 2019 11:57:49 +0300
Message-Id: <20190710085810.1650-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches that tidy up the export of comms and then add the
export of switch information. Switch information provides a simple way to
get an overview of activity.

The first 7 patches are tidy-up:

      perf db-export: Get rid of db_export__deferred()
      perf db-export: Rename db_export__comm() to db_export__exec_comm()
      perf db-export: Pass main_thread to db_export__thread()
      perf db-export: Export main_thread in db_export__sample()
      perf db-export: Export comm before exporting thread
      perf db-export: Move export__comm_thread into db_export__sample()
      perf db-export: Fix a white space issue in db_export__sample()

Then there are 3 to export more comm details:

      perf db-export: Export comm details
      perf scripts python: export-to-sqlite.py: Export comm details
      perf scripts python: export-to-postgresql.py: Export comm details

Then there are 6 relating to exporting a thread's current comm:

      perf db-export: Factor out db_export__comm()
      perf db-export: Also export thread's current comm
      perf scripts python: export-to-sqlite.py: Add has_calls column to comms table
      perf scripts python: export-to-postgresql.py: Add has_calls column to comms table
      perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons
      perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column

Finally there are 5 to export switch events:

      perf script: Add scripting operation process_switch()
      perf db-export: Factor out db_export__threads()
      perf db-export: Export switch events
      perf scripts python: export-to-sqlite.py: Export switch events
      perf scripts python: export-to-postgresql.py: Export switch events


Adrian Hunter (21):
      perf db-export: Get rid of db_export__deferred()
      perf db-export: Rename db_export__comm() to db_export__exec_comm()
      perf db-export: Pass main_thread to db_export__thread()
      perf db-export: Export main_thread in db_export__sample()
      perf db-export: Export comm before exporting thread
      perf db-export: Move export__comm_thread into db_export__sample()
      perf db-export: Fix a white space issue in db_export__sample()
      perf db-export: Export comm details
      perf scripts python: export-to-sqlite.py: Export comm details
      perf scripts python: export-to-postgresql.py: Export comm details
      perf db-export: Factor out db_export__comm()
      perf db-export: Also export thread's current comm
      perf scripts python: export-to-sqlite.py: Add has_calls column to comms table
      perf scripts python: export-to-postgresql.py: Add has_calls column to comms table
      perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons
      perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column
      perf script: Add scripting operation process_switch()
      perf db-export: Factor out db_export__threads()
      perf db-export: Export switch events
      perf scripts python: export-to-sqlite.py: Export switch events
      perf scripts python: export-to-postgresql.py: Export switch events

 tools/perf/builtin-script.c                        |   8 +-
 tools/perf/scripts/python/export-to-postgresql.py  |  68 ++++-
 tools/perf/scripts/python/export-to-sqlite.py      |  54 +++-
 tools/perf/scripts/python/exported-sql-viewer.py   |  34 ++-
 tools/perf/util/db-export.c                        | 291 +++++++++++++--------
 tools/perf/util/db-export.h                        |  19 +-
 .../util/scripting-engines/trace-event-python.c    |  53 +++-
 tools/perf/util/trace-event.h                      |   3 +
 8 files changed, 392 insertions(+), 138 deletions(-)


Regards
Adrian
