Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E24CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CC521783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfEUExP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfEUExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:53:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L4qPwM022521
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:53:14 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sm97wtrd4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:53:14 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 21 May 2019 05:53:13 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 05:53:10 +0100
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L4r8jW16974156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:53:09 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D865DC6055;
        Tue, 21 May 2019 04:53:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC21DC6057;
        Tue, 21 May 2019 04:52:58 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.203.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 04:52:57 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Ryan Grimm <grimm@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH 08/12] powerpc/pseries/svm: Export guest SVM status to user space via sysfs
Date:   Tue, 21 May 2019 01:49:08 -0300
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521044912.1375-1-bauerman@linux.ibm.com>
References: <20190521044912.1375-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052104-0004-0000-0000-000015120A43
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011134; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01206343; UDB=6.00633450; IPR=6.00987310;
 MB=3.00026980; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-21 04:53:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052104-0005-0000-0000-00008BBE4C66
Message-Id: <20190521044912.1375-9-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Grimm <grimm@linux.vnet.ibm.com>

User space might want to know it's running in a secure VM.  It can't do
a mfmsr because mfmsr is a privileged instruction.

The solution here is to create a cpu attribute:

/sys/devices/system/cpu/svm

which will read 0 or 1 based on the S bit of the guest's CPU 0.

Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index e8e93c2c7d03..8fdab134e9ae 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -18,6 +18,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/svm.h>
 
 #include "cacheinfo.h"
 #include "setup.h"
@@ -714,6 +715,32 @@ static struct device_attribute pa6t_attrs[] = {
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
+#ifdef CONFIG_PPC_SVM
+static void get_svm(void *val)
+{
+	u32 *value = val;
+
+	*value = is_secure_guest();
+}
+
+static ssize_t show_svm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u32 val;
+	smp_call_function_single(0, get_svm, &val, 1);
+	return sprintf(buf, "%u\n", val);
+}
+static DEVICE_ATTR(svm, 0444, show_svm, NULL);
+
+static void create_svm_file(void)
+{
+	device_create_file(cpu_subsys.dev_root, &dev_attr_svm);
+}
+#else
+static void create_svm_file(void)
+{
+}
+#endif /* CONFIG_PPC_SVM */
+
 static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -1057,6 +1084,8 @@ static int __init topology_init(void)
 	sysfs_create_dscr_default();
 #endif /* CONFIG_PPC64 */
 
+	create_svm_file();
+
 	return 0;
 }
 subsys_initcall(topology_init);

