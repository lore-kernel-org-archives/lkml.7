Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F12C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC18207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfKYMga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:36:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:35022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfKYMg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:36:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4FA3AC9F;
        Mon, 25 Nov 2019 12:36:26 +0000 (UTC)
Date:   Mon, 25 Nov 2019 13:36:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.5
Message-ID: <20191125123625.ddtry6j75bfjrbvi@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.5


===========================

- Allow to print symbolic error names via new %pe modifier.

- Use pr_warn() instead of the remaining pr_warning() calls.
  Fix formatting of the related lines.

- Add VSPRINTF entry to MAINTAINERS.

===========================

There are 3 expected merge conflicts:

  + with 'AKPM' tree:
    + both trees add a new independent configure option in lib/Kconfig.debug

  + with 'pm' tree:
    + both trees add new independent printf selftest

    + 'printk' tree adds 'e' into 'extension' string;
      'pm' tree adds support to check the third letter
      and detect %pfw


----------------------------------------------------------------
Kefeng Wang (29):
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
      platform/x86: eeepc-laptop: Use pr_warn instead of pr_warning
      platform/x86: asus-laptop: Use pr_warn instead of pr_warning
      platform/x86: intel_oaktrail: Use pr_warn instead of pr_warning
      scsi: Use pr_warn instead of pr_warning
      sh/intc: Use pr_warn instead of pr_warning
      fs: afs: Use pr_warn instead of pr_warning
      vgacon: Use pr_warn instead of pr_warning
      dma-debug: Use pr_warn instead of pr_warning
      trace: Use pr_warn instead of pr_warning
      lib: cpu_rmap: Use pr_warn instead of pr_warning
      ASoC: samsung: Use pr_warn instead of pr_warning
      tools lib api: Renaming pr_warning to pr_warn

Petr Mladek (2):
      Merge branch 'for-5.5-pr-warn' into for-5.5
      MAINTAINERS: Add VSPRINTF

Rasmus Villemoes (1):
      printf: add support for printing symbolic error names

Uwe Kleine-König (1):
      checkpatch: don't warn about new vsprintf pointer extension '%pe'

 Documentation/core-api/printk-formats.rst |  12 ++
 MAINTAINERS                               |  12 ++
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
 arch/x86/kernel/amd_gart_64.c             |  12 +-
 arch/x86/kernel/apic/apic.c               |  41 +++---
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
 drivers/acpi/apei/apei-base.c             |  44 +++---
 drivers/acpi/apei/einj.c                  |   4 +-
 drivers/acpi/apei/erst-dbg.c              |   5 +-
 drivers/acpi/apei/ghes.c                  |  25 ++--
 drivers/acpi/apei/hest.c                  |  14 +-
 drivers/acpi/battery.c                    |   2 +-
 drivers/acpi/resource.c                   |   4 +-
 drivers/block/drbd/drbd_nl.c              |  13 +-
 drivers/cdrom/gdrom.c                     |   4 +-
 drivers/clocksource/samsung_pwm_timer.c   |   3 +-
 drivers/crypto/n2_core.c                  |  12 +-
 drivers/ide/tx4938ide.c                   |   2 +-
 drivers/ide/tx4939ide.c                   |   6 +-
 drivers/isdn/hardware/mISDN/avmfritz.c    |  16 +--
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
 drivers/macintosh/windfarm_pm72.c         |  22 +--
 drivers/macintosh/windfarm_rm31.c         |   6 +-
 drivers/of/fdt.c                          |  20 +--
 drivers/oprofile/oprofile_perf.c          |   8 +-
 drivers/platform/x86/asus-laptop.c        |   2 +-
 drivers/platform/x86/eeepc-laptop.c       |   2 +-
 drivers/platform/x86/intel_oaktrail.c     |  10 +-
 drivers/scsi/a3000.c                      |   2 +-
 drivers/sh/intc/core.c                    |   4 +-
 drivers/video/console/vgacon.c            |   6 +-
 fs/afs/flock.c                            |   4 +-
 fs/afs/inode.c                            |  13 +-
 fs/afs/yfsclient.c                        |   4 +-
 include/linux/errname.h                   |  16 +++
 kernel/dma/debug.c                        |   2 +-
 kernel/trace/trace_benchmark.c            |   4 +-
 lib/Kconfig.debug                         |   9 ++
 lib/Makefile                              |   1 +
 lib/cpu_rmap.c                            |   2 +-
 lib/errname.c                             | 223 ++++++++++++++++++++++++++++++
 lib/test_printf.c                         |  21 +++
 lib/vsprintf.c                            |  27 ++++
 scripts/checkpatch.pl                     |   2 +-
 sound/soc/samsung/s3c-i2s-v2.c            |   6 +-
 tools/lib/api/debug-internal.h            |   4 +-
 tools/lib/api/debug.c                     |   4 +-
 tools/lib/api/fs/fs.c                     |   4 +-
 78 files changed, 571 insertions(+), 269 deletions(-)
 create mode 100644 include/linux/errname.h
 create mode 100644 lib/errname.c
