Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D2220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742771;
	bh=8VTJOhvvCeJRIQY0Kq1cUUYm8xK4AVz0/UqfJvkl2z8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a//xfypAnsXSuG5ea25A+9eOeYm9sUyHvFQ/IiCOuWcOWS9sJCfzqb+gyK7Pr0MEA
	 UNAj+7QpvqD0XJAo4bbhFTuWQIZ5ymMdh90i74LvbmnzuuJlUnzmE6C0Qolhyek8yO
	 nZlmGEzW+yJ+R5yCUVtNx8nFpl+w2d3KCvdzlW5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfDHQ7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:59:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfDHQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3w2GHX8tcmuRQCxFetBrOW/KrzOldt06+7W8EOV+SVM=; b=ZAAXyTCpLLkIGNRE4RTQBMLwJ
        XLF8NrId2nUuki4iSQcx6VPl2cWxnOigDCcDHfItost/Pd2BTuOVelofcNrmFaARK0rGQehxCpC1M
        14hkXj1xkU5YQcuNe9xF+uojaFK/Qqv84Bn4ebQZ9Zg5XKQlKd0bfEvj7CfQ65KtnvSd80y+glzh3
        O0ttyeKg2bQT7XOnCssgtZErCD8Cy6pkBM/7KBeOC2AsIyrY3HKLiedZ5fK5nZVgYIA0hQE5P6Q4b
        +ubVWMw1GmRTX9AjMCpnEt2t/FWK+ObwD68ajaNrLtHlpHmTwql3DA2DWlvXwaePbu7kFOzRaGaAm
        wgM+VlKsg==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Sv-9k; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005mx-4u; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/10] Add all documentation files to an html/pdf produced book
Date:   Mon,  8 Apr 2019 13:58:16 -0300
Message-Id: <cover.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite having converted almost all files to ReST at the main Documentation/
directory, they're still not included to any book. Also, after all those years
after migrated to ReST as the official documentation format, there are still
a lot of files using plain TXT files, with random internal formatting.

As it will likely require a lot more years to get everything converted,
let's add index.rst files to Documentation/* subdirs, with a text_files.rst
including all plain txt files as literal includes.

That ensures that the html output will contain the entire Linux Kernel
documentation.

Also, a few of the ReST files at the Documentation/*.txt are now
producing errors/warnings, as some patch broke its ReST format.

As keeping them as txt files makes harder to ensure that they'll be built
with Sphinx, let's place everything inside an "other" book, renaming them
to *.rst, in order to let Sphinx build them.

We could later move the files to a better book, but that will require some
time and patience, in order to ensure that they'll all be placed at their
rightful place.

It should be noticed that 3 files from the main Documentation/ dir are still
kept with *.txt suffix:

1) The logo.txt file is not really part of the Kernel documentation. It
just adds some documentation to the logo.gif file. So, leave it as-is;

2) The files atomic_t.txt and memory-barriers.txt aren't at ReST format.
Those got just moved to the Documentation/other/ directory. The rationale
is that the attempts to convert them to ReST found resistance from developers
whose maintain them. So, keep them as plain old text files, adding them
to the book via literal includes, just like the other plain txt files.

Keeping plain txt files is far from being perfect, but at least
now the written Kernel documentation will be available at html and pdf
formats.

Those patches are on my development tree at:
	https://git.linuxtv.org/mchehab/experimental.git/log/?h=all_docs_to_output


PS.: 

devicetree and ABI files are still not produced at Documentation/output.
Supporting those would likely be better served by some scripting.

Mauro Carvalho Chehab (10):
  docs: DMA-API-HOWTO: add a missing "="
  docs: atomic_bitops.txt: add a title for this document
  docs: clearing-warn-once.txt: add a title for this document
  docs: ntb.txt: use Sphinx notation for the two ascii figures
  docs: unaligned-memory-access.txt: use a lowercase title
  docs: video-output.txt: convert it to ReST format
  docs: Add all txt files to documentation
  docs: ntb.rst: add blank lines to clean up some Sphinx warnings
  docs: speculation.rst: mark example blocks as such
  docs: add plain text files to ReST output from  subdirs

 Documentation/EDID/index.rst                  |  15 ++
 Documentation/EDID/text_files.rst             |   6 +
 Documentation/PCI/index.rst                   |  15 ++
 Documentation/PCI/text_files.rst              |  72 +++++
 Documentation/RCU/index.rst                   |  15 ++
 Documentation/RCU/text_files.rst              |  96 +++++++
 Documentation/accounting/index.rst            |  15 ++
 Documentation/accounting/text_files.rst       |  30 +++
 Documentation/acpi/index.rst                  |  15 ++
 Documentation/acpi/text_files.rst             | 138 ++++++++++
 Documentation/aoe/index.rst                   |  15 ++
 Documentation/aoe/text_files.rst              |  18 ++
 Documentation/arm/index.rst                   |  21 ++
 Documentation/arm/text_files.rst              | 198 ++++++++++++++
 Documentation/arm64/index.rst                 |  15 ++
 Documentation/arm64/text_files.rst            |  72 +++++
 Documentation/auxdisplay/index.rst            |  15 ++
 Documentation/auxdisplay/text_files.rst       |   6 +
 Documentation/backlight/index.rst             |  15 ++
 Documentation/backlight/text_files.rst        |   6 +
 Documentation/block/index.rst                 |  15 ++
 Documentation/block/text_files.rst            |  96 +++++++
 Documentation/blockdev/index.rst              |  15 ++
 Documentation/blockdev/text_files.rst         |  42 +++
 Documentation/bus-devices/index.rst           |  15 ++
 Documentation/bus-devices/text_files.rst      |   6 +
 Documentation/cdrom/index.rst                 |  15 ++
 Documentation/cdrom/text_files.rst            |   6 +
 Documentation/cgroup-v1/index.rst             |  15 ++
 Documentation/cgroup-v1/text_files.rst        |  78 ++++++
 Documentation/cma/index.rst                   |  15 ++
 Documentation/cma/text_files.rst              |   6 +
 Documentation/connector/index.rst             |  15 ++
 Documentation/connector/text_files.rst        |   6 +
 Documentation/console/index.rst               |  15 ++
 Documentation/console/text_files.rst          |   6 +
 Documentation/cpu-freq/index.rst              |  15 ++
 Documentation/cpu-freq/text_files.rst         |  42 +++
 Documentation/device-mapper/index.rst         |  15 ++
 Documentation/device-mapper/text_files.rst    | 168 ++++++++++++
 Documentation/driver-model/index.rst          |  15 ++
 Documentation/driver-model/text_files.rst     |  60 +++++
 Documentation/early-userspace/index.rst       |  15 ++
 Documentation/early-userspace/text_files.rst  |   6 +
 Documentation/extcon/index.rst                |  15 ++
 Documentation/extcon/text_files.rst           |   6 +
 Documentation/fault-injection/index.rst       |  15 ++
 Documentation/fault-injection/text_files.rst  |  24 ++
 Documentation/fb/index.rst                    |  15 ++
 Documentation/fb/text_files.rst               | 204 ++++++++++++++
 Documentation/features/index.rst              |  15 ++
 Documentation/features/text_files.rst         | 252 ++++++++++++++++++
 Documentation/fmc/index.rst                   |  15 ++
 Documentation/fmc/text_files.rst              |  60 +++++
 Documentation/fpga/index.rst                  |  15 ++
 Documentation/fpga/text_files.rst             |   6 +
 Documentation/gpio/index.rst                  |  15 ++
 Documentation/gpio/text_files.rst             |   6 +
 Documentation/hid/index.rst                   |  15 ++
 Documentation/hid/text_files.rst              |  42 +++
 Documentation/hwmon/index.rst                 |  15 ++
 Documentation/hwmon/text_files.rst            |   6 +
 Documentation/ia64/index.rst                  |  15 ++
 Documentation/ia64/text_files.rst             |  48 ++++
 Documentation/ide/index.rst                   |  15 ++
 Documentation/ide/text_files.rst              |  18 ++
 Documentation/iio/index.rst                   |  15 ++
 Documentation/iio/text_files.rst              |  12 +
 Documentation/index.rst                       |  90 +++++++
 Documentation/infiniband/index.rst            |  15 ++
 Documentation/infiniband/text_files.rst       |  42 +++
 Documentation/ioctl/index.rst                 |  15 ++
 Documentation/ioctl/text_files.rst            |  30 +++
 Documentation/kbuild/index.rst                |  15 ++
 Documentation/kbuild/text_files.rst           |  42 +++
 Documentation/kdump/index.rst                 |  15 ++
 Documentation/kdump/text_files.rst            |  18 ++
 Documentation/laptops/index.rst               |  16 ++
 Documentation/laptops/text_files.rst          |  42 +++
 Documentation/leds/index.rst                  |  15 ++
 Documentation/leds/text_files.rst             |  84 ++++++
 Documentation/lightnvm/index.rst              |  15 ++
 Documentation/lightnvm/text_files.rst         |   6 +
 Documentation/livepatch/index.rst             |  15 ++
 Documentation/livepatch/text_files.rst        |  30 +++
 Documentation/locking/index.rst               |  15 ++
 Documentation/locking/text_files.rst          |  48 ++++
 Documentation/m68k/index.rst                  |  15 ++
 Documentation/m68k/text_files.rst             |   6 +
 Documentation/md/index.rst                    |  15 ++
 Documentation/md/text_files.rst               |  18 ++
 Documentation/memory-devices/index.rst        |  15 ++
 Documentation/memory-devices/text_files.rst   |   6 +
 Documentation/mic/index.rst                   |  15 ++
 Documentation/mic/text_files.rst              |  12 +
 Documentation/mmc/index.rst                   |  15 ++
 Documentation/mmc/text_files.rst              |  24 ++
 Documentation/mtd/index.rst                   |  15 ++
 Documentation/mtd/text_files.rst              |  18 ++
 Documentation/namespaces/index.rst            |  15 ++
 Documentation/namespaces/text_files.rst       |  12 +
 Documentation/netlabel/index.rst              |  15 ++
 Documentation/netlabel/text_files.rst         |  24 ++
 Documentation/nfc/index.rst                   |  15 ++
 Documentation/nfc/text_files.rst              |  12 +
 Documentation/nvdimm/index.rst                |  15 ++
 Documentation/nvdimm/text_files.rst           |  18 ++
 Documentation/nvmem/index.rst                 |  15 ++
 Documentation/nvmem/text_files.rst            |   6 +
 .../DMA-API-HOWTO.rst}                        |   2 +-
 .../{DMA-API.txt => other/DMA-API.rst}        |   0
 .../DMA-ISA-LPC.rst}                          |   0
 .../DMA-attributes.rst}                       |   0
 Documentation/{IPMI.txt => other/IPMI.rst}    |   0
 .../IRQ-affinity.rst}                         |   0
 .../{IRQ-domain.txt => other/IRQ-domain.rst}  |   0
 Documentation/{IRQ.txt => other/IRQ.rst}      |   0
 .../Intel-IOMMU.rst}                          |   0
 Documentation/{SAK.txt => other/SAK.rst}      |   0
 Documentation/{SM501.txt => other/SM501.rst}  |   0
 .../atomic_bitops.rst}                        |   6 +-
 Documentation/{ => other}/atomic_t.txt        |   0
 .../{bt8xxgpio.txt => other/bt8xxgpio.rst}    |   0
 .../{btmrvl.txt => other/btmrvl.rst}          |   0
 .../bus-virt-phys-mapping.rst}                |   0
 .../clearing-warn-once.rst}                   |   2 +
 .../{cpu-load.txt => other/cpu-load.rst}      |   0
 .../cputopology.rst}                          |   0
 Documentation/{crc32.txt => other/crc32.rst}  |   0
 .../{dcdbas.txt => other/dcdbas.rst}          |   0
 .../debugging-modules.rst}                    |   0
 .../debugging-via-ohci1394.rst}               |   0
 .../{dell_rbu.txt => other/dell_rbu.rst}      |   0
 .../{digsig.txt => other/digsig.rst}          |   0
 .../{efi-stub.txt => other/efi-stub.rst}      |   0
 Documentation/{eisa.txt => other/eisa.rst}    |   0
 .../futex-requeue-pi.rst}                     |   0
 .../gcc-plugins.rst}                          |   0
 .../{highuid.txt => other/highuid.rst}        |   0
 .../{hw_random.txt => other/hw_random.rst}    |   0
 .../{hwspinlock.txt => other/hwspinlock.rst}  |   0
 Documentation/other/index.rst                 | 100 +++++++
 .../{intel_txt.txt => other/intel_txt.rst}    |   0
 .../{io-mapping.txt => other/io-mapping.rst}  |   0
 .../io_ordering.rst}                          |   0
 .../{iostats.txt => other/iostats.rst}        |   0
 .../irqflags-tracing.rst}                     |   0
 Documentation/{isa.txt => other/isa.rst}      |   0
 .../{isapnp.txt => other/isapnp.rst}          |   0
 .../kernel-per-CPU-kthreads.rst}              |   0
 .../{kobject.txt => other/kobject.rst}        |   0
 .../{kprobes.txt => other/kprobes.rst}        |   0
 Documentation/{kref.txt => other/kref.rst}    |   0
 Documentation/{ldm.txt => other/ldm.rst}      |   0
 .../lockup-watchdogs.rst}                     |   0
 Documentation/{lsm.txt => other/lsm.rst}      |   0
 Documentation/{lzo.txt => other/lzo.rst}      |   0
 .../{mailbox.txt => other/mailbox.rst}        |   0
 Documentation/{ => other}/memory-barriers.txt |   0
 .../men-chameleon-bus.rst}                    |   0
 .../{nommu-mmap.txt => other/nommu-mmap.rst}  |   0
 Documentation/{ntb.txt => other/ntb.rst}      |  14 +-
 .../{numastat.txt => other/numastat.rst}      |   0
 .../{padata.txt => other/padata.rst}          |   0
 .../parport-lowlevel.rst}                     |   0
 .../percpu-rw-semaphore.rst}                  |   0
 Documentation/{phy.txt => other/phy.rst}      |   0
 .../{pi-futex.txt => other/pi-futex.rst}      |   0
 Documentation/{pnp.txt => other/pnp.rst}      |   0
 .../preempt-locking.rst}                      |   0
 Documentation/{pwm.txt => other/pwm.rst}      |   0
 .../{rbtree.txt => other/rbtree.rst}          |   0
 .../{remoteproc.txt => other/remoteproc.rst}  |   0
 .../{rfkill.txt => other/rfkill.rst}          |   0
 .../robust-futex-ABI.rst}                     |   0
 .../robust-futexes.rst}                       |   0
 Documentation/{rpmsg.txt => other/rpmsg.rst}  |   0
 Documentation/{rtc.txt => other/rtc.rst}      |   0
 .../{sgi-ioc4.txt => other/sgi-ioc4.rst}      |   0
 .../{siphash.txt => other/siphash.rst}        |   0
 .../smsc_ece1099.rst}                         |   0
 .../speculation.rst}                          |   8 +-
 .../static-keys.rst}                          |   0
 Documentation/{svga.txt => other/svga.rst}    |   0
 .../{switchtec.txt => other/switchtec.rst}    |   0
 .../{sync_file.txt => other/sync_file.rst}    |   0
 Documentation/{tee.txt => other/tee.rst}      |   0
 Documentation/other/text_files.rst            |  12 +
 .../this_cpu_ops.rst}                         |   0
 .../unaligned-memory-access.rst}              |   2 +-
 .../vfio-mediated-device.rst}                 |   0
 Documentation/{vfio.txt => other/vfio.rst}    |   0
 Documentation/other/video-output.rst          |  34 +++
 .../{xillybus.txt => other/xillybus.rst}      |   0
 Documentation/{xz.txt => other/xz.rst}        |   0
 Documentation/{zorro.txt => other/zorro.rst}  |   0
 Documentation/pcmcia/index.rst                |  15 ++
 Documentation/pcmcia/text_files.rst           |  24 ++
 Documentation/perf/index.rst                  |  15 ++
 Documentation/perf/text_files.rst             |  42 +++
 Documentation/phy/index.rst                   |  15 ++
 Documentation/phy/text_files.rst              |   6 +
 Documentation/platform/index.rst              |  15 ++
 Documentation/platform/text_files.rst         |   6 +
 Documentation/power/index.rst                 |  15 ++
 Documentation/power/text_files.rst            | 162 +++++++++++
 Documentation/powerpc/index.rst               |  16 ++
 Documentation/powerpc/text_files.rst          | 102 +++++++
 Documentation/pps/index.rst                   |  15 ++
 Documentation/pps/text_files.rst              |   6 +
 Documentation/pti/index.rst                   |  15 ++
 Documentation/pti/text_files.rst              |   6 +
 Documentation/ptp/index.rst                   |  15 ++
 Documentation/ptp/text_files.rst              |   6 +
 Documentation/rapidio/index.rst               |  15 ++
 Documentation/rapidio/text_files.rst          |  30 +++
 Documentation/riscv/index.rst                 |  15 ++
 Documentation/riscv/text_files.rst            |   6 +
 Documentation/s390/index.rst                  |  15 ++
 Documentation/s390/text_files.rst             |  60 +++++
 Documentation/scheduler/index.rst             |  15 ++
 Documentation/scheduler/text_files.rst        |  60 +++++
 Documentation/scsi/index.rst                  |  15 ++
 Documentation/scsi/text_files.rst             | 246 +++++++++++++++++
 Documentation/serial/index.rst                |  15 ++
 Documentation/serial/text_files.rst           |  30 +++
 Documentation/sparc/index.rst                 |  15 ++
 Documentation/sparc/text_files.rst            |  24 ++
 Documentation/sphinx/index.rst                |  15 ++
 Documentation/sphinx/text_files.rst           |   6 +
 Documentation/sysctl/index.rst                |  15 ++
 Documentation/sysctl/text_files.rst           |  42 +++
 Documentation/target/index.rst                |  15 ++
 Documentation/target/text_files.rst           |  12 +
 Documentation/thermal/index.rst               |  15 ++
 Documentation/thermal/text_files.rst          |  24 ++
 Documentation/timers/index.rst                |  15 ++
 Documentation/timers/text_files.rst           |  36 +++
 Documentation/usb/index.rst                   |  15 ++
 Documentation/usb/text_files.rst              | 138 ++++++++++
 Documentation/video-output.txt                |  34 ---
 Documentation/virtual/index.rst               |  17 ++
 Documentation/virtual/text_files.rst          | 150 +++++++++++
 Documentation/watchdog/index.rst              |  15 ++
 Documentation/watchdog/text_files.rst         |  54 ++++
 Documentation/x86/index.rst                   |  15 ++
 Documentation/x86/text_files.rst              | 132 +++++++++
 Documentation/xilinx/index.rst                |  15 ++
 Documentation/xilinx/text_files.rst           |   6 +
 Documentation/xtensa/index.rst                |  15 ++
 Documentation/xtensa/text_files.rst           |  18 ++
 251 files changed, 5262 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/EDID/index.rst
 create mode 100644 Documentation/EDID/text_files.rst
 create mode 100644 Documentation/PCI/index.rst
 create mode 100644 Documentation/PCI/text_files.rst
 create mode 100644 Documentation/RCU/index.rst
 create mode 100644 Documentation/RCU/text_files.rst
 create mode 100644 Documentation/accounting/index.rst
 create mode 100644 Documentation/accounting/text_files.rst
 create mode 100644 Documentation/acpi/index.rst
 create mode 100644 Documentation/acpi/text_files.rst
 create mode 100644 Documentation/aoe/index.rst
 create mode 100644 Documentation/aoe/text_files.rst
 create mode 100644 Documentation/arm/index.rst
 create mode 100644 Documentation/arm/text_files.rst
 create mode 100644 Documentation/arm64/index.rst
 create mode 100644 Documentation/arm64/text_files.rst
 create mode 100644 Documentation/auxdisplay/index.rst
 create mode 100644 Documentation/auxdisplay/text_files.rst
 create mode 100644 Documentation/backlight/index.rst
 create mode 100644 Documentation/backlight/text_files.rst
 create mode 100644 Documentation/block/index.rst
 create mode 100644 Documentation/block/text_files.rst
 create mode 100644 Documentation/blockdev/index.rst
 create mode 100644 Documentation/blockdev/text_files.rst
 create mode 100644 Documentation/bus-devices/index.rst
 create mode 100644 Documentation/bus-devices/text_files.rst
 create mode 100644 Documentation/cdrom/index.rst
 create mode 100644 Documentation/cdrom/text_files.rst
 create mode 100644 Documentation/cgroup-v1/index.rst
 create mode 100644 Documentation/cgroup-v1/text_files.rst
 create mode 100644 Documentation/cma/index.rst
 create mode 100644 Documentation/cma/text_files.rst
 create mode 100644 Documentation/connector/index.rst
 create mode 100644 Documentation/connector/text_files.rst
 create mode 100644 Documentation/console/index.rst
 create mode 100644 Documentation/console/text_files.rst
 create mode 100644 Documentation/cpu-freq/index.rst
 create mode 100644 Documentation/cpu-freq/text_files.rst
 create mode 100644 Documentation/device-mapper/index.rst
 create mode 100644 Documentation/device-mapper/text_files.rst
 create mode 100644 Documentation/driver-model/index.rst
 create mode 100644 Documentation/driver-model/text_files.rst
 create mode 100644 Documentation/early-userspace/index.rst
 create mode 100644 Documentation/early-userspace/text_files.rst
 create mode 100644 Documentation/extcon/index.rst
 create mode 100644 Documentation/extcon/text_files.rst
 create mode 100644 Documentation/fault-injection/index.rst
 create mode 100644 Documentation/fault-injection/text_files.rst
 create mode 100644 Documentation/fb/index.rst
 create mode 100644 Documentation/fb/text_files.rst
 create mode 100644 Documentation/features/index.rst
 create mode 100644 Documentation/features/text_files.rst
 create mode 100644 Documentation/fmc/index.rst
 create mode 100644 Documentation/fmc/text_files.rst
 create mode 100644 Documentation/fpga/index.rst
 create mode 100644 Documentation/fpga/text_files.rst
 create mode 100644 Documentation/gpio/index.rst
 create mode 100644 Documentation/gpio/text_files.rst
 create mode 100644 Documentation/hid/index.rst
 create mode 100644 Documentation/hid/text_files.rst
 create mode 100644 Documentation/hwmon/index.rst
 create mode 100644 Documentation/hwmon/text_files.rst
 create mode 100644 Documentation/ia64/index.rst
 create mode 100644 Documentation/ia64/text_files.rst
 create mode 100644 Documentation/ide/index.rst
 create mode 100644 Documentation/ide/text_files.rst
 create mode 100644 Documentation/iio/index.rst
 create mode 100644 Documentation/iio/text_files.rst
 create mode 100644 Documentation/infiniband/index.rst
 create mode 100644 Documentation/infiniband/text_files.rst
 create mode 100644 Documentation/ioctl/index.rst
 create mode 100644 Documentation/ioctl/text_files.rst
 create mode 100644 Documentation/kbuild/index.rst
 create mode 100644 Documentation/kbuild/text_files.rst
 create mode 100644 Documentation/kdump/index.rst
 create mode 100644 Documentation/kdump/text_files.rst
 create mode 100644 Documentation/laptops/index.rst
 create mode 100644 Documentation/laptops/text_files.rst
 create mode 100644 Documentation/leds/index.rst
 create mode 100644 Documentation/leds/text_files.rst
 create mode 100644 Documentation/lightnvm/index.rst
 create mode 100644 Documentation/lightnvm/text_files.rst
 create mode 100644 Documentation/livepatch/index.rst
 create mode 100644 Documentation/livepatch/text_files.rst
 create mode 100644 Documentation/locking/index.rst
 create mode 100644 Documentation/locking/text_files.rst
 create mode 100644 Documentation/m68k/index.rst
 create mode 100644 Documentation/m68k/text_files.rst
 create mode 100644 Documentation/md/index.rst
 create mode 100644 Documentation/md/text_files.rst
 create mode 100644 Documentation/memory-devices/index.rst
 create mode 100644 Documentation/memory-devices/text_files.rst
 create mode 100644 Documentation/mic/index.rst
 create mode 100644 Documentation/mic/text_files.rst
 create mode 100644 Documentation/mmc/index.rst
 create mode 100644 Documentation/mmc/text_files.rst
 create mode 100644 Documentation/mtd/index.rst
 create mode 100644 Documentation/mtd/text_files.rst
 create mode 100644 Documentation/namespaces/index.rst
 create mode 100644 Documentation/namespaces/text_files.rst
 create mode 100644 Documentation/netlabel/index.rst
 create mode 100644 Documentation/netlabel/text_files.rst
 create mode 100644 Documentation/nfc/index.rst
 create mode 100644 Documentation/nfc/text_files.rst
 create mode 100644 Documentation/nvdimm/index.rst
 create mode 100644 Documentation/nvdimm/text_files.rst
 create mode 100644 Documentation/nvmem/index.rst
 create mode 100644 Documentation/nvmem/text_files.rst
 rename Documentation/{DMA-API-HOWTO.txt => other/DMA-API-HOWTO.rst} (99%)
 rename Documentation/{DMA-API.txt => other/DMA-API.rst} (100%)
 rename Documentation/{DMA-ISA-LPC.txt => other/DMA-ISA-LPC.rst} (100%)
 rename Documentation/{DMA-attributes.txt => other/DMA-attributes.rst} (100%)
 rename Documentation/{IPMI.txt => other/IPMI.rst} (100%)
 rename Documentation/{IRQ-affinity.txt => other/IRQ-affinity.rst} (100%)
 rename Documentation/{IRQ-domain.txt => other/IRQ-domain.rst} (100%)
 rename Documentation/{IRQ.txt => other/IRQ.rst} (100%)
 rename Documentation/{Intel-IOMMU.txt => other/Intel-IOMMU.rst} (100%)
 rename Documentation/{SAK.txt => other/SAK.rst} (100%)
 rename Documentation/{SM501.txt => other/SM501.rst} (100%)
 rename Documentation/{atomic_bitops.txt => other/atomic_bitops.rst} (97%)
 rename Documentation/{ => other}/atomic_t.txt (100%)
 rename Documentation/{bt8xxgpio.txt => other/bt8xxgpio.rst} (100%)
 rename Documentation/{btmrvl.txt => other/btmrvl.rst} (100%)
 rename Documentation/{bus-virt-phys-mapping.txt => other/bus-virt-phys-mapping.rst} (100%)
 rename Documentation/{clearing-warn-once.txt => other/clearing-warn-once.rst} (85%)
 rename Documentation/{cpu-load.txt => other/cpu-load.rst} (100%)
 rename Documentation/{cputopology.txt => other/cputopology.rst} (100%)
 rename Documentation/{crc32.txt => other/crc32.rst} (100%)
 rename Documentation/{dcdbas.txt => other/dcdbas.rst} (100%)
 rename Documentation/{debugging-modules.txt => other/debugging-modules.rst} (100%)
 rename Documentation/{debugging-via-ohci1394.txt => other/debugging-via-ohci1394.rst} (100%)
 rename Documentation/{dell_rbu.txt => other/dell_rbu.rst} (100%)
 rename Documentation/{digsig.txt => other/digsig.rst} (100%)
 rename Documentation/{efi-stub.txt => other/efi-stub.rst} (100%)
 rename Documentation/{eisa.txt => other/eisa.rst} (100%)
 rename Documentation/{futex-requeue-pi.txt => other/futex-requeue-pi.rst} (100%)
 rename Documentation/{gcc-plugins.txt => other/gcc-plugins.rst} (100%)
 rename Documentation/{highuid.txt => other/highuid.rst} (100%)
 rename Documentation/{hw_random.txt => other/hw_random.rst} (100%)
 rename Documentation/{hwspinlock.txt => other/hwspinlock.rst} (100%)
 create mode 100644 Documentation/other/index.rst
 rename Documentation/{intel_txt.txt => other/intel_txt.rst} (100%)
 rename Documentation/{io-mapping.txt => other/io-mapping.rst} (100%)
 rename Documentation/{io_ordering.txt => other/io_ordering.rst} (100%)
 rename Documentation/{iostats.txt => other/iostats.rst} (100%)
 rename Documentation/{irqflags-tracing.txt => other/irqflags-tracing.rst} (100%)
 rename Documentation/{isa.txt => other/isa.rst} (100%)
 rename Documentation/{isapnp.txt => other/isapnp.rst} (100%)
 rename Documentation/{kernel-per-CPU-kthreads.txt => other/kernel-per-CPU-kthreads.rst} (100%)
 rename Documentation/{kobject.txt => other/kobject.rst} (100%)
 rename Documentation/{kprobes.txt => other/kprobes.rst} (100%)
 rename Documentation/{kref.txt => other/kref.rst} (100%)
 rename Documentation/{ldm.txt => other/ldm.rst} (100%)
 rename Documentation/{lockup-watchdogs.txt => other/lockup-watchdogs.rst} (100%)
 rename Documentation/{lsm.txt => other/lsm.rst} (100%)
 rename Documentation/{lzo.txt => other/lzo.rst} (100%)
 rename Documentation/{mailbox.txt => other/mailbox.rst} (100%)
 rename Documentation/{ => other}/memory-barriers.txt (100%)
 rename Documentation/{men-chameleon-bus.txt => other/men-chameleon-bus.rst} (100%)
 rename Documentation/{nommu-mmap.txt => other/nommu-mmap.rst} (100%)
 rename Documentation/{ntb.txt => other/ntb.rst} (98%)
 rename Documentation/{numastat.txt => other/numastat.rst} (100%)
 rename Documentation/{padata.txt => other/padata.rst} (100%)
 rename Documentation/{parport-lowlevel.txt => other/parport-lowlevel.rst} (100%)
 rename Documentation/{percpu-rw-semaphore.txt => other/percpu-rw-semaphore.rst} (100%)
 rename Documentation/{phy.txt => other/phy.rst} (100%)
 rename Documentation/{pi-futex.txt => other/pi-futex.rst} (100%)
 rename Documentation/{pnp.txt => other/pnp.rst} (100%)
 rename Documentation/{preempt-locking.txt => other/preempt-locking.rst} (100%)
 rename Documentation/{pwm.txt => other/pwm.rst} (100%)
 rename Documentation/{rbtree.txt => other/rbtree.rst} (100%)
 rename Documentation/{remoteproc.txt => other/remoteproc.rst} (100%)
 rename Documentation/{rfkill.txt => other/rfkill.rst} (100%)
 rename Documentation/{robust-futex-ABI.txt => other/robust-futex-ABI.rst} (100%)
 rename Documentation/{robust-futexes.txt => other/robust-futexes.rst} (100%)
 rename Documentation/{rpmsg.txt => other/rpmsg.rst} (100%)
 rename Documentation/{rtc.txt => other/rtc.rst} (100%)
 rename Documentation/{sgi-ioc4.txt => other/sgi-ioc4.rst} (100%)
 rename Documentation/{siphash.txt => other/siphash.rst} (100%)
 rename Documentation/{smsc_ece1099.txt => other/smsc_ece1099.rst} (100%)
 rename Documentation/{speculation.txt => other/speculation.rst} (95%)
 rename Documentation/{static-keys.txt => other/static-keys.rst} (100%)
 rename Documentation/{svga.txt => other/svga.rst} (100%)
 rename Documentation/{switchtec.txt => other/switchtec.rst} (100%)
 rename Documentation/{sync_file.txt => other/sync_file.rst} (100%)
 rename Documentation/{tee.txt => other/tee.rst} (100%)
 create mode 100644 Documentation/other/text_files.rst
 rename Documentation/{this_cpu_ops.txt => other/this_cpu_ops.rst} (100%)
 rename Documentation/{unaligned-memory-access.txt => other/unaligned-memory-access.rst} (99%)
 rename Documentation/{vfio-mediated-device.txt => other/vfio-mediated-device.rst} (100%)
 rename Documentation/{vfio.txt => other/vfio.rst} (100%)
 create mode 100644 Documentation/other/video-output.rst
 rename Documentation/{xillybus.txt => other/xillybus.rst} (100%)
 rename Documentation/{xz.txt => other/xz.rst} (100%)
 rename Documentation/{zorro.txt => other/zorro.rst} (100%)
 create mode 100644 Documentation/pcmcia/index.rst
 create mode 100644 Documentation/pcmcia/text_files.rst
 create mode 100644 Documentation/perf/index.rst
 create mode 100644 Documentation/perf/text_files.rst
 create mode 100644 Documentation/phy/index.rst
 create mode 100644 Documentation/phy/text_files.rst
 create mode 100644 Documentation/platform/index.rst
 create mode 100644 Documentation/platform/text_files.rst
 create mode 100644 Documentation/power/index.rst
 create mode 100644 Documentation/power/text_files.rst
 create mode 100644 Documentation/powerpc/index.rst
 create mode 100644 Documentation/powerpc/text_files.rst
 create mode 100644 Documentation/pps/index.rst
 create mode 100644 Documentation/pps/text_files.rst
 create mode 100644 Documentation/pti/index.rst
 create mode 100644 Documentation/pti/text_files.rst
 create mode 100644 Documentation/ptp/index.rst
 create mode 100644 Documentation/ptp/text_files.rst
 create mode 100644 Documentation/rapidio/index.rst
 create mode 100644 Documentation/rapidio/text_files.rst
 create mode 100644 Documentation/riscv/index.rst
 create mode 100644 Documentation/riscv/text_files.rst
 create mode 100644 Documentation/s390/index.rst
 create mode 100644 Documentation/s390/text_files.rst
 create mode 100644 Documentation/scheduler/index.rst
 create mode 100644 Documentation/scheduler/text_files.rst
 create mode 100644 Documentation/scsi/index.rst
 create mode 100644 Documentation/scsi/text_files.rst
 create mode 100644 Documentation/serial/index.rst
 create mode 100644 Documentation/serial/text_files.rst
 create mode 100644 Documentation/sparc/index.rst
 create mode 100644 Documentation/sparc/text_files.rst
 create mode 100644 Documentation/sphinx/index.rst
 create mode 100644 Documentation/sphinx/text_files.rst
 create mode 100644 Documentation/sysctl/index.rst
 create mode 100644 Documentation/sysctl/text_files.rst
 create mode 100644 Documentation/target/index.rst
 create mode 100644 Documentation/target/text_files.rst
 create mode 100644 Documentation/thermal/index.rst
 create mode 100644 Documentation/thermal/text_files.rst
 create mode 100644 Documentation/timers/index.rst
 create mode 100644 Documentation/timers/text_files.rst
 create mode 100644 Documentation/usb/index.rst
 create mode 100644 Documentation/usb/text_files.rst
 delete mode 100644 Documentation/video-output.txt
 create mode 100644 Documentation/virtual/index.rst
 create mode 100644 Documentation/virtual/text_files.rst
 create mode 100644 Documentation/watchdog/index.rst
 create mode 100644 Documentation/watchdog/text_files.rst
 create mode 100644 Documentation/x86/index.rst
 create mode 100644 Documentation/x86/text_files.rst
 create mode 100644 Documentation/xilinx/index.rst
 create mode 100644 Documentation/xilinx/text_files.rst
 create mode 100644 Documentation/xtensa/index.rst
 create mode 100644 Documentation/xtensa/text_files.rst

-- 
2.20.1


