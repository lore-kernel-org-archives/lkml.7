Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70856C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A9620644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfGNOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 10:54:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:39785 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:54:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 07:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,490,1557212400"; 
   d="scan'208";a="160863373"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2019 07:53:39 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hmfsf-0003xc-RA; Sun, 14 Jul 2019 17:53:37 +0300
Date:   Sun, 14 Jul 2019 17:53:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.3-1
Message-ID: <20190714145337.GA15206@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Gathered bunch of PDx86 changes. It's rather big, since includes two big
refactors and completely new driver. Nevertheless, no conflicts for merge
with current HEAD.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit d6423bd03031c020121da26c41a26bd5cc6d0da3:

  platform/x86: pmc_atom: Add several Beckhoff Automation boards to critclk_systems DMI table (2019-05-20 17:26:40 +0300)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.3-1

for you to fetch changes up to 7d67c8ac25fbc66ee254aa3e33329d1c9bc152ce:

  platform/x86: Fix PCENGINES_APU2 Kconfig warning (2019-07-12 16:00:38 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.3-1

ASUS WMI driver got a big refactoring in order to support the TUF Gaming
laptops. Besides that, the regression with backlight being permanently off
on various EeePC laptops has been fixed.

Accelerometer on HP ProBook 450 G0 shows wrong measurements due to
X axis being inverted. This has been fixed.

Intel PMC core driver has been extended to be ACPI enumerated
if the DSDT provides device with _HID "INT33A1". This allows
to convert the driver to be pure platform and support new hardware
purely based on ACPI DSDT.

From now on the Intel Speed Select Technology is supported thru
a corresponding driver. This driver provides an access to the features
of the ISST, such as Performance Profile, Core Power, Base frequency and
Turbo Frequency.

Mellanox platform drivers has been refactored and now extended
to support more systems, including new coming ones.

The OLPC XO-1.75 platform is now supported.

CB4063 Beckhoff Automation board is using PMC clocks,
provided via pmc_atom driver, for ethernet controllers in a way
that they can't be managed by the clock driver. The quirk
has been extended to cover this case.

Touchscreen on Chuwi Hi10 Plus tablet has been enabled. Meanwhile
the information of Chuwi Hi10 Air has been fixed to cover more models
based on the same platform.

Xiaomi notebooks have WMI interface enabled. Thus, the driver to support it
has been provided. It required some extension of the generic WMI library,
which allows to propagate opaque context to the ->probe() of the
individual drivers.

This release includes debugfs clean up from Greg KH for several drivers
that drop return code check and make debugfs absence or failure non-fatal.

Miscellaneous fixes here and there, mostly for Acer WMI and
various Intel drivers.

The listed below commits are duplicated due to previously pushed fixes in v5.2 cycle:
- 1dd93f873d8e platform/x86: asus-wmi: Only Tell EC the OS will handle display hotkeys from asus_nb_wmi
- 89ae3a073625 platform/x86: intel-vbtn: Report switch events when event wakes device
- fa882fc80dc8 platform/x86: mlx-platform: Fix parent device in i2c-mux-reg device registration
- 0bfcd24b39c2 platform/mellanox: mlxreg-hotplug: Add devm_free_irq call to remove flow

The following is an automated git shortlog grouped by driver:

acer-wmi:
 -  Mark expected switch fall-throughs
 -  no need to check return value of debugfs_create functions

asus-nb-wmi:
 -  Add microphone mute key code

asus-wmi:
 -  Use dev_get_drvdata()
 -  Do not disable keyboard backlight on unloading
 -  Switch fan boost mode
 -  Enhance detection of thermal data
 -  Organize code into sections
 -  Refactor error handling
 -  Support WMI event queue
 -  Refactor WMI event handling
 -  Improve DSTS WMI method ID detection
 -  Increase input buffer size of WMI methods
 -  Fix preserving keyboard backlight intensity on load
 -  Fix hwmon device cleanup
 -  no need to check return value of debugfs_create functions
 -  Only Tell EC the OS will handle display hotkeys from asus_nb_wmi

dell-laptop:
 -  no need to check return value of debugfs_create functions

hp_accel:
 -  Add support for HP ProBook 450 G0

ideapad-laptop:
 -  no need to check return value of debugfs_create functions

intel_int0002_vgpio:
 -  Get rid of custom ICPU() macro

intel_menlow:
 -  avoid null pointer deference error

intel_pmc:
 -  no need to check return value of debugfs_create functions

intel_pmc_core:
 -  Attach using APCI HID "INT33A1"
 -  transform Pkg C-state residency from TSC ticks into microseconds

intel_telemetry:
 -  no need to check return value of debugfs_create functions

intel-vbtn:
 -  Report switch events when event wakes device

ISST:
 -  Restore state on resume
 -  Add Intel Speed Select PUNIT MSR interface
 -  Add Intel Speed Select mailbox interface via MSRs
 -  Add Intel Speed Select mailbox interface via PCI
 -  Add Intel Speed Select mmio interface
 -  Add IOCTL to Translate Linux logical CPU to PUNIT CPU number
 -  Store per CPU information
 -  Add common API to register and handle ioctls
 -  Update ioctl-number.txt for Intel Speed Select interface
 -  A tool to validate Intel Speed Select commands
 -  Add .gitignore file

MAINTAINERS:
 -  Update for Intel Speed Select Technology

mlx-platform:
 -  Fix error handling in mlxplat_init()
 -  Add more reset cause attributes
 -  Modify DMI matching order
 -  Add regmap structure for the next generation systems
 -  Change API for i2c-mlxcpld driver activation
 -  Move regmap initialization before all drivers activation
 -  Fix parent device in i2c-mux-reg device registration
 -  Add new attribute for mlxreg-io sysfs interfaces

pcengines-apuv2:
 -  Make two symbols static
 -  Fix PCENGINES_APU2 Kconfig warning

OLPC:
 -  Add a config menu category for XO 1.75
 -  Require CONFIG_POWER_SUPPLY for XO-1.75 EC
 -  Fix olpc_xo175_ec_cmd() return value
 -  Make olpc_dt_compatible_match() static __init
 -  Add INPUT dependencies
 -  Fix build error without CONFIG_SPI
 -  Add a regulator for the DCON
 -  Add XO-1.75 EC driver
 -  Use BIT() and GENMASK() for event masks
 -  Avoid a warning if the EC didn't register yet
 -  Move EC-specific functionality out from x86
 -  Remove an unused include
 -  Add OLPC XO-1.75 EC bindings

platform/mellanox:
 -  mlxreg-hotplug: Add devm_free_irq call to remove flow

pmc_atom:
 -  Add CB4063 Beckhoff Automation board to critclk_systems DMI table
 -  no need to check return value of debugfs_create functions

Kconfig:
 - Remove left-over BACKLIGHT_LCD_SUPPORT

samsung-laptop:
 -  no need to check return value of debugfs_create functions

touchscreen_dmi:
 -  Update Hi10 Air filter
 -  Add info for the CHUWI Hi10 Plus tablet.

wmi:
 -  add Xiaomi WMI key driver
 -  add context argument to the probe function
 -  add context pointer field to struct wmi_device_id
 -  Add function to get _UID of WMI device

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: intel_int0002_vgpio: Get rid of custom ICPU() macro

Christian Oder (1):
      platform/x86: touchscreen_dmi: Update Hi10 Air filter

Colin Sindle (1):
      platform/x86: hp_accel: Add support for HP ProBook 450 G0

Daniel Smith (1):
      platform/x86: touchscreen_dmi: Add info for the CHUWI Hi10 Plus tablet.

Fuqian Huang (1):
      platform/x86: asus-wmi: Use dev_get_drvdata()

Greg Kroah-Hartman (8):
      platform/x86: acer-wmi: no need to check return value of debugfs_create functions
      platform/x86: asus-wmi: no need to check return value of debugfs_create functions
      platform/x86: dell-laptop: no need to check return value of debugfs_create functions
      platform/x86: ideapad-laptop: no need to check return value of debugfs_create functions
      platform/x86: samsung-laptop: no need to check return value of debugfs_create functions
      platform/x86: pmc_atom: no need to check return value of debugfs_create functions
      platform/x86: intel_pmc: no need to check return value of debugfs_create functions
      platform/x86: intel_telemetry: no need to check return value of debugfs_create functions

Gustavo A. R. Silva (1):
      platform/x86: acer-wmi: Mark expected switch fall-throughs

Hans de Goede (1):
      platform/x86: asus-wmi: Only Tell EC the OS will handle display hotkeys from asus_nb_wmi

Harry Pan (1):
      platform/x86: intel_pmc_core: transform Pkg C-state residency from TSC ticks into microseconds

Krzysztof Kozlowski (1):
      platform/x86: Remove left-over BACKLIGHT_LCD_SUPPORT

Lubomir Rintel (12):
      dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
      Platform: OLPC: Remove an unused include
      Platform: OLPC: Move EC-specific functionality out from x86
      Platform: OLPC: Avoid a warning if the EC didn't register yet
      Platform: OLPC: Use BIT() and GENMASK() for event masks
      Platform: OLPC: Add XO-1.75 EC driver
      Platform: OLPC: Add a regulator for the DCON
      power: supply: olpc_battery: Allow building the driver on non-x86
      Platform: OLPC: Make olpc_dt_compatible_match() static __init
      Platform: OLPC: Fix olpc_xo175_ec_cmd() return value
      Platform: OLPC: Require CONFIG_POWER_SUPPLY for XO-1.75 EC
      Platform: OLPC: Add a config menu category for XO 1.75

Mathew King (1):
      platform/x86: intel-vbtn: Report switch events when event wakes device

Mattias Jacobsson (3):
      platform/x86: wmi: add context pointer field to struct wmi_device_id
      platform/x86: wmi: add context argument to the probe function
      platform/x86: wmi: add Xiaomi WMI key driver

Prarit Bhargava (1):
      tools/power/x86/intel-speed-select: Add .gitignore file

Rajat Jain (1):
      platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"

Srinivas Pandruvada (11):
      platform/x86: ISST: Update ioctl-number.txt for Intel Speed Select interface
      platform/x86: ISST: Add common API to register and handle ioctls
      platform/x86: ISST: Store per CPU information
      platform/x86: ISST: Add IOCTL to Translate Linux logical CPU to PUNIT CPU number
      platform/x86: ISST: Add Intel Speed Select mmio interface
      platform/x86: ISST: Add Intel Speed Select mailbox interface via PCI
      platform/x86: ISST: Add Intel Speed Select mailbox interface via MSRs
      platform/x86: ISST: Add Intel Speed Select PUNIT MSR interface
      platform/x86: ISST: Restore state on resume
      tools/power/x86: A tool to validate Intel Speed Select commands
      MAINTAINERS: Update for Intel Speed Select Technology

Steffen Dirkwinkel (1):
      platform/x86: pmc_atom: Add CB4063 Beckhoff Automation board to critclk_systems DMI table

Vadim Pasternak (8):
      platform/x86: mlx-platform: Fix parent device in i2c-mux-reg device registration
      platform/mellanox: mlxreg-hotplug: Add devm_free_irq call to remove flow
      platform/x86: mlx-platform: Move regmap initialization before all drivers activation
      platform/x86: mlx-platform: Change API for i2c-mlxcpld driver activation
      platform/x86: mlx-platform: Add regmap structure for the next generation systems
      platform/x86: mlx-platform: Modify DMI matching order
      platform/x86: mlx-platform: Add more reset cause attributes
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces

Wei Yongjun (1):
      platform/x86: mlx-platform: Fix error handling in mlxplat_init()

Young Xiao (1):
      platform/x86: intel_menlow: avoid null pointer deference error

YueHaibing (4):
      Platform: OLPC: Fix build error without CONFIG_SPI
      Platform: OLPC: Add INPUT dependencies
      platform/x86: pcengines-apuv2: Make two symbols static
      platform/x86: Fix PCENGINES_APU2 Kconfig warning

Yurii Pavlovskyi (13):
      platform/x86: asus-wmi: Fix hwmon device cleanup
      platform/x86: asus-wmi: Fix preserving keyboard backlight intensity on load
      platform/x86: asus-wmi: Increase input buffer size of WMI methods
      platform/x86: wmi: Add function to get _UID of WMI device
      platform/x86: asus-wmi: Improve DSTS WMI method ID detection
      platform/x86: asus-wmi: Refactor WMI event handling
      platform/x86: asus-wmi: Support WMI event queue
      platform/x86: asus-nb-wmi: Add microphone mute key code
      platform/x86: asus-wmi: Refactor error handling
      platform/x86: asus-wmi: Organize code into sections
      platform/x86: asus-wmi: Enhance detection of thermal data
      platform/x86: asus-wmi: Switch fan boost mode
      platform/x86: asus-wmi: Do not disable keyboard backlight on unloading

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |   20 +
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |   10 +
 .../devicetree/bindings/misc/olpc,xo1.75-ec.txt    |   23 +
 Documentation/ioctl/ioctl-number.txt               |    1 +
 MAINTAINERS                                        |    8 +
 arch/x86/Kconfig                                   |    1 +
 arch/x86/include/asm/olpc.h                        |   31 -
 arch/x86/platform/olpc/olpc.c                      |  119 +-
 arch/x86/platform/olpc/olpc_dt.c                   |    2 +-
 drivers/hid/hid-asus.c                             |    2 +-
 drivers/platform/Kconfig                           |    2 +
 drivers/platform/Makefile                          |    2 +-
 drivers/platform/mellanox/mlxreg-hotplug.c         |    1 +
 drivers/platform/olpc/Kconfig                      |   29 +
 drivers/platform/olpc/Makefile                     |    3 +-
 drivers/platform/olpc/olpc-ec.c                    |  174 ++-
 drivers/platform/olpc/olpc-xo175-ec.c              |  753 +++++++++
 drivers/platform/x86/Kconfig                       |   16 +-
 drivers/platform/x86/Makefile                      |    4 +-
 drivers/platform/x86/acer-wmi.c                    |   33 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   11 +-
 drivers/platform/x86/asus-wmi.c                    |  479 ++++--
 drivers/platform/x86/asus-wmi.h                    |    1 +
 drivers/platform/x86/dell-laptop.c                 |    5 +-
 drivers/platform/x86/dell-smbios-wmi.c             |    2 +-
 drivers/platform/x86/dell-wmi-descriptor.c         |    3 +-
 drivers/platform/x86/dell-wmi.c                    |    2 +-
 drivers/platform/x86/hp_accel.c                    |    1 +
 drivers/platform/x86/huawei-wmi.c                  |    2 +-
 drivers/platform/x86/ideapad-laptop.c              |   36 +-
 drivers/platform/x86/intel-vbtn.c                  |   16 +-
 drivers/platform/x86/intel-wmi-thunderbolt.c       |    3 +-
 drivers/platform/x86/intel_int0002_vgpio.c         |   22 +-
 drivers/platform/x86/intel_menlow.c                |    8 +-
 drivers/platform/x86/intel_pmc_core.c              |   63 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c       |   62 +
 drivers/platform/x86/intel_speed_select_if/Kconfig |   17 +
 .../platform/x86/intel_speed_select_if/Makefile    |   10 +
 .../x86/intel_speed_select_if/isst_if_common.c     |  672 ++++++++
 .../x86/intel_speed_select_if/isst_if_common.h     |   69 +
 .../x86/intel_speed_select_if/isst_if_mbox_msr.c   |  216 +++
 .../x86/intel_speed_select_if/isst_if_mbox_pci.c   |  214 +++
 .../x86/intel_speed_select_if/isst_if_mmio.c       |  180 +++
 drivers/platform/x86/intel_telemetry_debugfs.c     |   78 +-
 drivers/platform/x86/mlx-platform.c                |  218 ++-
 drivers/platform/x86/pcengines-apuv2.c             |    4 +-
 drivers/platform/x86/pmc_atom.c                    |   51 +-
 drivers/platform/x86/samsung-laptop.c              |   89 +-
 drivers/platform/x86/touchscreen_dmi.c             |   28 +-
 drivers/platform/x86/wmi-bmof.c                    |    2 +-
 drivers/platform/x86/wmi.c                         |   44 +-
 drivers/platform/x86/xiaomi-wmi.c                  |   92 ++
 drivers/power/supply/Kconfig                       |    2 +-
 drivers/power/supply/olpc_battery.c                |    1 -
 include/linux/acpi.h                               |    1 +
 include/linux/mod_devicetable.h                    |    1 +
 include/linux/olpc-ec.h                            |   37 +-
 include/linux/platform_data/x86/asus-wmi.h         |    5 +-
 include/linux/wmi.h                                |    2 +-
 include/uapi/linux/isst_if.h                       |  172 +++
 tools/Makefile                                     |   12 +-
 tools/power/x86/intel-speed-select/.gitignore      |    2 +
 tools/power/x86/intel-speed-select/Build           |    1 +
 tools/power/x86/intel-speed-select/Makefile        |   56 +
 tools/power/x86/intel-speed-select/isst-config.c   | 1607 ++++++++++++++++++++
 tools/power/x86/intel-speed-select/isst-core.c     |  721 +++++++++
 tools/power/x86/intel-speed-select/isst-display.c  |  479 ++++++
 tools/power/x86/intel-speed-select/isst.h          |  231 +++
 68 files changed, 6617 insertions(+), 647 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
 create mode 100644 drivers/platform/olpc/Kconfig
 create mode 100644 drivers/platform/olpc/olpc-xo175-ec.c
 create mode 100644 drivers/platform/x86/intel_pmc_core_pltdrv.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/Kconfig
 create mode 100644 drivers/platform/x86/intel_speed_select_if/Makefile
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_common.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_common.h
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c
 create mode 100644 drivers/platform/x86/xiaomi-wmi.c
 create mode 100644 include/uapi/linux/isst_if.h
 create mode 100644 tools/power/x86/intel-speed-select/.gitignore
 create mode 100644 tools/power/x86/intel-speed-select/Build
 create mode 100644 tools/power/x86/intel-speed-select/Makefile
 create mode 100644 tools/power/x86/intel-speed-select/isst-config.c
 create mode 100644 tools/power/x86/intel-speed-select/isst-core.c
 create mode 100644 tools/power/x86/intel-speed-select/isst-display.c
 create mode 100644 tools/power/x86/intel-speed-select/isst.h

-- 
With Best Regards,
Andy Shevchenko


