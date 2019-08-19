Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89242C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A14206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="auRsNmh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHSLqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:46:10 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:53956 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfHSLqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:46:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 7DE5527E11AB;
        Mon, 19 Aug 2019 13:46:08 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Jid7DwlUBoPs; Mon, 19 Aug 2019 13:46:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 904D627E10B4;
        Mon, 19 Aug 2019 13:46:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 904D627E10B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1566215167;
        bh=NMyaOCZ7T+RfW5oUJFsoeepsqE1DlvqrKfJKuPOGn3w=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=auRsNmh26qOKQIMzaX6PoGGxn6FxZCSVht4KtOJu6Yb2rV8sanBJsqIn/CkeLrKSI
         NHNrdun1bAdDrbR5fOawhdSYvSsaYGQr4Qiab1Fe2S+YRdu9KA7+So/KIJ44KV/KCw
         86H6TrzyR2eYYEI/1Ljg/OIJASrq107T/5KjHNOg=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jJGoCisSGtLO; Mon, 19 Aug 2019 13:46:07 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 7784927E06B6;
        Mon, 19 Aug 2019 13:46:07 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Loic Pallardy <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Leger?= <cleger@kalray.eu>
Subject: [PATCH] rproc: Add elf64 support in elf loader
Date:   Mon, 19 Aug 2019 13:45:16 +0200
Message-Id: <20190819114516.28665-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.15.0.276.g89ea799
In-Reply-To: <04be3345-698d-29b0-7b4b-7eed088e490d@st.com>
References: <04be3345-698d-29b0-7b4b-7eed088e490d@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cl=C3=A9ment Leger <cleger@kalray.eu>

elf32 and elf64 mainly differ by their types. In order to avoid
copy/pasting the whole loader code, generate static inline functions
which will access values according to the elf class. It allows to keep a
common loader basis.
In order to accomodate both elf types sizes, the maximum size for a
elf header member is chosen using the maximum value of both elf class.

Signed-off-by: Clement Leger <cleger@kalray.eu>
Tested-by: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 135 ++++++++++++++++++-----=
------
 drivers/remoteproc/remoteproc_elf_loader.h |  69 +++++++++++++++
 drivers/remoteproc/remoteproc_internal.h   |   2 +-
 drivers/remoteproc/st_remoteproc.c         |   2 +-
 include/linux/remoteproc.h                 |   4 +-
 5 files changed, 156 insertions(+), 56 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_elf_loader.h

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remotep=
roc/remoteproc_elf_loader.c
index b17d72ec8603..6a2d31d6092c 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -31,6 +31,7 @@
 #include <linux/elf.h>
=20
 #include "remoteproc_internal.h"
+#include "remoteproc_elf_loader.h"
=20
 /**
  * rproc_elf_sanity_check() - Sanity Check ELF firmware image
@@ -43,8 +44,16 @@ int rproc_elf_sanity_check(struct rproc *rproc, const =
struct firmware *fw)
 {
 	const char *name =3D rproc->firmware;
 	struct device *dev =3D &rproc->dev;
+	/*
+	 * Elf files are beginning with the same structure. Thus, to simplify
+	 * header parsing, we can use the elf32_hdr one for both elf64 and
+	 * elf32.
+	 */
 	struct elf32_hdr *ehdr;
+	u32 elf_shdr_size;
+	u64 phoff, shoff;
 	char class;
+	u16 phnum;
=20
 	if (!fw) {
 		dev_err(dev, "failed to load %s\n", name);
@@ -58,9 +67,13 @@ int rproc_elf_sanity_check(struct rproc *rproc, const =
struct firmware *fw)
=20
 	ehdr =3D (struct elf32_hdr *)fw->data;
=20
-	/* We only support ELF32 at this point */
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
+		dev_err(dev, "Image is corrupted (bad magic)\n");
+		return -EINVAL;
+	}
+
 	class =3D ehdr->e_ident[EI_CLASS];
-	if (class !=3D ELFCLASS32) {
+	if (class !=3D ELFCLASS32 && class !=3D ELFCLASS64) {
 		dev_err(dev, "Unsupported class: %d\n", class);
 		return -EINVAL;
 	}
@@ -75,26 +88,29 @@ int rproc_elf_sanity_check(struct rproc *rproc, const=
 struct firmware *fw)
 		return -EINVAL;
 	}
=20
-	if (fw->size < ehdr->e_shoff + sizeof(struct elf32_shdr)) {
-		dev_err(dev, "Image is too small\n");
-		return -EINVAL;
-	}
+	phoff =3D elf_hdr_e_phoff(class, fw->data);
+	shoff =3D elf_hdr_e_shoff(class, fw->data);
+	phnum =3D  elf_hdr_e_phnum(class, fw->data);
+	elf_shdr_size =3D elf_size_of_shdr(class);
=20
-	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
-		dev_err(dev, "Image is corrupted (bad magic)\n");
+	if (fw->size < shoff + elf_shdr_size) {
+		dev_err(dev, "Image is too small\n");
 		return -EINVAL;
 	}
=20
-	if (ehdr->e_phnum =3D=3D 0) {
+	if (phnum =3D=3D 0) {
 		dev_err(dev, "No loadable segments\n");
 		return -EINVAL;
 	}
=20
-	if (ehdr->e_phoff > fw->size) {
+	if (phoff > fw->size) {
 		dev_err(dev, "Firmware size is too small\n");
 		return -EINVAL;
 	}
=20
+	dev_dbg(dev, "Firmware is an elf%d file\n",
+		class =3D=3D ELFCLASS32 ? 32 : 64);
+
 	return 0;
 }
 EXPORT_SYMBOL(rproc_elf_sanity_check);
@@ -110,11 +126,9 @@ EXPORT_SYMBOL(rproc_elf_sanity_check);
  * Note that the boot address is not a configurable property of all remo=
te
  * processors. Some will always boot at a specific hard-coded address.
  */
-u32 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *=
fw)
+u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *=
fw)
 {
-	struct elf32_hdr *ehdr  =3D (struct elf32_hdr *)fw->data;
-
-	return ehdr->e_entry;
+	return elf_hdr_e_entry(fw_elf_get_class(fw), fw->data);
 }
 EXPORT_SYMBOL(rproc_elf_get_boot_addr);
=20
@@ -145,37 +159,41 @@ EXPORT_SYMBOL(rproc_elf_get_boot_addr);
 int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *=
fw)
 {
 	struct device *dev =3D &rproc->dev;
-	struct elf32_hdr *ehdr;
-	struct elf32_phdr *phdr;
+	const void *ehdr, *phdr;
 	int i, ret =3D 0;
+	u16 phnum;
 	const u8 *elf_data =3D fw->data;
+	u8 class =3D fw_elf_get_class(fw);
+	u32 elf_phdr_size =3D elf_size_of_phdr(class);
=20
-	ehdr =3D (struct elf32_hdr *)elf_data;
-	phdr =3D (struct elf32_phdr *)(elf_data + ehdr->e_phoff);
+	ehdr =3D elf_data;
+	phnum =3D elf_hdr_e_phnum(class, ehdr);
+	phdr =3D elf_data + elf_hdr_e_phoff(class, ehdr);
=20
 	/* go through the available ELF segments */
-	for (i =3D 0; i < ehdr->e_phnum; i++, phdr++) {
-		u32 da =3D phdr->p_paddr;
-		u32 memsz =3D phdr->p_memsz;
-		u32 filesz =3D phdr->p_filesz;
-		u32 offset =3D phdr->p_offset;
+	for (i =3D 0; i < phnum; i++, phdr +=3D elf_phdr_size) {
+		u64 da =3D elf_phdr_p_paddr(class, phdr);
+		u64 memsz =3D elf_phdr_p_memsz(class, phdr);
+		u64 filesz =3D elf_phdr_p_filesz(class, phdr);
+		u64 offset =3D elf_phdr_p_offset(class, phdr);
+		u32 type =3D elf_phdr_p_type(class, phdr);
 		void *ptr;
=20
-		if (phdr->p_type !=3D PT_LOAD)
+		if (type !=3D PT_LOAD)
 			continue;
=20
-		dev_dbg(dev, "phdr: type %d da 0x%x memsz 0x%x filesz 0x%x\n",
-			phdr->p_type, da, memsz, filesz);
+		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
+			type, da, memsz, filesz);
=20
 		if (filesz > memsz) {
-			dev_err(dev, "bad phdr filesz 0x%x memsz 0x%x\n",
+			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
 				filesz, memsz);
 			ret =3D -EINVAL;
 			break;
 		}
=20
 		if (offset + filesz > fw->size) {
-			dev_err(dev, "truncated fw: need 0x%x avail 0x%zx\n",
+			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
 				offset + filesz, fw->size);
 			ret =3D -EINVAL;
 			break;
@@ -184,14 +202,15 @@ int rproc_elf_load_segments(struct rproc *rproc, co=
nst struct firmware *fw)
 		/* grab the kernel address for this device address */
 		ptr =3D rproc_da_to_va(rproc, da, memsz);
 		if (!ptr) {
-			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
+			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
+				memsz);
 			ret =3D -EINVAL;
 			break;
 		}
=20
 		/* put the segment where the remote processor expects it */
-		if (phdr->p_filesz)
-			memcpy(ptr, elf_data + phdr->p_offset, filesz);
+		if (filesz)
+			memcpy(ptr, elf_data + offset, filesz);
=20
 		/*
 		 * Zero out remaining memory for this segment.
@@ -208,24 +227,32 @@ int rproc_elf_load_segments(struct rproc *rproc, co=
nst struct firmware *fw)
 }
 EXPORT_SYMBOL(rproc_elf_load_segments);
=20
-static struct elf32_shdr *
-find_table(struct device *dev, struct elf32_hdr *ehdr, size_t fw_size)
+static const void *
+find_table(struct device *dev, const struct firmware *fw)
 {
-	struct elf32_shdr *shdr;
+	const void *shdr, *name_table_shdr;
 	int i;
 	const char *name_table;
 	struct resource_table *table =3D NULL;
-	const u8 *elf_data =3D (void *)ehdr;
+	const u8 *elf_data =3D (void *)fw->data;
+	u8 class =3D fw_elf_get_class(fw);
+	size_t fw_size =3D fw->size;
+	const void *ehdr =3D elf_data;
+	u16 shnum =3D elf_hdr_e_shnum(class, ehdr);
+	u32 elf_shdr_size =3D elf_size_of_shdr(class);
+	u16 shstrndx =3D elf_hdr_e_shstrndx(class, ehdr);
=20
 	/* look for the resource table and handle it */
-	shdr =3D (struct elf32_shdr *)(elf_data + ehdr->e_shoff);
-	name_table =3D elf_data + shdr[ehdr->e_shstrndx].sh_offset;
+	shdr =3D elf_data + elf_hdr_e_shoff(class, ehdr);
+	name_table_shdr =3D shdr + (shstrndx * elf_shdr_size);
+	name_table =3D elf_data + elf_shdr_sh_offset(class, name_table_shdr);
=20
-	for (i =3D 0; i < ehdr->e_shnum; i++, shdr++) {
-		u32 size =3D shdr->sh_size;
-		u32 offset =3D shdr->sh_offset;
+	for (i =3D 0; i < shnum; i++, shdr +=3D elf_shdr_size) {
+		u64 size =3D elf_shdr_sh_size(class, shdr);
+		u64 offset =3D elf_shdr_sh_offset(class, shdr);
+		u32 name =3D elf_shdr_sh_name(class, shdr);
=20
-		if (strcmp(name_table + shdr->sh_name, ".resource_table"))
+		if (strcmp(name_table + name, ".resource_table"))
 			continue;
=20
 		table =3D (struct resource_table *)(elf_data + offset);
@@ -279,21 +306,21 @@ find_table(struct device *dev, struct elf32_hdr *eh=
dr, size_t fw_size)
  */
 int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware =
*fw)
 {
-	struct elf32_hdr *ehdr;
-	struct elf32_shdr *shdr;
+	const void *shdr;
 	struct device *dev =3D &rproc->dev;
 	struct resource_table *table =3D NULL;
 	const u8 *elf_data =3D fw->data;
 	size_t tablesz;
+	u8 class =3D fw_elf_get_class(fw);
+	u64 sh_offset;
=20
-	ehdr =3D (struct elf32_hdr *)elf_data;
-
-	shdr =3D find_table(dev, ehdr, fw->size);
+	shdr =3D find_table(dev, fw);
 	if (!shdr)
 		return -EINVAL;
=20
-	table =3D (struct resource_table *)(elf_data + shdr->sh_offset);
-	tablesz =3D shdr->sh_size;
+	sh_offset =3D elf_shdr_sh_offset(class, shdr);
+	table =3D (struct resource_table *)(elf_data + sh_offset);
+	tablesz =3D elf_shdr_sh_size(class, shdr);
=20
 	/*
 	 * Create a copy of the resource table. When a virtio device starts
@@ -326,13 +353,17 @@ EXPORT_SYMBOL(rproc_elf_load_rsc_table);
 struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rpr=
oc,
 						       const struct firmware *fw)
 {
-	struct elf32_hdr *ehdr =3D (struct elf32_hdr *)fw->data;
-	struct elf32_shdr *shdr;
+	const void *shdr;
+	u64 sh_addr, sh_size;
+	u8 class =3D fw_elf_get_class(fw);
=20
-	shdr =3D find_table(&rproc->dev, ehdr, fw->size);
+	shdr =3D find_table(&rproc->dev, fw);
 	if (!shdr)
 		return NULL;
=20
-	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size);
+	sh_addr =3D elf_shdr_sh_addr(class, shdr);
+	sh_size =3D elf_shdr_sh_size(class, shdr);
+
+	return rproc_da_to_va(rproc, sh_addr, sh_size);
 }
 EXPORT_SYMBOL(rproc_elf_find_loaded_rsc_table);
diff --git a/drivers/remoteproc/remoteproc_elf_loader.h b/drivers/remotep=
roc/remoteproc_elf_loader.h
new file mode 100644
index 000000000000..fac3565734f9
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_elf_loader.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Remote processor elf loader defines
+ *
+ * Copyright (C) 2019 Kalray, Inc.
+ */
+
+#ifndef REMOTEPROC_ELF_LOADER_H
+#define REMOTEPROC_ELF_LOADER_H
+
+#include <linux/elf.h>
+#include <linux/types.h>
+
+/**
+ * fw_elf_get_class - Get elf class
+ * @fw: the ELF firmware image
+ *
+ * Note that we use and elf32_hdr to access the class since the start of=
 the
+ * struct is the same for both elf class
+ *
+ * Return: elf class of the firmware
+ */
+static inline u8 fw_elf_get_class(const struct firmware *fw)
+{
+	struct elf32_hdr *ehdr =3D (struct elf32_hdr *)fw->data;
+
+	return ehdr->e_ident[EI_CLASS];
+}
+
+#define ELF_GET_FIELD(__s, __field, __type) \
+static inline __type elf_##__s##_##__field(u8 class, const void *arg) \
+{ \
+	if (class =3D=3D ELFCLASS32) \
+		return (__type) ((const struct elf32_##__s *) arg)->__field; \
+	else \
+		return (__type) ((const struct elf64_##__s *) arg)->__field; \
+}
+
+ELF_GET_FIELD(hdr, e_entry, u64)
+ELF_GET_FIELD(hdr, e_phnum, u16)
+ELF_GET_FIELD(hdr, e_shnum, u16)
+ELF_GET_FIELD(hdr, e_phoff, u64)
+ELF_GET_FIELD(hdr, e_shoff, u64)
+ELF_GET_FIELD(hdr, e_shstrndx, u16)
+
+ELF_GET_FIELD(phdr, p_paddr, u64)
+ELF_GET_FIELD(phdr, p_filesz, u64)
+ELF_GET_FIELD(phdr, p_memsz, u64)
+ELF_GET_FIELD(phdr, p_type, u32)
+ELF_GET_FIELD(phdr, p_offset, u64)
+
+ELF_GET_FIELD(shdr, sh_size, u64)
+ELF_GET_FIELD(shdr, sh_offset, u64)
+ELF_GET_FIELD(shdr, sh_name, u32)
+ELF_GET_FIELD(shdr, sh_addr, u64)
+
+#define ELF_STRUCT_SIZE(__s) \
+static inline unsigned long elf_size_of_##__s(u8 class) \
+{ \
+	if (class =3D=3D ELFCLASS32)\
+		return sizeof(struct elf32_##__s); \
+	else \
+		return sizeof(struct elf64_##__s); \
+}
+
+ELF_STRUCT_SIZE(shdr)
+ELF_STRUCT_SIZE(phdr)
+
+#endif /* REMOTEPROC_ELF_LOADER_H */
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remotepro=
c/remoteproc_internal.h
index 45ff76a06c72..4ef745e3a1bc 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -63,7 +63,7 @@ phys_addr_t rproc_va_to_pa(void *cpu_addr);
 int rproc_trigger_recovery(struct rproc *rproc);
=20
 int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *f=
w);
-u32 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *=
fw);
+u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *=
fw);
 int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *=
fw);
 int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware =
*fw);
 struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rpr=
oc,
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_r=
emoteproc.c
index 51049d17b1e5..e23abd8a96b0 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -193,7 +193,7 @@ static int st_rproc_start(struct rproc *rproc)
 		}
 	}
=20
-	dev_info(&rproc->dev, "Started from 0x%x\n", rproc->bootaddr);
+	dev_info(&rproc->dev, "Started from 0x%llx\n", rproc->bootaddr);
=20
 	return 0;
=20
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 04d04709f2bd..512de9a2590c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -362,7 +362,7 @@ struct rproc_ops {
 				struct rproc *rproc, const struct firmware *fw);
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
-	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
+	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
 };
=20
 /**
@@ -478,7 +478,7 @@ struct rproc {
 	int num_traces;
 	struct list_head carveouts;
 	struct list_head mappings;
-	u32 bootaddr;
+	u64 bootaddr;
 	struct list_head rvdevs;
 	struct list_head subdevs;
 	struct idr notifyids;
--=20
2.15.0.276.g89ea799

