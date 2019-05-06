Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA39AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A52082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEFKzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:55:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfEFKzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:55:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F8A3AE1D;
        Mon,  6 May 2019 10:55:06 +0000 (UTC)
Date:   Mon, 6 May 2019 12:55:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.2
Message-ID: <20190506105505.asfh2spqa4qairng@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.2

==================

- Allow to reset state of printk_once() calls.

- Prevent crashes when dereferencing invalid pointers in vsprintf().
  Only first byte is checked for simplicity.

- Make vsprintf warnings consistent and inlined.

- Treewide conversion of obsolete %pf, %pF to %ps, %pF printf modifiers.

- Some clean up of vsprintf and test_printf code.

===================

The %pf, %pF conversion caused about 5 merge conflicts in linux-next.
An alternative is to remove the merge of 'for-5.2-pf-removal' branch
and run the following:

  git grep -l '%p[fF]' | grep -v '^\(tools\|Documentation\)/' | \
  while read i; do perl -i -pe 's/%pf/%ps/g; s/%pF/%pS/g;' $i; done

Feel free to ask me to prepare pull request without the Sakari's patch.

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/test_printf: Switch to bitmap_zalloc()

Paul Gortmaker (1):
      printk: Tie printk_once / printk_deferred_once into .data.once for reset

Petr Mladek (12):
      vsprintf: Shuffle restricted_pointer()
      vsprintf: Consistent %pK handling for kptr_restrict == 0
      vsprintf: Do not check address of well-known strings
      vsprintf: Factor out %p[iI] handler as ip_addr_string()
      vsprintf: Factor out %pV handler as va_format()
      vsprintf: Factor out %pO handler as kobject_string()
      vsprintf: Consolidate handling of unknown pointer specifiers
      vsprintf: Prevent crash when dereferencing invalid pointers
      vsprintf: Avoid confusion between invalid address and value
      vsprintf: Limit the length of inlined error messages
      Merge branch 'for-5.2-vsprintf-hardening' into for-linus
      Merge branch 'for-5.2-pf-removal' into for-linus

Sakari Ailus (1):
      treewide: Switch printk users from %pf and %pF to %ps and %pS, respectively

YueHaibing (1):
      lib/vsprintf: Make function pointer_string static

 Documentation/clearing-warn-once.txt      |   2 +-
 Documentation/core-api/printk-formats.rst |   8 +
 arch/alpha/kernel/pci_iommu.c             |  20 +-
 arch/arm/mach-imx/pm-imx6.c               |   2 +-
 arch/arm/mm/alignment.c                   |   2 +-
 arch/arm/nwfpe/fpmodule.c                 |   2 +-
 arch/microblaze/mm/pgtable.c              |   2 +-
 arch/sparc/kernel/ds.c                    |   2 +-
 arch/um/kernel/sysrq.c                    |   2 +-
 arch/x86/include/asm/trace/exceptions.h   |   2 +-
 arch/x86/kernel/irq_64.c                  |   2 +-
 arch/x86/mm/extable.c                     |   4 +-
 arch/x86/xen/multicalls.c                 |   2 +-
 drivers/acpi/device_pm.c                  |   2 +-
 drivers/base/power/main.c                 |   6 +-
 drivers/base/syscore.c                    |  12 +-
 drivers/block/drbd/drbd_receiver.c        |   2 +-
 drivers/block/floppy.c                    |  10 +-
 drivers/cpufreq/cpufreq.c                 |   2 +-
 drivers/mmc/core/quirks.h                 |   2 +-
 drivers/nvdimm/bus.c                      |   2 +-
 drivers/nvdimm/dimm_devs.c                |   2 +-
 drivers/pci/pci-driver.c                  |  14 +-
 drivers/pci/quirks.c                      |   4 +-
 drivers/pnp/quirks.c                      |   2 +-
 drivers/scsi/esp_scsi.c                   |   2 +-
 fs/btrfs/tests/free-space-tree-tests.c    |   4 +-
 fs/f2fs/f2fs.h                            |   2 +-
 fs/pstore/inode.c                         |   2 +-
 include/linux/printk.h                    |   4 +-
 include/trace/events/btrfs.h              |   2 +-
 include/trace/events/cpuhp.h              |   4 +-
 include/trace/events/preemptirq.h         |   2 +-
 include/trace/events/rcu.h                |   4 +-
 include/trace/events/sunrpc.h             |   2 +-
 include/trace/events/vmscan.h             |   4 +-
 include/trace/events/workqueue.h          |   4 +-
 include/trace/events/xen.h                |   2 +-
 init/main.c                               |   6 +-
 kernel/async.c                            |   4 +-
 kernel/events/uprobes.c                   |   2 +-
 kernel/fail_function.c                    |   2 +-
 kernel/irq/debugfs.c                      |   2 +-
 kernel/irq/handle.c                       |   2 +-
 kernel/irq/manage.c                       |   2 +-
 kernel/irq/spurious.c                     |   4 +-
 kernel/rcu/tree.c                         |   2 +-
 kernel/stop_machine.c                     |   2 +-
 kernel/time/sched_clock.c                 |   2 +-
 kernel/time/timer.c                       |   2 +-
 kernel/workqueue.c                        |  12 +-
 lib/error-inject.c                        |   2 +-
 lib/percpu-refcount.c                     |   4 +-
 lib/test_printf.c                         |  29 +-
 lib/vsprintf.c                            | 431 +++++++++++++++++++-----------
 mm/memblock.c                             |  14 +-
 mm/memory.c                               |   2 +-
 mm/vmscan.c                               |   2 +-
 net/ceph/osd_client.c                     |   2 +-
 net/core/net-procfs.c                     |   2 +-
 net/core/netpoll.c                        |   4 +-
 61 files changed, 412 insertions(+), 274 deletions(-)
