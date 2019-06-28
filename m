Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C96AC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37BF2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725157;
	bh=qQzF0ZSIcHd6lMzxUL1EULaRA9NHM9Vel4HFaj2pxF8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tqRdR7BpFJfkEsdMIBM54f0aW5CSH7uDQiPeyDOOj5CQIAmwW8kOByicg+/ED2+JI
	 /rBD3D8VWUpfVBKRGkirPsrfG300ZLsU4NPXLegev2DJ1MlwtWFasstuAeECr+tXXZ
	 tkD749TEqmXb7ATO7TFQfMEfutGWbR+ZH6SlKUUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfF1Mcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:32:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfF1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oXH5vc3osFDNjBscCBl4KkVxjV5aLoHRBOlDBA7S174=; b=mLri3pERHq7J69a0Q+2qDQWAS
        Oeq07Hj2dTj1TBdYIx7uNMXLacT5LVhIzPhyJ7rNdRuE+5YQXtpencFhejj3jx1tIICr7h7erYGcl
        3sb7XLChMyh/kFPHv7d7DoNEohWvjJfEgyOJ1B2zeb1aM5HAVSAtepmsmPgkmwqlHMQoy+QmYce+W
        AcA7OVk5ISwJNxDZwVIU4ekicDid1ZqGG2h7MSCjZ41MC7Tb6KHf61m3j2ONIsB/dN2FQmnUjuiti
        WIhvqppYZyxAdwLRvom9sjbM8Elv+RdHpitIWgJIUsm3hT7VWQAS8aJHOb4tfJNc43xIkgD+FrItr
        OZhotCgLA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1T-00054i-Ro; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1R-0005Qw-Uh; Fri, 28 Jun 2019 09:30:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/39] Don't let ReST documents orphaned
Date:   Fri, 28 Jun 2019 09:29:53 -0300
Message-Id: <cover.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal on this series is to not let ReST documents orphaned.

It moves files that are already on ReST format to a better place,
when needed, and add them to the documentation body.

On my past attempt, I was too "aggressive" trying to move all files
under Documentation/*.txt to some place. It ends that I did some
mistakes, so, on this series, I opted to do the reverse: I only moved
files that seemed to obviously belong to some place.

So, after this patch series, there will still 44 orphaned document
files under Documentation/*.txt, to be addressed on a next Kernel 
version.

After this series, there will be "only" 386 files with the .txt extension:

   $ find Documentation/ -name '*.txt'|grep -v features/|grep -v devicetree|grep -v output|wc -l
   386

(I'm excluding features, as those aren't really a text file, but a sort
of textual database)

The end result of this patch series (plus the other ones I sent today)
is at:

	https://www.infradead.org/~mchehab/rst_conversion/

And the full documentation patch series at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=convert_rst_renames_v7.1

Mauro Carvalho Chehab (39):
  docs: thermal: add it to the driver API
  docs: rapidio: add it to the driver API
  docs: perf: move to the admin-guide
  docs: nvdimm: add it to the driver-api book
  docs: namespace: move it to the admin-guide
  docs: mtd: move it to the driver-api book
  docs: nfc: add it to the driver-api book
  docs: mmc: move it to the driver-api
  docs: md: move it to the driver-api book
  docs: leds: add it to the driver-api book
  docs: ioctl: add it to the uAPI guide
  docs: interconnect.rst: add it to the driver-api guide
  docs: add arch doc directories to the index
  docs: device-mapper: move it to the admin-guide
  docs: early-userspace: move to driver-api guide
  docs: admin-guide: move sysctl directory to it
  docs: admin-guide: add laptops documentation
  docs: admin-guide: add kdump documentation into it
  docs: blockdev: add it to the admin-guide
  docs: security: move some books to it and update
  docs: x86: move two x86-specific files to x86 arch dir
  docs: ocxl.rst: add it to the uAPI book
  docs: lp855x-driver.rst: add it to the driver-api book
  docs: driver-model: move it to the driver-api book
  docs: add some documentation dirs to the driver-api book
  docs: aoe: add it to the driver-api book
  docs: cgroup-v1: add it to the admin-guide book
  docs: admin-guide: add a series of orphaned documents
  docs: driver-api: add a series of orphaned documents
  docs: driver-api: add xilinx driver API documentation
  docs: driver-api: add remaining converted dirs to it
  docs: serial: move it to the driver-api
  docs: phy: place documentation under driver-api
  docs: add a memory-devices subdir to driver-api
  docs: infiniband: add it to the driver-api bookset
  docs: add SPDX tags to new index files
  docs: adds some directories to the main documentation index
  docs: locking: add it to the main index
  docs: gpio: add sysfs interface to the admin-guide

 CREDITS                                       |  2 +-
 Documentation/ABI/obsolete/sysfs-gpio         |  2 +-
 Documentation/ABI/removed/sysfs-class-rfkill  |  2 +-
 Documentation/ABI/stable/sysfs-class-rfkill   |  2 +-
 Documentation/ABI/stable/sysfs-devices-node   |  2 +-
 Documentation/ABI/testing/procfs-diskstats    |  2 +-
 Documentation/ABI/testing/sysfs-block         |  2 +-
 Documentation/ABI/testing/sysfs-block-device  |  2 +-
 .../ABI/testing/sysfs-class-switchtec         |  2 +-
 .../ABI/testing/sysfs-devices-system-cpu      |  4 +-
 .../ABI/testing/sysfs-platform-asus-laptop    |  2 +-
 Documentation/accounting/index.rst            |  2 +-
 Documentation/{ => admin-guide}/aoe/aoe.rst   |  4 +-
 .../{ => admin-guide}/aoe/autoload.sh         |  0
 .../{ => admin-guide}/aoe/examples.rst        |  0
 Documentation/{ => admin-guide}/aoe/index.rst |  2 -
 Documentation/{ => admin-guide}/aoe/status.sh |  0
 Documentation/{ => admin-guide}/aoe/todo.rst  |  0
 .../{ => admin-guide}/aoe/udev-install.sh     |  0
 Documentation/{ => admin-guide}/aoe/udev.txt  |  2 +-
 .../blockdev/drbd/DRBD-8.3-data-packets.svg   |  0
 .../blockdev/drbd/DRBD-data-packets.svg       |  0
 .../blockdev/drbd/conn-states-8.dot           |  0
 .../blockdev/drbd/data-structure-v9.rst       |  0
 .../blockdev/drbd/disk-states-8.dot           |  0
 .../drbd/drbd-connection-state-overview.dot   |  0
 .../blockdev/drbd/figures.rst                 |  2 +
 .../{ => admin-guide}/blockdev/drbd/index.rst |  0
 .../blockdev/drbd/node-states-8.dot           |  1 -
 .../{ => admin-guide}/blockdev/floppy.rst     |  0
 .../{ => admin-guide}/blockdev/index.rst      |  2 +-
 .../{ => admin-guide}/blockdev/nbd.rst        |  0
 .../{ => admin-guide}/blockdev/paride.rst     |  0
 .../{ => admin-guide}/blockdev/ramdisk.rst    |  0
 .../{ => admin-guide}/blockdev/zram.rst       |  0
 .../{btmrvl.txt => admin-guide/btmrvl.rst}    |  0
 Documentation/admin-guide/bug-hunting.rst     |  4 +-
 .../cgroup-v1/blkio-controller.rst            |  0
 .../{ => admin-guide}/cgroup-v1/cgroups.rst   |  4 +-
 .../{ => admin-guide}/cgroup-v1/cpuacct.rst   |  0
 .../{ => admin-guide}/cgroup-v1/cpusets.rst   |  2 +-
 .../{ => admin-guide}/cgroup-v1/devices.rst   |  0
 .../cgroup-v1/freezer-subsystem.rst           |  0
 .../{ => admin-guide}/cgroup-v1/hugetlb.rst   |  0
 .../{ => admin-guide}/cgroup-v1/index.rst     |  2 -
 .../cgroup-v1/memcg_test.rst                  |  4 +-
 .../{ => admin-guide}/cgroup-v1/memory.rst    |  0
 .../{ => admin-guide}/cgroup-v1/net_cls.rst   |  0
 .../{ => admin-guide}/cgroup-v1/net_prio.rst  |  0
 .../{ => admin-guide}/cgroup-v1/pids.rst      |  0
 .../{ => admin-guide}/cgroup-v1/rdma.rst      |  0
 Documentation/admin-guide/cgroup-v2.rst       |  2 +-
 .../clearing-warn-once.rst}                   |  0
 .../cpu-load.rst}                             |  0
 .../cputopology.rst}                          |  0
 .../device-mapper/cache-policies.rst          |  0
 .../{ => admin-guide}/device-mapper/cache.rst |  0
 .../{ => admin-guide}/device-mapper/delay.rst |  0
 .../device-mapper/dm-crypt.rst                |  0
 .../device-mapper/dm-dust.txt                 |  0
 .../device-mapper/dm-flakey.rst               |  0
 .../device-mapper/dm-init.rst                 |  0
 .../device-mapper/dm-integrity.rst            |  0
 .../{ => admin-guide}/device-mapper/dm-io.rst |  0
 .../device-mapper/dm-log.rst                  |  0
 .../device-mapper/dm-queue-length.rst         |  0
 .../device-mapper/dm-raid.rst                 |  0
 .../device-mapper/dm-service-time.rst         |  0
 .../device-mapper/dm-uevent.rst               |  0
 .../device-mapper/dm-zoned.rst                |  0
 .../{ => admin-guide}/device-mapper/era.rst   |  0
 .../{ => admin-guide}/device-mapper/index.rst |  2 -
 .../device-mapper/kcopyd.rst                  |  0
 .../device-mapper/linear.rst                  |  0
 .../device-mapper/log-writes.rst              |  0
 .../device-mapper/persistent-data.rst         |  0
 .../device-mapper/snapshot.rst                |  0
 .../device-mapper/statistics.rst              |  4 +-
 .../device-mapper/striped.rst                 |  0
 .../device-mapper/switch.rst                  |  0
 .../device-mapper/thin-provisioning.rst       |  0
 .../device-mapper/unstriped.rst               |  0
 .../device-mapper/verity.rst                  |  0
 .../device-mapper/writecache.rst              |  0
 .../{ => admin-guide}/device-mapper/zero.rst  |  0
 .../efi-stub.rst}                             |  0
 .../{ => admin-guide}/gpio/index.rst          |  2 +-
 .../{ => admin-guide}/gpio/sysfs.rst          |  0
 .../{highuid.txt => admin-guide/highuid.rst}  |  0
 Documentation/admin-guide/hw-vuln/l1tf.rst    |  2 +-
 .../hw_random.rst}                            |  0
 Documentation/admin-guide/index.rst           | 28 +++++++
 .../{iostats.txt => admin-guide/iostats.rst}  |  0
 .../{ => admin-guide}/kdump/gdbmacros.txt     |  0
 .../{ => admin-guide}/kdump/index.rst         |  1 -
 .../{ => admin-guide}/kdump/kdump.rst         |  0
 .../{ => admin-guide}/kdump/vmcoreinfo.rst    |  0
 .../admin-guide/kernel-parameters.txt         | 36 ++++----
 .../kernel-per-CPU-kthreads.rst}              |  2 +-
 .../{ => admin-guide}/laptops/asus-laptop.rst |  0
 .../laptops/disk-shock-protection.rst         |  0
 .../{ => admin-guide}/laptops/index.rst       |  2 +-
 .../{ => admin-guide}/laptops/laptop-mode.rst |  0
 .../{ => admin-guide}/laptops/lg-laptop.rst   |  1 -
 .../{ => admin-guide}/laptops/sony-laptop.rst |  0
 .../{ => admin-guide}/laptops/sonypi.rst      |  0
 .../laptops/thinkpad-acpi.rst                 |  6 +-
 .../laptops/toshiba_haps.rst                  |  0
 .../lcd-panel-cgram.rst                       |  2 -
 .../{ldm.txt => admin-guide/ldm.rst}          |  0
 .../lockup-watchdogs.rst}                     |  0
 .../mm/cma_debugfs.rst}                       |  2 -
 Documentation/admin-guide/mm/index.rst        |  3 +-
 Documentation/admin-guide/mm/ksm.rst          |  2 +-
 .../admin-guide/mm/numa_memory_policy.rst     |  2 +-
 .../namespaces/compatibility-list.rst         |  0
 .../{ => admin-guide}/namespaces/index.rst    |  2 +-
 .../namespaces/resource-control.rst           |  0
 .../numastat.rst}                             |  0
 .../{ => admin-guide}/perf/arm-ccn.rst        |  0
 .../{ => admin-guide}/perf/arm_dsu_pmu.rst    |  0
 .../{ => admin-guide}/perf/hisi-pmu.rst       |  0
 .../{ => admin-guide}/perf/index.rst          |  2 +-
 .../{ => admin-guide}/perf/qcom_l2_pmu.rst    |  0
 .../{ => admin-guide}/perf/qcom_l3_pmu.rst    |  0
 .../{ => admin-guide}/perf/thunderx2-pmu.rst  |  0
 .../{ => admin-guide}/perf/xgene-pmu.rst      |  0
 .../{pnp.txt => admin-guide/pnp.rst}          |  0
 .../{driver-api => admin-guide}/rapidio.rst   |  0
 .../{rtc.txt => admin-guide/rtc.rst}          |  0
 .../{svga.txt => admin-guide/svga.rst}        |  0
 .../{ => admin-guide}/sysctl/abi.rst          |  0
 Documentation/{ => admin-guide}/sysctl/fs.rst |  0
 .../{ => admin-guide}/sysctl/index.rst        |  2 -
 .../{ => admin-guide}/sysctl/kernel.rst       |  2 +-
 .../{ => admin-guide}/sysctl/net.rst          |  0
 .../{ => admin-guide}/sysctl/sunrpc.rst       |  0
 .../{ => admin-guide}/sysctl/user.rst         |  0
 Documentation/{ => admin-guide}/sysctl/vm.rst |  4 +-
 .../video-output.rst}                         |  0
 Documentation/arm/index.rst                   |  2 +-
 Documentation/arm/nwfpe/index.rst             |  2 +
 Documentation/arm/omap/index.rst              |  2 +
 Documentation/arm/sa1100/index.rst            |  2 +
 Documentation/arm/samsung-s3c24xx/index.rst   |  2 +
 Documentation/arm/samsung/index.rst           |  2 +
 Documentation/arm64/index.rst                 |  2 -
 Documentation/block/bfq-iosched.rst           |  2 +-
 Documentation/block/index.rst                 |  2 +-
 Documentation/cdrom/index.rst                 |  2 +-
 Documentation/core-api/printk-formats.rst     |  2 +-
 .../devicetree/bindings/phy/phy-bindings.txt  |  2 +-
 .../devicetree/bindings/phy/phy-pxa-usb.txt   |  2 +-
 .../backlight/lp855x-driver.rst               |  2 -
 .../bt8xxgpio.rst}                            |  0
 .../{connector => driver-api}/connector.rst   |  2 +-
 .../{console => driver-api}/console.rst       |  2 +-
 .../{dcdbas.txt => driver-api/dcdbas.rst}     |  0
 .../{dell_rbu.txt => driver-api/dell_rbu.rst} |  0
 .../{ => driver-api}/driver-model/binding.rst |  0
 .../{ => driver-api}/driver-model/bus.rst     |  0
 .../{ => driver-api}/driver-model/class.rst   |  0
 .../driver-model/design-patterns.rst          |  0
 .../{ => driver-api}/driver-model/device.rst  |  0
 .../{ => driver-api}/driver-model/devres.rst  |  0
 .../{ => driver-api}/driver-model/driver.rst  |  0
 .../{ => driver-api}/driver-model/index.rst   |  2 -
 .../driver-model/overview.rst                 |  0
 .../driver-model/platform.rst                 |  0
 .../{ => driver-api}/driver-model/porting.rst |  2 +-
 .../early-userspace/buffer-format.rst         |  0
 .../early_userspace_support.rst               |  0
 .../early-userspace/index.rst                 |  2 +-
 .../{EDID/howto.rst => driver-api/edid.rst}   |  2 +-
 .../{eisa.txt => driver-api/eisa.rst}         |  4 +-
 Documentation/driver-api/gpio/driver.rst      |  2 +-
 Documentation/driver-api/index.rst            | 44 +++++++++-
 .../interconnect.rst                          |  2 -
 Documentation/{isa.txt => driver-api/isa.rst} |  0
 .../{isapnp.txt => driver-api/isapnp.rst}     |  0
 .../pblk.txt => driver-api/lightnvm-pblk.rst} |  0
 Documentation/{ => driver-api}/md/index.rst   |  2 +-
 .../{ => driver-api}/md/md-cluster.rst        |  0
 .../{ => driver-api}/md/raid5-cache.rst       |  0
 .../{ => driver-api}/md/raid5-ppl.rst         |  0
 .../driver-api/memory-devices/index.rst       | 18 ++++
 .../memory-devices/ti-emif.rst                |  2 +-
 .../memory-devices}/ti-gpmc.rst               |  2 +-
 .../men-chameleon-bus.rst}                    |  0
 Documentation/{ => driver-api}/mmc/index.rst  |  2 +-
 .../{ => driver-api}/mmc/mmc-async-req.rst    |  0
 .../{ => driver-api}/mmc/mmc-dev-attrs.rst    |  0
 .../{ => driver-api}/mmc/mmc-dev-parts.rst    |  0
 .../{ => driver-api}/mmc/mmc-tools.rst        |  0
 Documentation/{ => driver-api}/mtd/index.rst  |  2 +-
 .../{ => driver-api}/mtd/intel-spi.rst        |  0
 .../{ => driver-api}/mtd/nand_ecc.rst         |  0
 .../{ => driver-api}/mtd/spi-nor.rst          |  0
 Documentation/{ => driver-api}/nfc/index.rst  |  2 +-
 .../{ => driver-api}/nfc/nfc-hci.rst          |  0
 .../{ => driver-api}/nfc/nfc-pn544.rst        |  0
 Documentation/{ntb.txt => driver-api/ntb.rst} |  0
 Documentation/{ => driver-api}/nvdimm/btt.rst |  0
 .../{ => driver-api}/nvdimm/index.rst         |  2 +-
 .../{ => driver-api}/nvdimm/nvdimm.rst        |  0
 .../{ => driver-api}/nvdimm/security.rst      |  0
 Documentation/{nvmem => driver-api}/nvmem.rst |  2 +-
 .../parport-lowlevel.rst}                     |  0
 Documentation/driver-api/phy/index.rst        | 18 ++++
 .../{phy.txt => driver-api/phy/phy.rst}       |  0
 .../{ => driver-api}/phy/samsung-usb2.rst     |  2 -
 Documentation/driver-api/pps.rst              |  2 +-
 .../{pti => driver-api}/pti_intel_mid.rst     |  2 +-
 Documentation/driver-api/ptp.rst              |  2 +-
 Documentation/{pwm.txt => driver-api/pwm.rst} |  0
 .../{ => driver-api}/rapidio/index.rst        |  2 +-
 .../{ => driver-api}/rapidio/mport_cdev.rst   |  0
 .../{ => driver-api}/rapidio/rapidio.rst      |  0
 .../{ => driver-api}/rapidio/rio_cm.rst       |  0
 .../{ => driver-api}/rapidio/sysfs.rst        |  0
 .../{ => driver-api}/rapidio/tsi721.rst       |  0
 .../{rfkill.txt => driver-api/rfkill.rst}     |  0
 .../{ => driver-api}/serial/cyclades_z.rst    |  0
 .../{ => driver-api}/serial/driver.rst        |  2 +-
 .../{ => driver-api}/serial/index.rst         |  2 +-
 .../{ => driver-api}/serial/moxa-smartio.rst  |  0
 .../{ => driver-api}/serial/n_gsm.rst         |  0
 .../{ => driver-api}/serial/rocket.rst        |  0
 .../serial/serial-iso7816.rst                 |  0
 .../{ => driver-api}/serial/serial-rs485.rst  |  0
 Documentation/{ => driver-api}/serial/tty.rst |  0
 .../{sgi-ioc4.txt => driver-api/sgi-ioc4.rst} |  0
 .../{SM501.txt => driver-api/sm501.rst}       |  0
 .../smsc_ece1099.rst}                         |  0
 .../switchtec.rst}                            |  2 +-
 .../sync_file.rst}                            |  0
 .../thermal/cpu-cooling-api.rst               |  0
 .../thermal/exynos_thermal.rst                |  0
 .../thermal/exynos_thermal_emulation.rst      |  0
 .../{ => driver-api}/thermal/index.rst        |  2 +-
 .../thermal/intel_powerclamp.rst              |  0
 .../thermal/nouveau_thermal.rst               |  0
 .../thermal/power_allocator.rst               |  0
 .../{ => driver-api}/thermal/sysfs-api.rst    | 12 +--
 .../thermal/x86_pkg_temperature_thermal.rst   |  2 +-
 .../vfio-mediated-device.rst}                 |  2 +-
 .../{vfio.txt => driver-api/vfio.rst}         |  0
 .../{ => driver-api}/xilinx/eemi.rst          |  0
 .../{ => driver-api}/xilinx/index.rst         |  1 -
 .../{xillybus.txt => driver-api/xillybus.rst} |  0
 .../{zorro.txt => driver-api/zorro.rst}       |  0
 Documentation/fault-injection/index.rst       |  2 +-
 Documentation/fb/fbcon.rst                    |  4 +-
 Documentation/fb/index.rst                    |  2 +-
 Documentation/fb/vesafb.rst                   |  2 +-
 Documentation/filesystems/nfs/nfsroot.txt     |  2 +-
 Documentation/filesystems/proc.txt            |  2 +-
 .../filesystems/ramfs-rootfs-initramfs.txt    |  4 +-
 Documentation/filesystems/sysfs.txt           |  2 +-
 Documentation/filesystems/tmpfs.txt           |  2 +-
 .../firmware-guide/acpi/enumeration.rst       |  2 +-
 Documentation/fpga/index.rst                  |  2 +-
 Documentation/hid/index.rst                   |  2 +-
 Documentation/hwmon/submitting-patches.rst    |  2 +-
 Documentation/ia64/index.rst                  |  2 +-
 Documentation/ide/index.rst                   |  2 +-
 Documentation/iio/index.rst                   |  2 +-
 Documentation/index.rst                       | 34 ++++++++
 Documentation/infiniband/index.rst            |  2 +-
 Documentation/ioctl/index.rst                 |  2 +-
 Documentation/ioctl/ioctl-number.rst          |  2 -
 Documentation/kbuild/index.rst                |  2 +-
 Documentation/leds/index.rst                  |  2 +-
 Documentation/livepatch/index.rst             |  2 +-
 Documentation/locking/index.rst               |  2 +-
 Documentation/m68k/index.rst                  |  2 +-
 Documentation/mic/index.rst                   |  2 -
 Documentation/netlabel/index.rst              |  2 +-
 Documentation/networking/ip-sysctl.txt        |  2 +-
 Documentation/pcmcia/index.rst                |  2 +-
 Documentation/power/index.rst                 |  2 +-
 .../powerpc/firmware-assisted-dump.rst        |  2 +-
 Documentation/powerpc/index.rst               |  2 +-
 Documentation/riscv/index.rst                 |  2 -
 Documentation/s390/index.rst                  |  2 -
 Documentation/s390/vfio-ccw.rst               |  6 +-
 Documentation/scheduler/index.rst             |  2 -
 Documentation/scheduler/sched-deadline.rst    |  2 +-
 Documentation/scheduler/sched-design-CFS.rst  |  2 +-
 Documentation/scheduler/sched-rt-group.rst    |  2 +-
 Documentation/security/index.rst              |  5 +-
 .../security/{LSM.rst => lsm-development.rst} |  0
 Documentation/{lsm.txt => security/lsm.rst}   |  0
 Documentation/{SAK.txt => security/sak.rst}   |  0
 .../{siphash.txt => security/siphash.rst}     |  0
 Documentation/security/tpm/index.rst          |  1 +
 Documentation/security/tpm/xen-tpmfront.rst   |  2 -
 Documentation/sparc/index.rst                 |  2 -
 Documentation/target/index.rst                |  2 +-
 Documentation/timers/index.rst                |  2 +-
 .../translations/zh_CN/filesystems/sysfs.txt  |  2 +-
 Documentation/translations/zh_CN/gpio.txt     |  4 +-
 .../translations/zh_CN/oops-tracing.txt       |  4 +-
 .../{ => userspace-api}/accelerators/ocxl.rst |  2 -
 Documentation/userspace-api/index.rst         |  1 +
 Documentation/vm/numa.rst                     |  4 +-
 Documentation/vm/page_migration.rst           |  2 +-
 Documentation/vm/unevictable-lru.rst          |  4 +-
 Documentation/w1/w1.netlink                   |  2 +-
 Documentation/watchdog/hpwdt.rst              |  2 +-
 Documentation/watchdog/index.rst              |  2 +-
 Documentation/x86/index.rst                   |  2 +
 .../{Intel-IOMMU.txt => x86/intel-iommu.rst}  |  0
 .../{intel_txt.txt => x86/intel_txt.rst}      |  0
 Documentation/x86/topology.rst                |  2 +-
 .../x86/x86_64/fake-numa-for-cpusets.rst      |  4 +-
 Documentation/xtensa/index.rst                |  2 +-
 MAINTAINERS                                   | 82 +++++++++----------
 Next/merge.log                                |  4 +-
 arch/arm/Kconfig                              |  4 +-
 arch/arm64/Kconfig                            |  2 +-
 arch/parisc/Kconfig                           |  2 +-
 arch/sh/Kconfig                               |  4 +-
 arch/sparc/Kconfig                            |  2 +-
 arch/x86/Kconfig                              |  8 +-
 block/Kconfig                                 |  2 +-
 block/partitions/Kconfig                      |  2 +-
 drivers/base/platform.c                       |  2 +-
 drivers/block/Kconfig                         |  8 +-
 drivers/block/floppy.c                        |  2 +-
 drivers/block/zram/Kconfig                    |  6 +-
 drivers/char/Kconfig                          |  6 +-
 drivers/char/hw_random/core.c                 |  2 +-
 drivers/dma-buf/Kconfig                       |  2 +-
 drivers/gpio/Kconfig                          |  2 +-
 drivers/gpio/gpio-cs5535.c                    |  2 +-
 drivers/gpu/drm/Kconfig                       |  2 +-
 drivers/md/Kconfig                            |  2 +-
 drivers/md/dm-init.c                          |  2 +-
 drivers/md/dm-raid.c                          |  2 +-
 drivers/mtd/nand/raw/nand_ecc.c               |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
 drivers/nvdimm/Kconfig                        |  2 +-
 drivers/pci/switch/Kconfig                    |  2 +-
 drivers/perf/qcom_l3_pmu.c                    |  2 +-
 drivers/platform/x86/Kconfig                  |  8 +-
 drivers/platform/x86/dcdbas.c                 |  2 +-
 drivers/platform/x86/dell_rbu.c               |  2 +-
 drivers/pnp/isapnp/Kconfig                    |  2 +-
 drivers/rapidio/Kconfig                       |  2 +-
 .../staging/unisys/Documentation/overview.txt |  4 +-
 drivers/tty/Kconfig                           |  6 +-
 drivers/tty/serial/ucc_uart.c                 |  2 +-
 drivers/vfio/Kconfig                          |  2 +-
 drivers/vfio/mdev/Kconfig                     |  2 +-
 drivers/w1/Kconfig                            |  2 +-
 fs/proc/Kconfig                               |  2 +-
 include/linux/cgroup-defs.h                   |  2 +-
 include/linux/device.h                        |  2 +-
 include/linux/hw_random.h                     |  2 +-
 include/linux/platform_device.h               |  2 +-
 include/linux/serial_core.h                   |  2 +-
 include/linux/thermal.h                       |  4 +-
 include/uapi/linux/bpf.h                      |  2 +-
 init/Kconfig                                  |  4 +-
 kernel/cgroup/cpuset.c                        |  2 +-
 kernel/panic.c                                |  2 +-
 mm/swap.c                                     |  2 +-
 samples/Kconfig                               |  2 +-
 scripts/coccinelle/free/devm_free.cocci       |  2 +-
 security/Kconfig                              |  2 +-
 security/device_cgroup.c                      |  2 +-
 tools/include/uapi/linux/bpf.h                |  2 +-
 tools/testing/selftests/zram/README           |  2 +-
 usr/Kconfig                                   |  2 +-
 375 files changed, 436 insertions(+), 318 deletions(-)
 rename Documentation/{ => admin-guide}/aoe/aoe.rst (97%)
 rename Documentation/{ => admin-guide}/aoe/autoload.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/examples.rst (100%)
 rename Documentation/{ => admin-guide}/aoe/index.rst (95%)
 rename Documentation/{ => admin-guide}/aoe/status.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/todo.rst (100%)
 rename Documentation/{ => admin-guide}/aoe/udev-install.sh (100%)
 rename Documentation/{ => admin-guide}/aoe/udev.txt (93%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/DRBD-8.3-data-packets.svg (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/DRBD-data-packets.svg (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/conn-states-8.dot (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/data-structure-v9.rst (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/disk-states-8.dot (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/drbd-connection-state-overview.dot (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/figures.rst (95%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/index.rst (100%)
 rename Documentation/{ => admin-guide}/blockdev/drbd/node-states-8.dot (99%)
 rename Documentation/{ => admin-guide}/blockdev/floppy.rst (100%)
 rename Documentation/{ => admin-guide}/blockdev/index.rst (83%)
 rename Documentation/{ => admin-guide}/blockdev/nbd.rst (100%)
 rename Documentation/{ => admin-guide}/blockdev/paride.rst (100%)
 rename Documentation/{ => admin-guide}/blockdev/ramdisk.rst (100%)
 rename Documentation/{ => admin-guide}/blockdev/zram.rst (100%)
 rename Documentation/{btmrvl.txt => admin-guide/btmrvl.rst} (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/blkio-controller.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/cgroups.rst (99%)
 rename Documentation/{ => admin-guide}/cgroup-v1/cpuacct.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/cpusets.rst (99%)
 rename Documentation/{ => admin-guide}/cgroup-v1/devices.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/freezer-subsystem.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/hugetlb.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/index.rst (97%)
 rename Documentation/{ => admin-guide}/cgroup-v1/memcg_test.rst (98%)
 rename Documentation/{ => admin-guide}/cgroup-v1/memory.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/net_cls.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/net_prio.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/pids.rst (100%)
 rename Documentation/{ => admin-guide}/cgroup-v1/rdma.rst (100%)
 rename Documentation/{clearing-warn-once.txt => admin-guide/clearing-warn-once.rst} (100%)
 rename Documentation/{cpu-load.txt => admin-guide/cpu-load.rst} (100%)
 rename Documentation/{cputopology.txt => admin-guide/cputopology.rst} (100%)
 rename Documentation/{ => admin-guide}/device-mapper/cache-policies.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/cache.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/delay.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-crypt.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-dust.txt (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-flakey.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-init.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-integrity.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-io.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-log.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-queue-length.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-raid.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-service-time.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-uevent.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/dm-zoned.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/era.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/index.rst (98%)
 rename Documentation/{ => admin-guide}/device-mapper/kcopyd.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/linear.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/log-writes.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/persistent-data.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/snapshot.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/statistics.rst (98%)
 rename Documentation/{ => admin-guide}/device-mapper/striped.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/switch.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/thin-provisioning.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/unstriped.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/verity.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/writecache.rst (100%)
 rename Documentation/{ => admin-guide}/device-mapper/zero.rst (100%)
 rename Documentation/{efi-stub.txt => admin-guide/efi-stub.rst} (100%)
 rename Documentation/{ => admin-guide}/gpio/index.rst (78%)
 rename Documentation/{ => admin-guide}/gpio/sysfs.rst (100%)
 rename Documentation/{highuid.txt => admin-guide/highuid.rst} (100%)
 rename Documentation/{hw_random.txt => admin-guide/hw_random.rst} (100%)
 rename Documentation/{iostats.txt => admin-guide/iostats.rst} (100%)
 rename Documentation/{ => admin-guide}/kdump/gdbmacros.txt (100%)
 rename Documentation/{ => admin-guide}/kdump/index.rst (97%)
 rename Documentation/{ => admin-guide}/kdump/kdump.rst (100%)
 rename Documentation/{ => admin-guide}/kdump/vmcoreinfo.rst (100%)
 rename Documentation/{kernel-per-CPU-kthreads.txt => admin-guide/kernel-per-CPU-kthreads.rst} (99%)
 rename Documentation/{ => admin-guide}/laptops/asus-laptop.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/disk-shock-protection.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/index.rst (84%)
 rename Documentation/{ => admin-guide}/laptops/laptop-mode.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/lg-laptop.rst (99%)
 rename Documentation/{ => admin-guide}/laptops/sony-laptop.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/sonypi.rst (100%)
 rename Documentation/{ => admin-guide}/laptops/thinkpad-acpi.rst (99%)
 rename Documentation/{ => admin-guide}/laptops/toshiba_haps.rst (100%)
 rename Documentation/{auxdisplay => admin-guide}/lcd-panel-cgram.rst (99%)
 rename Documentation/{ldm.txt => admin-guide/ldm.rst} (100%)
 rename Documentation/{lockup-watchdogs.txt => admin-guide/lockup-watchdogs.rst} (100%)
 rename Documentation/{cma/debugfs.rst => admin-guide/mm/cma_debugfs.rst} (98%)
 rename Documentation/{ => admin-guide}/namespaces/compatibility-list.rst (100%)
 rename Documentation/{ => admin-guide}/namespaces/index.rst (74%)
 rename Documentation/{ => admin-guide}/namespaces/resource-control.rst (100%)
 rename Documentation/{numastat.txt => admin-guide/numastat.rst} (100%)
 rename Documentation/{ => admin-guide}/perf/arm-ccn.rst (100%)
 rename Documentation/{ => admin-guide}/perf/arm_dsu_pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/hisi-pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/index.rst (85%)
 rename Documentation/{ => admin-guide}/perf/qcom_l2_pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/qcom_l3_pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/thunderx2-pmu.rst (100%)
 rename Documentation/{ => admin-guide}/perf/xgene-pmu.rst (100%)
 rename Documentation/{pnp.txt => admin-guide/pnp.rst} (100%)
 rename Documentation/{driver-api => admin-guide}/rapidio.rst (100%)
 rename Documentation/{rtc.txt => admin-guide/rtc.rst} (100%)
 rename Documentation/{svga.txt => admin-guide/svga.rst} (100%)
 rename Documentation/{ => admin-guide}/sysctl/abi.rst (100%)
 rename Documentation/{ => admin-guide}/sysctl/fs.rst (100%)
 rename Documentation/{ => admin-guide}/sysctl/index.rst (99%)
 rename Documentation/{ => admin-guide}/sysctl/kernel.rst (99%)
 rename Documentation/{ => admin-guide}/sysctl/net.rst (100%)
 rename Documentation/{ => admin-guide}/sysctl/sunrpc.rst (100%)
 rename Documentation/{ => admin-guide}/sysctl/user.rst (100%)
 rename Documentation/{ => admin-guide}/sysctl/vm.rst (99%)
 rename Documentation/{video-output.txt => admin-guide/video-output.rst} (100%)
 rename Documentation/{ => driver-api}/backlight/lp855x-driver.rst (99%)
 rename Documentation/{bt8xxgpio.txt => driver-api/bt8xxgpio.rst} (100%)
 rename Documentation/{connector => driver-api}/connector.rst (99%)
 rename Documentation/{console => driver-api}/console.rst (99%)
 rename Documentation/{dcdbas.txt => driver-api/dcdbas.rst} (100%)
 rename Documentation/{dell_rbu.txt => driver-api/dell_rbu.rst} (100%)
 rename Documentation/{ => driver-api}/driver-model/binding.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/bus.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/class.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/design-patterns.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/device.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/devres.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/driver.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/index.rst (96%)
 rename Documentation/{ => driver-api}/driver-model/overview.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/platform.rst (100%)
 rename Documentation/{ => driver-api}/driver-model/porting.rst (99%)
 rename Documentation/{ => driver-api}/early-userspace/buffer-format.rst (100%)
 rename Documentation/{ => driver-api}/early-userspace/early_userspace_support.rst (100%)
 rename Documentation/{ => driver-api}/early-userspace/index.rst (85%)
 rename Documentation/{EDID/howto.rst => driver-api/edid.rst} (98%)
 rename Documentation/{eisa.txt => driver-api/eisa.rst} (98%)
 rename Documentation/{interconnect => driver-api}/interconnect.rst (99%)
 rename Documentation/{isa.txt => driver-api/isa.rst} (100%)
 rename Documentation/{isapnp.txt => driver-api/isapnp.rst} (100%)
 rename Documentation/{lightnvm/pblk.txt => driver-api/lightnvm-pblk.rst} (100%)
 rename Documentation/{ => driver-api}/md/index.rst (71%)
 rename Documentation/{ => driver-api}/md/md-cluster.rst (100%)
 rename Documentation/{ => driver-api}/md/raid5-cache.rst (100%)
 rename Documentation/{ => driver-api}/md/raid5-ppl.rst (100%)
 create mode 100644 Documentation/driver-api/memory-devices/index.rst
 rename Documentation/{ => driver-api}/memory-devices/ti-emif.rst (98%)
 rename Documentation/{bus-devices => driver-api/memory-devices}/ti-gpmc.rst (99%)
 rename Documentation/{men-chameleon-bus.txt => driver-api/men-chameleon-bus.rst} (100%)
 rename Documentation/{ => driver-api}/mmc/index.rst (82%)
 rename Documentation/{ => driver-api}/mmc/mmc-async-req.rst (100%)
 rename Documentation/{ => driver-api}/mmc/mmc-dev-attrs.rst (100%)
 rename Documentation/{ => driver-api}/mmc/mmc-dev-parts.rst (100%)
 rename Documentation/{ => driver-api}/mmc/mmc-tools.rst (100%)
 rename Documentation/{ => driver-api}/mtd/index.rst (81%)
 rename Documentation/{ => driver-api}/mtd/intel-spi.rst (100%)
 rename Documentation/{ => driver-api}/mtd/nand_ecc.rst (100%)
 rename Documentation/{ => driver-api}/mtd/spi-nor.rst (100%)
 rename Documentation/{ => driver-api}/nfc/index.rst (78%)
 rename Documentation/{ => driver-api}/nfc/nfc-hci.rst (100%)
 rename Documentation/{ => driver-api}/nfc/nfc-pn544.rst (100%)
 rename Documentation/{ntb.txt => driver-api/ntb.rst} (100%)
 rename Documentation/{ => driver-api}/nvdimm/btt.rst (100%)
 rename Documentation/{ => driver-api}/nvdimm/index.rst (82%)
 rename Documentation/{ => driver-api}/nvdimm/nvdimm.rst (100%)
 rename Documentation/{ => driver-api}/nvdimm/security.rst (100%)
 rename Documentation/{nvmem => driver-api}/nvmem.rst (99%)
 rename Documentation/{parport-lowlevel.txt => driver-api/parport-lowlevel.rst} (100%)
 create mode 100644 Documentation/driver-api/phy/index.rst
 rename Documentation/{phy.txt => driver-api/phy/phy.rst} (100%)
 rename Documentation/{ => driver-api}/phy/samsung-usb2.rst (99%)
 rename Documentation/{pti => driver-api}/pti_intel_mid.rst (99%)
 rename Documentation/{pwm.txt => driver-api/pwm.rst} (100%)
 rename Documentation/{ => driver-api}/rapidio/index.rst (82%)
 rename Documentation/{ => driver-api}/rapidio/mport_cdev.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/rapidio.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/rio_cm.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/sysfs.rst (100%)
 rename Documentation/{ => driver-api}/rapidio/tsi721.rst (100%)
 rename Documentation/{rfkill.txt => driver-api/rfkill.rst} (100%)
 rename Documentation/{ => driver-api}/serial/cyclades_z.rst (100%)
 rename Documentation/{ => driver-api}/serial/driver.rst (99%)
 rename Documentation/{ => driver-api}/serial/index.rst (90%)
 rename Documentation/{ => driver-api}/serial/moxa-smartio.rst (100%)
 rename Documentation/{ => driver-api}/serial/n_gsm.rst (100%)
 rename Documentation/{ => driver-api}/serial/rocket.rst (100%)
 rename Documentation/{ => driver-api}/serial/serial-iso7816.rst (100%)
 rename Documentation/{ => driver-api}/serial/serial-rs485.rst (100%)
 rename Documentation/{ => driver-api}/serial/tty.rst (100%)
 rename Documentation/{sgi-ioc4.txt => driver-api/sgi-ioc4.rst} (100%)
 rename Documentation/{SM501.txt => driver-api/sm501.rst} (100%)
 rename Documentation/{smsc_ece1099.txt => driver-api/smsc_ece1099.rst} (100%)
 rename Documentation/{switchtec.txt => driver-api/switchtec.rst} (97%)
 rename Documentation/{sync_file.txt => driver-api/sync_file.rst} (100%)
 rename Documentation/{ => driver-api}/thermal/cpu-cooling-api.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/exynos_thermal_emulation.rst (100%)
 rename Documentation/{ => driver-api}/thermal/index.rst (86%)
 rename Documentation/{ => driver-api}/thermal/intel_powerclamp.rst (100%)
 rename Documentation/{ => driver-api}/thermal/nouveau_thermal.rst (100%)
 rename Documentation/{ => driver-api}/thermal/power_allocator.rst (100%)
 rename Documentation/{ => driver-api}/thermal/sysfs-api.rst (98%)
 rename Documentation/{ => driver-api}/thermal/x86_pkg_temperature_thermal.rst (94%)
 rename Documentation/{vfio-mediated-device.txt => driver-api/vfio-mediated-device.rst} (99%)
 rename Documentation/{vfio.txt => driver-api/vfio.rst} (100%)
 rename Documentation/{ => driver-api}/xilinx/eemi.rst (100%)
 rename Documentation/{ => driver-api}/xilinx/index.rst (94%)
 rename Documentation/{xillybus.txt => driver-api/xillybus.rst} (100%)
 rename Documentation/{zorro.txt => driver-api/zorro.rst} (100%)
 rename Documentation/security/{LSM.rst => lsm-development.rst} (100%)
 rename Documentation/{lsm.txt => security/lsm.rst} (100%)
 rename Documentation/{SAK.txt => security/sak.rst} (100%)
 rename Documentation/{siphash.txt => security/siphash.rst} (100%)
 rename Documentation/{ => userspace-api}/accelerators/ocxl.rst (99%)
 rename Documentation/{Intel-IOMMU.txt => x86/intel-iommu.rst} (100%)
 rename Documentation/{intel_txt.txt => x86/intel_txt.rst} (100%)

-- 
2.21.0


