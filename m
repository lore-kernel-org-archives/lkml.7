Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD843C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B322054F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558363698;
	bh=jZJwogitDK2MhnzmV78AEBG/ddAnm5Vv8Bm2hD7hUjQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g//U0JLUTiyjSg+rCDNeCiY0jKRRBNyvv/YaVWkWnUgfaIY7hKMTtFmL3HSnrnL1S
	 Xw8cjdQocB1tqsFk104bE+1zPg1z96Xa5MRFHVRALuQTgM2xz9hQLzYSz/FFgRmA2c
	 2FWEhuAXomWhO5arNELfs+y4/1i2NOdkfsIUwQCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392078AbfETOsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:48:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392061AbfETOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vVHp8mOWmedrndUR5L2vnWJIylwIXvsfY4K0aos+6CI=; b=DxHhUVlzt2iJixNr6Pi/XXTGl
        dJ5rX9lt9r/k+ab9nVFKnh/X6rGK5fl6EVUgLulHeAlNhXurPncne8yfmqj7qv9pSzci/orPQy8QY
        PpyaksLsUdIYgAOsWNd2Wzh766N7tIJDXCjjpqb9ClmShpMuV4XTZIob6cv/d1bsYT2Iam+JRFdxk
        pw4ekXZ1cl7jk8L+ELc4XF6ugpU8B7BuZWZfHuvZhDWDPC1iLWCEIWCCXa+OJlQCw+3Uk8f3aPI+m
        LV+uDACRFpxnsjk7EqD7VFYxgRyKNhw/tWtWEfYk33BwUu1oxncS1lEgP0kFDqAhVqI4bHUglVIGY
        qJo/idIjA==;
Received: from [179.176.119.151] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSjaC-0000Ud-HE; Mon, 20 May 2019 14:48:08 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hSjZo-00010a-90; Mon, 20 May 2019 11:47:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 00/10] Fix broken documentation references at v5.2-rc1
Date:   Mon, 20 May 2019 11:47:29 -0300
Message-Id: <cover.1558362030.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several broken Documentation/* references within the Kernel
tree. There are some reasons for several of them:

1. The acpi and x86 documentation files were renamed, but the
   references weren't updated;
2. The DT files have been converted to JSON format, causing them
   to be renamed;
3. Translated files point to future translation work still pending merge
   or require some action from someone that it is fluent at the
   translated language;
4. Some files (specially at DT) weren't accepted yet, but there are already
   references for them (at MAINTAINERS and on other DT files);
5. Some files got removed without addressing Documentation, with
   needs them to describe some things.

This series addresses problems 1 and 2, plus other random trivial
breakages. Problems 3 to 5 depend on either accepting a patch or
some specific knowledge. So, won't be addressed by this series.

The first 4 patches improve the documentation script to address some
corner cases I detected while doing this series. The remaining ones are
documentation fixes, being the last one having just trivial renaming
stuff all over the Kernel tree.

After this series, only those warnings will be reported on v5.2-rc1:

Removed file without a non-trivial documentation adjustment:

    Documentation/cgroup-v1/blkio-controller.txt: Documentation/block/cfq-iosched.txt
    Documentation/cgroup-v1/blkio-controller.txt: Documentation/block/cfq-iosched.txt

The documentation file uses cfq as an example, but it got removed
recently. Some parts of doc should be re-written to use another
scheduler as an example.

Files pending addition (as far as I identified, there were e-mails asking
their inclusions, but it didn't happen upstream yet):

    Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt: Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
    Documentation/driver-api/generic-counter.rst: Documentation/ABI/testing/sys-bus-counter-generic-sysfs
    Documentation/driver-api/generic-counter.rst: Documentation/ABI/testing/sys-bus-counter
    MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt

Translation files with broken stuff:

    Documentation/translations/it_IT/process/adding-syscalls.rst: Documentation/translations/it_IT/filesystems/sysfs.txt
    Documentation/translations/it_IT/process/coding-style.rst: Documentation/translations/it_IT/kbuild/kconfig-language.txt
    Documentation/translations/it_IT/process/magic-number.rst: Documentation/process/magic-numbers.rst
    Documentation/translations/zh_CN/basic_profiling.txt: Documentation/basic_profiling
    Documentation/translations/zh_CN/basic_profiling.txt: Documentation/basic_profiling
    Documentation/translations/zh_CN/process/howto.rst: Documentation/DocBook/

Mauro Carvalho Chehab (10):
  scripts/documentation-file-ref-check: better handle translations
  scripts/documentation-file-ref-check: exclude false-positives
  scripts/documentation-file-ref-check: improve tools ref handling
  scripts/documentation-file-ref-check: teach about .txt -> .yaml
    renames
  ABI: sysfs-devices-system-cpu: point to the right docs
  isdn: mISDN: remove a bogus reference to a non-existing doc
  mfd: madera: point to the right pinctrl binding file
  dt: fix refs that were renamed to json with the same file name
  dt: fix broken references to nand.txt
  docs: fix broken documentation links

 .../ABI/testing/sysfs-devices-system-cpu      |  3 +-
 Documentation/acpi/dsd/leds.txt               |  2 +-
 .../admin-guide/kernel-parameters.rst         |  6 +--
 .../admin-guide/kernel-parameters.txt         | 16 +++----
 Documentation/admin-guide/ras.rst             |  2 +-
 .../devicetree/bindings/arm/omap/crossbar.txt |  2 +-
 .../bindings/clock/samsung,s5pv210-clock.txt  |  2 +-
 .../marvell,odmi-controller.txt               |  2 +-
 .../bindings/leds/irled/spi-ir-led.txt        |  2 +-
 .../bindings/mtd/amlogic,meson-nand.txt       |  2 +-
 .../devicetree/bindings/mtd/gpmc-nand.txt     |  2 +-
 .../devicetree/bindings/mtd/marvell-nand.txt  |  2 +-
 .../devicetree/bindings/mtd/tango-nand.txt    |  2 +-
 .../devicetree/bindings/net/fsl-enetc.txt     |  7 ++-
 .../bindings/pci/amlogic,meson-pcie.txt       |  2 +-
 .../regulator/qcom,rpmh-regulator.txt         |  2 +-
 .../devicetree/booting-without-of.txt         |  2 +-
 Documentation/driver-api/gpio/board.rst       |  2 +-
 Documentation/driver-api/gpio/consumer.rst    |  2 +-
 .../firmware-guide/acpi/enumeration.rst       |  2 +-
 .../firmware-guide/acpi/method-tracing.rst    |  2 +-
 Documentation/i2c/instantiating-devices       |  2 +-
 Documentation/sysctl/kernel.txt               |  4 +-
 .../translations/it_IT/process/4.Coding.rst   |  2 +-
 .../translations/it_IT/process/howto.rst      |  2 +-
 .../it_IT/process/stable-kernel-rules.rst     |  4 +-
 .../translations/zh_CN/process/4.Coding.rst   |  2 +-
 Documentation/x86/x86_64/5level-paging.rst    |  2 +-
 Documentation/x86/x86_64/boot-options.rst     |  4 +-
 .../x86/x86_64/fake-numa-for-cpusets.rst      |  2 +-
 MAINTAINERS                                   | 10 ++---
 arch/arm/Kconfig                              |  2 +-
 arch/arm64/kernel/kexec_image.c               |  2 +-
 arch/powerpc/Kconfig                          |  2 +-
 arch/x86/Kconfig                              | 16 +++----
 arch/x86/Kconfig.debug                        |  2 +-
 arch/x86/boot/header.S                        |  2 +-
 arch/x86/entry/entry_64.S                     |  2 +-
 arch/x86/include/asm/bootparam_utils.h        |  2 +-
 arch/x86/include/asm/page_64_types.h          |  2 +-
 arch/x86/include/asm/pgtable_64_types.h       |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c           |  2 +-
 arch/x86/kernel/kexec-bzimage64.c             |  2 +-
 arch/x86/kernel/pci-dma.c                     |  2 +-
 arch/x86/mm/tlb.c                             |  2 +-
 arch/x86/platform/pvh/enlighten.c             |  2 +-
 drivers/acpi/Kconfig                          | 10 ++---
 drivers/isdn/mISDN/dsp_core.c                 |  2 -
 drivers/net/ethernet/faraday/ftgmac100.c      |  2 +-
 .../fieldbus/Documentation/fieldbus_dev.txt   |  4 +-
 drivers/vhost/vhost.c                         |  2 +-
 include/acpi/acpi_drivers.h                   |  2 +-
 include/linux/fs_context.h                    |  2 +-
 include/linux/lsm_hooks.h                     |  2 +-
 include/linux/mfd/madera/pdata.h              |  3 +-
 mm/Kconfig                                    |  2 +-
 scripts/documentation-file-ref-check          | 44 +++++++++++++++----
 security/Kconfig                              |  2 +-
 tools/include/linux/err.h                     |  2 +-
 .../Documentation/stack-validation.txt        |  4 +-
 tools/testing/selftests/x86/protection_keys.c |  2 +-
 61 files changed, 127 insertions(+), 102 deletions(-)

-- 
2.21.0


