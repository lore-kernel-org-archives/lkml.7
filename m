Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF34C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7307621A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJJQIoCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfJAMgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:36:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42660 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfJAMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:36:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so10988602qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=634VmFFWQGA/0eibfGg9+EdQVS83YCYZZ6kyi6jecGc=;
        b=dJJQIoCugsCoGo4zbN9padNPuiESOyG+8l1YHMiYVd1km1/IKojjd2yHv3Dg4C382b
         pVhhRxLJ5pVuTITGTuDxUmelzKnpt7BPKNS0hVGtyU5CqjYMB23u0+Jr24x/C3YOVbxX
         J5rjp0WJBeNJqcOC76rD9KfIaO5ZVR021LWgj4/1wXw2WIzreynhagtbIAsW5yCYexBg
         3hxZFiq6SN+WW3ZPRvciXDn8igl5Rxw2rCq+V+1/grcX5yqQA28uqK7kUQXcYyw9aCsI
         bD8fD5yK8OT+rIvOB+EurKBXcOhgpEwI582rWj9R9Ide01z7RnPdN/qmVSVOug9IVvub
         YIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=634VmFFWQGA/0eibfGg9+EdQVS83YCYZZ6kyi6jecGc=;
        b=rdnA3UbqsthDZLPbRDcNKpR8zTzy6cm3tCZaYWpXhYSV9QxWV0eYF86BiUMouw2QqA
         DWzQxuP+xG+BBlq+1tMQCNWiSHyehJE4/YvXLe3JsJMKIDsRjQnSSUCqE+J6LWTuTGSb
         YjP1U/r1d67migL1eZoQ7OAADhdPmjmrmUQHD60AygJYx1yuUQRAR9vx6HPu7Q70xu4O
         IpmSCbt4rGiV70zTznC7KJ5KwBcxAkCrlWtZqZxxuezUSBgInrDVgU+3hTVuBdKJBHAd
         nAOmNOk4HM2EXeE8nKDtkKAcUN89SdFSXU8UIrDn4DfEf4iYOyPLZsEMkXgP80J47VLb
         wiEw==
X-Gm-Message-State: APjAAAV7hZrCNLSNWN6x7skehEpTAj30W6FzP6r7HyX7LMbBmomy8/Bb
        v/A10roxocJ0/zeP914RLtaZ+6crU1c=
X-Google-Smtp-Source: APXvYqxDDQjba/WXvfDD/VbuCEJZYnk8ZJyACBglqVPKb3CEtmnchVrkBjTvPvCur+s82kUN41KPCQ==
X-Received: by 2002:a37:e58:: with SMTP id 85mr5609037qko.403.1569933397376;
        Tue, 01 Oct 2019 05:36:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z5sm7055706qkl.101.2019.10.01.05.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 05:36:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFHOO-0002X9-AS; Tue, 01 Oct 2019 09:36:36 -0300
Date:   Tue, 1 Oct 2019 09:36:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        sam@ravnborg.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
Message-ID: <20191001123636.GA8351@ziepe.ca>
References: <20190725105132.22545-2-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190725105132.22545-2-noralf@tronnes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:51:30PM +0200, Noralf Tr=C3=B8nnes wrote:
> This makes the tiny drivers visible by default without having to enable a
> knob.
>=20
> Signed-off-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com> to it once
> ---
>  drivers/gpu/drm/Makefile        |  2 +-
>  drivers/gpu/drm/tinydrm/Kconfig | 37 +++++++++++++++++++--------------
>  2 files changed, 22 insertions(+), 17 deletions(-)

Bisection says this patch (28c47e16ea2a19adb47fe2c182cbd61cb854237c)
breaks kconfig stuff in v5.4-rc by creating circular
dependencies. Could someone send a -rc patch to fix this please?

THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definitio=
n...
=2E..depends on FB_SSD1307 (defined at drivers/video/fbdev/Kconfig:2259), w=
ith definition...
=2E..depends on FB (defined at drivers/video/fbdev/Kconfig:12), with defini=
tion...
=2E..depends on DRM_KMS_FB_HELPER (defined at drivers/gpu/drm/Kconfig:79), =
with definition...
=2E..depends on DRM_KMS_HELPER (defined at drivers/gpu/drm/Kconfig:73), wit=
h definition...
=2E..depends on TINYDRM_REPAPER (defined at drivers/gpu/drm/tinydrm/Kconfig=
:51), with definition...
=2E..depends on THERMAL (defined at drivers/thermal/Kconfig:6), with defini=
tion...
=2E..depends on SENSORS_NPCM7XX (defined at drivers/hwmon/Kconfig:1285), wi=
th definition...
=2E..depends on HWMON (defined at drivers/hwmon/Kconfig:6), with definition=
=2E..
=2E..depends on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484)=
, with definition...
=2E..depends on ACPI_VIDEO (defined at drivers/acpi/Kconfig:193), with defi=
nition...
=2E..depends on ACER_WMI (defined at drivers/platform/x86/Kconfig:19), with=
 definition...
=2E..depends on BACKLIGHT_CLASS_DEVICE (defined at drivers/video/backlight/=
Kconfig:144), with definition...
=2E..depends again on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfi=
g:484)

Full output:

kconfiglib.KconfigError:=20
Dependency loop
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definitio=
n...

config THINKPAD_ACPI
	tristate "ThinkPad ACPI Laptop Extras"
	select HWMON
	select NVRAM
	select NEW_LEDS
	select LEDS_CLASS
	select LEDS_TRIGGERS
	select LEDS_TRIGGER_AUDIO
	depends on ACPI && ACPI_BATTERY && INPUT && (RFKILL || RFKILL =3D n) && (A=
CPI_VIDEO || ACPI_VIDEO =3D n) && BACKLIGHT_CLASS_DEVICE && X86_PLATFORM_DE=
VICES && X86
	help
	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
	  support for Fn-Fx key combinations, Bluetooth control, video
	  output switching, ThinkLight control, UltraBay eject and more.
	  For more information about this driver see
	  <file:Documentation/admin-guide/laptops/thinkpad-acpi.rst> and
	  <http://ibm-acpi.sf.net/> .
	 =20
	  This driver was formerly known as ibm-acpi.
	 =20
	  Extra functionality will be available if the rfkill (CONFIG_RFKILL)
	  and/or ALSA (CONFIG_SND) subsystems are available in the kernel.
	  Note that if you want ThinkPad-ACPI to be built-in instead of
	  modular, ALSA and rfkill will also have to be built-in.
	 =20
	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.

=2E..depends on ACPI_VIDEO (defined at drivers/acpi/Kconfig:193), with defi=
nition...

config ACPI_VIDEO
	tristate "Video"
	select THERMAL
	depends on X86 && BACKLIGHT_CLASS_DEVICE && INPUT && ACPI
	help
	  This driver implements the ACPI Extensions For Display Adapters
	  for integrated graphics devices on motherboard, as specified in
	  ACPI 2.0 Specification, Appendix B.  This supports basic operations
	  such as defining the video POST device, retrieving EDID information,
	  and setting up a video output.
	 =20
	  To compile this driver as a module, choose M here:
	  the module will be called video.

(select-related dependencies: (DRM_NOUVEAU && ACPI && X86 && BACKLIGHT_CLAS=
S_DEVICE && INPUT && DRM && PCI && MMU && HAS_IOMEM) || (DRM_NOUVEAU && ACP=
I && X86 && DRM && PCI && MMU && HAS_IOMEM) || (DRM_I915 && ACPI && DRM && =
X86 && PCI && HAS_IOMEM) || (DRM_GMA500 && ACPI && DRM && PCI && X86 && MMU=
 && HAS_IOMEM) || (ACER_WMI && ACPI && ACPI && BACKLIGHT_CLASS_DEVICE && SE=
RIO_I8042 && INPUT && (RFKILL || RFKILL =3D n) && ACPI_WMI && X86_PLATFORM_=
DEVICES && X86))

=2E..depends on ACER_WMI (defined at drivers/platform/x86/Kconfig:19), with=
 definition...

config ACER_WMI
	tristate "Acer WMI Laptop Extras"
	select LEDS_CLASS
	select NEW_LEDS
	select INPUT_SPARSEKMAP
	select ACPI_VIDEO if ACPI
	depends on ACPI && BACKLIGHT_CLASS_DEVICE && SERIO_I8042 && INPUT && (RFKI=
LL || RFKILL =3D n) && ACPI_WMI && X86_PLATFORM_DEVICES && X86
	help
	  This is a driver for newer Acer (and Wistron) laptops. It adds
	  wireless radio and bluetooth control, and on some laptops,
	  exposes the mail LED and LCD backlight.
	 =20
	  If you have an ACPI-WMI compatible Acer/ Wistron laptop, say Y or M
	  here.

=2E..depends on SERIO_I8042 (defined at drivers/input/serio/Kconfig:29), wi=
th definition...

config SERIO_I8042
	tristate "i8042 PC Keyboard controller"
	default y
	depends on ARCH_MIGHT_HAVE_PC_SERIO && SERIO && !UML
	help
	  i8042 is the chip over which the standard AT keyboard and PS/2
	  mouse are connected to the computer. If you use these devices,
	  you'll need to say Y here.
	 =20
	  If unsure, say Y.
	 =20
	  To compile this driver as a module, choose M here: the
	  module will be called i8042.

(select-related dependencies: (KEYBOARD_ATKBD && ARCH_MIGHT_HAVE_PC_SERIO &=
& INPUT_KEYBOARD && INPUT && !UML) || (MOUSE_PS2 && ARCH_MIGHT_HAVE_PC_SERI=
O && INPUT_MOUSE && INPUT && !UML))

=2E..depends on SERIO (defined at drivers/input/serio/Kconfig:5), with defi=
nition...

config SERIO
	tristate "Serial I/O support"
	default y
	depends on !UML
	help
	  Say Yes here if you have any input device that uses serial I/O to
	  communicate with the system. This includes the
	                * standard AT keyboard and PS/2 mouse *
	  as well as serial mice, Sun keyboards, some joysticks and 6dof
	  devices and more.
	 =20
	  If unsure, say Y.
	 =20
	  To compile this driver as a module, choose M here: the
	  module will be called serio.

(select-related dependencies: (KEYBOARD_ATKBD && INPUT_KEYBOARD && INPUT &&=
 !UML) || (KEYBOARD_LKKBD && INPUT_KEYBOARD && INPUT && !UML) || (KEYBOARD_=
HIL && (GSC || HP300) && INPUT_KEYBOARD && INPUT && !UML) || (KEYBOARD_NEWT=
ON && INPUT_KEYBOARD && INPUT && !UML) || (KEYBOARD_STOWAWAY && INPUT_KEYBO=
ARD && INPUT && !UML) || (KEYBOARD_SUNKBD && INPUT_KEYBOARD && INPUT && !UM=
L) || (KEYBOARD_XTKBD && INPUT_KEYBOARD && INPUT && !UML) || (MOUSE_PS2 && =
INPUT_MOUSE && INPUT && !UML) || (MOUSE_SERIAL && INPUT_MOUSE && INPUT && !=
UML) || (MOUSE_VSXXXAA && INPUT_MOUSE && INPUT && !UML) || (JOYSTICK_WARRIO=
R && INPUT_JOYSTICK && INPUT && !UML) || (JOYSTICK_MAGELLAN && INPUT_JOYSTI=
CK && INPUT && !UML) || (JOYSTICK_SPACEORB && INPUT_JOYSTICK && INPUT && !U=
ML) || (JOYSTICK_SPACEBALL && INPUT_JOYSTICK && INPUT && !UML) || (JOYSTICK=
_STINGER && INPUT_JOYSTICK && INPUT && !UML) || (JOYSTICK_TWIDJOY && INPUT_=
JOYSTICK && INPUT && !UML) || (JOYSTICK_ZHENHUA && INPUT_JOYSTICK && INPUT =
&& !UML) || (TABLET_SERIAL_WACOM4 && INPUT_TABLET && INPUT && !UML) || (TOU=
CHSCREEN_DYNAPRO && INPUT_TOUCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_HAM=
PSHIRE && INPUT_TOUCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_EGALAX_SERIAL=
 && INPUT_TOUCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_FUJITSU && INPUT_TO=
UCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_GUNZE && INPUT_TOUCHSCREEN && I=
NPUT && !UML) || (TOUCHSCREEN_ELO && INPUT_TOUCHSCREEN && INPUT && !UML) ||=
 (TOUCHSCREEN_WACOM_W8001 && INPUT_TOUCHSCREEN && INPUT && !UML) || (TOUCHS=
CREEN_MTOUCH && INPUT_TOUCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_INEXIO =
&& INPUT_TOUCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_PENMOUNT && INPUT_TO=
UCHSCREEN && INPUT && !UML) || (TOUCHSCREEN_TOUCHRIGHT && INPUT_TOUCHSCREEN=
 && INPUT && !UML) || (TOUCHSCREEN_TOUCHWIN && INPUT_TOUCHSCREEN && INPUT &=
& !UML) || (TOUCHSCREEN_TOUCHIT213 && INPUT_TOUCHSCREEN && INPUT && !UML) |=
| (TOUCHSCREEN_TSC_SERIO && INPUT_TOUCHSCREEN && INPUT && !UML) || (RMI4_F0=
3_SERIO && RMI4_CORE && RMI4_F03 && RMI4_CORE && INPUT && !UML) || (I2C_TAO=
S_EVM && TTY && HAS_IOMEM && I2C) || (USB_PULSE8_CEC && USB_ACM && MEDIA_CE=
C_SUPPORT && MEDIA_USB_SUPPORT && USB && MEDIA_SUPPORT && MEDIA_SUPPORT) ||=
 (USB_RAINSHADOW_CEC && USB_ACM && MEDIA_CEC_SUPPORT && MEDIA_USB_SUPPORT &=
& USB && MEDIA_SUPPORT && MEDIA_SUPPORT))

=2E..depends on RMI4_F03 (defined at drivers/input/rmi4/Kconfig:46), with d=
efinition...

config RMI4_F03
	bool "RMI4 Function 03 (PS2 Guest)"
	depends on RMI4_CORE && RMI4_CORE && INPUT && !UML
	help
	  Say Y here if you want to add support for RMI4 function 03.
	 =20
	  Function 03 provides PS2 guest support for RMI4 devices. This
	  includes support for TrackPoints on TouchPads.

(select-related dependencies: HID_RMI && HID && HID && HID && INPUT)

=2E..depends on HID_RMI (defined at drivers/hid/Kconfig:919), with definiti=
on...

config HID_RMI
	tristate "Synaptics RMI4 device support"
	select RMI4_CORE
	select RMI4_F03
	select RMI4_F11
	select RMI4_F12
	select RMI4_F30
	depends on HID && HID && HID && INPUT
	help
	  Support for Synaptics RMI4 touchpads.
	  Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or usbhid
	  and want support for its special functionalities.

=2E..depends on HID (defined at drivers/hid/Kconfig:8), with definition...

config HID
	tristate "HID bus support"
	default y
	depends on INPUT && INPUT
	help
	  A human interface device (HID) is a type of computer device that
	  interacts directly with and takes input from humans. The term "HID"
	  most commonly used to refer to the USB-HID specification, but other
	  devices (such as, but not strictly limited to, Bluetooth) are
	  designed using HID specification (this involves certain keyboards,
	  mice, tablets, etc). This option adds the HID bus to the kernel,
	  together with generic HID layer code. The HID devices are added and
	  removed from the HID bus by the transport-layer drivers, such as
	  usbhid (USB_HID) and hidp (BT_HIDP).
	 =20
	  For docs and specs, see http://www.usb.org/developers/hidpage/
	 =20
	  If unsure, say Y.

(select-related dependencies: (BT_HIDP && BT_BREDR && INPUT && NET) || (USB=
_HID && USB && INPUT && USB && INPUT) || (I2C_HID && I2C && INPUT && I2C &&=
 INPUT) || (INTEL_ISH_HID && (X86_64 || COMPILE_TEST) && PCI && INPUT))

=2E..depends on I2C_HID (defined at drivers/hid/i2c-hid/Kconfig:5), with de=
finition...

config I2C_HID
	tristate "HID over I2C transport layer"
	default n
	select HID
	depends on I2C && INPUT && I2C && INPUT
	help
	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
	  other HID based devices which is connected to your computer via I2C.
	 =20
	  If unsure, say N.
	 =20
	  This support is also available as a module.  If so, the module
	  will be called i2c-hid.

=2E..depends on I2C (defined at drivers/i2c/Kconfig:8), with definition...

config I2C
	tristate "I2C support"
	select RT_MUTEXES
	select IRQ_DOMAIN
	help
	  I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
	  many micro controller applications and developed by Philips.  SMBus,
	  or System Management Bus is a subset of the I2C protocol.  More
	  information is contained in the directory <file:Documentation/i2c/>,
	  especially in the file called "summary" there.
	 =20
	  Both I2C and SMBus are supported here. You will need this for
	  hardware sensors support, and also for Video For Linux support.
	 =20
	  If you want I2C support, you should say Y here and also to the
	  specific driver for your bus adapter(s) below.
	 =20
	  This I2C support can also be built as a module.  If so, the module
	  will be called i2c-core.

(select-related dependencies: (X86_INTEL_MID && X86_EXTENDED_PLATFORM && X8=
6_PLATFORM_DEVICES && PCI && (X86_64 || (PCI_GOANY && X86_32)) && X86_IO_AP=
IC) || (CAN_PEAK_PCIEC && CAN_PEAK_PCI && CAN_SJA1000 && CAN_DEV && CAN && =
NET) || (IGB && PCI && NET_VENDOR_INTEL && ETHERNET && NETDEVICES) || (SFC =
&& PCI && NET_VENDOR_SOLARFLARE && ETHERNET && NETDEVICES) || (SFC_FALCON &=
& PCI && NET_VENDOR_SOLARFLARE && ETHERNET && NETDEVICES) || (IPMI_SSIF && =
IPMI_HANDLER) || I3C || (MEDIA_SUBDRV_AUTOSELECT && (MEDIA_ANALOG_TV_SUPPOR=
T || MEDIA_DIGITAL_TV_SUPPORT || MEDIA_CAMERA_SUPPORT || MEDIA_SDR_SUPPORT)=
 && HAS_IOMEM && MEDIA_SUPPORT) || (DRM && (AGP || AGP =3D n) && !EMULATED_=
CMPXCHG && HAS_DMA && HAS_IOMEM) || (FB_DDC && FB && HAS_IOMEM) || (SND_AOA=
_ONYX && SND_AOA && SND && !UML && SOUND) || (SND_AOA_TAS && SND_AOA && SND=
 && !UML && SOUND) || (ARCH_R8A7790 && ARM && ARCH_RENESAS && SOC_RENESAS) =
|| (ARCH_R8A7791 && ARM && ARCH_RENESAS && SOC_RENESAS) || (ARCH_R8A7793 &&=
 ARM && ARCH_RENESAS && SOC_RENESAS) || (PHY_EXYNOS5250_SATA && SOC_EXYNOS5=
250 && HAS_IOMEM && OF))

=2E..depends on FB_DDC (defined at drivers/video/fbdev/Kconfig:63), with de=
finition...

config FB_DDC
	tristate
	select I2C_ALGOBIT
	select I2C
	depends on FB && HAS_IOMEM

(select-related dependencies: (FB_CYBER2000_DDC && FB_CYBER2000 && HAS_IOME=
M) || (FB_NVIDIA_I2C && FB_NVIDIA && HAS_IOMEM) || (FB_RIVA_I2C && FB_RIVA =
&& HAS_IOMEM) || (FB_I740 && FB && PCI && HAS_IOMEM) || (FB_I810_I2C && FB_=
I810 && FB_I810_GTF && HAS_IOMEM) || (FB_INTEL_I2C && FB_INTEL && HAS_IOMEM=
) || (FB_MATROX_I2C && FB_MATROX && HAS_IOMEM) || (FB_RADEON_I2C && FB_RADE=
ON && HAS_IOMEM) || (FB_S3_DDC && FB_S3 && HAS_IOMEM) || (FB_SAVAGE_I2C && =
FB_SAVAGE && HAS_IOMEM) || (FB_3DFX_I2C && FB_3DFX && HAS_IOMEM) || (FB_TRI=
DENT && FB && PCI && HAS_IOMEM))

=2E..depends on FB_S3 (defined at drivers/video/fbdev/Kconfig:1314), with d=
efinition...

config FB_S3
	tristate "S3 Trio/Virge support"
	select FB_CFB_FILLRECT
	select FB_CFB_COPYAREA
	select FB_CFB_IMAGEBLIT
	select FB_TILEBLITTING
	select FB_SVGALIB
	select VGASTATE
	select FONT_8x16 if FRAMEBUFFER_CONSOLE
	depends on FB && PCI && HAS_IOMEM
	help
	  Driver for graphics boards with S3 Trio / S3 Virge chip.

=2E..depends on FB (defined at drivers/video/fbdev/Kconfig:12), with defini=
tion...

menuconfig FB
	tristate "Support for frame buffer devices"
	select FB_CMDLINE
	select FB_NOTIFY
	depends on HAS_IOMEM
	help
	  The frame buffer device provides an abstraction for the graphics
	  hardware. It represents the frame buffer of some video hardware and
	  allows application software to access the graphics hardware through
	  a well-defined interface, so the software doesn't need to know
	  anything about the low-level (hardware register) stuff.
	 =20
	  Frame buffer devices work identically across the different
	  architectures supported by Linux and make the implementation of
	  application programs easier and more portable; at this point, an X
	  server exists which uses the frame buffer device exclusively.
	  On several non-X86 architectures, the frame buffer device is the
	  only way to use the graphics hardware.
	 =20
	  The device is accessed through special device nodes, usually located
	  in the /dev directory, i.e. /dev/fb*.
	 =20
	  You need an utility program called fbset to make full use of frame
	  buffer devices. Please read <file:Documentation/fb/framebuffer.rst>
	  and the Framebuffer-HOWTO at
	  <http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.3.html> for mo=
re
	  information.
	 =20
	  Say Y here and to the driver for your graphics board below if you
	  are compiling a kernel for a non-x86 architecture.
	 =20
	  If you are compiling for the x86 architecture, you can say Y if you
	  want to play with it, but it is not essential. Please note that
	  running graphical applications that directly touch the hardware
	  (e.g. an accelerated X server) and that are not frame buffer
	  device-aware may cause unexpected results. If unsure, say N.

(select-related dependencies: (DRM_KMS_FB_HELPER && DRM_KMS_HELPER && HAS_I=
OMEM) || (DRM_VMWGFX && DRM && PCI && X86 && MMU && HAS_IOMEM))

=2E..depends on DRM_KMS_HELPER (defined at drivers/gpu/drm/Kconfig:73), wit=
h definition...

config DRM_KMS_HELPER
	tristate
	depends on DRM && HAS_IOMEM
	help
	  CRTC helpers for KMS drivers.

(select-related dependencies: (DRM_DEBUG_SELFTEST && DRM && DEBUG_KERNEL &&=
 HAS_IOMEM) || (DRM_FBDEV_EMULATION && DRM && HAS_IOMEM) || (DRM_HDLCD && D=
RM && OF && (ARM || ARM64) && COMMON_CLK && HAS_IOMEM) || (DRM_MALI_DISPLAY=
 && DRM && OF && (ARM || ARM64) && COMMON_CLK && HAS_IOMEM) || (DRM_KOMEDA =
&& DRM && OF && COMMON_CLK && HAS_IOMEM) || (DRM_RADEON && DRM && PCI && MM=
U && HAS_IOMEM) || (DRM_AMDGPU && DRM && PCI && MMU && HAS_IOMEM) || (DRM_N=
OUVEAU && DRM && PCI && MMU && HAS_IOMEM) || (DRM_I915 && DRM && X86 && PCI=
 && HAS_IOMEM) || (DRM_VKMS && DRM && HAS_IOMEM) || (DRM_EXYNOS && OF && DR=
M && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_MULTIPLATFORM || =
COMPILE_TEST) && HAS_IOMEM) || (DRM_ROCKCHIP && DRM && ROCKCHIP_IOMMU && HA=
S_IOMEM) || (DRM_VMWGFX && DRM && PCI && X86 && MMU && HAS_IOMEM) || (DRM_G=
MA500 && DRM && PCI && X86 && MMU && HAS_IOMEM) || (DRM_UDL && DRM && USB_S=
UPPORT && USB_ARCH_HAS_HCD && HAS_IOMEM) || (DRM_AST && DRM && PCI && MMU &=
& HAS_IOMEM) || (DRM_MGAG200 && DRM && PCI && MMU && HAS_IOMEM) || (DRM_CIR=
RUS_QEMU && DRM && PCI && MMU && HAS_IOMEM) || (DRM_ARMADA && DRM && HAVE_C=
LK && ARM && MMU && HAS_IOMEM) || (DRM_ATMEL_HLCDC && DRM && OF && COMMON_C=
LK && MFD_ATMEL_HLCDC && ARM && HAS_IOMEM) || (DRM_RCAR_DU && DRM && OF && =
(ARM || ARM64) && (ARCH_RENESAS || COMPILE_TEST) && HAS_IOMEM) || (DRM_SHMO=
BILE && DRM && ARM && (ARCH_SHMOBILE || COMPILE_TEST) && HAS_IOMEM) || (DRM=
_SUN4I && DRM && (ARM || ARM64) && COMMON_CLK && (ARCH_SUNXI || COMPILE_TES=
T) && HAS_IOMEM) || (DRM_OMAP && DRM && (ARCH_OMAP2PLUS || ARCH_MULTIPLATFO=
RM) && HAS_IOMEM) || (DRM_TILCDC && DRM && OF && ARM && HAS_IOMEM) || (DRM_=
QXL && DRM && PCI && MMU && HAS_IOMEM) || (DRM_BOCHS && DRM && PCI && MMU &=
& HAS_IOMEM) || (DRM_VIRTIO_GPU && DRM && VIRTIO && MMU && HAS_IOMEM) || (D=
RM_MSM && DRM && (ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)) && OF && =
COMMON_CLK && MMU && (INTERCONNECT || !INTERCONNECT) && HAS_IOMEM) || (DRM_=
FSL_DCU && DRM && OF && ARM && COMMON_CLK && HAS_IOMEM) || (DRM_TEGRA && (A=
RCH_TEGRA || (ARM && COMPILE_TEST)) && COMMON_CLK && DRM && OF && HAS_IOMEM=
) || (DRM_STM && DRM && (ARCH_STM32 || ARCH_MULTIPLATFORM) && HAS_IOMEM) ||=
 (DRM_ANALOGIX_ANX78XX && DRM && DRM_BRIDGE && HAS_IOMEM) || (DRM_CDNS_DSI =
&& OF && DRM && DRM_BRIDGE && HAS_IOMEM) || (DRM_DUMB_VGA_DAC && OF && DRM =
&& DRM_BRIDGE && HAS_IOMEM) || (DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW && OF &=
& DRM && DRM_BRIDGE && HAS_IOMEM) || (DRM_NXP_PTN3460 && OF && DRM && DRM_B=
RIDGE && HAS_IOMEM) || (DRM_PARADE_PS8622 && OF && DRM && DRM_BRIDGE && HAS=
_IOMEM) || (DRM_SIL_SII8620 && OF && DRM && DRM_BRIDGE && HAS_IOMEM) || (DR=
M_SII902X && OF && DRM && DRM_BRIDGE && HAS_IOMEM) || (DRM_TOSHIBA_TC358767=
 && OF && DRM && DRM_BRIDGE && HAS_IOMEM) || (DRM_TI_TFP410 && OF && DRM &&=
 DRM_BRIDGE && HAS_IOMEM) || (DRM_TI_SN65DSI86 && OF && DRM && DRM_BRIDGE &=
& HAS_IOMEM) || (DRM_I2C_ADV7511 && OF && DRM && DRM_BRIDGE && HAS_IOMEM) |=
| (DRM_DW_HDMI && DRM && DRM_BRIDGE && HAS_IOMEM) || (DRM_DW_MIPI_DSI && DR=
M && DRM_BRIDGE && HAS_IOMEM) || (DRM_STI && OF && DRM && (ARCH_STI || ARCH=
_MULTIPLATFORM) && HAS_IOMEM) || (DRM_IMX && DRM && (ARCH_MXC || ARCH_MULTI=
PLATFORM || COMPILE_TEST) && IMX_IPUV3_CORE && HAS_IOMEM) || (DRM_INGENIC &=
& (MIPS || COMPILE_TEST) && DRM && CMA && OF && HAS_IOMEM) || (DRM_VC4 && (=
ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST) && DRM && SND && SND_SOC && COMMO=
N_CLK && HAS_IOMEM) || (DRM_ARCPGU && DRM && OF && HAS_IOMEM) || (DRM_HISI_=
HIBMC && DRM && PCI && MMU && HAS_IOMEM) || (DRM_HISI_KIRIN && DRM && OF &&=
 ARM64 && HAS_IOMEM) || (DRM_MEDIATEK && DRM && (ARCH_MEDIATEK || (ARM && C=
OMPILE_TEST)) && COMMON_CLK && HAVE_ARM_SMCCC && OF && HAS_IOMEM) || (DRM_Z=
TE && DRM && ARCH_ZX && HAS_IOMEM) || (DRM_MXSFB && DRM && OF && COMMON_CLK=
 && HAS_IOMEM) || (DRM_MESON && DRM && OF && (ARM || ARM64) && (ARCH_MESON =
|| COMPILE_TEST) && HAS_IOMEM) || (TINYDRM_HX8357D && DRM && SPI && HAS_IOM=
EM) || (TINYDRM_ILI9225 && DRM && SPI && HAS_IOMEM) || (TINYDRM_ILI9341 && =
DRM && SPI && HAS_IOMEM) || (TINYDRM_MI0283QT && DRM && SPI && HAS_IOMEM) |=
| (TINYDRM_REPAPER && DRM && SPI && (THERMAL || !THERMAL) && HAS_IOMEM) || =
(TINYDRM_ST7586 && DRM && SPI && HAS_IOMEM) || (TINYDRM_ST7735R && DRM && S=
PI && HAS_IOMEM) || (DRM_PL111 && DRM && (ARM || ARM64 || COMPILE_TEST) && =
COMMON_CLK && HAS_IOMEM) || (DRM_TVE200 && DRM && CMA && (ARM || COMPILE_TE=
ST) && OF && HAS_IOMEM) || (DRM_XEN_FRONTEND && DRM_XEN && DRM && HAS_IOMEM=
) || (DRM_VBOXVIDEO && DRM && X86 && PCI && HAS_IOMEM) || (DRM_ASPEED_GFX &=
& DRM && OF && (COMPILE_TEST || ARCH_ASPEED) && HAS_IOMEM) || (DRM_MCDE && =
DRM && CMA && (ARM || COMPILE_TEST) && OF && HAS_IOMEM) || (DRM_GM12U320 &&=
 DRM && USB && HAS_IOMEM))

=2E..depends on THERMAL (defined at drivers/thermal/Kconfig:6), with defini=
tion...

menuconfig THERMAL
	bool "Generic Thermal sysfs driver"
	help
	  Generic Thermal Sysfs driver offers a generic mechanism for
	  thermal management. Usually it's made up of one or more thermal
	  zone and cooling device.
	  Each thermal zone contains its own temperature, trip points,
	  cooling devices.
	  All platforms with ACPI thermal support can use this driver.
	  If you want this support, you should say Y here.

(select-related dependencies: (ACPI_VIDEO && X86 && BACKLIGHT_CLASS_DEVICE =
&& INPUT && ACPI) || (ACPI_CPU_FREQ_PSS && ACPI) || (ACPI_THERMAL && ACPI_P=
ROCESSOR && ACPI) || (DRM_NOUVEAU && ACPI && X86 && DRM && PCI && MMU && HA=
S_IOMEM) || (DRM_ETNAVIV && DRM_ETNAVIV_THERMAL && DRM && MMU && HAS_IOMEM)=
 || (MMC_SDHCI_OMAP && MMC_SDHCI_PLTFM && OF && MMC) || (INTEL_MENLOW && AC=
PI_THERMAL && X86_PLATFORM_DEVICES && X86))

(imply-related dependencies: (ACPI_VIDEO && X86 && BACKLIGHT_CLASS_DEVICE &=
& INPUT && ACPI) || (ACPI_CPU_FREQ_PSS && ACPI) || (ACPI_THERMAL && ACPI_PR=
OCESSOR && ACPI) || (DRM_NOUVEAU && ACPI && X86 && DRM && PCI && MMU && HAS=
_IOMEM) || (DRM_ETNAVIV && DRM_ETNAVIV_THERMAL && DRM && MMU && HAS_IOMEM) =
|| (MMC_SDHCI_OMAP && MMC_SDHCI_PLTFM && OF && MMC) || (INTEL_MENLOW && ACP=
I_THERMAL && X86_PLATFORM_DEVICES && X86))

=2E..depends on SENSORS_MLXREG_FAN (defined at drivers/hwmon/Kconfig:952), =
with definition...

config SENSORS_MLXREG_FAN
	tristate "Mellanox Mellanox FAN driver"
	select REGMAP
	imply THERMAL
	depends on MELLANOX_PLATFORM && HWMON
	help
	  This option enables support for the FAN control on the Mellanox
	  Ethernet and InfiniBand switches. The driver can be activated by the
	  platform device add call. Say Y to enable these. To compile this
	  driver as a module, choose 'M' here: the module will be called
	  mlxreg-fan.

=2E..depends on HWMON (defined at drivers/hwmon/Kconfig:6), with definition=
=2E..

menuconfig HWMON
	tristate "Hardware Monitoring support"
	default y
	depends on HAS_IOMEM
	help
	  Hardware monitoring devices let you monitor the hardware health
	  of a system. Most modern motherboards include such a device. It
	  can include temperature sensors, voltage sensors, fan speed
	  sensors and various additional features such as the ability to
	  control the speed of the fans. If you want this support you
	  should say Y here and also to the specific driver(s) for your
	  sensors chip(s) below.
	 =20
	  To find out which specific driver(s) you need, use the
	  sensors-detect script from the lm_sensors package.  Read
	  <file:Documentation/hwmon/userspace-tools.rst> for details.
	 =20
	  This support can also be built as a module. If so, the module
	  will be called hwmon.

(select-related dependencies: I8K || (HABANA_AI && PCI && HAS_IOMEM) || (DR=
M_RADEON && DRM && PCI && MMU && HAS_IOMEM) || (DRM_AMDGPU && DRM && PCI &&=
 MMU && HAS_IOMEM) || (THINKPAD_ACPI && ACPI && ACPI_BATTERY && INPUT && (R=
FKILL || RFKILL =3D n) && (ACPI_VIDEO || ACPI_VIDEO =3D n) && BACKLIGHT_CLA=
SS_DEVICE && X86_PLATFORM_DEVICES && X86) || (EEEPC_LAPTOP && ACPI && INPUT=
 && (RFKILL || RFKILL =3D n) && (ACPI_VIDEO || ACPI_VIDEO =3D n) && HOTPLUG=
_PCI && BACKLIGHT_CLASS_DEVICE && X86_PLATFORM_DEVICES && X86) || (CPU_HWMO=
N && LOONGSON_MACH3X && MIPS_PLATFORM_DEVICES && MIPS) || (NTB_IDT && PCI &=
& NTB))

(imply-related dependencies: I8K || (HABANA_AI && PCI && HAS_IOMEM) || (DRM=
_RADEON && DRM && PCI && MMU && HAS_IOMEM) || (DRM_AMDGPU && DRM && PCI && =
MMU && HAS_IOMEM) || (THINKPAD_ACPI && ACPI && ACPI_BATTERY && INPUT && (RF=
KILL || RFKILL =3D n) && (ACPI_VIDEO || ACPI_VIDEO =3D n) && BACKLIGHT_CLAS=
S_DEVICE && X86_PLATFORM_DEVICES && X86) || (EEEPC_LAPTOP && ACPI && INPUT =
&& (RFKILL || RFKILL =3D n) && (ACPI_VIDEO || ACPI_VIDEO =3D n) && HOTPLUG_=
PCI && BACKLIGHT_CLASS_DEVICE && X86_PLATFORM_DEVICES && X86) || (CPU_HWMON=
 && LOONGSON_MACH3X && MIPS_PLATFORM_DEVICES && MIPS) || (NTB_IDT && PCI &&=
 NTB))

=2E..depends again on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfi=
g:484)
