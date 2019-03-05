Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA136C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8CC20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfCENWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:22:05 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:46355 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfCENWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:22:04 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N3Kc8-1h9RQE473i-010Js4; Tue, 05 Mar 2019 14:21:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: i10nm, skx: fix randconfig builds
Date:   Tue,  5 Mar 2019 14:21:30 +0100
Message-Id: <20190305132147.3739133-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DG3N/3ueq6q9PTMKpnrJ3WdtP6DHHvJU0tQ9ryMCYiPPgKrrUsL
 Ni8fhsxLi33Cj/g7DRnGTdhU8o8uahsemZgB7ss44KGuHltlkXX8c8PbRyEJPLz8fm+ENRa
 3/RsA6GmTJHdlQ+Uouta6CBq5SW9OY6I+zU4EmlPhFaurxYO+trgpfToPkhTR21akgICD1l
 jc6u2iJTU42J8zh4ONL9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dCIGAx79iUo=:GWTG1Ij+FaoxBx6AlVRH/Y
 Fd3o6OLIZbHwlyLGSkZwCw7nWApZOVzr6QpP0iWzP7xSc5aVrc3H7e0Kj6HGVFb4igamQXNtQ
 lImFhzDFqHducKmY6QBV/PB03fKNvvF85tjyz314u0QBuSpFhRzOJizWJ9B4GV/chOszPEJrp
 Bjz6JowW/swKo29JC9lvUH7KTcG1iq7BykzcCKhzmwd0l00+XSBCFZcR0jTT8W1526OPUpi/W
 kceiKZ8qu+lvKkxLA6hOiUMjBYVxfhGVxJ4O3PDSxi4Oa12UKtpzjZEzsGLWTRNbrXH8uyOso
 pVgf0a61o7I8ZdVyLOHY5IWlZk3tITAb9kewF9zIN8izMf/c+GuAPEnjiL4/mE4jqhxpO7UTD
 H5w6XsWgWEoCy7owPMLgLExz33XCWxUltkHw27DR/rOuFA1XGw4Ww3gkmGAoaYKA7aftmdhIa
 HNRi+CfdA2TVZBS8xjr5NAn3iDHtZ8MqAdjj/nBvzUZAljz81zuJe+GTZWojAcGj7BKccF8Ye
 XMQP9zBzJceoqtskTQfcsulcfSck9gQ8s/7gvP3kauZMBJoUM3sR+8+QejICKnqB+mgpVjuhM
 9arY+WHFkYcAgv+z5X1c7vy0wGOuMNtDUCz1JgpC6aOviDIAlfOXVOYzu5wkPYSP5ia/oxy/N
 kN+IPo36o9BvDBbcGTCqKzWBfJSsLWWJoIxobadDe8FERH1F2OaE/f24wfCzr36Ndp9QUEynq
 uG8NCtyhfEoOgpX0iUssqc2MjbGDOj7ZXsnDbA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a configuration where one of the two drivers is built-in and the
other one is a module, kbuild tries to add the modular file into
vmlinux, and fails with

drivers/edac/skx_common.o:(.rodata+0xc0): undefined reference to `__this_module'

We either have to make both drivers be configured the same way all the
time, or make skx_common a separate module.

This takes the second approach, which is more logical, but has the downside
of requiring lots of new EXPORT_SYMBOL_GPL() statements.

Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/Makefile     |  8 ++++----
 drivers/edac/skx_common.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84a0f6..ab01d15be46c 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -57,11 +57,11 @@ obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
 layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
 obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
 
-skx_edac-y				:= skx_common.o skx_base.o
-obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o
+skx_edac-y				:= skx_base.o
+obj-$(CONFIG_EDAC_SKX)			+= skx_common.o skx_edac.o
 
-i10nm_edac-y				:= skx_common.o i10nm_base.o
-obj-$(CONFIG_EDAC_I10NM)		+= i10nm_edac.o
+i10nm_edac-y				:= i10nm_base.o
+obj-$(CONFIG_EDAC_I10NM)		+= skx_common.o i10nm_edac.o
 
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 0e96e7b5b0a7..bb183035df5c 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -83,12 +83,14 @@ int __init skx_adxl_get(void)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(skx_adxl_get);
 
 void __exit skx_adxl_put(void)
 {
 	kfree(adxl_values);
 	kfree(adxl_msg);
 }
+EXPORT_SYMBOL_GPL(skx_adxl_put);
 
 static bool skx_adxl_decode(struct decoded_addr *res)
 {
@@ -127,6 +129,7 @@ void skx_set_decode(skx_decode_f decode)
 {
 	skx_decode = decode;
 }
+EXPORT_SYMBOL_GPL(skx_set_decode);
 
 int skx_get_src_id(struct skx_dev *d, u8 *id)
 {
@@ -140,6 +143,7 @@ int skx_get_src_id(struct skx_dev *d, u8 *id)
 	*id = GET_BITFIELD(reg, 12, 14);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(skx_get_src_id);
 
 int skx_get_node_id(struct skx_dev *d, u8 *id)
 {
@@ -153,6 +157,7 @@ int skx_get_node_id(struct skx_dev *d, u8 *id)
 	*id = GET_BITFIELD(reg, 0, 2);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(skx_get_node_id);
 
 static int get_width(u32 mtr)
 {
@@ -219,6 +224,7 @@ int skx_get_all_bus_mappings(unsigned int did, int off, enum type type,
 		*list = &dev_edac_list;
 	return ndev;
 }
+EXPORT_SYMBOL_GPL(skx_get_all_bus_mappings);
 
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 {
@@ -258,6 +264,7 @@ int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 	pci_dev_put(pdev);
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(skx_get_hi_lo);
 
 static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 			     int minval, int maxval, const char *name)
@@ -311,6 +318,7 @@ int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(skx_get_dimm_info);
 
 int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 			int chan, int dimmno, const char *mod_str)
@@ -359,6 +367,7 @@ int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 
 	return (size == 0 || size == ~0ull) ? 0 : 1;
 }
+EXPORT_SYMBOL_GPL(skx_get_nvdimm_info);
 
 int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 		     const char *ctl_name, const char *mod_str,
@@ -426,6 +435,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	imc->mci = NULL;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(skx_register_mci);
 
 static void skx_unregister_mci(struct skx_imc *imc)
 {
@@ -609,6 +619,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	return NOTIFY_DONE;
 }
+EXPORT_SYMBOL_GPL(skx_mce_check_error);
 
 void skx_remove(void)
 {
@@ -644,6 +655,7 @@ void skx_remove(void)
 		kfree(d);
 	}
 }
+EXPORT_SYMBOL_GPL(skx_remove);
 
 #ifdef CONFIG_EDAC_DEBUG
 /*
@@ -683,9 +695,11 @@ void setup_skx_debug(const char *dirname)
 		skx_test = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(setup_skx_debug);
 
 void teardown_skx_debug(void)
 {
 	debugfs_remove_recursive(skx_test);
 }
+EXPORT_SYMBOL_GPL(teardown_skx_debug);
 #endif /*CONFIG_EDAC_DEBUG*/
-- 
2.20.0

