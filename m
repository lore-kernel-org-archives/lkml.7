Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015DAC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0ED20874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920692;
	bh=4BQXjHM/0DWtFo2HhpXrBkKVLPTEKmgwg598UQ4Nidk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VRuF/v65Ab9Xy+qClaaDRISrWmBmj06038vhx6V+9vMzeNNg8OeiTqtW/rwH2RAy7
	 yvxOsAtHCn7GxJdDOGu5BSd5l5oTXnNVI03vDPngVLlHIJHWurMpEEO8SOBiFCwb0Z
	 Sw4jveycBOvoidANrMX9MWFa1ijhgwnbiH6PkPuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfKPQLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729967AbfKPPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:38 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 024102086A;
        Sat, 16 Nov 2019 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919318;
        bh=4BQXjHM/0DWtFo2HhpXrBkKVLPTEKmgwg598UQ4Nidk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wShjuPUHB01VPK0OSvz8C4MiGDnL2IuvG8n9ZTYKY3s/dhZ6n48Uuta4LOKtfngf0
         QIYp4pzF9fYm8lusxUoiO7Oo97em/Q3G+KN8bEIifz1Slgz7PsZqyWeDXfme5gw99c
         qOF/8+mWo2x3yIbEC9MUc0yfCIlhRt554tPz2iE8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 059/150] powerpc/pseries: Export raw per-CPU VPA data via debugfs
Date:   Sat, 16 Nov 2019 10:45:57 -0500
Message-Id: <20191116154729.9573-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

[ Upstream commit c6c26fb55e8e4b3fc376be5611685990a17de27a ]

This patch exports the raw per-CPU VPA data via debugfs.
A per-CPU file is created which exports the VPA data of
that CPU to help debug some of the VPA related issues or
to analyze the per-CPU VPA related statistics.

v3: Removed offline CPU check.

v2: Included offline CPU check and other review comments.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/lpar.c | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index eb738ef577926..c0ae3847b8db5 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -48,6 +48,7 @@
 #include <asm/kexec.h>
 #include <asm/fadump.h>
 #include <asm/asm-prototypes.h>
+#include <asm/debugfs.h>
 
 #include "pseries.h"
 
@@ -1036,3 +1037,56 @@ static int __init reserve_vrma_context_id(void)
 	return 0;
 }
 machine_device_initcall(pseries, reserve_vrma_context_id);
+
+#ifdef CONFIG_DEBUG_FS
+/* debugfs file interface for vpa data */
+static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
+			      loff_t *pos)
+{
+	int cpu = (long)filp->private_data;
+	struct lppaca *lppaca = &lppaca_of(cpu);
+
+	return simple_read_from_buffer(buf, len, pos, lppaca,
+				sizeof(struct lppaca));
+}
+
+static const struct file_operations vpa_fops = {
+	.open		= simple_open,
+	.read		= vpa_file_read,
+	.llseek		= default_llseek,
+};
+
+static int __init vpa_debugfs_init(void)
+{
+	char name[16];
+	long i;
+	static struct dentry *vpa_dir;
+
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return 0;
+
+	vpa_dir = debugfs_create_dir("vpa", powerpc_debugfs_root);
+	if (!vpa_dir) {
+		pr_warn("%s: can't create vpa root dir\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* set up the per-cpu vpa file*/
+	for_each_possible_cpu(i) {
+		struct dentry *d;
+
+		sprintf(name, "cpu-%ld", i);
+
+		d = debugfs_create_file(name, 0400, vpa_dir, (void *)i,
+					&vpa_fops);
+		if (!d) {
+			pr_warn("%s: can't create per-cpu vpa file\n",
+					__func__);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+machine_arch_initcall(pseries, vpa_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
-- 
2.20.1

