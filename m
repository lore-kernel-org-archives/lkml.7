Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46128C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153E0218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfCVOC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:02:56 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCVOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:02:55 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0Fh1-1gksC41oTH-00xHb5; Fri, 22 Mar 2019 15:02:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Date:   Fri, 22 Mar 2019 15:02:26 +0100
Message-Id: <20190322140241.4171530-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dp9ZRsPxecNlIjLmRl+hmaeVN/jA0KGkR6kC9RGmz1v9wug9RZf
 u9liQou4XYpDcE0z6K3BmeW4rj6xnNOLav6GkQvv4APUbgOqnBeNAzLgA3bx1PCg0zLHL3C
 BnTcR6bragtIyOX68CcnzKp+vXu+V96zRHmHFk2KMzBmtJrvrb4mx465qGyUbkmOXnxCIV3
 P7w7apfDBDCKLoXJ/gNPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ul4WU+k5uI=:a61oJR4ykm8GoOy8V086Kt
 7DdXUrxeCMRX8+03AX1S3nkg5xoYIMD5Q347tyPvpB7UxA2eZPQPCDlH1ipkTiWfbeBFDdYh2
 d9v4qvtxF34ybp4uny4kSwAys6uAzOzuvKqh6Sm0kutaB8boq4y1f38GDR1WQr0qEeEmENxF2
 Mh+fwJ5PwVNwncWSM10FlGAPcLmkqbieakxsrsUAJQFU9k9H3otn6B+gNjfMwL6YuxjXlD7gt
 wa6h1uYLw8XZDzQ/xdxmjxxff0XiDKP0ObD6vTxyTB6YgJWDV+Tjuhad0AlckAQICLrg1h0TT
 bl3guzn2Y0HtIdBhEE0Wayqis0GVEoGw6p8+q1Vid6fU5sdU9+a1wlEBw6Df9amESYAa+ln2+
 hXrw8cmRUSjbTIkxrZyNtovCfTTXzoOb8asRVPSnKgCwhJ0Ik3IxG6VUy/MYERKlRGxPkDLXY
 FYWjPsCa3KtrHzuteo4VF1GzifZw4dm04ei+a9V3Hd3gQOe67Rr+nK9wTJsgcLGg2fuFzlsDx
 nbMQDyQzg22SHrUcn/lJp9ylrJJSep8iybzfq0/ClETdt0UyW9IVtxhU0joSH+BlLlynJgsEs
 EFMlgTyh0IEBhh9J2DM0oVM7MXclBnQH2yUOb3ZnNovi/kXejnqJZDigF7vqbwjrdQCwngKOu
 mfRiaaXQPF96fKqqHxvagr1QRNwkwtEkutEI4XWLQpxPjSttlckN4BunONhdTObgwvvhgXUVo
 fCdPAsbo1bOG+JruF9eKvHMfQB+BzUEW9SBwiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configurations with CONFIG_EDAC_SKX and CONFIG_EDAC_I10NM
both enabled, but only one of them built-in and the other
being a loadable module fail to link because the common
file is built the wrong way:

skx_common.c:672: undefined reference to `__this_module'

This overrides the way the modules are built, building
both into the zImage file if that happens.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/Kconfig  | 9 +++++++++
 drivers/edac/Makefile | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d13ed5f..70080926329f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -235,6 +235,7 @@ config EDAC_SKX
 	depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_SKX can't be y
 	select DMI
 	select ACPI_ADXL
+	select EDAC_SKX_COMMON
 	help
 	  Support for error detection and correction the Intel
 	  Skylake server Integrated Memory Controllers. If your
@@ -247,12 +248,20 @@ config EDAC_I10NM
 	depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_I10NM can't be y
 	select DMI
 	select ACPI_ADXL
+	select EDAC_SKX_COMMON
 	help
 	  Support for error detection and correction the Intel
 	  10nm server Integrated Memory Controllers. If your
 	  system has non-volatile DIMMs you should also manually
 	  select CONFIG_ACPI_NFIT.
 
+config EDAC_SKX_COMMON
+	tristate
+	help
+	  This is an internal helper symbol to ensure that all variants
+	  of the EDAC_SKX driver are either built-in or modular, as mixing
+	  the two causes link time problems.
+
 config EDAC_PND2
 	tristate "Intel Pondicherry2"
 	depends on PCI && X86_64 && X86_MCE_INTEL
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84a0f6..0f363309f662 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -58,10 +58,14 @@ layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
 obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
 
 skx_edac-y				:= skx_common.o skx_base.o
-obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o
+ifdef CONFIG_EDAC_SKX
+obj-$(CONFIG_EDAC_SKX_COMMON)		+= skx_edac.o
+endif
 
 i10nm_edac-y				:= skx_common.o i10nm_base.o
-obj-$(CONFIG_EDAC_I10NM)		+= i10nm_edac.o
+ifdef CONFIG_EDAC_I10NM
+obj-$(CONFIG_EDAC_SKX_COMMON))		+= i10nm_edac.o
+endif
 
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
-- 
2.20.0

