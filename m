Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfDXNCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:02:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:41910 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfDXNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:02:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 06:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="136979691"
Received: from nzhao1-mobl.ccr.corp.intel.com ([10.249.168.79])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2019 06:02:07 -0700
Message-ID: <1556110926.2390.13.camel@intel.com>
Subject: Re: [PATCH 1/7] thermal/drivers/core: Remove the module Kconfig's
 option
From:   Zhang Rui <rui.zhang@intel.com>
To:     Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Date:   Wed, 24 Apr 2019 21:02:06 +0800
In-Reply-To: <20190423155208.GC16014@localhost.localdomain>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
         <20190423155208.GC16014@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 二, 2019-04-23 at 08:52 -0700, Eduardo Valentin wrote:
> Hello,
> 
> On Tue, Apr 02, 2019 at 06:12:44PM +0200, Daniel Lezcano wrote:
> > 
> > The module support for the thermal subsystem makes little sense:
> >  - some subsystems relying on it are not modules, thus forcing the
> >    framework to be compiled in
> >  - it is compiled in for almost every configs, the remaining ones
> >    are a few platforms where I don't see why we can not switch the
> > thermal
> >    to 'y'. The drivers can stay in tristate.
> >  - platforms need the thermal to be ready as soon as possible at
> > boot time
> >    in order to mitigate
> > 
> > Usually the subsystems framework are compiled-in and the plugs are
> > as module.
> > 
> > Remove the module option. The removal of the module related dead
> > code will
> > come after this patch gets in or is acked.
> 
> I remember some buzilla entry around this some time back.
> 
> Rui, do you remember why you made this to be module?
> 
> I dont have strong opinion here, but I would like to see
> a better description why we are going this direction rather
> than "most people dont use it as module". Was there any particular
> specific technical motivation?
> 
I checked the change log, it seems that we make CONFIG_THERMAL from
bool to tristate long time ago.

commit 63c4ec905d63834a97ec7dbbf0a2ec89ef5872be
Author:     Zhang Rui <rui.zhang@intel.com>
AuthorDate: Mon Apr 21 16:07:13 2008 +0800
Commit:     Len Brown <len.brown@intel.com>
CommitDate: Tue Apr 29 02:44:00 2008 -0400

    thermal: add the support for building the generic thermal as a
module
    
    Build the generic thermal driver as module "thermal_sys".
    
    Make ACPI thermal, video, processor and fan SELECT the generic
    thermal driver, as these drivers rely on it to build the sysfs I/F.
    
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Acked-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

But the things described in the changelog does not seem to be a solid
reason why we need thermal to be a module.

Anyway, let's try bool instead of tristate and see if everything still
works well.

thanks,
rui
> 
> > 
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Acked-by: Guenter Roeck <groeck@chromium.org>
> > For mini2440:
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/configs/mini2440_defconfig        | 2 +-
> >  arch/arm/configs/pxa_defconfig             | 2 +-
> >  arch/mips/configs/ip22_defconfig           | 2 +-
> >  arch/mips/configs/ip27_defconfig           | 2 +-
> >  arch/unicore32/configs/unicore32_defconfig | 2 +-
> >  drivers/thermal/Kconfig                    | 4 ++--
> >  6 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/configs/mini2440_defconfig
> > b/arch/arm/configs/mini2440_defconfig
> > index d95a8059d30b..0cf1c120c4bb 100644
> > --- a/arch/arm/configs/mini2440_defconfig
> > +++ b/arch/arm/configs/mini2440_defconfig
> > @@ -152,7 +152,7 @@ CONFIG_SPI_S3C24XX=y
> >  CONFIG_SPI_SPIDEV=y
> >  CONFIG_GPIO_SYSFS=y
> >  CONFIG_SENSORS_LM75=y
> > -CONFIG_THERMAL=m
> > +CONFIG_THERMAL=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_S3C2410_WATCHDOG=y
> >  CONFIG_FB=y
> > diff --git a/arch/arm/configs/pxa_defconfig
> > b/arch/arm/configs/pxa_defconfig
> > index d4654755b09c..d4f9dda3a52f 100644
> > --- a/arch/arm/configs/pxa_defconfig
> > +++ b/arch/arm/configs/pxa_defconfig
> > @@ -387,7 +387,7 @@ CONFIG_SENSORS_LM75=m
> >  CONFIG_SENSORS_LM90=m
> >  CONFIG_SENSORS_LM95245=m
> >  CONFIG_SENSORS_NTC_THERMISTOR=m
> > -CONFIG_THERMAL=m
> > +CONFIG_THERMAL=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_XILINX_WATCHDOG=m
> >  CONFIG_SA1100_WATCHDOG=m
> > diff --git a/arch/mips/configs/ip22_defconfig
> > b/arch/mips/configs/ip22_defconfig
> > index ff40fbc2f439..21a1168ae301 100644
> > --- a/arch/mips/configs/ip22_defconfig
> > +++ b/arch/mips/configs/ip22_defconfig
> > @@ -228,7 +228,7 @@ CONFIG_SERIAL_IP22_ZILOG=m
> >  # CONFIG_HW_RANDOM is not set
> >  CONFIG_RAW_DRIVER=m
> >  # CONFIG_HWMON is not set
> > -CONFIG_THERMAL=m
> > +CONFIG_THERMAL=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_INDYDOG=m
> >  # CONFIG_VGA_CONSOLE is not set
> > diff --git a/arch/mips/configs/ip27_defconfig
> > b/arch/mips/configs/ip27_defconfig
> > index 81c47e18131b..54db5dedf776 100644
> > --- a/arch/mips/configs/ip27_defconfig
> > +++ b/arch/mips/configs/ip27_defconfig
> > @@ -271,7 +271,7 @@ CONFIG_I2C_PARPORT_LIGHT=m
> >  CONFIG_I2C_TAOS_EVM=m
> >  CONFIG_I2C_STUB=m
> >  # CONFIG_HWMON is not set
> > -CONFIG_THERMAL=m
> > +CONFIG_THERMAL=y
> >  CONFIG_MFD_PCF50633=m
> >  CONFIG_PCF50633_ADC=m
> >  CONFIG_PCF50633_GPIO=m
> > diff --git a/arch/unicore32/configs/unicore32_defconfig
> > b/arch/unicore32/configs/unicore32_defconfig
> > index aebd01fc28e5..360cc9abcdb0 100644
> > --- a/arch/unicore32/configs/unicore32_defconfig
> > +++ b/arch/unicore32/configs/unicore32_defconfig
> > @@ -119,7 +119,7 @@ CONFIG_I2C_PUV3=y
> >  #	Hardware Monitoring support
> >  #CONFIG_SENSORS_LM75=m
> >  #	Generic Thermal sysfs driver
> > -#CONFIG_THERMAL=m
> > +#CONFIG_THERMAL=y
> >  #CONFIG_THERMAL_HWMON=y
> >  
> >  #	Multimedia support
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 653aa27a25a4..ccf5b9408d7a 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -3,7 +3,7 @@
> >  #
> >  
> >  menuconfig THERMAL
> > -	tristate "Generic Thermal sysfs driver"
> > +	bool "Generic Thermal sysfs driver"
> >  	help
> >  	  Generic Thermal Sysfs driver offers a generic mechanism
> > for
> >  	  thermal management. Usually it's made up of one or more
> > thermal
> > @@ -11,7 +11,7 @@ menuconfig THERMAL
> >  	  Each thermal zone contains its own temperature, trip
> > points,
> >  	  cooling devices.
> >  	  All platforms with ACPI thermal support can use this
> > driver.
> > -	  If you want this support, you should say Y or M here.
> > +	  If you want this support, you should say Y here.
> >  
> >  if THERMAL
> >  
