Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B967BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B87218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127973;
	bh=8OUakEaXUQ+sq60S8PSKY7lN8DOO0UOYPH7HCMBFV/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYtDFNWsu28CEN0RBleVS0bnA/K7ijPSLmezNa2FaugDnIgzJDK3JUL8Ov25Tjz3i
	 OmrgDzYbYlscc+ovy2PaQhnWzLa6sjWtaVKWhilPINJ4xhoga7F1XmNvoWd2wehyT1
	 E0dkGj+5v2RwU6M92oghIycXrKnDke1DtjK3RFpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391425AbfDXRcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390437AbfDXRcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2B421903;
        Wed, 24 Apr 2019 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127161;
        bh=8OUakEaXUQ+sq60S8PSKY7lN8DOO0UOYPH7HCMBFV/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1P0xmuaFteNQGF+8/GyyTPDvQebkwcqiXe86JrnXNfR8hNny2cwSr/JUqlkBtvaTh
         ksyHIYc7ndF37pjSQpRVv/UVLYu+IlRoMpK1/qsY3jErYcjN58D6XgZvCvm/+ztXr0
         XEIGhU9Uzb8IlWA5GvLparrtTCsxoOkhd36Spjck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Malaterre <malat@debian.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 84/96] modpost: file2alias: go back to simple devtable lookup
Date:   Wed, 24 Apr 2019 19:10:29 +0200
Message-Id: <20190424170925.485329670@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ec91e78d378cc5d4b43805a1227d8e04e5dfa17d ]

Commit e49ce14150c6 ("modpost: use linker section to generate table.")
was not so cool as we had expected first; it ended up with ugly section
hacks when commit dd2a3acaecd7 ("mod/file2alias: make modpost compile
on darwin again") came in.

Given a certain degree of unknowledge about the link stage of host
programs, I really want to see simple, stupid table lookup so that
this works in the same way regardless of the underlying executable
format.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/file2alias.c | 144 +++++++++++++--------------------------
 1 file changed, 49 insertions(+), 95 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7be43697ff84..9f3ebde7a0cd 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -50,46 +50,6 @@ struct devtable {
 	void *function;
 };
 
-#define ___cat(a,b) a ## b
-#define __cat(a,b) ___cat(a,b)
-
-/* we need some special handling for this host tool running eventually on
- * Darwin. The Mach-O section handling is a bit different than ELF section
- * handling. The differnces in detail are:
- *  a) we have segments which have sections
- *  b) we need a API call to get the respective section symbols */
-#if defined(__MACH__)
-#include <mach-o/getsect.h>
-
-#define INIT_SECTION(name)  do {					\
-		unsigned long name ## _len;				\
-		char *__cat(pstart_,name) = getsectdata("__TEXT",	\
-			#name, &__cat(name,_len));			\
-		char *__cat(pstop_,name) = __cat(pstart_,name) +	\
-			__cat(name, _len);				\
-		__cat(__start_,name) = (void *)__cat(pstart_,name);	\
-		__cat(__stop_,name) = (void *)__cat(pstop_,name);	\
-	} while (0)
-#define SECTION(name)   __attribute__((section("__TEXT, " #name)))
-
-struct devtable **__start___devtable, **__stop___devtable;
-#else
-#define INIT_SECTION(name) /* no-op for ELF */
-#define SECTION(name)   __attribute__((section(#name)))
-
-/* We construct a table of pointers in an ELF section (pointers generally
- * go unpadded by gcc).  ld creates boundary syms for us. */
-extern struct devtable *__start___devtable[], *__stop___devtable[];
-#endif /* __MACH__ */
-
-#if !defined(__used)
-# if __GNUC__ == 3 && __GNUC_MINOR__ < 3
-#  define __used			__attribute__((__unused__))
-# else
-#  define __used			__attribute__((__used__))
-# endif
-#endif
-
 /* Define a variable f that holds the value of field f of struct devid
  * based at address m.
  */
@@ -102,16 +62,6 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
 #define DEF_FIELD_ADDR(m, devid, f) \
 	typeof(((struct devid *)0)->f) *f = ((m) + OFF_##devid##_##f)
 
-/* Add a table entry.  We test function type matches while we're here. */
-#define ADD_TO_DEVTABLE(device_id, type, function) \
-	static struct devtable __cat(devtable,__LINE__) = {	\
-		device_id + 0*sizeof((function)((const char *)NULL,	\
-						(void *)NULL,		\
-						(char *)NULL)),		\
-		SIZE_##type, (function) };				\
-	static struct devtable *SECTION(__devtable) __used \
-		__cat(devtable_ptr,__LINE__) = &__cat(devtable,__LINE__)
-
 #define ADD(str, sep, cond, field)                              \
 do {                                                            \
         strcat(str, sep);                                       \
@@ -431,7 +381,6 @@ static int do_hid_entry(const char *filename,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("hid", hid_device_id, do_hid_entry);
 
 /* Looks like: ieee1394:venNmoNspNverN */
 static int do_ieee1394_entry(const char *filename,
@@ -456,7 +405,6 @@ static int do_ieee1394_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("ieee1394", ieee1394_device_id, do_ieee1394_entry);
 
 /* Looks like: pci:vNdNsvNsdNbcNscNiN. */
 static int do_pci_entry(const char *filename,
@@ -500,7 +448,6 @@ static int do_pci_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("pci", pci_device_id, do_pci_entry);
 
 /* looks like: "ccw:tNmNdtNdmN" */
 static int do_ccw_entry(const char *filename,
@@ -524,7 +471,6 @@ static int do_ccw_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("ccw", ccw_device_id, do_ccw_entry);
 
 /* looks like: "ap:tN" */
 static int do_ap_entry(const char *filename,
@@ -535,7 +481,6 @@ static int do_ap_entry(const char *filename,
 	sprintf(alias, "ap:t%02X*", dev_type);
 	return 1;
 }
-ADD_TO_DEVTABLE("ap", ap_device_id, do_ap_entry);
 
 /* looks like: "css:tN" */
 static int do_css_entry(const char *filename,
@@ -546,7 +491,6 @@ static int do_css_entry(const char *filename,
 	sprintf(alias, "css:t%01X", type);
 	return 1;
 }
-ADD_TO_DEVTABLE("css", css_device_id, do_css_entry);
 
 /* Looks like: "serio:tyNprNidNexN" */
 static int do_serio_entry(const char *filename,
@@ -566,7 +510,6 @@ static int do_serio_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("serio", serio_device_id, do_serio_entry);
 
 /* looks like: "acpi:ACPI0003" or "acpi:PNP0C0B" or "acpi:LNXVIDEO" or
  *             "acpi:bbsspp" (bb=base-class, ss=sub-class, pp=prog-if)
@@ -604,7 +547,6 @@ static int do_acpi_entry(const char *filename,
 	}
 	return 1;
 }
-ADD_TO_DEVTABLE("acpi", acpi_device_id, do_acpi_entry);
 
 /* looks like: "pnp:dD" */
 static void do_pnp_device_entry(void *symval, unsigned long size,
@@ -725,7 +667,6 @@ static int do_pcmcia_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("pcmcia", pcmcia_device_id, do_pcmcia_entry);
 
 static int do_vio_entry(const char *filename, void *symval,
 		char *alias)
@@ -745,7 +686,6 @@ static int do_vio_entry(const char *filename, void *symval,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("vio", vio_device_id, do_vio_entry);
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
@@ -818,7 +758,6 @@ static int do_input_entry(const char *filename, void *symval,
 		do_input(alias, *swbit, 0, INPUT_DEVICE_ID_SW_MAX);
 	return 1;
 }
-ADD_TO_DEVTABLE("input", input_device_id, do_input_entry);
 
 static int do_eisa_entry(const char *filename, void *symval,
 		char *alias)
@@ -830,7 +769,6 @@ static int do_eisa_entry(const char *filename, void *symval,
 		strcat(alias, "*");
 	return 1;
 }
-ADD_TO_DEVTABLE("eisa", eisa_device_id, do_eisa_entry);
 
 /* Looks like: parisc:tNhvNrevNsvN */
 static int do_parisc_entry(const char *filename, void *symval,
@@ -850,7 +788,6 @@ static int do_parisc_entry(const char *filename, void *symval,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("parisc", parisc_device_id, do_parisc_entry);
 
 /* Looks like: sdio:cNvNdN. */
 static int do_sdio_entry(const char *filename,
@@ -867,7 +804,6 @@ static int do_sdio_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("sdio", sdio_device_id, do_sdio_entry);
 
 /* Looks like: ssb:vNidNrevN. */
 static int do_ssb_entry(const char *filename,
@@ -884,7 +820,6 @@ static int do_ssb_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("ssb", ssb_device_id, do_ssb_entry);
 
 /* Looks like: bcma:mNidNrevNclN. */
 static int do_bcma_entry(const char *filename,
@@ -903,7 +838,6 @@ static int do_bcma_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("bcma", bcma_device_id, do_bcma_entry);
 
 /* Looks like: virtio:dNvN */
 static int do_virtio_entry(const char *filename, void *symval,
@@ -919,7 +853,6 @@ static int do_virtio_entry(const char *filename, void *symval,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("virtio", virtio_device_id, do_virtio_entry);
 
 /*
  * Looks like: vmbus:guid
@@ -942,7 +875,6 @@ static int do_vmbus_entry(const char *filename, void *symval,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("vmbus", hv_vmbus_device_id, do_vmbus_entry);
 
 /* Looks like: rpmsg:S */
 static int do_rpmsg_entry(const char *filename, void *symval,
@@ -953,7 +885,6 @@ static int do_rpmsg_entry(const char *filename, void *symval,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("rpmsg", rpmsg_device_id, do_rpmsg_entry);
 
 /* Looks like: i2c:S */
 static int do_i2c_entry(const char *filename, void *symval,
@@ -964,7 +895,6 @@ static int do_i2c_entry(const char *filename, void *symval,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("i2c", i2c_device_id, do_i2c_entry);
 
 /* Looks like: spi:S */
 static int do_spi_entry(const char *filename, void *symval,
@@ -975,7 +905,6 @@ static int do_spi_entry(const char *filename, void *symval,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("spi", spi_device_id, do_spi_entry);
 
 static const struct dmifield {
 	const char *prefix;
@@ -1030,7 +959,6 @@ static int do_dmi_entry(const char *filename, void *symval,
 	strcat(alias, ":");
 	return 1;
 }
-ADD_TO_DEVTABLE("dmi", dmi_system_id, do_dmi_entry);
 
 static int do_platform_entry(const char *filename,
 			     void *symval, char *alias)
@@ -1039,7 +967,6 @@ static int do_platform_entry(const char *filename,
 	sprintf(alias, PLATFORM_MODULE_PREFIX "%s", *name);
 	return 1;
 }
-ADD_TO_DEVTABLE("platform", platform_device_id, do_platform_entry);
 
 static int do_mdio_entry(const char *filename,
 			 void *symval, char *alias)
@@ -1064,7 +991,6 @@ static int do_mdio_entry(const char *filename,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("mdio", mdio_device_id, do_mdio_entry);
 
 /* Looks like: zorro:iN. */
 static int do_zorro_entry(const char *filename, void *symval,
@@ -1075,7 +1001,6 @@ static int do_zorro_entry(const char *filename, void *symval,
 	ADD(alias, "i", id != ZORRO_WILDCARD, id);
 	return 1;
 }
-ADD_TO_DEVTABLE("zorro", zorro_device_id, do_zorro_entry);
 
 /* looks like: "pnp:dD" */
 static int do_isapnp_entry(const char *filename,
@@ -1091,7 +1016,6 @@ static int do_isapnp_entry(const char *filename,
 		(function >> 12) & 0x0f, (function >> 8) & 0x0f);
 	return 1;
 }
-ADD_TO_DEVTABLE("isapnp", isapnp_device_id, do_isapnp_entry);
 
 /* Looks like: "ipack:fNvNdN". */
 static int do_ipack_entry(const char *filename,
@@ -1107,7 +1031,6 @@ static int do_ipack_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("ipack", ipack_device_id, do_ipack_entry);
 
 /*
  * Append a match expression for a single masked hex digit.
@@ -1178,7 +1101,6 @@ static int do_amba_entry(const char *filename,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("amba", amba_id, do_amba_entry);
 
 /*
  * looks like: "mipscdmm:tN"
@@ -1194,7 +1116,6 @@ static int do_mips_cdmm_entry(const char *filename,
 	sprintf(alias, "mipscdmm:t%02X*", type);
 	return 1;
 }
-ADD_TO_DEVTABLE("mipscdmm", mips_cdmm_device_id, do_mips_cdmm_entry);
 
 /* LOOKS like cpu:type:x86,venVVVVfamFFFFmodMMMM:feature:*,FEAT,*
  * All fields are numbers. It would be nicer to use strings for vendor
@@ -1219,7 +1140,6 @@ static int do_x86cpu_entry(const char *filename, void *symval,
 		sprintf(alias + strlen(alias), "%04X*", feature);
 	return 1;
 }
-ADD_TO_DEVTABLE("x86cpu", x86_cpu_id, do_x86cpu_entry);
 
 /* LOOKS like cpu:type:*:feature:*FEAT* */
 static int do_cpu_entry(const char *filename, void *symval, char *alias)
@@ -1229,7 +1149,6 @@ static int do_cpu_entry(const char *filename, void *symval, char *alias)
 	sprintf(alias, "cpu:type:*:feature:*%04X*", feature);
 	return 1;
 }
-ADD_TO_DEVTABLE("cpu", cpu_feature, do_cpu_entry);
 
 /* Looks like: mei:S:uuid:N:* */
 static int do_mei_entry(const char *filename, void *symval,
@@ -1248,7 +1167,6 @@ static int do_mei_entry(const char *filename, void *symval,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("mei", mei_cl_device_id, do_mei_entry);
 
 /* Looks like: rapidio:vNdNavNadN */
 static int do_rio_entry(const char *filename,
@@ -1268,7 +1186,6 @@ static int do_rio_entry(const char *filename,
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("rapidio", rio_device_id, do_rio_entry);
 
 /* Looks like: ulpi:vNpN */
 static int do_ulpi_entry(const char *filename, void *symval,
@@ -1281,7 +1198,6 @@ static int do_ulpi_entry(const char *filename, void *symval,
 
 	return 1;
 }
-ADD_TO_DEVTABLE("ulpi", ulpi_device_id, do_ulpi_entry);
 
 /* Looks like: hdaudio:vNrNaN */
 static int do_hda_entry(const char *filename, void *symval, char *alias)
@@ -1298,7 +1214,6 @@ static int do_hda_entry(const char *filename, void *symval, char *alias)
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("hdaudio", hda_device_id, do_hda_entry);
 
 /* Looks like: sdw:mNpN */
 static int do_sdw_entry(const char *filename, void *symval, char *alias)
@@ -1313,7 +1228,6 @@ static int do_sdw_entry(const char *filename, void *symval, char *alias)
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("sdw", sdw_device_id, do_sdw_entry);
 
 /* Looks like: fsl-mc:vNdN */
 static int do_fsl_mc_entry(const char *filename, void *symval,
@@ -1325,7 +1239,6 @@ static int do_fsl_mc_entry(const char *filename, void *symval,
 	sprintf(alias, "fsl-mc:v%08Xd%s", vendor, *obj_type);
 	return 1;
 }
-ADD_TO_DEVTABLE("fslmc", fsl_mc_device_id, do_fsl_mc_entry);
 
 /* Looks like: tbsvc:kSpNvNrN */
 static int do_tbsvc_entry(const char *filename, void *symval, char *alias)
@@ -1350,7 +1263,6 @@ static int do_tbsvc_entry(const char *filename, void *symval, char *alias)
 	add_wildcard(alias);
 	return 1;
 }
-ADD_TO_DEVTABLE("tbsvc", tb_service_id, do_tbsvc_entry);
 
 /* Looks like: typec:idNmN */
 static int do_typec_entry(const char *filename, void *symval, char *alias)
@@ -1363,7 +1275,6 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 
 	return 1;
 }
-ADD_TO_DEVTABLE("typec", typec_device_id, do_typec_entry);
 
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
@@ -1396,6 +1307,48 @@ static void do_table(void *symval, unsigned long size,
 	}
 }
 
+static const struct devtable devtable[] = {
+	{"hid", SIZE_hid_device_id, do_hid_entry},
+	{"ieee1394", SIZE_ieee1394_device_id, do_ieee1394_entry},
+	{"pci", SIZE_pci_device_id, do_pci_entry},
+	{"ccw", SIZE_ccw_device_id, do_ccw_entry},
+	{"ap", SIZE_ap_device_id, do_ap_entry},
+	{"css", SIZE_css_device_id, do_css_entry},
+	{"serio", SIZE_serio_device_id, do_serio_entry},
+	{"acpi", SIZE_acpi_device_id, do_acpi_entry},
+	{"pcmcia", SIZE_pcmcia_device_id, do_pcmcia_entry},
+	{"vio", SIZE_vio_device_id, do_vio_entry},
+	{"input", SIZE_input_device_id, do_input_entry},
+	{"eisa", SIZE_eisa_device_id, do_eisa_entry},
+	{"parisc", SIZE_parisc_device_id, do_parisc_entry},
+	{"sdio", SIZE_sdio_device_id, do_sdio_entry},
+	{"ssb", SIZE_ssb_device_id, do_ssb_entry},
+	{"bcma", SIZE_bcma_device_id, do_bcma_entry},
+	{"virtio", SIZE_virtio_device_id, do_virtio_entry},
+	{"vmbus", SIZE_hv_vmbus_device_id, do_vmbus_entry},
+	{"rpmsg", SIZE_rpmsg_device_id, do_rpmsg_entry},
+	{"i2c", SIZE_i2c_device_id, do_i2c_entry},
+	{"spi", SIZE_spi_device_id, do_spi_entry},
+	{"dmi", SIZE_dmi_system_id, do_dmi_entry},
+	{"platform", SIZE_platform_device_id, do_platform_entry},
+	{"mdio", SIZE_mdio_device_id, do_mdio_entry},
+	{"zorro", SIZE_zorro_device_id, do_zorro_entry},
+	{"isapnp", SIZE_isapnp_device_id, do_isapnp_entry},
+	{"ipack", SIZE_ipack_device_id, do_ipack_entry},
+	{"amba", SIZE_amba_id, do_amba_entry},
+	{"mipscdmm", SIZE_mips_cdmm_device_id, do_mips_cdmm_entry},
+	{"x86cpu", SIZE_x86_cpu_id, do_x86cpu_entry},
+	{"cpu", SIZE_cpu_feature, do_cpu_entry},
+	{"mei", SIZE_mei_cl_device_id, do_mei_entry},
+	{"rapidio", SIZE_rio_device_id, do_rio_entry},
+	{"ulpi", SIZE_ulpi_device_id, do_ulpi_entry},
+	{"hdaudio", SIZE_hda_device_id, do_hda_entry},
+	{"sdw", SIZE_sdw_device_id, do_sdw_entry},
+	{"fslmc", SIZE_fsl_mc_device_id, do_fsl_mc_entry},
+	{"tbsvc", SIZE_tb_service_id, do_tbsvc_entry},
+	{"typec", SIZE_typec_device_id, do_typec_entry},
+};
+
 /* Create MODULE_ALIAS() statements.
  * At this time, we cannot write the actual output C source yet,
  * so we write into the mod->dev_table_buf buffer. */
@@ -1450,13 +1403,14 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	else if (sym_is(name, namelen, "pnp_card"))
 		do_pnp_card_entries(symval, sym->st_size, mod);
 	else {
-		struct devtable **p;
-		INIT_SECTION(__devtable);
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(devtable); i++) {
+			const struct devtable *p = &devtable[i];
 
-		for (p = __start___devtable; p < __stop___devtable; p++) {
-			if (sym_is(name, namelen, (*p)->device_id)) {
-				do_table(symval, sym->st_size, (*p)->id_size,
-					 (*p)->device_id, (*p)->function, mod);
+			if (sym_is(name, namelen, p->device_id)) {
+				do_table(symval, sym->st_size, p->id_size,
+					 p->device_id, p->function, mod);
 				break;
 			}
 		}
-- 
2.19.1



