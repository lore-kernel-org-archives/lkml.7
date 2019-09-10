Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E901C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328872168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405996AbfIJPAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:00:39 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:28398 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393703AbfIJPAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:00:15 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEphL3013469;
        Tue, 10 Sep 2019 15:00:00 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uwur92rqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 15:00:00 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 327C88D;
        Tue, 10 Sep 2019 14:59:59 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 9725A201FCF1B; Tue, 10 Sep 2019 09:59:58 -0500 (CDT)
Message-Id: <20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: quilt/0.46-1
Date:   Tue, 10 Sep 2019 09:58:44 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/8] x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files
Content-Disposition: inline; filename=add-procfs-files
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate to UV user utilities that UV hubless support is available on
this system via the existing /proc infterface.  The current interface is
maintained with the addition of new /proc leaves ("hubbed", "hubless",
and "oemid") that contain the specific type of UV arch this one is.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
V2: Remove is_uv_hubbed define
    Remove leading '_' from _is_uv_hubbed
---
 arch/x86/include/asm/uv/uv.h       |    4 +
 arch/x86/kernel/apic/x2apic_uv_x.c |   93 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/include/asm/uv/uv.h
+++ linux/arch/x86/include/asm/uv/uv.h
@@ -12,6 +12,8 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+#define	UV_PROC_NODE	"sgi_uv"
+
 static inline int uv(int uvtype)
 {
 	/* uv(0) is "any" */
@@ -28,6 +30,7 @@ static inline bool is_early_uv_system(vo
 	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
+extern int is_uv_hubbed(int uvtype);
 extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
@@ -40,6 +43,7 @@ extern const struct cpumask *uv_flush_tl
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
+static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,6 +26,7 @@
 static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
+static int			uv_hubbed_system;
 static int			uv_hubless_system;
 static u64			gru_start_paddr, gru_end_paddr;
 static u64			gru_dist_base, gru_first_node_paddr = -1LL, gru_last_node_paddr;
@@ -309,6 +310,24 @@ static int __init uv_acpi_madt_oem_check
 	if (uv_hub_info->hub_revision == 0)
 		goto badbios;
 
+	switch (uv_hub_info->hub_revision) {
+	case UV4_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x11;
+		break;
+
+	case UV3_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x9;
+		break;
+
+	case UV2_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x5;
+		break;
+
+	case UV1_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x3;
+		break;
+	}
+
 	pnodeid = early_get_pnodeid();
 	early_get_apic_socketid_shift();
 
@@ -359,6 +378,12 @@ int is_uv_system(void)
 }
 EXPORT_SYMBOL_GPL(is_uv_system);
 
+int is_uv_hubbed(int uvtype)
+{
+	return (uv_hubbed_system & uvtype);
+}
+EXPORT_SYMBOL_GPL(is_uv_hubbed);
+
 int is_uv_hubless(int uvtype)
 {
 	return (uv_hubless_system & uvtype);
@@ -1457,6 +1482,68 @@ static void __init build_socket_tables(v
 	}
 }
 
+/* Setup user proc fs files */
+static int proc_hubbed_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "0x%x\n", uv_hubbed_system);
+	return 0;
+}
+
+static int proc_hubless_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "0x%x\n", uv_hubless_system);
+	return 0;
+}
+
+static int proc_oemid_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
+	return 0;
+}
+
+static int proc_hubbed_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hubbed_show, (void *)NULL);
+}
+
+static int proc_hubless_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hubless_show, (void *)NULL);
+}
+
+static int proc_oemid_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_oemid_show, (void *)NULL);
+}
+
+/* (struct is "non-const" as open function is set at runtime) */
+static struct file_operations proc_version_fops = {
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_oemid_fops = {
+	.open		= proc_oemid_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init void uv_setup_proc_files(int hubless)
+{
+	struct proc_dir_entry *pde;
+	char *name = hubless ? "hubless" : "hubbed";
+
+	pde = proc_mkdir(UV_PROC_NODE, NULL);
+	proc_create("oemid", 0, pde, &proc_oemid_fops);
+	proc_create(name, 0, pde, &proc_version_fops);
+	if (hubless)
+		proc_version_fops.open = proc_hubless_open;
+	else
+		proc_version_fops.open = proc_hubbed_open;
+}
+
 /* Initialize UV hubless systems */
 static __init int uv_system_init_hubless(void)
 {
@@ -1468,6 +1555,10 @@ static __init int uv_system_init_hubless
 	/* Init kernel/BIOS interface */
 	rc = uv_bios_init();
 
+	/* Create user access node if UVsystab available */
+	if (rc >= 0)
+		uv_setup_proc_files(1);
+
 	return rc;
 }
 
@@ -1596,7 +1687,7 @@ static void __init uv_system_init_hub(vo
 	uv_nmi_setup();
 	uv_cpu_init();
 	uv_scir_register_cpu_notifier();
-	proc_mkdir("sgi_uv", NULL);
+	uv_setup_proc_files(0);
 
 	/* Register Legacy VGA I/O redirection handler: */
 	pci_register_set_vga_state(uv_set_vga_state);

-- 

