Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457EAECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E459208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfILKgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:36:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731092AbfILKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:36:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8CAX30a026071;
        Thu, 12 Sep 2019 06:35:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uym8prbxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 06:35:55 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8CAZKwA034203;
        Thu, 12 Sep 2019 06:35:54 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uym8prbww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 06:35:54 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8CAU8iC017403;
        Thu, 12 Sep 2019 10:35:53 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 2uy6jvwg7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 10:35:53 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8CAZqqN52560328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 10:35:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC49C13604F;
        Thu, 12 Sep 2019 10:35:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 770F3136051;
        Thu, 12 Sep 2019 10:35:52 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.237])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 Sep 2019 10:35:52 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 1F7B12E47C4; Thu, 12 Sep 2019 16:05:51 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/2] pseries/hotplug-cpu: Add sysfs attribute for cede_offline
Date:   Thu, 12 Sep 2019 16:05:41 +0530
Message-Id: <1568284541-15169-3-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Define a new sysfs attribute
"/sys/device/system/cpu/cede_offline_enabled" on PSeries Linux guests
to allow userspace programs to change the state into which the
offlined CPU need to be put to at runtime. This is intended for
userspace programs that fold CPUs for the purpose of saving energy
when the utilization is low.

Setting the value of this attribute ensures that subsequent CPU
offline operations will put the offlined CPUs to extended
cede. However, it will cause inconsistencies in the PURR accounting.

Clearing the attribute will make the offlined CPUs call the RTAS
"stop-self" call thereby returning the CPU to the hypervisor.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 14 +++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c       | 68 ++++++++++++++++++++--
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 06d0931..b3c52cd 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -572,3 +572,17 @@ Description:	Secure Virtual Machine
 		If 1, it means the system is using the Protected Execution
 		Facility in POWER9 and newer processors. i.e., it is a Secure
 		Virtual Machine.
+
+What:		/sys/devices/system/cpu/cede_offline_enabled
+Date:		August 2019
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+		Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Offline CPU state control
+
+		If 1, it means that offline CPUs on PSeries guests
+		will be made to call an extended CEDE which provides
+		energy savings but at the expense of accuracy of PURR
+		accounting. If 0, the offline CPUs on PSeries guests
+		will be made to call RTAS "stop-self" call which will
+		return the CPUs to the Hypervisor and provide accurate
+		values of PURR. The value is 0 by default.
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f9d0366..4a04cf7 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -943,9 +943,64 @@ static int parse_cede_parameters(void)
 			 CEDE_LATENCY_PARAM_MAX_LENGTH);
 }
 
-static int __init pseries_cpu_hotplug_init(void)
+/*
+ * Must be guarded by
+ * cpu_maps_update_begin()...cpu_maps_update_done()
+ */
+static void update_default_offline_state(void)
 {
 	int cpu;
+
+	if (cede_offline_enabled)
+		default_offline_state = CPU_STATE_INACTIVE;
+	else
+		default_offline_state = CPU_STATE_OFFLINE;
+
+	for_each_possible_cpu(cpu)
+		set_default_offline_state(cpu);
+}
+
+static ssize_t show_cede_offline_enabled(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	unsigned long ret = 0;
+
+	if (cede_offline_enabled)
+		ret = 1;
+
+	return sprintf(buf, "%lx\n", ret);
+}
+
+static ssize_t store_cede_offline_enabled(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	bool val;
+	int ret = 0;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return -EINVAL;
+
+	cpu_maps_update_begin();
+	/* Check if anything needs to be done */
+	if (val == cede_offline_enabled)
+		goto done;
+	cede_offline_enabled = val;
+	update_default_offline_state();
+done:
+	cpu_maps_update_done();
+
+	return count;
+}
+
+static DEVICE_ATTR(cede_offline_enabled, 0600,
+		   show_cede_offline_enabled,
+		   store_cede_offline_enabled);
+
+static int __init pseries_cpu_hotplug_init(void)
+{
 	int qcss_tok;
 
 #ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
@@ -971,11 +1026,12 @@ static int __init pseries_cpu_hotplug_init(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		of_reconfig_notifier_register(&pseries_smp_nb);
 		cpu_maps_update_begin();
-		if (cede_offline_enabled && parse_cede_parameters() == 0) {
-			default_offline_state = CPU_STATE_INACTIVE;
-			for_each_online_cpu(cpu)
-				set_default_offline_state(cpu);
-		}
+		if (parse_cede_parameters() == 0)
+			device_create_file(cpu_subsys.dev_root,
+					   &dev_attr_cede_offline_enabled);
+		else /* Extended cede is not supported */
+			cede_offline_enabled = false;
+		update_default_offline_state();
 		cpu_maps_update_done();
 	}
 
-- 
1.9.4

