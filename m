Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70912C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447A2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KwVWGnML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCHUd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:33:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfCHUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lEZe74g5fDUGmIxZz6wjPQPPpjENW5ua1e86Z7HlcpI=; b=KwVWGnML9V15ZL0zEip5C9OX1
        ltAgPWyu+6P11NIbU28Sa84/mo+fi2aC3S2D+jPZDYwgJUU+O7DBCOKYC7IKtiBpYebcbHX7tJS0q
        PQ2Qcc0f8bBlLlNeY2+25zXWFqypJrzGsuT5FuzUS8eXhKDL9i5AOCm1F/sP5jafCYV/vi1E71x3w
        BLN/REei0Z24EmVjgZiYownDwSGxj3/gRmiMeXC0puy0KCH2XJqwhNSEVHhcJTMJiYeVZVhLe+e9U
        65k+F4r3Gwbor/sHZB884CrPoSWsremIijFRXlCOR3tvM45cIZ55oCTlAByjqWtzZALxK0FLY0y/z
        bT5WXgLfA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2MBL-0000Dx-HQ; Fri, 08 Mar 2019 20:33:27 +0000
Date:   Fri, 8 Mar 2019 12:33:26 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.1-1
Message-ID: <20190308203326.GA48374@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The wmi mod alias changes collide with a similar series for TEE based devices. I
have provided my merge resolution here:

  git://git.infradead.org/linux-platform-drivers-x86.git pdx86-5.1-1-merge

This series includes two previously merged patches from the RC cycle:
- 522e4ee6e5 Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0
- ff7c634b4f x86/CPU: Add Icelake model number

Thanks,

Darren Hart
VMware Open Source Technology Center

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.1-1

for you to fetch changes up to 9c22cc020db637850ba47a14a598d09f706f19ad:

  MAINTAINERS: Include mlxreg.h in Mellanox Platform Driver files (2019-03-07 08:46:29 -0800)

----------------------------------------------------------------
platform-drivers-x86 for v5.1-1

Use MODULE_DEVICE_TABLE across several wmi drivers, keeping
wmi_device_id and MODULE_ALIAS() declarations in sync. Add several
Ideapad models to the no_hw_rfkill list. Add support for new Mellanox
platforms, including new fan and LED functionality. Address Dell
keyboard backlight change event and power button release issues. Update
dell_rbu to use appropriate memory allocation mechanisms. Several small
fixes and Ice Lake support for intel_pmc_core. Fix a suspend regression
for Cherry Trail based devices in intel_int0002_vgpio. A few other
routine fixes.

The following is an automated git shortlog grouped by driver:

ACPI / scan:
 -  Create platform device for BSG2150 ACPI nodes

Documentation/ABI:
 -  Add new attribute for mlxreg-io sysfs interfaces
 -  Correct mlxreg-io KernelVersion for 5.0

MAINTAINERS:
 -  Include mlxreg.h in Mellanox Platform Driver files

asus-wmi:
 -  Allow loading on systems without the Asus Management GUID

dell-smbios-wmi:
 -  use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

dell-wmi:
 -  use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
 -  Ignore new keyboard backlight change event

dell-wmi-descriptor:
 -  use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

dell_rbu:
 -  fix lock imbalance in img_update_realloc
 -  stop abusing the DMA API

huawei-wmi:
 -  use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

ideapad-laptop:
 -  Add ideapad 330-15ICH to no_hw_rfkill
 -  Add S130-14IGM to no_hw_rfkill list
 -  Add Ideapad 530S-14ARR to no_hw_rfkill list
 -  Add Yoga C930 to no_hw_rfkill_list
 -  Add Y530-I5ICH-1060 to no_hw_rfkill list
 -  Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN

intel-hid:
 -  Missing power button release on some Dell models

intel-wmi-thunderbolt:
 -  use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

intel_int0002_vgpio:
 -  Only implement irq_set_wake on Bay Trail

intel_pmc_core:
 -  Quirk to ignore XTAL shutdown
 -  Add Package cstates residency info
 -  Add ICL platform support
 -  Convert to INTEL_CPU_FAM6 macro
 -  Avoid a u32 overflow
 -  Include Reserved IP for LTR
 -  Fix file permissions for ltr_show
 -  Fix PCH IP name
 -  Fix PCH IP sts reading
 -  Handle CFL regmap properly

leds:
 -  mlxreg: Add support for capability register

mlx-platform:
 -  Fix access mode for fan_dir attribute
 -  Add UID LED for the next generation systems
 -  Add extra CPLD for next generation systems
 -  Add support for new VMOD0007 board name
 -  Add support for fan capability registers
 -  Add support for fan direction register

modpost:
 -  file2alias: define size of alias

platform/mellanox:
 -  mlxreg-hotplug: Fix KASAN warning

platform_data/mlxreg:
 -  Add capability field to core platform data
 -  Document fixes for core platform data

touchscreen_dmi:
 -  Add info for the CHUWI Hi10 Air tablet
 -  Add info for the Chuwi Hi8 Air tablet
 -  Add info for the PoV Wintab P1006w (v1.0) tablet

wmi:
 -  add WMI support to MODULE_DEVICE_TABLE()
 -  move struct wmi_device_id to mod_devicetable.h
 -  fix potential null pointer dereference

wmi-bmof:
 -  use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

x86/CPU:
 -  Add Icelake model number

----------------------------------------------------------------
Anthony Wong (1):
      platform/x86: ideapad: Add ideapad 330-15ICH to no_hw_rfkill

Christian Oder (1):
      platform/x86: touchscreen_dmi: Add info for the CHUWI Hi10 Air tablet

Christoph Hellwig (2):
      platform/x86: dell_rbu: stop abusing the DMA API
      platform/x86: dell_rbu: fix lock imbalance in img_update_realloc

Darren Hart (VMware) (2):
      Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0
      MAINTAINERS: Include mlxreg.h in Mellanox Platform Driver files

Felix Eckhofer (1):
      platform/x86: ideapad-laptop: Add S130-14IGM to no_hw_rfkill list

Hans de Goede (4):
      ACPI / scan: Create platform device for BSG2150 ACPI nodes
      platform/x86: touchscreen_dmi: Add info for the PoV Wintab P1006w (v1.0) tablet
      platform/x86: intel_int0002_vgpio: Only implement irq_set_wake on Bay Trail
      platform/x86: asus-wmi: Allow loading on systems without the Asus Management GUID

Hugo Trovao (1):
      platform/x86: ideapad-laptop: Add Yoga C930 to no_hw_rfkill_list

Jérôme de Bretagne (1):
      platform/x86: intel-hid: Missing power button release on some Dell models

Kai Renzig (1):
      platform/x86: touchscreen_dmi: Add info for the Chuwi Hi8 Air tablet

Kai-Heng Feng (2):
      platform/x86: dell-wmi: Ignore new keyboard backlight change event
      platform/x86: ideapad-laptop: Add Ideapad 530S-14ARR to no_hw_rfkill list

Mark Levedahl (1):
      platform/x86: ideapad-laptop: Add Y530-I5ICH-1060 to no_hw_rfkill list

Mattias Jacobsson (10):
      platform/x86: wmi: fix potential null pointer dereference
      modpost: file2alias: define size of alias
      platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
      platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
      platform/x86: dell-smbios-wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
      platform/x86: dell-wmi-descriptor: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
      platform/x86: dell-wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
      platform/x86: huawei-wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
      platform/x86: intel-wmi-thunderbolt: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
      platform/x86: wmi-bmof: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()

Rajat Jain (1):
      platform/x86: intel_pmc_core: Avoid a u32 overflow

Rajneesh Bhardwaj (10):
      platform/x86: intel_pmc_core: Handle CFL regmap properly
      platform/x86: intel_pmc_core: Fix PCH IP sts reading
      platform/x86: intel_pmc_core: Fix PCH IP name
      platform/x86: intel_pmc_core: Fix file permissions for ltr_show
      platform/x86: intel_pmc_core: Include Reserved IP for LTR
      x86/CPU: Add Icelake model number
      platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
      platform/x86: intel_pmc_core: Add ICL platform support
      platform/x86: intel_pmc_core: Add Package cstates residency info
      platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown

Vadim Pasternak (11):
      platform/x86: mlx-platform: Add support for fan direction register
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
      platform_data/mlxreg: Document fixes for core platform data
      platform_data/mlxreg: Add capability field to core platform data
      platform/x86: mlx-platform: Add support for fan capability registers
      platform/x86: mlx-platform: Add support for new VMOD0007 board name
      platform/mellanox: mlxreg-hotplug: Fix KASAN warning
      leds: mlxreg: Add support for capability register
      platform/x86: mlx-platform: Add extra CPLD for next generation systems
      platform/x86: mlx-platform: Add UID LED for the next generation systems
      platform/x86: mlx-platform: Fix access mode for fan_dir attribute

Yang Fan (1):
      platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN

 Documentation/ABI/stable/sysfs-driver-mlxreg-io |  20 ++-
 MAINTAINERS                                     |   1 +
 arch/x86/include/asm/intel-family.h             |   2 +
 drivers/acpi/scan.c                             |   1 +
 drivers/leds/leds-mlxreg.c                      |  19 +++
 drivers/platform/mellanox/mlxreg-hotplug.c      |  28 ++++-
 drivers/platform/x86/asus-wmi.c                 |   9 +-
 drivers/platform/x86/dell-smbios-wmi.c          |   2 +-
 drivers/platform/x86/dell-wmi-descriptor.c      |   2 +-
 drivers/platform/x86/dell-wmi.c                 |   7 +-
 drivers/platform/x86/dell_rbu.c                 |  50 +++-----
 drivers/platform/x86/huawei-wmi.c               |   3 +-
 drivers/platform/x86/i2c-multi-instantiate.c    |   9 ++
 drivers/platform/x86/ideapad-laptop.c           |  37 +++++-
 drivers/platform/x86/intel-hid.c                |   7 +-
 drivers/platform/x86/intel-wmi-thunderbolt.c    |   2 +-
 drivers/platform/x86/intel_int0002_vgpio.c      |  32 ++++-
 drivers/platform/x86/intel_pmc_core.c           | 159 ++++++++++++++++++++----
 drivers/platform/x86/intel_pmc_core.h           |  14 ++-
 drivers/platform/x86/mlx-platform.c             | 105 ++++++++++++++++
 drivers/platform/x86/touchscreen_dmi.c          |  79 ++++++++++++
 drivers/platform/x86/wmi-bmof.c                 |   2 +-
 drivers/platform/x86/wmi.c                      |   5 +-
 include/linux/mod_devicetable.h                 |  12 ++
 include/linux/platform_data/mlxreg.h            |   6 +-
 include/linux/wmi.h                             |   5 +-
 scripts/mod/devicetable-offsets.c               |   3 +
 scripts/mod/file2alias.c                        |  28 ++++-
 28 files changed, 546 insertions(+), 103 deletions(-)

-- 
Darren Hart
VMware Open Source Technology Center
