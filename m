Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5FC20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552052873;
	bh=oGztcOjAhdQ2nrpNpnbciJeFaxjXVFPMlf4tVKl65E0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y1PmzMOpDDOzWRwlp77/wubA8hmS9mWR9+lWiw+sKHQCp6xs+GyPbz2ujwdd2Hiyj
	 /AlFfiIGh9uODM4yldz9GC3/7+1ig9+/lMnGTijSDX/UGbn88UNAmbhqvRKTigqY0i
	 iOIgaFgqttcvdyRvdn5/xWIvgo8FJA2LxrTGznQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfCHNrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:47:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfCHNrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1410A3092664;
        Fri,  8 Mar 2019 13:47:50 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E3305C1B4;
        Fri,  8 Mar 2019 13:47:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCHv5 00/11] perf record: Add support to store data in directory
Date:   Fri,  8 Mar 2019 14:47:34 +0100
Message-Id: <20190308134745.5057-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 08 Mar 2019 13:47:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset adds the --dir option to record command (and all
the other record command that overload cmd_record) that allows
the data to be stored in directory with multiple data files.

It's next step for multiple threads implementation in record.
It's now possible to make directory data via --dir option, like:

  $ perf record --dir perf bench sched messaging
  $ ls -l perf.data
  total 344
  -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
  -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
  -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
  -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
  -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
  -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
  -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
  -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7
  -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header

There's a data file created for every cpu and it's storing
data for those cpu maps. The report command will read it
transparently, sort it and display as single file data.

There's new DIR_FORMAT feature to describe directory data
layout/format. In future we can describe different data files
layout according to special needs.

It's possible to transform directory data into standard
perf.data file via simple inject command:
    
  $ perf inject -o perf.data.file -i perf.data

The old perf fails over the directory data with following message:
  $ perf report
  incompatible file format (rerun with -v to learn more)

I'm now testing the record threads support, so I'd like to
have some agreement on the directory data support before.

v5 changes:
  - rebased to latest Arnaldo's perf/core

v4 changes:
  - some of the patches already taken
  - removing up perf.data directory on perf_data__open
    error path

v3 changes:
  - add rm_rf_perf_data to safely remove file/directory perf data
  - allocation fix in perf_data__create_dir

v2 changes:
  - rm_rf changes are already accepted with requested changes
  - updated doc/man plus adding perf.data-directory-format.txt
    to describe directory format/layout
  - the --switch-output options now works over directory data
  - data rollback is not part of this patchset, updated my TODO though ;-)
  - added --output-dir option to combine -o and --dir
  - added DIR_FORMAT feature to describe directory data
  - disabling directory output for aio for now

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/dir

thanks,
jirka


---
Jiri Olsa (11):
      perf data: Add directory support
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir function
      perf data: Make perf_data__size to work over directory
      perf header: Add DIR_FORMAT feature to describe directory data
      perf session: Add process callback to reader object
      perf session: Add __perf_session__process_dir_events function
      perf session: Add path to reader object
      perf record: Add --dir option to store data in directory
      perf record: Add --output-dir option to store data in directory
      perf record: Describe perf.data directory format

 tools/lib/subcmd/parse-options.h                        |   4 ++++
 tools/perf/Documentation/perf-record.txt                |   6 ++++++
 tools/perf/Documentation/perf.data-directory-format.txt |  54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-record.c                             |  95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/data.c                                  |  96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/data.h                                  |  12 ++++++++----
 tools/perf/util/header.c                                |  44 +++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h                                |   5 +++++
 tools/perf/util/mmap.h                                  |  23 ++++++++++++-----------
 tools/perf/util/session.c                               | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 10 files changed, 430 insertions(+), 34 deletions(-)
 create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt
