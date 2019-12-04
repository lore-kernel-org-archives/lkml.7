Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F5922525
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YkLJ6tx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfLDX34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:29:56 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:59201
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728132AbfLDX3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:29:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lupwCQQsywKqGRKBCu/5+jk3bFgdRotUBnPJpPecEjGq2Q8TShM9blMcP/RLozW1IHxQM7ZX9kTIe24JLFXLWsOh2YZFp0eHAQM0qGk2lXsvaZEDHuyLtpVOLvxCq8vUAn9ke//vm8ndhEmwtUQzzT2YnyQ+Tl3FIp2eiSO8GA2n/asbhkAoiIcnZL+QJKeGfPLbA+d5Rf5ejSTkxDUje5siZG+dXu2QH6AM+B3q4lePuNsGPWVMsbjw20mU7h948QdlmSdwqnXmFMkzVLwChciafLwi2S2tLFFeI8S0HX14NriCL8yr0jVvQfqcsQ31DKTDd+U8cFJTfvVW2MD+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3YQP68LJyymWuPbnb67Z3B2nv5ikzPivDfqLAz/Qs8=;
 b=MVAZk3njaSD7GWqVSojTF/Gisog+BfYaAWYVy/WxFhzt9ucba7FI2Yy6v3aFs4Dt18R8ThaBJbTLZCOg5iN5VOSzmMW/ud8tGHixGon09RmKk6VPiyHujSEJTvRazmdO/0bQdIst7428DJxmy1B5tcd4ykZGiugfxOsm7eUkgwRXi6BSOsYypSD5XZ+iXzSvtf6uHJPIa9hGKtkEfOEWAlBvU28/cdqCYxTmgqIJQpgZKFJAtqxyE9rQAFbLtuGha4HA3JXEs17xYPGD7JumT3saF6lLMmrFl+ORPVyY217HShvuOBABkCl4oiZnbUyZPEt7aV+PLvi3xopU0PdxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=aggios.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3YQP68LJyymWuPbnb67Z3B2nv5ikzPivDfqLAz/Qs8=;
 b=YkLJ6tx16HOLx60iV5YbRnt4xfA2bpAqcCDTZAKllO7+BEms7W64Vlk/FncvoUDnM1fbM5jFkomPCErPBZ56zU3+c5QCpADz4qYkBZWj0qBGggbHEX0p8eYs/PYzKp+3Jayl32TYKbumJydSXEj/NVfqCO1ROYktIxH0WZqPH3U=
Received: from BN6PR02CA0045.namprd02.prod.outlook.com (2603:10b6:404:5f::31)
 by MWHPR02MB2575.namprd02.prod.outlook.com (2603:10b6:300:46::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Wed, 4 Dec
 2019 23:29:37 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR02CA0045.outlook.office365.com
 (2603:10b6:404:5f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Wed, 4 Dec 2019 23:29:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; aggios.com; dkim=none (message not signed)
 header.d=none;aggios.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 4 Dec 2019 23:29:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5P-0005aG-9H; Wed, 04 Dec 2019 15:29:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5K-00080R-5q; Wed, 04 Dec 2019 15:29:30 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB4NTRrD004749;
        Wed, 4 Dec 2019 15:29:27 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5H-000802-Ki; Wed, 04 Dec 2019 15:29:27 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Stefan Krsmanovic <stefan.krsmanovic@aggios.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 4/5] firmware: xilinx: Add sysfs to set shutdown scope
Date:   Wed,  4 Dec 2019 15:29:18 -0800
Message-Id: <1575502159-11327-5-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(8936002)(5660300002)(48376002)(8676002)(44832011)(107886003)(36756003)(14444005)(478600001)(2906002)(26005)(36386004)(6636002)(16586007)(7696005)(336012)(305945005)(70206006)(50226002)(54906003)(186003)(316002)(2616005)(11346002)(4326008)(81156014)(9786002)(50466002)(51416003)(356004)(76176011)(6666004)(70586007)(426003)(7416002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2575;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9dda446-b850-4d39-ce5f-08d77911d344
X-MS-TrafficTypeDiagnostic: MWHPR02MB2575:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2575389CCDFF5DB9C2C7A4F8B85D0@MWHPR02MB2575.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0241D5F98C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeCR3HLqa+V+/jp2L/7Fi5wHb9rmpP0v7ZGWz63P0OUEiVPBFXI+CmnaygNtSYZ+CrQ9vHHdw94JTofDu/cFHXIcmXmHqDByuJomHJP0ilaLqyHKggI8PUFgKPWLsAOkm5gamiBnba4+z4O4DT5CiJMTCaXSE2GNCpeNARSeqhBvrCY/yl1QPWsze3Km+EeLgR8Hiak1SwMTfCU3iOAeWwbYaAnlPjgTZfnulbtC1aNlWN7KYO3uOobBgfcicyK+0/oLAArpjY1PMppOdUBJVcAHL9nu+eC0n/8i+nSC3nsqYRqipR8lyE7NzhO+pypVFt9BRqijWJqP5cgcDwASgRBZaWwi+gbyawJjJ2ri8VNvcHrhdkKMAWzndRvY485T3CxpgGvVIErXZ8ggw4z+oBGwsw3+qTl+1NeDqeGTlYTPKLOud4fOSqgVL5D8tTab
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 23:29:35.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dda446-b850-4d39-ce5f-08d77911d344
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

The Linux shutdown functionality implemented via PSCI system_off does
not include an option to set a scope, i.e. which parts of the system to
shut down.

This patch creates sysfs that allows to set the shutdown scope for the
next shutdown request. When the next shutdown is performed, the platform
specific portion of PSCI-system_off can use the chosen shutdown scope.

Signed-off-by: Stefan Krsmanovic <stefan.krsmanovic@aggios.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 Documentation/ABI/stable/sysfs-firmware-zynqmp |  32 ++++++
 drivers/firmware/xilinx/zynqmp.c               | 141 +++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h           |  12 +++
 3 files changed, 185 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-firmware-zynqmp b/Documentation/ABI/stable/sysfs-firmware-zynqmp
index 0a75812..13e4fd2 100644
--- a/Documentation/ABI/stable/sysfs-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-firmware-zynqmp
@@ -48,3 +48,35 @@ Description:
 		# echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/pggs0
 
 Users:		Xilinx
+
+What:		/sys/firmware/zynqmp/shutdown_scope
+Date:		February 2018
+KernelVersion:	4.15.6
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		This sysfs interface allows to set the shutdown scope for the
+		next shutdown request. When the next shutdown is performed, the
+		platform specific portion of PSCI-system_off can use the chosen
+		shutdown scope.
+
+		Following are available shutdown scopes(subtypes):
+
+		subsystem:	Only the APU along with all of its peripherals
+				not used by other processing units will be
+				shut down. This may result in the FPD power
+				domain being shut down provided that no other
+				processing unit uses FPD peripherals or DRAM.
+		ps_only:	The complete PS will be shut down, including the
+				RPU, PMU, etc.  Only the PL domain (FPGA)
+				remains untouched.
+		system:		The complete system/device is shut down.
+
+		Usage:
+		# cat /sys/firmware/zynqmp/shutdown_scope
+		# echo <scope> > /sys/firmware/zynqmp/shutdown_scope
+
+		Example:
+		# cat /sys/firmware/zynqmp/shutdown_scope
+		# echo "subsystem" > /sys/firmware/zynqmp/shutdown_scope
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8dcf5a4..b23bda4 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -746,6 +746,146 @@ const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
 
 /**
+ * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
+ * @subtype:	Shutdown subtype
+ * @name:	Matching string for scope argument
+ *
+ * This struct encapsulates mapping between shutdown scope ID and string.
+ */
+struct zynqmp_pm_shutdown_scope {
+	const enum zynqmp_pm_shutdown_subtype subtype;
+	const char *name;
+};
+
+static struct zynqmp_pm_shutdown_scope shutdown_scopes[] = {
+	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM] = {
+		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM,
+		.name = "subsystem",
+	},
+	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY] = {
+		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY,
+		.name = "ps_only",
+	},
+	[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM] = {
+		.subtype = ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM,
+		.name = "system",
+	},
+};
+
+static struct zynqmp_pm_shutdown_scope *selected_scope =
+		&shutdown_scopes[ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM];
+
+/**
+ * zynqmp_pm_is_shutdown_scope_valid - Check if shutdown scope string is valid
+ * @scope_string:	Shutdown scope string
+ *
+ * Return:		Return pointer to matching shutdown scope struct from
+ *			array of available options in system if string is valid,
+ *			otherwise returns NULL.
+ */
+static struct zynqmp_pm_shutdown_scope*
+		zynqmp_pm_is_shutdown_scope_valid(const char *scope_string)
+{
+	int count;
+
+	for (count = 0; count < ARRAY_SIZE(shutdown_scopes); count++)
+		if (sysfs_streq(scope_string, shutdown_scopes[count].name))
+			return &shutdown_scopes[count];
+
+	return NULL;
+}
+
+/**
+ * shutdown_scope_show - Show shutdown_scope sysfs attribute
+ * @kobj:	Kobject structure
+ * @attr:	Kobject attribute structure
+ * @buf:	Requested available shutdown_scope attributes string
+ *
+ * User-space interface for viewing the available scope options for system
+ * shutdown. Scope option for next shutdown call is marked with [].
+ *
+ * Usage: cat /sys/firmware/zynqmp/shutdown_scope
+ *
+ * Return:	Number of bytes printed into the buffer.
+ */
+static ssize_t shutdown_scope_show(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   char *buf)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(shutdown_scopes); i++) {
+		if (&shutdown_scopes[i] == selected_scope) {
+			strcat(buf, "[");
+			strcat(buf, shutdown_scopes[i].name);
+			strcat(buf, "]");
+		} else {
+			strcat(buf, shutdown_scopes[i].name);
+		}
+		strcat(buf, " ");
+	}
+	strcat(buf, "\n");
+
+	return strlen(buf);
+}
+
+/**
+ * shutdown_scope_store - Store shutdown_scope sysfs attribute
+ * @kobj:	Kobject structure
+ * @attr:	Kobject attribute structure
+ * @buf:	User entered shutdown_scope attribute string
+ * @count:	Buffer size
+ *
+ * User-space interface for setting the scope for the next system shutdown.
+ * Usage: echo <scope> > /sys/firmware/zynqmp/shutdown_scope
+ *
+ * The Linux shutdown functionality implemented via PSCI system_off does not
+ * include an option to set a scope, i.e. which parts of the system to shut
+ * down.
+ *
+ * This API function allows to set the shutdown scope for the next shutdown
+ * request by passing it to the ATF running in EL3. When the next shutdown
+ * is performed, the platform specific portion of PSCI-system_off can use
+ * the chosen shutdown scope.
+ *
+ * subsystem:	Only the APU along with all of its peripherals not used by other
+ *		processing units will be shut down. This may result in the FPD
+ *		power domain being shut down provided that no other processing
+ *		unit uses FPD peripherals or DRAM.
+ * ps_only:	The complete PS will be shut down, including the RPU, PMU, etc.
+ *		Only the PL domain (FPGA) remains untouched.
+ * system:	The complete system/device is shut down.
+ *
+ * Return:	count argument if request succeeds, the corresponding error
+ *		code otherwise
+ */
+static ssize_t shutdown_scope_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int ret;
+	struct zynqmp_pm_shutdown_scope *scope;
+
+	scope = zynqmp_pm_is_shutdown_scope_valid(buf);
+	if (!scope)
+		return -EINVAL;
+
+	ret = zynqmp_pm_system_shutdown(ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
+					scope->subtype);
+	if (ret) {
+		pr_err("unable to set shutdown scope %s\n", buf);
+		return ret;
+	}
+
+	selected_scope = scope;
+
+	return count;
+}
+
+static struct kobj_attribute zynqmp_attr_shutdown_scope =
+						__ATTR_RW(shutdown_scope);
+
+/**
  * config_reg_store - Write config_reg sysfs attribute
  * @kobj:	Kobject structure
  * @attr:	Kobject attribute structure
@@ -870,6 +1010,7 @@ static struct kobj_attribute zynqmp_attr_config_reg =
 					__ATTR_RW(config_reg);
 
 static struct attribute *attrs[] = {
+	&zynqmp_attr_shutdown_scope.attr,
 	&zynqmp_attr_config_reg.attr,
 	NULL,
 };
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index b96ea5d..54061de 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -277,6 +277,18 @@ enum pm_register_access_id {
 	CONFIG_REG_READ,
 };
 
+enum zynqmp_pm_shutdown_type {
+	ZYNQMP_PM_SHUTDOWN_TYPE_SHUTDOWN,
+	ZYNQMP_PM_SHUTDOWN_TYPE_RESET,
+	ZYNQMP_PM_SHUTDOWN_TYPE_SETSCOPE_ONLY,
+};
+
+enum zynqmp_pm_shutdown_subtype {
+	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SUBSYSTEM,
+	ZYNQMP_PM_SHUTDOWN_SUBTYPE_PS_ONLY,
+	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.7.4

