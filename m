Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB4BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695572189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977507;
	bh=63+L+OKkNZJVGDfsEWrzEa2eitTNyFAvfMLvvP3sHtU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N7QTTCU6MJ72EoWfMbs6CpFTByLHqQ8A8CcBihZQBNBVrBwrtrQ8nP5ukjWOkgekb
	 2Vmf8rBpOPKZ8RUjh/4qBysOxd3UIQLinjpSmiGsJlqqzIc1MKPTOecsvsybXiF88d
	 6uNouq1wEq3wZkv4HwWU4aO8iow1a6X8W4qWmPwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1Hbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:31:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37761 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1Hbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so970380pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jw139WFaeAYShaAhk+oJpGVRyFCodK4ai3MV6BKWou4=;
        b=Kt3+DJ8J+Fr3T0xBhUdquznIlnrXB68xxf4J2t2qmIIiREujIyovpMS5LesH63tH0k
         lkc3XuEXLtym3pHpGhBxwZrtSpjbFcFGUWrpwE3mH3y72uWZ/aUz5MRcBDGQhl+qaAeh
         TqnT01Je2hSBy4lB+CTnp/Yr2b8dT9+LKYx38kfWRqdRKDSQGEj9J1Yslc9N6dzBM71a
         I0dg4Woihgan8YLl/vh/A/krDRCsb73ATqtZZ7J6ge5IEi7mF2L5FUy5FwD0+gzG+fpR
         GPn8BgKqTt9REpfEnUQvEn2ddCFD8pEwSlQTz5a/Tqnu/nNUTVyO1nd0zDy559FklYJK
         tTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Jw139WFaeAYShaAhk+oJpGVRyFCodK4ai3MV6BKWou4=;
        b=jrDfj1QQYerlSPhdPiK5qUL7EvePLMSu9hwd51zro3xJYm7C0wgek9COXkSz+O+l/R
         2hLsDeXODONReRAKWtwwjITERfQYruS/EgPXps8c55ADEwwiTuFrgVKqciYVW/D1eNpB
         jdOsXYHfDqxObHkjJeype2nmJFW+X2m3FPyldSB3JkyM6gO2aw3vM8K1mpIzY74OdyjA
         PRrP4wtPQ8WeK+ESHW50MZjxOveu7L/pH5AHi2bmY0qNhgENe/aRuHSr2177atVugXoH
         6sCoG3U5f2teTLuueZTFupZnWaxfivLFrNwR4tmlP2Rl20z6H564OvgGLJ2ZnvahO5O2
         ZxSg==
X-Gm-Message-State: APjAAAWyjTqf2c+qOb7FtyUzchBn7FyuZAJ7iuKtYGbk1A0e2/XCiUnC
        WvLQGhHLTSeNLQzHLPnDhPbCzIhl
X-Google-Smtp-Source: APXvYqwSuG3S77/8vs6WkeMea0a3NeI1FvgaDibyD7E7YJzCbSENXRvUOCxSPmd9Hh4Ee5QNrURthg==
X-Received: by 2002:aa7:8b0f:: with SMTP id f15mr3033913pfd.235.1566977505293;
        Wed, 28 Aug 2019 00:31:45 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:31:44 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCHSET 0/9] perf: Improve cgroup profiling (v1)
Date:   Wed, 28 Aug 2019 16:31:21 +0900
Message-Id: <20190828073130.83800-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This work is to improve cgroup profiling in perf.  Currently it only
supports profiling tasks in a specific cgroup and there's no way to
identify which cgroup the current sample belongs to.  So I added
PERF_SAMPLE_CGROUP to add cgroup info into each sample.  It's a 64-bit
integer having inode number of the cgroup.  And kernel also generates
PERF_RECORD_CGROUP event for new groups to correlate the inode number
and cgroup name (path in the cgroup filesystem).  The inode number can
be read from userspace easily so it can synthesize the CGROUP event
for existing groups.

Note that this only works for "perf_event" cgroups (obviously) so if
users are still using cgroup-v1 interface, they need to have same
hierarchy for subsystem(s) want to profile with it.

The testing result looks something like this:

  [root@qemu build]# ./perf record --all-cgroups ./cgtest
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.009 MB perf.data (150 samples) ]
  
  [root@qemu build]# ./perf report -s cgroup,comm --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 150  of event 'cpu-clock:pppH'
  # Event count (approx.): 37500000
  #
  # Overhead  cgroup      Command
  # ........  ..........  .......
  #
      32.00%  /sub/cgrp2  looper2
      28.00%  /sub/cgrp1  looper1
      25.33%  /sub        looper0
       4.00%  /           cgtest 
       4.00%  /sub        cgtest 
       3.33%  /sub/cgrp2  cgtest 
       2.67%  /sub/cgrp1  cgtest 
       0.67%  /           looper0


The test program (cgtest) follows.

Thanks,
Namhyung


Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>


-------8<-----------------------------------------8<----------------
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <sys/mount.h>

char cgbase[] = "/sys/fs/cgroup/perf_event";

void mkcgrp(char *name) {
  char buf[256];

  snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
  if (mkdir(buf, 0755) < 0)
    perror("mkdir");
}

void rmcgrp(char *name) {
  char buf[256];

  snprintf(buf, sizeof(buf), "%s%s", cgbase, name);
  if (rmdir(buf) < 0)
    perror("rmdir");
}

void setcgrp(char *name) {
  char buf[256];
  int fd;

  snprintf(buf, sizeof(buf), "%s%s/tasks", cgbase, name);

  fd = open(buf, O_WRONLY);
  if (fd > 0) {
    if (write(fd, "0\n", 2) != 2)
      perror("write");
    close(fd);
  }
}

void create_sub_cgroup(int idx) {
  char buf[128];

  snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
  mkcgrp(buf);
}

void remove_sub_cgroup(int idx) {
  char buf[128];

  snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
  rmcgrp(buf);
}

void set_sub_cgroup(int idx) {
  char buf[128];

  snprintf(buf, sizeof(buf), "/sub/cgrp%d", idx);
  setcgrp(buf);
}

void set_task_name(int idx) {
  char buf[16];

  snprintf(buf, sizeof(buf), "looper%d", idx);
  prctl(PR_SET_NAME, buf, 0, 0, 0);
}

void loop(unsigned max) {
  volatile unsigned int count = 1;

  while (count++ != max) {
    asm volatile ("pause");
  }
}

void worker(int idx, unsigned cnt, int new_ns) {
  int oldns;

  create_sub_cgroup(idx);
  set_sub_cgroup(idx);

  if (new_ns) {
    if (unshare(CLONE_NEWCGROUP) < 0)
      perror("unshare");

#if 0  /* FIXME */
    if (unshare(CLONE_NEWNS) < 0)
      perror("unshare");

    if (mount("none", "/sys", NULL, MS_REMOUNT | MS_REC | MS_SLAVE, NULL) < 0)
      perror("mount --make-rslave");

    sleep(1);
    if (umount("/sys/fs/cgroup/perf_event") < 0)
      perror("umount");

    if (mount("cgroup", "/sys/fs/cgroup/perf_event", "cgroup",
              MS_NODEV | MS_NOEXEC | MS_NOSUID, "perf_event") < 0)
      perror("mount again");
#endif
  }

  if (fork() == 0) {
    set_task_name(idx);
    loop(cnt);
    exit(0);
  }
  wait(NULL);
}

int main(int argc, char *argv[])
{
  int i, nr = 2;
  int new_ns = 1;
  unsigned cnt = 1000000;
  int fd;

  if (argc > 1)
    nr = atoi(argv[1]);
  if (argc > 2)
    cnt = atoi(argv[2]);
  if (argc > 3)
    new_ns = atoi(argv[3]);

  mkcgrp("/sub");
  setcgrp("/sub");

  for (i = 0; i < nr; i++) {
    if (fork() == 0) {
      worker(i+1, cnt, new_ns);
      exit(0);
    }
  }

  set_task_name(0);
  loop(cnt);

  for (i = 0; i < nr; i++)
    wait(NULL);

  for (i = 0; i < nr; i++)
    remove_sub_cgroup(i+1);

  setcgrp("/");
  rmcgrp("/sub");

  return 0;
}
-------8<-----------------------------------------8<----------------


Namhyung Kim (9):
  perf/core: Add PERF_RECORD_CGROUP event
  perf/core: Add PERF_SAMPLE_CGROUP feature
  perf tools: Basic support for CGROUP event
  perf tools: Maintain cgroup hierarchy
  perf report: Add 'cgroup' sort key
  perf record: Support synthesizing cgroup events
  perf record: Add --all-cgroups option
  perf top: Add --all-cgroups option
  perf script: Add --show-cgroup-events option

 include/linux/perf_event.h               |   1 +
 include/uapi/linux/perf_event.h          |  18 ++-
 kernel/events/core.c                     | 128 ++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h    |  17 ++-
 tools/perf/Documentation/perf-record.txt |   5 +-
 tools/perf/Documentation/perf-report.txt |   1 +
 tools/perf/Documentation/perf-script.txt |   3 +
 tools/perf/Documentation/perf-top.txt    |   4 +
 tools/perf/builtin-diff.c                |   1 +
 tools/perf/builtin-record.c              |  10 ++
 tools/perf/builtin-report.c              |   1 +
 tools/perf/builtin-script.c              |  41 +++++++
 tools/perf/builtin-top.c                 |   9 ++
 tools/perf/lib/include/perf/event.h      |   7 ++
 tools/perf/util/cgroup.c                 |  75 ++++++++++++-
 tools/perf/util/cgroup.h                 |  16 ++-
 tools/perf/util/event.c                  | 133 +++++++++++++++++++++++
 tools/perf/util/event.h                  |  11 ++
 tools/perf/util/evsel.c                  |  12 ++
 tools/perf/util/hist.c                   |   7 ++
 tools/perf/util/hist.h                   |   1 +
 tools/perf/util/machine.c                |  19 ++++
 tools/perf/util/machine.h                |   3 +
 tools/perf/util/record.h                 |   1 +
 tools/perf/util/session.c                |   8 ++
 tools/perf/util/sort.c                   |  31 ++++++
 tools/perf/util/sort.h                   |   2 +
 tools/perf/util/tool.h                   |   2 +
 28 files changed, 556 insertions(+), 11 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

