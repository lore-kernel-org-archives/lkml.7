Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA0DC48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DF320652
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561224747;
	bh=9FwO2D/s4lKD/6KJ1DKOzc3DYUdSpYW7sFZUqiXUO+o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GPSuXbyJBnBcYIpqNp5TC5NPaJuhNolJM8+TKzs15aA9zZ70DZnT31NAhXOOJGfrc
	 vSbWY6RrVEIhCFAciGEnQ5ApaavI029FlE7b7/+sx4FQ1u5TlpOyrGkncCJFr6yvwZ
	 On38wEGnQW+mNmuQ2FO/3/d9eutbi2phng7vRVew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfFVRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:32:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfFVRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LYvD0SkaRvCNw3DeXdCNf59ut30pmqyr5CJXUF3fCo8=; b=n2TVkKWEaHqdMhFtjM33CRITs
        iB8r/4rHrOm6KLB/1+drUAm+DQvkMI2RGNxYNBeUwHTkFJ01Mbh8uWE8XagU/RkCJbNYS8vYPAjGf
        QC7RavKtLfuJ7wFc3wT7cCy8mlYsxFH0z4/ty0+bfBsPGEqi/WUTO9pdOmAqMXdFJgssp1wVFvJqN
        7cpect3aka0KZ6D1Af9+yHTTrvDQ60+7gw9tnlW/m8z+54/XtqhNRgY7l9NeblE/rrvDTUftebeX8
        MYHYjNPWB51fsaMhSZSr9dvSWKDOBfKrNeIS5RSbdAEz36npW1tDWPy9kREzaIDafPRRKZ2MtNv7C
        5uOz2YcKw==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejrs-00076e-26; Sat, 22 Jun 2019 17:32:00 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejrq-0001H5-3z; Sat, 22 Jun 2019 14:31:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [RFC v2 0/8]Produce ABI guide without escaping ReST source  files
Date:   Sat, 22 Jun 2019 14:31:48 -0300
Message-Id: <cover.1561224093.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

It turns out that fixing ABI/testing for it to be parsed transparently
was easy :-)

This series goes on top of the series I pasted early today:

	Subject: [PATCH 00/12] Add the ABI documentation to the admin guide
	
It basically change the ABI parser to not try to escape ReST code.

With that, the descriptions inside the ABI files should now be compatible 
with ReST output.

Patch 1 states that at ABI/README;

Patch 2 and 3 fix troubles at stable and testing ABI files. No changes at the
content of the ABI themselves. Most of the changes there are due to some
examples, tables and some parameter descriptions with weird formats.

Patch 4 enables the "clear mode" for stable;

Patch 5 is just a helper patch: it adds a second level to the ABI index, in order
to allow seeing what sections the parsed files will produce;

patch 6 enables "clear mode" to obsolete and removed;

patch 7 enables "clear mode" to testing

-

Patch 8 is here just for us not to forget it - it causes any COMPILE_TEST
build to validate if the ABI files are following the syntax described at
ABI/README. It won't try to build it with Sphinx, though. As this is quick
(~100ms on my desktop), I think it is worth to have it.

Mauro Carvalho Chehab (8):
  docs: ABI: README: specify that files should be ReST compatible
  docs: ABI: stable: make files ReST compatible
  docs: ABI: testing: make the files compatible with ReST output
  docs: ABI: make it parse ABI/stable as ReST-compatible files
  docs: ABI: create a 2-depth index for ABI
  docs: ABI: don't escape ReST-incompatible chars from obsolete and
    removed
  docs: abi-testing.rst: enable --rst-sources when building docs
  docs: Kconfig/Makefile: add a check for broken ABI files

 Documentation/ABI/README                      |  10 +-
 Documentation/ABI/obsolete/sysfs-gpio         |   2 +
 Documentation/ABI/stable/firewire-cdev        |   4 +
 Documentation/ABI/stable/sysfs-acpi-pmprofile |  22 +-
 Documentation/ABI/stable/sysfs-bus-firewire   |   3 +
 Documentation/ABI/stable/sysfs-bus-nvmem      |  19 +-
 Documentation/ABI/stable/sysfs-bus-usb        |   6 +-
 .../ABI/stable/sysfs-class-backlight          |   1 +
 .../ABI/stable/sysfs-class-infiniband         |  97 +++++--
 Documentation/ABI/stable/sysfs-class-rfkill   |  13 +-
 Documentation/ABI/stable/sysfs-class-tpm      |  90 +++----
 Documentation/ABI/stable/sysfs-devices        |   5 +-
 Documentation/ABI/stable/sysfs-driver-ib_srp  |   1 +
 .../ABI/stable/sysfs-firmware-efi-vars        |   4 +
 .../ABI/stable/sysfs-firmware-opal-dump       |   5 +
 .../ABI/stable/sysfs-firmware-opal-elog       |   2 +
 Documentation/ABI/stable/sysfs-hypervisor-xen |   3 +
 Documentation/ABI/stable/vdso                 |   5 +-
 .../ABI/testing/configfs-spear-pcie-gadget    |  36 +--
 Documentation/ABI/testing/configfs-usb-gadget |  77 +++---
 .../ABI/testing/configfs-usb-gadget-hid       |  10 +-
 .../ABI/testing/configfs-usb-gadget-rndis     |  16 +-
 .../ABI/testing/configfs-usb-gadget-uac1      |  18 +-
 .../ABI/testing/configfs-usb-gadget-uvc       | 220 +++++++++-------
 Documentation/ABI/testing/debugfs-ec          |  11 +-
 Documentation/ABI/testing/debugfs-pktcdvd     |  11 +-
 Documentation/ABI/testing/dev-kmsg            |  27 +-
 Documentation/ABI/testing/evm                 |  17 +-
 Documentation/ABI/testing/ima_policy          | 132 +++++-----
 Documentation/ABI/testing/procfs-diskstats    |  40 +--
 Documentation/ABI/testing/sysfs-block         |  26 +-
 Documentation/ABI/testing/sysfs-block-device  |   2 +
 Documentation/ABI/testing/sysfs-bus-acpi      |  18 +-
 .../sysfs-bus-event_source-devices-format     |   3 +-
 .../ABI/testing/sysfs-bus-i2c-devices-pca954x |  27 +-
 Documentation/ABI/testing/sysfs-bus-iio       |  10 +
 .../sysfs-bus-iio-adc-envelope-detector       |   5 +-
 .../ABI/testing/sysfs-bus-iio-cros-ec         |   2 +-
 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 |  10 +-
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32   |  29 ++-
 .../sysfs-bus-iio-magnetometer-hmc5843        |  19 +-
 .../sysfs-bus-iio-temperature-max31856        |  19 +-
 .../ABI/testing/sysfs-bus-iio-timer-stm32     | 114 +++++----
 .../testing/sysfs-bus-intel_th-devices-msc    |   4 +
 .../testing/sysfs-bus-pci-devices-aer_stats   | 119 +++++----
 Documentation/ABI/testing/sysfs-bus-rapidio   |  23 +-
 .../ABI/testing/sysfs-bus-thunderbolt         |  40 +--
 Documentation/ABI/testing/sysfs-bus-usb       |  30 ++-
 .../testing/sysfs-bus-usb-devices-usbsevseg   |   7 +-
 Documentation/ABI/testing/sysfs-bus-vfio-mdev |  10 +-
 Documentation/ABI/testing/sysfs-class-cxl     |  15 +-
 Documentation/ABI/testing/sysfs-class-led     |   2 +-
 Documentation/ABI/testing/sysfs-class-mic.txt |  52 ++--
 Documentation/ABI/testing/sysfs-class-ocxl    |   3 +
 Documentation/ABI/testing/sysfs-class-power   |  73 +++++-
 .../ABI/testing/sysfs-class-power-twl4030     |  33 +--
 Documentation/ABI/testing/sysfs-class-rc      |  30 ++-
 .../ABI/testing/sysfs-class-scsi_host         |   7 +-
 Documentation/ABI/testing/sysfs-class-typec   |  12 +-
 .../testing/sysfs-devices-platform-ACPI-TAD   |   4 +
 .../ABI/testing/sysfs-devices-platform-docg3  |  10 +-
 .../sysfs-devices-platform-sh_mobile_lcdc_fb  |   8 +-
 .../ABI/testing/sysfs-devices-system-cpu      |  99 +++++---
 .../ABI/testing/sysfs-devices-system-ibm-rtl  |   6 +-
 .../testing/sysfs-driver-bd9571mwv-regulator  |   4 +
 Documentation/ABI/testing/sysfs-driver-genwqe |  11 +-
 .../testing/sysfs-driver-hid-logitech-lg4ff   |  18 +-
 .../ABI/testing/sysfs-driver-hid-wiimote      |  11 +-
 .../ABI/testing/sysfs-driver-samsung-laptop   |  13 +-
 .../ABI/testing/sysfs-driver-toshiba_acpi     |  26 ++
 .../ABI/testing/sysfs-driver-toshiba_haps     |   2 +
 Documentation/ABI/testing/sysfs-driver-wacom  |   4 +-
 Documentation/ABI/testing/sysfs-firmware-acpi | 237 +++++++++---------
 .../ABI/testing/sysfs-firmware-dmi-entries    |  50 ++--
 Documentation/ABI/testing/sysfs-firmware-gsmi |   2 +-
 .../ABI/testing/sysfs-firmware-memmap         |  16 +-
 Documentation/ABI/testing/sysfs-fs-ext4       |   4 +-
 .../ABI/testing/sysfs-hypervisor-xen          |  13 +-
 .../ABI/testing/sysfs-kernel-boot_params      |  23 +-
 .../ABI/testing/sysfs-kernel-mm-hugepages     |  12 +-
 .../ABI/testing/sysfs-platform-asus-laptop    |  21 +-
 .../ABI/testing/sysfs-platform-asus-wmi       |   1 +
 Documentation/ABI/testing/sysfs-platform-at91 |  10 +-
 .../ABI/testing/sysfs-platform-eeepc-laptop   |  14 +-
 .../ABI/testing/sysfs-platform-ideapad-laptop |   9 +-
 .../sysfs-platform-intel-wmi-thunderbolt      |   1 +
 .../ABI/testing/sysfs-platform-sst-atom       |  13 +-
 .../ABI/testing/sysfs-platform-usbip-vudc     |  11 +-
 Documentation/ABI/testing/sysfs-ptp           |   2 +-
 Documentation/ABI/testing/sysfs-uevent        |  10 +-
 Documentation/Kconfig                         |  11 +
 Documentation/Makefile                        |   5 +
 Documentation/admin-guide/abi-obsolete.rst    |   1 +
 Documentation/admin-guide/abi-removed.rst     |   1 +
 Documentation/admin-guide/abi-stable.rst      |   1 +
 Documentation/admin-guide/abi-testing.rst     |   1 +
 Documentation/admin-guide/abi.rst             |   2 +-
 Documentation/sphinx/kernel_abi.py            |   8 +-
 lib/Kconfig.debug                             |   2 +
 scripts/get_abi.pl                            |  14 +-
 100 files changed, 1457 insertions(+), 905 deletions(-)
 create mode 100644 Documentation/Kconfig

-- 
2.21.0


