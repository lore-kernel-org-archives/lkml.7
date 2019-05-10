Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF146C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386B9217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557517224;
	bh=GyLRaUYh2a7xXHL/9WwhDQck71Sh32j+ncAAVmkq1Ts=;
	h=From:To:Subject:Date:List-ID:From;
	b=Otunsip/hE+AcjqG5s6yioauS0MxHG4928ESN271ryNnjTNCdEeQFjw2kOlkkgoaB
	 4FfOTGl2ZakxQl9EnHR8aJI2VVQaGo0gOPHURfHTvZUadeOPs1beaESo5IJza0jY3V
	 ykQoFiLpSriACwX4Kw1omLwG8jSwwsv2x1Sc/iAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfEJTkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:40:23 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45736 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfEJTkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:40:22 -0400
Received: by mail-oi1-f193.google.com with SMTP id u3so5339948oic.12;
        Fri, 10 May 2019 12:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ql94wJIYm9OXOKywkUeRhZdTGBvAm+fyP1vA9Ds/QgA=;
        b=aLnbz8DEGDJfZ650IgAPaXbxxWPtWyZeLAd9bpnv4A/K0DDjKahhasDrMtqWX0mdXB
         Re0kCo3eW+A4tAuqESY0PScGwUz8NiYh8qGpRh0dT2N5ZC0nqod78W4waRlnUTb4siU3
         o88a+MzkBpHwrdDGC046Js4WdmfK4OkBI86DJYHSo7BOC7EWLZfQUBDOmd4oDynUakVm
         uWzLTM2XMgO9fVrBcv2/QOA9pt/Fx0KgvtJAexwnUQx3C5Ry+v3XPAPhxWB5QwP3ApxP
         Fuzf+JM93wKZYAdI9dq6iMENXznUSNBdT093/gBiOq5IWjvRsV/kJzblTa+3PZNcjVwe
         uqTw==
X-Gm-Message-State: APjAAAW99BkYVUXwBwdkRhPYCykagesx/WY7+aJ86WP3qXqv2CxsZvVG
        zOce+ynnQY57qqQyRsmKQ2g17QE=
X-Google-Smtp-Source: APXvYqxESV+qDQRZFGENN9AHivydfGgaXNT2YxZB35lwYuy9xSg8A6sSPBq8lw1BtVZTmYky8szOeg==
X-Received: by 2002:aca:df44:: with SMTP id w65mr5873205oig.66.1557517220218;
        Fri, 10 May 2019 12:40:20 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a60sm2426438otb.56.2019.05.10.12.40.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 12:40:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
Date:   Fri, 10 May 2019 14:40:18 -0500
Message-Id: <20190510194018.28206-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the vendor prefix registry to a schema. This will enable checking
that new vendor prefixes are added (in addition to the less than perfect
checkpatch.pl check) and will also check against adding other prefixes
which are not vendors.

Converted vendor-prefixes.txt using the following sed script:

sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'

Signed-off-by: Rob Herring <robh@kernel.org>
---
As vendor prefix updates come in via multiple trees, I plan to merge 
this before -rc1 to avoid cross tree conflicts.

 .../devicetree/bindings/vendor-prefixes.txt   | 476 ---------
 .../devicetree/bindings/vendor-prefixes.yaml  | 975 ++++++++++++++++++
 2 files changed, 975 insertions(+), 476 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/vendor-prefixes.txt
 create mode 100644 Documentation/devicetree/bindings/vendor-prefixes.yaml

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
deleted file mode 100644
index e9034a6c003a..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ /dev/null
@@ -1,476 +0,0 @@
-Device tree binding vendor prefix registry.  Keep list in alphabetical order.
-
-This isn't an exhaustive list, but you should add new prefixes to it before
-using them to avoid name-space collisions.
-
-abilis	Abilis Systems
-abracon	Abracon Corporation
-actions	Actions Semiconductor Co., Ltd.
-active-semi	Active-Semi International Inc
-ad	Avionic Design GmbH
-adafruit	Adafruit Industries, LLC
-adapteva	Adapteva, Inc.
-adaptrum	Adaptrum, Inc.
-adh	AD Holdings Plc.
-adi	Analog Devices, Inc.
-advantech	Advantech Corporation
-aeroflexgaisler	Aeroflex Gaisler AB
-al	Annapurna Labs
-allo	Allo.com
-allwinner	Allwinner Technology Co., Ltd.
-alphascale	AlphaScale Integrated Circuits Systems, Inc.
-altr	Altera Corp.
-amarula	Amarula Solutions
-amazon	Amazon.com, Inc.
-amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
-amd	Advanced Micro Devices (AMD), Inc.
-amediatech	Shenzhen Amediatech Technology Co., Ltd
-amlogic	Amlogic, Inc.
-ampire	Ampire Co., Ltd.
-ams	AMS AG
-amstaos	AMS-Taos Inc.
-analogix	Analogix Semiconductor, Inc.
-andestech	Andes Technology Corporation
-apm	Applied Micro Circuits Corporation (APM)
-aptina	Aptina Imaging
-arasan	Arasan Chip Systems
-archermind ArcherMind Technology (Nanjing) Co., Ltd.
-arctic	Arctic Sand
-arcx	arcx Inc. / Archronix Inc.
-aries	Aries Embedded GmbH
-arm	ARM Ltd.
-armadeus	ARMadeus Systems SARL
-arrow	Arrow Electronics
-artesyn	Artesyn Embedded Technologies Inc.
-asahi-kasei	Asahi Kasei Corp.
-aspeed	ASPEED Technology Inc.
-asus	AsusTek Computer Inc.
-atlas	Atlas Scientific LLC
-atmel	Atmel Corporation
-auo	AU Optronics Corporation
-auvidea Auvidea GmbH
-avago	Avago Technologies
-avia	avia semiconductor
-avic	Shanghai AVIC Optoelectronics Co., Ltd.
-avnet	Avnet, Inc.
-axentia	Axentia Technologies AB
-axis	Axis Communications AB
-azoteq	Azoteq (Pty) Ltd
-azw     Shenzhen AZW Technology Co., Ltd.
-bananapi BIPAI KEJI LIMITED
-bhf	Beckhoff Automation GmbH & Co. KG
-bitmain	Bitmain Technologies
-boe	BOE Technology Group Co., Ltd.
-bosch	Bosch Sensortec GmbH
-boundary	Boundary Devices Inc.
-brcm	Broadcom Corporation
-buffalo	Buffalo, Inc.
-bticino Bticino International
-calxeda	Calxeda
-capella	Capella Microsystems, Inc
-cascoda	Cascoda, Ltd.
-catalyst	Catalyst Semiconductor, Inc.
-cavium	Cavium, Inc.
-cdns	Cadence Design Systems Inc.
-cdtech	CDTech(H.K.) Electronics Limited
-ceva	Ceva, Inc.
-chipidea	Chipidea, Inc
-chipone		ChipOne
-chipspark	ChipSPARK
-chrp	Common Hardware Reference Platform
-chunghwa	Chunghwa Picture Tubes Ltd.
-ciaa	Computadora Industrial Abierta Argentina
-cirrus	Cirrus Logic, Inc.
-cloudengines	Cloud Engines, Inc.
-cnm	Chips&Media, Inc.
-cnxt	Conexant Systems, Inc.
-compulab	CompuLab Ltd.
-cortina	Cortina Systems, Inc.
-cosmic	Cosmic Circuits
-crane	Crane Connectivity Solutions
-creative	Creative Technology Ltd
-crystalfontz	Crystalfontz America, Inc.
-csky	Hangzhou C-SKY Microsystems Co., Ltd
-cubietech	Cubietech, Ltd.
-cypress	Cypress Semiconductor Corporation
-cznic	CZ.NIC, z.s.p.o.
-dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
-dataimage	DataImage, Inc.
-davicom	DAVICOM Semiconductor, Inc.
-delta	Delta Electronics, Inc.
-denx	Denx Software Engineering
-devantech	Devantech, Ltd.
-dh	DH electronics GmbH
-digi	Digi International Inc.
-digilent	Diglent, Inc.
-dioo	Dioo Microcircuit Co., Ltd
-dlc	DLC Display Co., Ltd.
-dlg	Dialog Semiconductor
-dlink	D-Link Corporation
-dmo	Data Modul AG
-domintech	Domintech Co., Ltd.
-dongwoon	Dongwoon Anatech
-dptechnics	DPTechnics
-dragino	Dragino Technology Co., Limited
-ea	Embedded Artists AB
-ebs-systart EBS-SYSTART GmbH
-ebv	EBV Elektronik
-eckelmann	Eckelmann AG
-edt	Emerging Display Technologies
-eeti	eGalax_eMPIA Technology Inc
-elan	Elan Microelectronic Corp.
-elgin	Elgin S/A.
-embest	Shenzhen Embest Technology Co., Ltd.
-emlid	Emlid, Ltd.
-emmicro	EM Microelectronic
-emtrion	emtrion GmbH
-endless	Endless Mobile, Inc.
-energymicro	Silicon Laboratories (formerly Energy Micro AS)
-engicam	Engicam S.r.l.
-epcos	EPCOS AG
-epfl	Ecole Polytechnique Fédérale de Lausanne
-epson	Seiko Epson Corp.
-est	ESTeem Wireless Modems
-ettus	NI Ettus Research
-eukrea  Eukréa Electromatique
-everest	Everest Semiconductor Co. Ltd.
-everspin	Everspin Technologies, Inc.
-exar	Exar Corporation
-excito	Excito
-ezchip	EZchip Semiconductor
-facebook	Facebook
-fairphone	Fairphone B.V.
-faraday	Faraday Technology Corporation
-fastrax	Fastrax Oy
-fcs	Fairchild Semiconductor
-feiyang	Shenzhen Fly Young Technology Co.,LTD.
-firefly	Firefly
-focaltech	FocalTech Systems Co.,Ltd
-friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
-fsl	Freescale Semiconductor
-fujitsu	Fujitsu Ltd.
-gateworks	Gateworks Corporation
-gcw Game Consoles Worldwide
-ge	General Electric Company
-geekbuying	GeekBuying
-gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-geniatech	Geniatech, Inc.
-giantec	Giantec Semiconductor, Inc.
-giantplus	Giantplus Technology Co., Ltd.
-globalscale	Globalscale Technologies, Inc.
-globaltop	GlobalTop Technology, Inc.
-gmt	Global Mixed-mode Technology, Inc.
-goodix	Shenzhen Huiding Technology Co., Ltd.
-google	Google, Inc.
-grinn	Grinn
-grmn	Garmin Limited
-gumstix	Gumstix, Inc.
-gw	Gateworks Corporation
-hannstar	HannStar Display Corporation
-haoyu	Haoyu Microelectronic Co. Ltd.
-hardkernel	Hardkernel Co., Ltd
-hideep	HiDeep Inc.
-himax	Himax Technologies, Inc.
-hisilicon	Hisilicon Limited.
-hit	Hitachi Ltd.
-hitex	Hitex Development Tools
-holt	Holt Integrated Circuits, Inc.
-honeywell	Honeywell
-hp	Hewlett Packard
-holtek	Holtek Semiconductor, Inc.
-hwacom	HwaCom Systems Inc.
-i2se	I2SE GmbH
-ibm	International Business Machines (IBM)
-icplus	IC Plus Corp.
-idt	Integrated Device Technologies, Inc.
-ifi	Ingenieurburo Fur Ic-Technologie (I/F/I)
-ilitek	ILI Technology Corporation (ILITEK)
-img	Imagination Technologies Ltd.
-infineon Infineon Technologies
-inforce	Inforce Computing
-ingenic	Ingenic Semiconductor
-innolux	Innolux Corporation
-inside-secure	INSIDE Secure
-intel	Intel Corporation
-intercontrol	Inter Control Group
-invensense	InvenSense Inc.
-inversepath	Inverse Path
-iom	Iomega Corporation
-isee	ISEE 2007 S.L.
-isil	Intersil
-issi	Integrated Silicon Solutions Inc.
-itead	ITEAD Intelligent Systems Co.Ltd
-iwave  iWave Systems Technologies Pvt. Ltd.
-jdi	Japan Display Inc.
-jedec	JEDEC Solid State Technology Association
-jianda	Jiandangjing Technology Co., Ltd.
-karo	Ka-Ro electronics GmbH
-keithkoep	Keith & Koep GmbH
-keymile	Keymile GmbH
-khadas	Khadas
-kiebackpeter    Kieback & Peter GmbH
-kinetic Kinetic Technologies
-kingdisplay	King & Display Technology Co., Ltd.
-kingnovel	Kingnovel Technology Co., Ltd.
-kionix	Kionix, Inc.
-kobo	Rakuten Kobo Inc.
-koe	Kaohsiung Opto-Electronics Inc.
-kosagi	Sutajio Ko-Usagi PTE Ltd.
-kyo	Kyocera Corporation
-lacie	LaCie
-laird	Laird PLC
-lantiq	Lantiq Semiconductor
-lattice	Lattice Semiconductor
-lego	LEGO Systems A/S
-lemaker	Shenzhen LeMaker Technology Co., Ltd.
-lenovo	Lenovo Group Ltd.
-lg	LG Corporation
-libretech	Shenzhen Libre Technology Co., Ltd
-licheepi	Lichee Pi
-linaro	Linaro Limited
-linksys	Belkin International, Inc. (Linksys)
-linux	Linux-specific binding
-linx	Linx Technologies
-lltc	Linear Technology Corporation
-logicpd	Logic PD, Inc.
-lsi	LSI Corp. (LSI Logic)
-lwn	Liebherr-Werk Nenzing GmbH
-macnica	Macnica Americas
-marvell	Marvell Technology Group Ltd.
-maxbotix	MaxBotix Inc.
-maxim	Maxim Integrated Products
-mbvl	Mobiveil Inc.
-mcube	mCube
-meas	Measurement Specialties
-mediatek	MediaTek Inc.
-megachips	MegaChips
-mele	Shenzhen MeLE Digital Technology Ltd.
-melexis	Melexis N.V.
-melfas	MELFAS Inc.
-mellanox	Mellanox Technologies
-memsic	MEMSIC Inc.
-menlo	Menlo Systems GmbH
-merrii	Merrii Technology Co., Ltd.
-micrel	Micrel Inc.
-microchip	Microchip Technology Inc.
-microcrystal	Micro Crystal AG
-micron	Micron Technology Inc.
-mikroe		MikroElektronika d.o.o.
-minix	MINIX Technology Ltd.
-miramems	MiraMEMS Sensing Technology Co., Ltd.
-mitsubishi	Mitsubishi Electric Corporation
-mosaixtech	Mosaix Technologies, Inc.
-motorola	Motorola, Inc.
-moxa	Moxa Inc.
-mpl	MPL AG
-mqmaker	mqmaker Inc.
-mscc	Microsemi Corporation
-msi	Micro-Star International Co. Ltd.
-mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
-multi-inno	Multi-Inno Technology Co.,Ltd
-mundoreader	Mundo Reader S.L.
-murata	Murata Manufacturing Co., Ltd.
-mxicy	Macronix International Co., Ltd.
-myir	MYIR Tech Limited
-national	National Semiconductor
-nec	NEC LCD Technologies, Ltd.
-neonode		Neonode Inc.
-netgear	NETGEAR
-netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
-netron-dy	Netron DY
-netxeon		Shenzhen Netxeon Technology CO., LTD
-nexbox	Nexbox
-nextthing	Next Thing Co.
-newhaven	Newhaven Display International
-ni	National Instruments
-nintendo	Nintendo
-nlt	NLT Technologies, Ltd.
-nokia	Nokia
-nordic	Nordic Semiconductor
-novtech NovTech, Inc.
-nutsboard	NutsBoard
-nuvoton	Nuvoton Technology Corporation
-nvd	New Vision Display
-nvidia	NVIDIA
-nxp	NXP Semiconductors
-oceanic	Oceanic Systems (UK) Ltd.
-okaya	Okaya Electric America, Inc.
-oki	Oki Electric Industry Co., Ltd.
-olimex	OLIMEX Ltd.
-olpc	One Laptop Per Child
-onion	Onion Corporation
-onnn	ON Semiconductor Corp.
-ontat	On Tat Industrial Company
-opalkelly	Opal Kelly Incorporated
-opencores	OpenCores.org
-openrisc	OpenRISC.io
-option	Option NV
-oranth	Shenzhen Oranth Technology Co., Ltd.
-ORCL	Oracle Corporation
-orisetech	Orise Technology
-ortustech	Ortus Technology Co., Ltd.
-osddisplays	OSD Displays
-ovti	OmniVision Technologies
-oxsemi	Oxford Semiconductor, Ltd.
-panasonic	Panasonic Corporation
-parade	Parade Technologies Inc.
-pda	Precision Design Associates, Inc.
-pericom	Pericom Technology Inc.
-pervasive	Pervasive Displays, Inc.
-phicomm PHICOMM Co., Ltd.
-phytec	PHYTEC Messtechnik GmbH
-picochip	Picochip Ltd
-pine64	Pine64
-pixcir  PIXCIR MICROELECTRONICS Co., Ltd
-plantower Plantower Co., Ltd
-plathome	Plat'Home Co., Ltd.
-plda	PLDA
-plx	Broadcom Corporation (formerly PLX Technology)
-pni	PNI Sensor Corporation
-portwell	Portwell Inc.
-poslab	Poslab Technology Co., Ltd.
-powervr	PowerVR (deprecated, use img)
-probox2	PROBOX2 (by W2COMP Co., Ltd.)
-pulsedlight	PulsedLight, Inc
-qca	Qualcomm Atheros, Inc.
-qcom	Qualcomm Technologies, Inc
-qemu	QEMU, a generic and open source machine emulator and virtualizer
-qi	Qi Hardware
-qiaodian	QiaoDian XianShi Corporation
-qnap	QNAP Systems, Inc.
-radxa	Radxa
-raidsonic	RaidSonic Technology GmbH
-ralink	Mediatek/Ralink Technology Corp.
-ramtron	Ramtron International
-raspberrypi	Raspberry Pi Foundation
-raydium	Raydium Semiconductor Corp.
-rda	Unisoc Communications, Inc.
-realtek Realtek Semiconductor Corp.
-renesas	Renesas Electronics Corporation
-richtek	Richtek Technology Corporation
-ricoh	Ricoh Co. Ltd.
-rikomagic	Rikomagic Tech Corp. Ltd
-riscv	RISC-V Foundation
-rockchip	Fuzhou Rockchip Electronics Co., Ltd
-rocktech	ROCKTECH DISPLAYS LIMITED
-rohm	ROHM Semiconductor Co., Ltd
-ronbo   Ronbo Electronics
-roofull	Shenzhen Roofull Technology Co, Ltd
-samsung	Samsung Semiconductor
-samtec	Samtec/Softing company
-sancloud	Sancloud Ltd
-sandisk	Sandisk Corporation
-sbs	Smart Battery System
-schindler	Schindler
-seagate	Seagate Technology PLC
-seirobotics	Shenzhen SEI Robotics Co., Ltd
-semtech	Semtech Corporation
-sensirion	Sensirion AG
-sff	Small Form Factor Committee
-sgd	Solomon Goldentek Display Corporation
-sgx	SGX Sensortech
-sharp	Sharp Corporation
-shimafuji	Shimafuji Electric, Inc.
-si-en	Si-En Technology Ltd.
-si-linux	Silicon Linux Corporation
-sifive	SiFive, Inc.
-sigma	Sigma Designs, Inc.
-sii	Seiko Instruments, Inc.
-sil	Silicon Image
-silabs	Silicon Laboratories
-silead	Silead Inc.
-silergy	Silergy Corp.
-siliconmitus	Silicon Mitus, Inc.
-simtek
-sirf	SiRF Technology, Inc.
-sis	Silicon Integrated Systems Corp.
-sitronix	Sitronix Technology Corporation
-skyworks	Skyworks Solutions, Inc.
-smsc	Standard Microsystems Corporation
-snps	Synopsys, Inc.
-socionext	Socionext Inc.
-solidrun	SolidRun
-solomon        Solomon Systech Limited
-sony	Sony Corporation
-spansion	Spansion Inc.
-sprd	Spreadtrum Communications Inc.
-sst	Silicon Storage Technology, Inc.
-st	STMicroelectronics
-starry	Starry Electronic Technology (ShenZhen) Co., LTD
-startek	Startek
-ste	ST-Ericsson
-stericsson	ST-Ericsson
-summit	Summit microelectronics
-sunchip	Shenzhen Sunchip Technology Co., Ltd
-SUNW	Sun Microsystems, Inc
-swir	Sierra Wireless
-syna	Synaptics Inc.
-synology	Synology, Inc.
-tbs	TBS Technologies
-tbs-biometrics	Touchless Biometric Systems AG
-tcg	Trusted Computing Group
-tcl	Toby Churchill Ltd.
-technexion	TechNexion
-technologic	Technologic Systems
-tempo	Tempo Semiconductor
-techstar	Shenzhen Techstar Electronics Co., Ltd.
-terasic	Terasic Inc.
-thine	THine Electronics, Inc.
-ti	Texas Instruments
-tianma	Tianma Micro-electronics Co., Ltd.
-tlm	Trusted Logic Mobility
-tmt	Tecon Microprocessor Technologies, LLC.
-topeet  Topeet
-toradex	Toradex AG
-toshiba	Toshiba Corporation
-toumaz	Toumaz
-tpk	TPK U.S.A. LLC
-tplink	TP-LINK Technologies Co., Ltd.
-tpo	TPO
-tq	TQ Systems GmbH
-tronfy	Tronfy
-tronsmart	Tronsmart
-truly	Truly Semiconductors Limited
-tsd	Theobroma Systems Design und Consulting GmbH
-tyan	Tyan Computer Corporation
-u-blox	u-blox
-ucrobotics	uCRobotics
-ubnt	Ubiquiti Networks
-udoo	Udoo
-uniwest	United Western Technologies Corp (UniWest)
-upisemi	uPI Semiconductor Corp.
-urt	United Radiant Technology Corporation
-usi	Universal Scientific Industrial Co., Ltd.
-v3	V3 Semiconductor
-vamrs	Vamrs Ltd.
-variscite	Variscite Ltd.
-via	VIA Technologies, Inc.
-virtio	Virtual I/O Device Specification, developed by the OASIS consortium
-vishay	Vishay Intertechnology, Inc
-vitesse	Vitesse Semiconductor Corporation
-vivante	Vivante Corporation
-vocore VoCore Studio
-voipac	Voipac Technologies s.r.o.
-vot	Vision Optical Technology Co., Ltd.
-wd	Western Digital Corp.
-wetek	WeTek Electronics, limited.
-wexler	Wexler
-whwave  Shenzhen whwave Electronics, Inc.
-wi2wi	Wi2Wi, Inc.
-winbond Winbond Electronics corp.
-winstar	Winstar Display Corp.
-wlf	Wolfson Microelectronics
-wm	Wondermedia Technologies, Inc.
-x-powers	X-Powers
-xes	Extreme Engineering Solutions (X-ES)
-xillybus	Xillybus Ltd.
-xlnx	Xilinx
-xunlong	Shenzhen Xunlong Software CO.,Limited
-ysoft	Y Soft Corporation a.s.
-zarlink	Zarlink Semiconductor
-zeitec	ZEITEC Semiconductor Co., LTD.
-zidoo	Shenzhen Zidoo Technology Co., Ltd.
-zii	Zodiac Inflight Innovations
-zte	ZTE Corp.
-zyxel	ZyXEL Communications Corp.
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
new file mode 100644
index 000000000000..be037fb2cada
--- /dev/null
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -0,0 +1,975 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/vendor-prefixes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Devicetree Vendor Prefix Registry
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+select: true
+
+properties: {}
+
+patternProperties:
+  # Prefixes which are not vendors, but followed the pattern
+  # DO NOT ADD NEW PROPERTIES TO THIS LIST
+  "^(at25|devbus|dmacap|dsa|exynos|gpio-fan|gpio|gpmc|hdmi|i2c-gpio),.*": true
+  "^(m25p|max8952|max8997|max8998|mpmc|pinctrl-single|#pinctrl-single),.*": true
+  "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
+  "^(simple-audio-card|simple-graph-card|st-plgpio|st-spics|ts),.*": true
+
+  # Keep list in alphabetical order.
+  "^abilis,.*":
+    description: Abilis Systems
+  "^abracon,.*":
+    description: Abracon Corporation
+  "^actions,.*":
+    description: Actions Semiconductor Co., Ltd.
+  "^active-semi,.*":
+    description: Active-Semi International Inc
+  "^ad,.*":
+    description: Avionic Design GmbH
+  "^adafruit,.*":
+    description: Adafruit Industries, LLC
+  "^adapteva,.*":
+    description: Adapteva, Inc.
+  "^adaptrum,.*":
+    description: Adaptrum, Inc.
+  "^adh,.*":
+    description: AD Holdings Plc.
+  "^adi,.*":
+    description: Analog Devices, Inc.
+  "^advantech,.*":
+    description: Advantech Corporation
+  "^aeroflexgaisler,.*":
+    description: Aeroflex Gaisler AB
+  "^al,.*":
+    description: Annapurna Labs
+  "^allo,.*":
+    description: Allo.com
+  "^allwinner,.*":
+    description: Allwinner Technology Co., Ltd.
+  "^alphascale,.*":
+    description: AlphaScale Integrated Circuits Systems, Inc.
+  "^altr,.*":
+    description: Altera Corp.
+  "^amarula,.*":
+    description: Amarula Solutions
+  "^amazon,.*":
+    description: Amazon.com, Inc.
+  "^amcc,.*":
+    description: Applied Micro Circuits Corporation (APM, formally AMCC)
+  "^amd,.*":
+    description: Advanced Micro Devices (AMD), Inc.
+  "^amediatech,.*":
+    description: Shenzhen Amediatech Technology Co., Ltd
+  "^amlogic,.*":
+    description: Amlogic, Inc.
+  "^ampire,.*":
+    description: Ampire Co., Ltd.
+  "^ams,.*":
+    description: AMS AG
+  "^amstaos,.*":
+    description: AMS-Taos Inc.
+  "^analogix,.*":
+    description: Analogix Semiconductor, Inc.
+  "^andestech,.*":
+    description: Andes Technology Corporation
+  "^apm,.*":
+    description: Applied Micro Circuits Corporation (APM)
+  "^aptina,.*":
+    description: Aptina Imaging
+  "^arasan,.*":
+    description: Arasan Chip Systems
+  "^archermind,.*":
+    description: ArcherMind Technology (Nanjing) Co., Ltd.
+  "^arctic,.*":
+    description: Arctic Sand
+  "^arcx,.*":
+    description: arcx Inc. / Archronix Inc.
+  "^aries,.*":
+    description: Aries Embedded GmbH
+  "^arm,.*":
+    description: ARM Ltd.
+  "^armadeus,.*":
+    description: ARMadeus Systems SARL
+  "^arrow,.*":
+    description: Arrow Electronics
+  "^artesyn,.*":
+    description: Artesyn Embedded Technologies Inc.
+  "^asahi-kasei,.*":
+    description: Asahi Kasei Corp.
+  "^aspeed,.*":
+    description: ASPEED Technology Inc.
+  "^asus,.*":
+    description: AsusTek Computer Inc.
+  "^atlas,.*":
+    description: Atlas Scientific LLC
+  "^atmel,.*":
+    description: Atmel Corporation
+  "^auo,.*":
+    description: AU Optronics Corporation
+  "^auvidea,.*":
+    description: Auvidea GmbH
+  "^avago,.*":
+    description: Avago Technologies
+  "^avia,.*":
+    description: avia semiconductor
+  "^avic,.*":
+    description: Shanghai AVIC Optoelectronics Co., Ltd.
+  "^avnet,.*":
+    description: Avnet, Inc.
+  "^axentia,.*":
+    description: Axentia Technologies AB
+  "^axis,.*":
+    description: Axis Communications AB
+  "^azoteq,.*":
+    description: Azoteq (Pty) Ltd
+  "^azw,.*":
+    description: Shenzhen AZW Technology Co., Ltd.
+  "^bananapi,.*":
+    description: BIPAI KEJI LIMITED
+  "^bhf,.*":
+    description: Beckhoff Automation GmbH & Co. KG
+  "^bitmain,.*":
+    description: Bitmain Technologies
+  "^boe,.*":
+    description: BOE Technology Group Co., Ltd.
+  "^bosch,.*":
+    description: Bosch Sensortec GmbH
+  "^boundary,.*":
+    description: Boundary Devices Inc.
+  "^brcm,.*":
+    description: Broadcom Corporation
+  "^buffalo,.*":
+    description: Buffalo, Inc.
+  "^bticino,.*":
+    description: Bticino International
+  "^calxeda,.*":
+    description: Calxeda
+  "^capella,.*":
+    description: Capella Microsystems, Inc
+  "^cascoda,.*":
+    description: Cascoda, Ltd.
+  "^catalyst,.*":
+    description: Catalyst Semiconductor, Inc.
+  "^cavium,.*":
+    description: Cavium, Inc.
+  "^cdns,.*":
+    description: Cadence Design Systems Inc.
+  "^cdtech,.*":
+    description: CDTech(H.K.) Electronics Limited
+  "^ceva,.*":
+    description: Ceva, Inc.
+  "^chipidea,.*":
+    description: Chipidea, Inc
+  "^chipone,.*":
+    description: ChipOne
+  "^chipspark,.*":
+    description: ChipSPARK
+  "^chrp,.*":
+    description: Common Hardware Reference Platform
+  "^chunghwa,.*":
+    description: Chunghwa Picture Tubes Ltd.
+  "^ciaa,.*":
+    description: Computadora Industrial Abierta Argentina
+  "^cirrus,.*":
+    description: Cirrus Logic, Inc.
+  "^cloudengines,.*":
+    description: Cloud Engines, Inc.
+  "^cnm,.*":
+    description: Chips&Media, Inc.
+  "^cnxt,.*":
+    description: Conexant Systems, Inc.
+  "^compulab,.*":
+    description: CompuLab Ltd.
+  "^cortina,.*":
+    description: Cortina Systems, Inc.
+  "^cosmic,.*":
+    description: Cosmic Circuits
+  "^crane,.*":
+    description: Crane Connectivity Solutions
+  "^creative,.*":
+    description: Creative Technology Ltd
+  "^crystalfontz,.*":
+    description: Crystalfontz America, Inc.
+  "^csky,.*":
+    description: Hangzhou C-SKY Microsystems Co., Ltd
+  "^cubietech,.*":
+    description: Cubietech, Ltd.
+  "^cypress,.*":
+    description: Cypress Semiconductor Corporation
+  "^cznic,.*":
+    description: CZ.NIC, z.s.p.o.
+  "^dallas,.*":
+    description: Maxim Integrated Products (formerly Dallas Semiconductor)
+  "^dataimage,.*":
+    description: DataImage, Inc.
+  "^davicom,.*":
+    description: DAVICOM Semiconductor, Inc.
+  "^delta,.*":
+    description: Delta Electronics, Inc.
+  "^denx,.*":
+    description: Denx Software Engineering
+  "^devantech,.*":
+    description: Devantech, Ltd.
+  "^dh,.*":
+    description: DH electronics GmbH
+  "^digi,.*":
+    description: Digi International Inc.
+  "^digilent,.*":
+    description: Diglent, Inc.
+  "^dioo,.*":
+    description: Dioo Microcircuit Co., Ltd
+  "^dlc,.*":
+    description: DLC Display Co., Ltd.
+  "^dlg,.*":
+    description: Dialog Semiconductor
+  "^dlink,.*":
+    description: D-Link Corporation
+  "^dmo,.*":
+    description: Data Modul AG
+  "^domintech,.*":
+    description: Domintech Co., Ltd.
+  "^dongwoon,.*":
+    description: Dongwoon Anatech
+  "^dptechnics,.*":
+    description: DPTechnics
+  "^dragino,.*":
+    description: Dragino Technology Co., Limited
+  "^ea,.*":
+    description: Embedded Artists AB
+  "^ebs-systart,.*":
+    description: EBS-SYSTART GmbH
+  "^ebv,.*":
+    description: EBV Elektronik
+  "^eckelmann,.*":
+    description: Eckelmann AG
+  "^edt,.*":
+    description: Emerging Display Technologies
+  "^eeti,.*":
+    description: eGalax_eMPIA Technology Inc
+  "^elan,.*":
+    description: Elan Microelectronic Corp.
+  "^elgin,.*":
+    description: Elgin S/A.
+  "^embest,.*":
+    description: Shenzhen Embest Technology Co., Ltd.
+  "^emlid,.*":
+    description: Emlid, Ltd.
+  "^emmicro,.*":
+    description: EM Microelectronic
+  "^emtrion,.*":
+    description: emtrion GmbH
+  "^endless,.*":
+    description: Endless Mobile, Inc.
+  "^energymicro,.*":
+    description: Silicon Laboratories (formerly Energy Micro AS)
+  "^engicam,.*":
+    description: Engicam S.r.l.
+  "^epcos,.*":
+    description: EPCOS AG
+  "^epfl,.*":
+    description: Ecole Polytechnique Fédérale de Lausanne
+  "^epson,.*":
+    description: Seiko Epson Corp.
+  "^est,.*":
+    description: ESTeem Wireless Modems
+  "^ettus,.*":
+    description: NI Ettus Research
+  "^eukrea,.*":
+    description: Eukréa Electromatique
+  "^everest,.*":
+    description: Everest Semiconductor Co. Ltd.
+  "^everspin,.*":
+    description: Everspin Technologies, Inc.
+  "^exar,.*":
+    description: Exar Corporation
+  "^excito,.*":
+    description: Excito
+  "^ezchip,.*":
+    description: EZchip Semiconductor
+  "^facebook,.*":
+    description: Facebook
+  "^fairphone,.*":
+    description: Fairphone B.V.
+  "^faraday,.*":
+    description: Faraday Technology Corporation
+  "^fastrax,.*":
+    description: Fastrax Oy
+  "^fcs,.*":
+    description: Fairchild Semiconductor
+  "^feiyang,.*":
+    description: Shenzhen Fly Young Technology Co.,LTD.
+  "^firefly,.*":
+    description: Firefly
+  "^focaltech,.*":
+    description: FocalTech Systems Co.,Ltd
+  "^friendlyarm,.*":
+    description: Guangzhou FriendlyARM Computer Tech Co., Ltd
+  "^fsl,.*":
+    description: Freescale Semiconductor
+  "^fujitsu,.*":
+    description: Fujitsu Ltd.
+  "^gateworks,.*":
+    description: Gateworks Corporation
+  "^gcw,.*":
+    description: Game Consoles Worldwide
+  "^ge,.*":
+    description: General Electric Company
+  "^geekbuying,.*":
+    description: GeekBuying
+  "^gef,.*":
+    description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+  "^GEFanuc,.*":
+    description: GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+  "^geniatech,.*":
+    description: Geniatech, Inc.
+  "^giantec,.*":
+    description: Giantec Semiconductor, Inc.
+  "^giantplus,.*":
+    description: Giantplus Technology Co., Ltd.
+  "^globalscale,.*":
+    description: Globalscale Technologies, Inc.
+  "^globaltop,.*":
+    description: GlobalTop Technology, Inc.
+  "^gmt,.*":
+    description: Global Mixed-mode Technology, Inc.
+  "^goodix,.*":
+    description: Shenzhen Huiding Technology Co., Ltd.
+  "^google,.*":
+    description: Google, Inc.
+  "^grinn,.*":
+    description: Grinn
+  "^grmn,.*":
+    description: Garmin Limited
+  "^gumstix,.*":
+    description: Gumstix, Inc.
+  "^gw,.*":
+    description: Gateworks Corporation
+  "^hannstar,.*":
+    description: HannStar Display Corporation
+  "^haoyu,.*":
+    description: Haoyu Microelectronic Co. Ltd.
+  "^hardkernel,.*":
+    description: Hardkernel Co., Ltd
+  "^hideep,.*":
+    description: HiDeep Inc.
+  "^himax,.*":
+    description: Himax Technologies, Inc.
+  "^hisilicon,.*":
+    description: Hisilicon Limited.
+  "^hit,.*":
+    description: Hitachi Ltd.
+  "^hitex,.*":
+    description: Hitex Development Tools
+  "^holt,.*":
+    description: Holt Integrated Circuits, Inc.
+  "^honeywell,.*":
+    description: Honeywell
+  "^hp,.*":
+    description: Hewlett Packard
+  "^holtek,.*":
+    description: Holtek Semiconductor, Inc.
+  "^hwacom,.*":
+    description: HwaCom Systems Inc.
+  "^i2se,.*":
+    description: I2SE GmbH
+  "^ibm,.*":
+    description: International Business Machines (IBM)
+  "^icplus,.*":
+    description: IC Plus Corp.
+  "^idt,.*":
+    description: Integrated Device Technologies, Inc.
+  "^ifi,.*":
+    description: Ingenieurburo Fur Ic-Technologie (I/F/I)
+  "^ilitek,.*":
+    description: ILI Technology Corporation (ILITEK)
+  "^img,.*":
+    description: Imagination Technologies Ltd.
+  "^infineon,.*":
+    description: Infineon Technologies
+  "^inforce,.*":
+    description: Inforce Computing
+  "^ingenic,.*":
+    description: Ingenic Semiconductor
+  "^innolux,.*":
+    description: Innolux Corporation
+  "^inside-secure,.*":
+    description: INSIDE Secure
+  "^intel,.*":
+    description: Intel Corporation
+  "^intercontrol,.*":
+    description: Inter Control Group
+  "^invensense,.*":
+    description: InvenSense Inc.
+  "^inversepath,.*":
+    description: Inverse Path
+  "^iom,.*":
+    description: Iomega Corporation
+  "^isee,.*":
+    description: ISEE 2007 S.L.
+  "^isil,.*":
+    description: Intersil
+  "^issi,.*":
+    description: Integrated Silicon Solutions Inc.
+  "^itead,.*":
+    description: ITEAD Intelligent Systems Co.Ltd
+  "^iwave,.*":
+    description: iWave Systems Technologies Pvt. Ltd.
+  "^jdi,.*":
+    description: Japan Display Inc.
+  "^jedec,.*":
+    description: JEDEC Solid State Technology Association
+  "^jianda,.*":
+    description: Jiandangjing Technology Co., Ltd.
+  "^karo,.*":
+    description: Ka-Ro electronics GmbH
+  "^keithkoep,.*":
+    description: Keith & Koep GmbH
+  "^keymile,.*":
+    description: Keymile GmbH
+  "^khadas,.*":
+    description: Khadas
+  "^kiebackpeter,.*":
+    description: Kieback & Peter GmbH
+  "^kinetic,.*":
+    description: Kinetic Technologies
+  "^kingdisplay,.*":
+    description: King & Display Technology Co., Ltd.
+  "^kingnovel,.*":
+    description: Kingnovel Technology Co., Ltd.
+  "^kionix,.*":
+    description: Kionix, Inc.
+  "^kobo,.*":
+    description: Rakuten Kobo Inc.
+  "^koe,.*":
+    description: Kaohsiung Opto-Electronics Inc.
+  "^kosagi,.*":
+    description: Sutajio Ko-Usagi PTE Ltd.
+  "^kyo,.*":
+    description: Kyocera Corporation
+  "^lacie,.*":
+    description: LaCie
+  "^laird,.*":
+    description: Laird PLC
+  "^lantiq,.*":
+    description: Lantiq Semiconductor
+  "^lattice,.*":
+    description: Lattice Semiconductor
+  "^lego,.*":
+    description: LEGO Systems A/S
+  "^lemaker,.*":
+    description: Shenzhen LeMaker Technology Co., Ltd.
+  "^lenovo,.*":
+    description: Lenovo Group Ltd.
+  "^lg,.*":
+    description: LG Corporation
+  "^libretech,.*":
+    description: Shenzhen Libre Technology Co., Ltd
+  "^licheepi,.*":
+    description: Lichee Pi
+  "^linaro,.*":
+    description: Linaro Limited
+  "^linksys,.*":
+    description: Belkin International, Inc. (Linksys)
+  "^linux,.*":
+    description: Linux-specific binding
+  "^linx,.*":
+    description: Linx Technologies
+  "^lltc,.*":
+    description: Linear Technology Corporation
+  "^logicpd,.*":
+    description: Logic PD, Inc.
+  "^lsi,.*":
+    description: LSI Corp. (LSI Logic)
+  "^lwn,.*":
+    description: Liebherr-Werk Nenzing GmbH
+  "^macnica,.*":
+    description: Macnica Americas
+  "^marvell,.*":
+    description: Marvell Technology Group Ltd.
+  "^maxbotix,.*":
+    description: MaxBotix Inc.
+  "^maxim,.*":
+    description: Maxim Integrated Products
+  "^mbvl,.*":
+    description: Mobiveil Inc.
+  "^mcube,.*":
+    description: mCube
+  "^meas,.*":
+    description: Measurement Specialties
+  "^mediatek,.*":
+    description: MediaTek Inc.
+  "^megachips,.*":
+    description: MegaChips
+  "^mele,.*":
+    description: Shenzhen MeLE Digital Technology Ltd.
+  "^melexis,.*":
+    description: Melexis N.V.
+  "^melfas,.*":
+    description: MELFAS Inc.
+  "^mellanox,.*":
+    description: Mellanox Technologies
+  "^memsic,.*":
+    description: MEMSIC Inc.
+  "^menlo,.*":
+    description: Menlo Systems GmbH
+  "^merrii,.*":
+    description: Merrii Technology Co., Ltd.
+  "^micrel,.*":
+    description: Micrel Inc.
+  "^microchip,.*":
+    description: Microchip Technology Inc.
+  "^microcrystal,.*":
+    description: Micro Crystal AG
+  "^micron,.*":
+    description: Micron Technology Inc.
+  "^mikroe,.*":
+    description: MikroElektronika d.o.o.
+  "^minix,.*":
+    description: MINIX Technology Ltd.
+  "^miramems,.*":
+    description: MiraMEMS Sensing Technology Co., Ltd.
+  "^mitsubishi,.*":
+    description: Mitsubishi Electric Corporation
+  "^mosaixtech,.*":
+    description: Mosaix Technologies, Inc.
+  "^motorola,.*":
+    description: Motorola, Inc.
+  "^moxa,.*":
+    description: Moxa Inc.
+  "^mpl,.*":
+    description: MPL AG
+  "^mqmaker,.*":
+    description: mqmaker Inc.
+  "^mscc,.*":
+    description: Microsemi Corporation
+  "^msi,.*":
+    description: Micro-Star International Co. Ltd.
+  "^mti,.*":
+    description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
+  "^multi-inno,.*":
+    description: Multi-Inno Technology Co.,Ltd
+  "^mundoreader,.*":
+    description: Mundo Reader S.L.
+  "^murata,.*":
+    description: Murata Manufacturing Co., Ltd.
+  "^mxicy,.*":
+    description: Macronix International Co., Ltd.
+  "^myir,.*":
+    description: MYIR Tech Limited
+  "^national,.*":
+    description: National Semiconductor
+  "^nec,.*":
+    description: NEC LCD Technologies, Ltd.
+  "^neonode,.*":
+    description: Neonode Inc.
+  "^netgear,.*":
+    description: NETGEAR
+  "^netlogic,.*":
+    description: Broadcom Corporation (formerly NetLogic Microsystems)
+  "^netron-dy,.*":
+    description: Netron DY
+  "^netxeon,.*":
+    description: Shenzhen Netxeon Technology CO., LTD
+  "^nexbox,.*":
+    description: Nexbox
+  "^nextthing,.*":
+    description: Next Thing Co.
+  "^newhaven,.*":
+    description: Newhaven Display International
+  "^ni,.*":
+    description: National Instruments
+  "^nintendo,.*":
+    description: Nintendo
+  "^nlt,.*":
+    description: NLT Technologies, Ltd.
+  "^nokia,.*":
+    description: Nokia
+  "^nordic,.*":
+    description: Nordic Semiconductor
+  "^novtech,.*":
+    description: NovTech, Inc.
+  "^nutsboard,.*":
+    description: NutsBoard
+  "^nuvoton,.*":
+    description: Nuvoton Technology Corporation
+  "^nvd,.*":
+    description: New Vision Display
+  "^nvidia,.*":
+    description: NVIDIA
+  "^nxp,.*":
+    description: NXP Semiconductors
+  "^oceanic,.*":
+    description: Oceanic Systems (UK) Ltd.
+  "^okaya,.*":
+    description: Okaya Electric America, Inc.
+  "^oki,.*":
+    description: Oki Electric Industry Co., Ltd.
+  "^olimex,.*":
+    description: OLIMEX Ltd.
+  "^olpc,.*":
+    description: One Laptop Per Child
+  "^onion,.*":
+    description: Onion Corporation
+  "^onnn,.*":
+    description: ON Semiconductor Corp.
+  "^ontat,.*":
+    description: On Tat Industrial Company
+  "^opalkelly,.*":
+    description: Opal Kelly Incorporated
+  "^opencores,.*":
+    description: OpenCores.org
+  "^openrisc,.*":
+    description: OpenRISC.io
+  "^option,.*":
+    description: Option NV
+  "^oranth,.*":
+    description: Shenzhen Oranth Technology Co., Ltd.
+  "^ORCL,.*":
+    description: Oracle Corporation
+  "^orisetech,.*":
+    description: Orise Technology
+  "^ortustech,.*":
+    description: Ortus Technology Co., Ltd.
+  "^osddisplays,.*":
+    description: OSD Displays
+  "^ovti,.*":
+    description: OmniVision Technologies
+  "^oxsemi,.*":
+    description: Oxford Semiconductor, Ltd.
+  "^panasonic,.*":
+    description: Panasonic Corporation
+  "^parade,.*":
+    description: Parade Technologies Inc.
+  "^pda,.*":
+    description: Precision Design Associates, Inc.
+  "^pericom,.*":
+    description: Pericom Technology Inc.
+  "^pervasive,.*":
+    description: Pervasive Displays, Inc.
+  "^phicomm,.*":
+    description: PHICOMM Co., Ltd.
+  "^phytec,.*":
+    description: PHYTEC Messtechnik GmbH
+  "^picochip,.*":
+    description: Picochip Ltd
+  "^pine64,.*":
+    description: Pine64
+  "^pixcir,.*":
+    description: PIXCIR MICROELECTRONICS Co., Ltd
+  "^plantower,.*":
+    description: Plantower Co., Ltd
+  "^plathome,.*":
+    description: Plat'Home Co., Ltd.
+  "^plda,.*":
+    description: PLDA
+  "^plx,.*":
+    description: Broadcom Corporation (formerly PLX Technology)
+  "^pni,.*":
+    description: PNI Sensor Corporation
+  "^portwell,.*":
+    description: Portwell Inc.
+  "^poslab,.*":
+    description: Poslab Technology Co., Ltd.
+  "^powervr,.*":
+    description: PowerVR (deprecated, use img)
+  "^probox2,.*":
+    description: PROBOX2 (by W2COMP Co., Ltd.)
+  "^pulsedlight,.*":
+    description: PulsedLight, Inc
+  "^qca,.*":
+    description: Qualcomm Atheros, Inc.
+  "^qcom,.*":
+    description: Qualcomm Technologies, Inc
+  "^qemu,.*":
+    description: QEMU, a generic and open source machine emulator and virtualizer
+  "^qi,.*":
+    description: Qi Hardware
+  "^qiaodian,.*":
+    description: QiaoDian XianShi Corporation
+  "^qnap,.*":
+    description: QNAP Systems, Inc.
+  "^radxa,.*":
+    description: Radxa
+  "^raidsonic,.*":
+    description: RaidSonic Technology GmbH
+  "^ralink,.*":
+    description: Mediatek/Ralink Technology Corp.
+  "^ramtron,.*":
+    description: Ramtron International
+  "^raspberrypi,.*":
+    description: Raspberry Pi Foundation
+  "^raydium,.*":
+    description: Raydium Semiconductor Corp.
+  "^rda,.*":
+    description: Unisoc Communications, Inc.
+  "^realtek,.*":
+    description: Realtek Semiconductor Corp.
+  "^renesas,.*":
+    description: Renesas Electronics Corporation
+  "^richtek,.*":
+    description: Richtek Technology Corporation
+  "^ricoh,.*":
+    description: Ricoh Co. Ltd.
+  "^rikomagic,.*":
+    description: Rikomagic Tech Corp. Ltd
+  "^riscv,.*":
+    description: RISC-V Foundation
+  "^rockchip,.*":
+    description: Fuzhou Rockchip Electronics Co., Ltd
+  "^rocktech,.*":
+    description: ROCKTECH DISPLAYS LIMITED
+  "^rohm,.*":
+    description: ROHM Semiconductor Co., Ltd
+  "^ronbo,.*":
+    description: Ronbo Electronics
+  "^roofull,.*":
+    description: Shenzhen Roofull Technology Co, Ltd
+  "^samsung,.*":
+    description: Samsung Semiconductor
+  "^samtec,.*":
+    description: Samtec/Softing company
+  "^sancloud,.*":
+    description: Sancloud Ltd
+  "^sandisk,.*":
+    description: Sandisk Corporation
+  "^sbs,.*":
+    description: Smart Battery System
+  "^schindler,.*":
+    description: Schindler
+  "^seagate,.*":
+    description: Seagate Technology PLC
+  "^seirobotics,.*":
+    description: Shenzhen SEI Robotics Co., Ltd
+  "^semtech,.*":
+    description: Semtech Corporation
+  "^sensirion,.*":
+    description: Sensirion AG
+  "^sff,.*":
+    description: Small Form Factor Committee
+  "^sgd,.*":
+    description: Solomon Goldentek Display Corporation
+  "^sgx,.*":
+    description: SGX Sensortech
+  "^sharp,.*":
+    description: Sharp Corporation
+  "^shimafuji,.*":
+    description: Shimafuji Electric, Inc.
+  "^si-en,.*":
+    description: Si-En Technology Ltd.
+  "^si-linux,.*":
+    description: Silicon Linux Corporation
+  "^sifive,.*":
+    description: SiFive, Inc.
+  "^sigma,.*":
+    description: Sigma Designs, Inc.
+  "^sii,.*":
+    description: Seiko Instruments, Inc.
+  "^sil,.*":
+    description: Silicon Image
+  "^silabs,.*":
+    description: Silicon Laboratories
+  "^silead,.*":
+    description: Silead Inc.
+  "^silergy,.*":
+    description: Silergy Corp.
+  "^siliconmitus,.*":
+    description: Silicon Mitus, Inc.
+  "^simte,.*":
+    description: k
+  "^sirf,.*":
+    description: SiRF Technology, Inc.
+  "^sis,.*":
+    description: Silicon Integrated Systems Corp.
+  "^sitronix,.*":
+    description: Sitronix Technology Corporation
+  "^skyworks,.*":
+    description: Skyworks Solutions, Inc.
+  "^smsc,.*":
+    description: Standard Microsystems Corporation
+  "^snps,.*":
+    description: Synopsys, Inc.
+  "^socionext,.*":
+    description: Socionext Inc.
+  "^solidrun,.*":
+    description: SolidRun
+  "^solomon,.*":
+    description: Solomon Systech Limited
+  "^sony,.*":
+    description: Sony Corporation
+  "^spansion,.*":
+    description: Spansion Inc.
+  "^sprd,.*":
+    description: Spreadtrum Communications Inc.
+  "^sst,.*":
+    description: Silicon Storage Technology, Inc.
+  "^st,.*":
+    description: STMicroelectronics
+  "^starry,.*":
+    description: Starry Electronic Technology (ShenZhen) Co., LTD
+  "^startek,.*":
+    description: Startek
+  "^ste,.*":
+    description: ST-Ericsson
+  "^stericsson,.*":
+    description: ST-Ericsson
+  "^summit,.*":
+    description: Summit microelectronics
+  "^sunchip,.*":
+    description: Shenzhen Sunchip Technology Co., Ltd
+  "^SUNW,.*":
+    description: Sun Microsystems, Inc
+  "^swir,.*":
+    description: Sierra Wireless
+  "^syna,.*":
+    description: Synaptics Inc.
+  "^synology,.*":
+    description: Synology, Inc.
+  "^tbs,.*":
+    description: TBS Technologies
+  "^tbs-biometrics,.*":
+    description: Touchless Biometric Systems AG
+  "^tcg,.*":
+    description: Trusted Computing Group
+  "^tcl,.*":
+    description: Toby Churchill Ltd.
+  "^technexion,.*":
+    description: TechNexion
+  "^technologic,.*":
+    description: Technologic Systems
+  "^tempo,.*":
+    description: Tempo Semiconductor
+  "^techstar,.*":
+    description: Shenzhen Techstar Electronics Co., Ltd.
+  "^terasic,.*":
+    description: Terasic Inc.
+  "^thine,.*":
+    description: THine Electronics, Inc.
+  "^ti,.*":
+    description: Texas Instruments
+  "^tianma,.*":
+    description: Tianma Micro-electronics Co., Ltd.
+  "^tlm,.*":
+    description: Trusted Logic Mobility
+  "^tmt,.*":
+    description: Tecon Microprocessor Technologies, LLC.
+  "^topeet,.*":
+    description: Topeet
+  "^toradex,.*":
+    description: Toradex AG
+  "^toshiba,.*":
+    description: Toshiba Corporation
+  "^toumaz,.*":
+    description: Toumaz
+  "^tpk,.*":
+    description: TPK U.S.A. LLC
+  "^tplink,.*":
+    description: TP-LINK Technologies Co., Ltd.
+  "^tpo,.*":
+    description: TPO
+  "^tq,.*":
+    description: TQ Systems GmbH
+  "^tronfy,.*":
+    description: Tronfy
+  "^tronsmart,.*":
+    description: Tronsmart
+  "^truly,.*":
+    description: Truly Semiconductors Limited
+  "^tsd,.*":
+    description: Theobroma Systems Design und Consulting GmbH
+  "^tyan,.*":
+    description: Tyan Computer Corporation
+  "^u-blox,.*":
+    description: u-blox
+  "^ucrobotics,.*":
+    description: uCRobotics
+  "^ubnt,.*":
+    description: Ubiquiti Networks
+  "^udoo,.*":
+    description: Udoo
+  "^uniwest,.*":
+    description: United Western Technologies Corp (UniWest)
+  "^upisemi,.*":
+    description: uPI Semiconductor Corp.
+  "^urt,.*":
+    description: United Radiant Technology Corporation
+  "^usi,.*":
+    description: Universal Scientific Industrial Co., Ltd.
+  "^v3,.*":
+    description: V3 Semiconductor
+  "^vamrs,.*":
+    description: Vamrs Ltd.
+  "^variscite,.*":
+    description: Variscite Ltd.
+  "^via,.*":
+    description: VIA Technologies, Inc.
+  "^virtio,.*":
+    description: Virtual I/O Device Specification, developed by the OASIS consortium
+  "^vishay,.*":
+    description: Vishay Intertechnology, Inc
+  "^vitesse,.*":
+    description: Vitesse Semiconductor Corporation
+  "^vivante,.*":
+    description: Vivante Corporation
+  "^vocore,.*":
+    description: VoCore Studio
+  "^voipac,.*":
+    description: Voipac Technologies s.r.o.
+  "^vot,.*":
+    description: Vision Optical Technology Co., Ltd.
+  "^wd,.*":
+    description: Western Digital Corp.
+  "^wetek,.*":
+    description: WeTek Electronics, limited.
+  "^wexler,.*":
+    description: Wexler
+  "^whwave,.*":
+    description: Shenzhen whwave Electronics, Inc.
+  "^wi2wi,.*":
+    description: Wi2Wi, Inc.
+  "^winbond,.*":
+    description: Winbond Electronics corp.
+  "^winstar,.*":
+    description: Winstar Display Corp.
+  "^wlf,.*":
+    description: Wolfson Microelectronics
+  "^wm,.*":
+    description: Wondermedia Technologies, Inc.
+  "^x-powers,.*":
+    description: X-Powers
+  "^xes,.*":
+    description: Extreme Engineering Solutions (X-ES)
+  "^xillybus,.*":
+    description: Xillybus Ltd.
+  "^xlnx,.*":
+    description: Xilinx
+  "^xunlong,.*":
+    description: Shenzhen Xunlong Software CO.,Limited
+  "^ysoft,.*":
+    description: Y Soft Corporation a.s.
+  "^zarlink,.*":
+    description: Zarlink Semiconductor
+  "^zeitec,.*":
+    description: ZEITEC Semiconductor Co., LTD.
+  "^zidoo,.*":
+    description: Shenzhen Zidoo Technology Co., Ltd.
+  "^zii,.*":
+    description: Zodiac Inflight Innovations
+  "^zte,.*":
+    description: ZTE Corp.
+  "^zyxel,.*":
+    description: ZyXEL Communications Corp.
+
+  # Normal property name match without a comma
+  # These should catch all node/property names without a prefix
+  "^[a-zA-Z0-9#][a-zA-Z0-9+\\-._@]{0,63}$": true
+  "^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$": true
+
+additionalProperties: false
+
+...
-- 
2.20.1

