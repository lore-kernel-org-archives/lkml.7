Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9C2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60D320882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437231AbfITGIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:08:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408276AbfITGIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:08:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92C6F238268DF2A63800;
        Fri, 20 Sep 2019 14:08:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:43 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH 00/32] Kill pr_warning in the whole linux code
Date:   Fri, 20 Sep 2019 14:25:12 +0800
Message-ID: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are pr_warning and pr_warng to show WARNING level message,             
most of the code using pr_warn, number based on next-20190919,
                                                                             
pr_warn: 5189   pr_warning: 546 (tools: 398, others: 148)                    
                                                                             
Joe Perches posted a patch, commit f2c2cbcc35d4 ("powerpc: Use               
pr_warn instead of pr_warning"), which is beginning to remove                
pr_warning, so all logging messages use a consistent pr_warn                 
style once pr_warning removed, and checkpatch also sugguests                 
that better to use pr_warn instead of pr_warning.                            
                                                                             
Let's carry on with the work to standardize the logging macro,               
kill pr_warning in the whole linux code.                                     
                                                                             
Note, for tools api/bpf/perf part, rename pr_warning to pr_warn              
to keep the consistence, with this patchset,                                 
                                                                             
pr_warn: 5730   pr_warning: 0                                                
                                                                             
Miscellanea:                                                                 
o Coalesce formats                                                           
o Realign arguments                                                          
o Remove unnecessary line continuations                                      

Kefeng Wang (32):
  alpha: Use pr_warn instead of pr_warning
  arm64: Use pr_warn instead of pr_warning
  ia64: Use pr_warn instead of pr_warning
  riscv: Use pr_warn instead of pr_warning
  sh: Use pr_warn instead of pr_warning
  sparc: Use pr_warn instead of pr_warning
  x86: Use pr_warn instead of pr_warning
  acpi: Use pr_warn instead of pr_warning
  drbd: Use pr_warn instead of pr_warning
  gdrom: Use pr_warn instead of pr_warning
  clocksource: samsung_pwm_timer: Use pr_warn instead of pr_warning
  crypto: n2: Use pr_warn instead of pr_warning
  ide: Use pr_warn instead of pr_warning
  idsn: Use pr_warn instead of pr_warning
  macintosh: Use pr_warn instead of pr_warning
  of: Use pr_warn instead of pr_warning
  oprofile: Use pr_warn instead of pr_warning
  platform/x86: Use pr_warn instead of pr_warning
  scsi: Use pr_warn instead of pr_warning
  sh/intc: Use pr_warn instead of pr_warning
  staging: Use pr_warn instead of pr_warning
  fs: afs: Use pr_warn instead of pr_warning
  vgacon: Use pr_warn instead of pr_warning
  dma-debug: Use pr_warn instead of pr_warning
  trace: Use pr_warn instead of pr_warning
  lib: cpu_rmap: Use pr_warn instead of pr_warning
  ASoC: samsung: Use pr_warn instead of pr_warning
  printk: Drop pr_warning
  tools lib api: Renaming pr_warning to pr_warn
  tools lib bpf: Renaming pr_warning to pr_warn
  tools perf: Renaming pr_warning to pr_warn
  checkpatch: Drop pr_warning check

 arch/alpha/kernel/perf_event.c            |   4 +-
 arch/arm64/kernel/hw_breakpoint.c         |   8 +-
 arch/arm64/kernel/smp.c                   |  11 +-
 arch/ia64/kernel/setup.c                  |   2 +-
 arch/riscv/kernel/module.c                |   4 +-
 arch/sh/boards/mach-sdk7786/nmi.c         |   2 +-
 arch/sh/drivers/pci/fixups-sdk7786.c      |   2 +-
 arch/sh/kernel/io_trapped.c               |   2 +-
 arch/sh/kernel/setup.c                    |   2 +-
 arch/sh/mm/consistent.c                   |   5 +-
 arch/sparc/kernel/smp_64.c                |   6 +-
 arch/x86/kernel/amd_gart_64.c             |  11 +-
 arch/x86/kernel/apic/apic.c               |  41 +-
 arch/x86/kernel/setup_percpu.c            |   4 +-
 arch/x86/kernel/tboot.c                   |  15 +-
 arch/x86/kernel/tsc_sync.c                |   8 +-
 arch/x86/kernel/umip.c                    |   6 +-
 arch/x86/mm/kmmio.c                       |   7 +-
 arch/x86/mm/mmio-mod.c                    |   6 +-
 arch/x86/mm/numa_emulation.c              |   4 +-
 arch/x86/mm/testmmiotrace.c               |   6 +-
 arch/x86/oprofile/op_x86_model.h          |   6 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c    |   2 +-
 arch/x86/platform/sfi/sfi.c               |   3 +-
 arch/x86/xen/setup.c                      |   2 +-
 drivers/acpi/apei/apei-base.c             |  36 +-
 drivers/acpi/apei/einj.c                  |   4 +-
 drivers/acpi/apei/erst-dbg.c              |   5 +-
 drivers/acpi/apei/ghes.c                  |  25 +-
 drivers/acpi/apei/hest.c                  |  14 +-
 drivers/acpi/battery.c                    |   2 +-
 drivers/acpi/resource.c                   |   4 +-
 drivers/block/drbd/drbd_nl.c              |  13 +-
 drivers/cdrom/gdrom.c                     |   4 +-
 drivers/clocksource/samsung_pwm_timer.c   |   2 +-
 drivers/crypto/n2_core.c                  |  12 +-
 drivers/ide/tx4938ide.c                   |   2 +-
 drivers/ide/tx4939ide.c                   |   6 +-
 drivers/isdn/hardware/mISDN/avmfritz.c    |  16 +-
 drivers/isdn/hardware/mISDN/hfcmulti.c    |   8 +-
 drivers/isdn/hardware/mISDN/hfcpci.c      |   3 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c     |   4 +-
 drivers/isdn/hardware/mISDN/mISDNipac.c   |   4 +-
 drivers/isdn/hardware/mISDN/mISDNisar.c   |  10 +-
 drivers/isdn/hardware/mISDN/netjet.c      |   8 +-
 drivers/isdn/hardware/mISDN/w6692.c       |  12 +-
 drivers/isdn/mISDN/hwchannel.c            |   7 +-
 drivers/macintosh/windfarm_fcu_controls.c |   4 +-
 drivers/macintosh/windfarm_lm87_sensor.c  |   4 +-
 drivers/macintosh/windfarm_pm72.c         |  22 +-
 drivers/macintosh/windfarm_rm31.c         |   6 +-
 drivers/of/fdt.c                          |  20 +-
 drivers/oprofile/oprofile_perf.c          |   8 +-
 drivers/platform/x86/asus-laptop.c        |   2 +-
 drivers/platform/x86/eeepc-laptop.c       |   2 +-
 drivers/platform/x86/intel_oaktrail.c     |  10 +-
 drivers/scsi/a3000.c                      |   2 +-
 drivers/sh/intc/core.c                    |   4 +-
 drivers/staging/isdn/gigaset/interface.c  |   2 +-
 drivers/video/console/vgacon.c            |   6 +-
 fs/afs/flock.c                            |   4 +-
 fs/afs/inode.c                            |  13 +-
 fs/afs/yfsclient.c                        |   4 +-
 include/linux/printk.h                    |   3 +-
 kernel/dma/debug.c                        |   2 +-
 kernel/trace/trace_benchmark.c            |   4 +-
 lib/cpu_rmap.c                            |   2 +-
 scripts/checkpatch.pl                     |   9 -
 sound/soc/samsung/s3c-i2s-v2.c            |   6 +-
 tools/lib/api/debug-internal.h            |   4 +-
 tools/lib/api/debug.c                     |   4 +-
 tools/lib/api/fs/fs.c                     |   4 +-
 tools/lib/bpf/btf.c                       |  56 +-
 tools/lib/bpf/btf_dump.c                  |  20 +-
 tools/lib/bpf/libbpf.c                    | 652 +++++++++++-----------
 tools/lib/bpf/libbpf_internal.h           |   2 +-
 tools/lib/bpf/xsk.c                       |   4 +-
 tools/perf/arch/x86/util/intel-pt.c       |   2 +-
 tools/perf/builtin-annotate.c             |   7 +-
 tools/perf/builtin-buildid-cache.c        |  28 +-
 tools/perf/builtin-diff.c                 |  12 +-
 tools/perf/builtin-help.c                 |  10 +-
 tools/perf/builtin-inject.c               |   8 +-
 tools/perf/builtin-probe.c                |  14 +-
 tools/perf/builtin-record.c               |  10 +-
 tools/perf/builtin-report.c               |   2 +-
 tools/perf/builtin-script.c               |  14 +-
 tools/perf/builtin-stat.c                 |  18 +-
 tools/perf/builtin-timechart.c            |  12 +-
 tools/perf/builtin-top.c                  |   2 +-
 tools/perf/builtin-trace.c                |   8 +-
 tools/perf/lib/internal.h                 |   2 +-
 tools/perf/ui/browsers/scripts.c          |   2 +-
 tools/perf/util/bpf-loader.c              |   6 +-
 tools/perf/util/bpf-prologue.c            |   4 +-
 tools/perf/util/callchain.c               |   2 +-
 tools/perf/util/config.c                  |   8 +-
 tools/perf/util/data-convert-bt.c         |   4 +-
 tools/perf/util/data.c                    |   2 +-
 tools/perf/util/debug.c                   |   4 +-
 tools/perf/util/debug.h                   |   2 +-
 tools/perf/util/event.c                   |  14 +-
 tools/perf/util/evlist.c                  |   4 +-
 tools/perf/util/evsel.c                   |  19 +-
 tools/perf/util/header.c                  |  20 +-
 tools/perf/util/jitdump.c                 |   4 +-
 tools/perf/util/llvm-utils.c              |  18 +-
 tools/perf/util/machine.c                 |   2 +-
 tools/perf/util/parse-branch-options.c    |   3 +-
 tools/perf/util/perf-hooks.c              |   6 +-
 tools/perf/util/probe-event.c             |  90 +--
 tools/perf/util/probe-file.c              |  36 +-
 tools/perf/util/probe-finder.c            | 112 ++--
 tools/perf/util/record.c                  |  18 +-
 tools/perf/util/session.c                 |   2 +-
 tools/perf/util/srcline.c                 |   6 +-
 tools/perf/util/thread-stack.c            |   4 +-
 tools/perf/util/thread_map.c              |   2 +-
 tools/perf/util/trace-event-parse.c       |   2 +-
 tools/perf/util/unwind-libunwind-local.c  |   9 +-
 120 files changed, 882 insertions(+), 927 deletions(-)

-- 
2.20.1

