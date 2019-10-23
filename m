Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB95CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3D02084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mFCT3wUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404985AbfJWLd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:33:29 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:53228
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404669AbfJWLd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:33:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaPvUem9xMxUTPZyg6/uqP0nxRpXF2SvpaVQ+3zDv3DihEl4yiMHutrjYhcshFPmO/87qDRTvOjizdQVnEdeYRd+JCuGMz9hFh0VJtgKmMa+24PagRCoIpacdab0+HIx0zoD8mEgUJMJV+3w3L7P5aMv4zkpb7Wmj5CuOMvdCkGfBLd7OpgV5e8HR/w9NFqjE5br0mY+aetIqLvXjktnjo5RuvY0HmjCUOqFVwcjrYloXAaZSFqZi/vXEiS6vcLWhfxl6BkQOr2cMzRveEzeJlZK4Be0+jsWWPFSo86HBIjHmQrjtYMuYP02SG2emW82ySXWQzojMfiNWVhOvHCB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOHgdw3EHVUC1U/j4RaaXStACKmCy0XtxnB8gZRXVKQ=;
 b=Pvz8UyHnbYk8P6YeHUcrGdNZYbHPrByeSexN16KEtOSAhUDnY1LimsOpPR+olpoYYbaztBLVFw6MgDug0YKMknaCnMfrolNgRsKulY2rBBqmuo4Dj6HPqQ5n47wLM6FtTRA159v4EiZoCNJ/R7FfNouDGIQGqfmTUJhLOwOwy+KR93jORwmOpVUpFUcK0k/47bFhisSbYgIgYVchynLGHLb457qssr+rlZkcYGy6l0aan4r5VOynApV6cBTzMR9LNgCfoqbcrRjCszU4+ClX9SLAiS/BC91L55px6DzQtnRhiqy4lY2nZYPFSQdMfEOSbnfdJkQQWkH8IfJm+O4nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOHgdw3EHVUC1U/j4RaaXStACKmCy0XtxnB8gZRXVKQ=;
 b=mFCT3wUTYPWCZfVyrlFj606eVW03kqm69LgXPDtmocKaS2bQMLBW1OY/fiDuHVTNw4IJMvMK0KoXmh7xTzNgA2PK9wiOPTzMiDrGk6WjdLKrq8OJlMBFZx7q8lYx8mkcZOEilEeMMu04xw4a4HFfp5NjrqepQN4jBQJGDdJJZ6M=
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1527.namprd12.prod.outlook.com (10.172.66.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 11:31:01 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::a1f5:6f09:5c0d:78f1]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::a1f5:6f09:5c0d:78f1%11]) with mapi id 15.20.2387.019; Wed, 23 Oct
 2019 11:31:01 +0000
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
Subject: [RFC PATCH 2/2] tee: add AMD-TEE driver
Thread-Topic: [RFC PATCH 2/2] tee: add AMD-TEE driver
Thread-Index: AQHViZVZciGFwXY/I0yiZSF/OkmewA==
Date:   Wed, 23 Oct 2019 11:31:01 +0000
Message-ID: <fd7b187b01cccd690dc3c71d6c5f2520bb9e303a.1571818136.git.Rijo-john.Thomas@amd.com>
References: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c573a91-6773-422d-a533-08d757ac7b53
x-ms-traffictypediagnostic: CY4PR12MB1527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1527A06319FBA3A5C73A38F1CF6B0@CY4PR12MB1527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:260;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(99286004)(71200400001)(118296001)(6512007)(25786009)(71190400001)(66946007)(30864003)(50226002)(3846002)(6116002)(6436002)(316002)(478600001)(66066001)(76176011)(52116002)(2201001)(66476007)(66556008)(64756008)(2501003)(36756003)(4326008)(66446008)(54906003)(110136005)(8676002)(486006)(8936002)(256004)(14444005)(2906002)(6506007)(6486002)(386003)(81156014)(14454004)(476003)(2616005)(5660300002)(305945005)(86362001)(102836004)(7736002)(186003)(11346002)(446003)(81166006)(26005)(959014)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1527;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdUr2cxB9HTb+UPQ4Cn5Q13s4kYajoQcXqYVanx2F3byo4EE7Ofhepe5/M4u6VQkMB9KL0ADXutRpGVDhR0P1HY8vsnpj0aR1XmBOZ5G90zaH6hUIcm2jrEODbX6cMtu287D0JpHMpMALm4Kq13EFWjxErqq8ezKxpsX6GGV2Jd0nV0JFAU8PyI2JvAbJol4VCGDO1lVCejwAkhjcHu2sNY/nfSupnTVgatsorT/p+iFizFTL9s3k0FieFZ9QBPw4KT2+t+p/dfInLycVjMU7WdxYtdk8ZZwfikwUjKTMb/WjJKrfwfCtC24d5+HxdFnkgilBAyT7aBbfntXQR8xnEqaC6WWiiOgLeLHwAnyQRIOfADIwTFIyFnpdeGZ6xTTkcilJRs8+S3xgvNXNpB7NjOo5bejzS9Lg1bJ2+NHBbZigx+MPsqhrsX2HqxNiW1L
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c573a91-6773-422d-a533-08d757ac7b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 11:31:01.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgoPXQHAXOv5ZRq1BfqIyr6Grv6DCdrnA4QqXPUAIDHl6fS/JA0XD6VOXpDBhnFESmwwRkLZ8oktdtRqVVuEbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds AMD-TEE driver.
* targets AMD APUs which has AMD Secure Processor with software-based
  Trusted Execution Environment (TEE) support
* registers with TEE subsystem
* defines tee_driver_ops function callbacks
* kernel allocated memory is used as shared memory between normal
  world and secure world.
* acts as REE (Rich Execution Environment) communication agent, which
  uses the services of AMD Secure Processor driver to submit commands
  for processing in TEE environment

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
---
 drivers/tee/Kconfig                 |   2 +-
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/Kconfig          |   8 +
 drivers/tee/amdtee/Makefile         |   5 +
 drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
 drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
 drivers/tee/amdtee/call.c           | 370 ++++++++++++++++++++++++++
 drivers/tee/amdtee/core.c           | 510 ++++++++++++++++++++++++++++++++=
++++
 drivers/tee/amdtee/shm_pool.c       | 130 +++++++++
 include/uapi/linux/tee.h            |   1 +
 10 files changed, 1368 insertions(+), 1 deletion(-)
 create mode 100644 drivers/tee/amdtee/Kconfig
 create mode 100644 drivers/tee/amdtee/Makefile
 create mode 100644 drivers/tee/amdtee/amdtee_if.h
 create mode 100644 drivers/tee/amdtee/amdtee_private.h
 create mode 100644 drivers/tee/amdtee/call.c
 create mode 100644 drivers/tee/amdtee/core.c
 create mode 100644 drivers/tee/amdtee/shm_pool.c

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 4f3197d..8da63f3 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -14,7 +14,7 @@ if TEE
 menu "TEE drivers"
=20
 source "drivers/tee/optee/Kconfig"
-
+source "drivers/tee/amdtee/Kconfig"
 endmenu
=20
 endif
diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
index 21f51fd..68da044 100644
--- a/drivers/tee/Makefile
+++ b/drivers/tee/Makefile
@@ -4,3 +4,4 @@ tee-objs +=3D tee_core.o
 tee-objs +=3D tee_shm.o
 tee-objs +=3D tee_shm_pool.o
 obj-$(CONFIG_OPTEE) +=3D optee/
+obj-$(CONFIG_AMDTEE) +=3D amdtee/
diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
new file mode 100644
index 0000000..4e32b64
--- /dev/null
+++ b/drivers/tee/amdtee/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: MIT
+# AMD-TEE Trusted Execution Environment Configuration
+config AMDTEE
+	tristate "AMD-TEE"
+	default m
+	depends on CRYPTO_DEV_SP_PSP
+	help
+	  This implements AMD's Trusted Execution Environment (TEE) driver.
diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
new file mode 100644
index 0000000..ff14852
--- /dev/null
+++ b/drivers/tee/amdtee/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: MIT
+obj-$(CONFIG_AMDTEE) +=3D amdtee.o
+amdtee-objs +=3D core.o
+amdtee-objs +=3D call.o
+amdtee-objs +=3D shm_pool.o
diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.=
h
new file mode 100644
index 0000000..ff48c3e
--- /dev/null
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: MIT */
+
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+
+/*
+ * This file has definitions related to Host and AMD-TEE Trusted OS interf=
ace.
+ * These definitions must match the definitions on the TEE side.
+ */
+
+#ifndef AMDTEE_IF_H
+#define AMDTEE_IF_H
+
+#include <linux/types.h>
+
+/*************************************************************************=
****
+ ** TEE Param
+ *************************************************************************=
*****/
+#define TEE_MAX_PARAMS		4
+
+/**
+ * struct memref - memory reference structure
+ * @buf_id:    buffer ID of the buffer mapped by TEE_CMD_ID_MAP_SHARED_MEM
+ * @offset:    offset in bytes from beginning of the buffer
+ * @size:      data size in bytes
+ */
+struct memref {
+	u32 buf_id;
+	u32 offset;
+	u32 size;
+};
+
+struct value {
+	u32 a;
+	u32 b;
+};
+
+/*
+ * Parameters passed to open_session or invoke_command
+ */
+union tee_op_param {
+	struct memref mref;
+	struct value val;
+};
+
+struct tee_operation {
+	u32 param_types;
+	union tee_op_param params[TEE_MAX_PARAMS];
+};
+
+/* Must be same as in GP TEE specification */
+#define TEE_OP_PARAM_TYPE_NONE                  0
+#define TEE_OP_PARAM_TYPE_VALUE_INPUT           1
+#define TEE_OP_PARAM_TYPE_VALUE_OUTPUT          2
+#define TEE_OP_PARAM_TYPE_VALUE_INOUT           3
+#define TEE_OP_PARAM_TYPE_INVALID               4
+#define TEE_OP_PARAM_TYPE_MEMREF_INPUT          5
+#define TEE_OP_PARAM_TYPE_MEMREF_OUTPUT         6
+#define TEE_OP_PARAM_TYPE_MEMREF_INOUT          7
+
+#define TEE_PARAM_TYPE_GET(t, i)        (((t) >> ((i) * 4)) & 0xF)
+#define TEE_PARAM_TYPES(t0, t1, t2, t3) \
+	((t0) | ((t1) << 4) | ((t2) << 8) | ((t3) << 12))
+
+/*************************************************************************=
****
+ ** TEE Commands
+ *************************************************************************=
****/
+
+/*
+ * The shared memory between rich world and secure world may be physically
+ * non-contiguous. Below structures are meant to describe a shared memory =
region
+ * via scatter/gather (sg) list
+ */
+
+/**
+ * struct tee_sg_desc - sg descriptor for a physically contiguous buffer
+ * @low_addr: [in] bits[31:0] of buffer's physical address. Must be 4KB al=
igned
+ * @hi_addr:  [in] bits[63:32] of the buffer's physical address
+ * @size:     [in] size in bytes (must be multiple of 4KB)
+ */
+struct tee_sg_desc {
+	u32 low_addr;
+	u32 hi_addr;
+	u32 size;
+};
+
+/**
+ * struct tee_sg_list - structure describing a scatter/gather list
+ * @count:   [in] number of sg descriptors
+ * @size:    [in] total size of all buffers in the list. Must be multiple =
of 4KB
+ * @buf:     [in] list of sg buffer descriptors
+ */
+#define TEE_MAX_SG_DESC 64
+struct tee_sg_list {
+	u32 count;
+	u32 size;
+	struct tee_sg_desc buf[TEE_MAX_SG_DESC];
+};
+
+/**
+ * struct tee_cmd_map_shared_mem - command to map shared memory
+ * @buf_id:    [out] return buffer ID value
+ * @sg_list:   [in] list describing memory to be mapped
+ */
+struct tee_cmd_map_shared_mem {
+	u32 buf_id;
+	struct tee_sg_list sg_list;
+};
+
+/**
+ * struct tee_cmd_unmap_shared_mem - command to unmap shared memory
+ * @buf_id:    [in] buffer ID of memory to be unmapped
+ */
+struct tee_cmd_unmap_shared_mem {
+	u32 buf_id;
+};
+
+/**
+ * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
+ * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:     [in] bits [63:32] of the physical address of the TA binar=
y
+ * @size:        [in] size of TA binary in bytes
+ * @ta_handle:   [out] return handle of the loaded TA
+ */
+struct tee_cmd_load_ta {
+	u32 low_addr;
+	u32 hi_addr;
+	u32 size;
+	u32 ta_handle;
+};
+
+/**
+ * struct tee_cmd_unload_ta - command to unload TA binary from TEE environ=
ment
+ * @ta_handle:    [in] handle of the loaded TA to be unloaded
+ */
+struct tee_cmd_unload_ta {
+	u32 ta_handle;
+};
+
+/**
+ * struct tee_cmd_open_session - command to call TA_OpenSessionEntryPoint =
in TA
+ * @ta_handle:      [in] handle of the loaded TA
+ * @session_info:   [out] pointer to TA allocated session data
+ * @op:             [in/out] operation parameters
+ * @return_origin:  [out] origin of return code after TEE processing
+ */
+struct tee_cmd_open_session {
+	u32 ta_handle;
+	u32 session_info;
+	struct tee_operation op;
+	u32 return_origin;
+};
+
+/**
+ * struct tee_cmd_close_session - command to call TA_CloseSessionEntryPoin=
t()
+ *                                in TA
+ * @ta_handle:      [in] handle of the loaded TA
+ * @session_info:   [in] pointer to TA allocated session data
+ */
+struct tee_cmd_close_session {
+	u32 ta_handle;
+	u32 session_info;
+};
+
+/**
+ * struct tee_cmd_invoke_cmd - command to call TA_InvokeCommandEntryPoint(=
) in
+ *                             TA
+ * @ta_handle:     [in] handle of the loaded TA
+ * @cmd_id:        [in] TA command ID
+ * @session_info:  [in] pointer to TA allocated session data
+ * @op:            [in/out] operation parameters
+ * @return_origin: [out] origin of return code after TEE processing
+ */
+struct tee_cmd_invoke_cmd {
+	u32 ta_handle;
+	u32 cmd_id;
+	u32 session_info;
+	struct tee_operation op;
+	u32 return_origin;
+};
+
+#endif /*AMDTEE_IF_H*/
diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdte=
e_private.h
new file mode 100644
index 0000000..d7f798c
--- /dev/null
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: MIT */
+
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+
+#ifndef AMDTEE_PRIVATE_H
+#define AMDTEE_PRIVATE_H
+
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/tee_drv.h>
+#include <linux/kref.h>
+#include <linux/types.h>
+#include "amdtee_if.h"
+
+#define DRIVER_NAME	"amdtee"
+#define DRIVER_AUTHOR   "AMD-TEE Linux driver team"
+
+/* Some GlobalPlatform error codes used in this driver */
+#define TEEC_SUCCESS			0x00000000
+#define TEEC_ERROR_GENERIC		0xFFFF0000
+#define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
+#define TEEC_ERROR_COMMUNICATION	0xFFFF000E
+
+#define TEEC_ORIGIN_COMMS		0x00000002
+
+/* Maximum number of sessions which can be opened with a Trusted Applicati=
on */
+#define TEE_NUM_SESSIONS			32
+
+#define TA_LOAD_PATH				"/amdtee"
+#define TA_PATH_MAX				60
+
+/**
+ * struct amdtee - main service struct
+ * @teedev:		client device
+ * @pool:		shared memory pool
+ */
+struct amdtee {
+	struct tee_device *teedev;
+	struct tee_shm_pool *pool;
+};
+
+/**
+ * struct amdtee_session - Trusted Application (TA) session related inform=
ation.
+ * @ta_handle:     handle to Trusted Application (TA) loaded in TEE enviro=
nment
+ * @refcount:      counter to keep track of sessions opened for the TA ins=
tance
+ * @session_info:  an array pointing to TA allocated session data.
+ * @sess_mask:     session usage bit-mask. If a particular bit is set, the=
n the
+ *                 corresponding @session_info entry is in use or valid.
+ *
+ * Session structure is updated on open_session and this information is us=
ed for
+ * subsequent operations with the Trusted Application.
+ */
+struct amdtee_session {
+	struct list_head list_node;
+	u32 ta_handle;
+	struct kref refcount;
+	u32 session_info[TEE_NUM_SESSIONS];
+	DECLARE_BITMAP(sess_mask, TEE_NUM_SESSIONS);
+	spinlock_t lock;	/* synchronizes access to @sess_mask */
+};
+
+/**
+ * struct amdtee_context_data - AMD-TEE driver context data
+ * @sess_list:    Keeps track of sessions opened in current TEE context
+ */
+struct amdtee_context_data {
+	struct list_head sess_list;
+};
+
+struct amdtee_driver_data {
+	struct amdtee *amdtee;
+};
+
+struct shmem_desc {
+	void *kaddr;
+	u64 size;
+};
+
+/**
+ * struct amdtee_shm_data - Shared memory data
+ * @kaddr:	Kernel virtual address of shared memory
+ * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
+ */
+struct amdtee_shm_data {
+	struct  list_head shm_node;
+	void    *kaddr;
+	u32     buf_id;
+};
+
+struct amdtee_shm_context {
+	struct list_head shmdata_list;
+};
+
+#define LOWER_TWO_BYTE_MASK	0x0000FFFF
+
+/**
+ * set_session_id() - Sets the session identifier.
+ * @ta_handle:      [in] handle of the loaded Trusted Application (TA)
+ * @session_index:  [in] Session index. Range: 0 to (TEE_NUM_SESSIONS - 1)=
.
+ * @session:        [out] Pointer to session id
+ *
+ * Lower two bytes of the session identifier represents the TA handle and =
the
+ * upper two bytes is session index.
+ */
+static inline void set_session_id(u32 ta_handle, u32 session_index,
+				  u32 *session)
+{
+	*session =3D (session_index << 16) | (LOWER_TWO_BYTE_MASK & ta_handle);
+}
+
+static inline u32 get_ta_handle(u32 session)
+{
+	return session & LOWER_TWO_BYTE_MASK;
+}
+
+static inline u32 get_session_index(u32 session)
+{
+	return (session >> 16) & LOWER_TWO_BYTE_MASK;
+}
+
+int amdtee_open_session(struct tee_context *ctx,
+			struct tee_ioctl_open_session_arg *arg,
+			struct tee_param *param);
+
+int amdtee_close_session(struct tee_context *ctx, u32 session);
+
+int amdtee_invoke_func(struct tee_context *ctx,
+		       struct tee_ioctl_invoke_arg *arg,
+		       struct tee_param *param);
+
+int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)=
;
+
+int amdtee_map_shmem(struct tee_shm *shm);
+
+void amdtee_unmap_shmem(struct tee_shm *shm);
+
+int handle_load_ta(void *data, u32 size,
+		   struct tee_ioctl_open_session_arg *arg);
+
+int handle_unload_ta(u32 ta_handle);
+
+int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
+			struct tee_param *p);
+
+int handle_close_session(u32 ta_handle, u32 info);
+
+int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id);
+
+void handle_unmap_shmem(u32 buf_id);
+
+int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
+		      struct tee_param *p);
+
+struct tee_shm_pool *amdtee_config_shm(void);
+
+u32 get_buffer_id(struct tee_shm *shm);
+#endif /*AMDTEE_PRIVATE_H*/
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
new file mode 100644
index 0000000..e87b0d1
--- /dev/null
+++ b/drivers/tee/amdtee/call.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/psp-tee.h>
+#include <linux/slab.h>
+#include <linux/psp-sev.h>
+#include "../tee_private.h"
+#include "amdtee_if.h"
+#include "amdtee_private.h"
+
+static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
+				    struct tee_operation *amd)
+{
+	int i, ret =3D 0;
+	u32 type;
+
+	if (!count)
+		return 0;
+
+	if (!tee || !amd || count > TEE_MAX_PARAMS)
+		return -EINVAL;
+
+	amd->param_types =3D 0;
+	for (i =3D 0; i < count; i++)
+		amd->param_types |=3D ((tee[i].attr & 0xF) << i * 4);
+
+	for (i =3D 0; i < count; i++) {
+		type =3D TEE_PARAM_TYPE_GET(amd->param_types, i);
+		pr_debug("%s: type[%d] =3D 0x%x\n", __func__, i, type);
+
+		if (type =3D=3D TEE_OP_PARAM_TYPE_INVALID ||
+		    type > TEE_OP_PARAM_TYPE_MEMREF_INOUT)
+			return -EINVAL;
+
+		if (type =3D=3D TEE_OP_PARAM_TYPE_NONE)
+			continue;
+
+		/* It is assumed that all values are within 2^32-1 */
+		if (type > TEE_OP_PARAM_TYPE_VALUE_INOUT) {
+			u32 buf_id =3D get_buffer_id(tee[i].u.memref.shm);
+
+			amd->params[i].mref.buf_id =3D buf_id;
+			amd->params[i].mref.offset =3D tee[i].u.memref.shm_offs;
+			amd->params[i].mref.size =3D tee[i].u.memref.size;
+			pr_debug("%s: bufid[%d] =3D 0x%x, offset[%d] =3D 0x%x, size[%d] =3D 0x%=
x\n",
+				 __func__,
+				 i, amd->params[i].mref.buf_id,
+				 i, amd->params[i].mref.offset,
+				 i, amd->params[i].mref.size);
+		} else {
+			if (tee[i].u.value.c)
+				pr_warn("%s: Discarding value c", __func__);
+
+			amd->params[i].val.a =3D tee[i].u.value.a;
+			amd->params[i].val.b =3D tee[i].u.value.b;
+			pr_debug("%s: a[%d] =3D 0x%x, b[%d] =3D 0x%x\n", __func__,
+				 i, amd->params[i].val.a,
+				 i, amd->params[i].val.b);
+		}
+	}
+	return ret;
+}
+
+static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
+				    struct tee_operation *amd)
+{
+	int i, ret =3D 0;
+	u32 type;
+
+	if (!count)
+		return 0;
+
+	if (!tee || !amd || count > TEE_MAX_PARAMS)
+		return -EINVAL;
+
+	/* Assumes amd->param_types is valid */
+	for (i =3D 0; i < count; i++) {
+		type =3D TEE_PARAM_TYPE_GET(amd->param_types, i);
+		pr_debug("%s: type[%d] =3D 0x%x\n", __func__, i, type);
+
+		if (type =3D=3D TEE_OP_PARAM_TYPE_INVALID ||
+		    type > TEE_OP_PARAM_TYPE_MEMREF_INOUT)
+			return -EINVAL;
+
+		if (type =3D=3D TEE_OP_PARAM_TYPE_NONE ||
+		    type =3D=3D TEE_OP_PARAM_TYPE_VALUE_INPUT ||
+		    type =3D=3D TEE_OP_PARAM_TYPE_MEMREF_INPUT)
+			continue;
+
+		/*
+		 * It is assumed that buf_id remains unchanged for
+		 * both open_session and invoke_cmd call
+		 */
+		if (type > TEE_OP_PARAM_TYPE_MEMREF_INPUT) {
+			tee[i].u.memref.shm_offs =3D amd->params[i].mref.offset;
+			tee[i].u.memref.size =3D amd->params[i].mref.size;
+			pr_debug("%s: bufid[%d] =3D 0x%x, offset[%d] =3D 0x%x, size[%d] =3D 0x%=
x\n",
+				 __func__,
+				 i, amd->params[i].mref.buf_id,
+				 i, amd->params[i].mref.offset,
+				 i, amd->params[i].mref.size);
+		} else {
+			/* field 'c' not supported by AMD */
+			tee[i].u.value.a =3D amd->params[i].val.a;
+			tee[i].u.value.b =3D amd->params[i].val.b;
+			tee[i].u.value.c =3D 0;
+			pr_debug("%s: a[%d] =3D 0x%x, b[%d] =3D 0x%x\n",
+				 __func__,
+				 i, amd->params[i].val.a,
+				 i, amd->params[i].val.b);
+		}
+	}
+	return ret;
+}
+
+int handle_unload_ta(u32 ta_handle)
+{
+	struct tee_cmd_unload_ta cmd =3D {0};
+	int ret =3D 0;
+	u32 status;
+
+	if (!ta_handle)
+		return -EINVAL;
+
+	cmd.ta_handle =3D ta_handle;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
+				  sizeof(cmd), &status);
+	if (!ret && status !=3D 0) {
+		pr_err("unload ta: status =3D 0x%x\n", status);
+		ret =3D -EBUSY;
+	}
+
+	return ret;
+}
+
+int handle_close_session(u32 ta_handle, u32 info)
+{
+	struct tee_cmd_close_session cmd =3D {0};
+	int ret =3D 0;
+	u32 status;
+
+	if (ta_handle =3D=3D 0)
+		return -EINVAL;
+
+	cmd.ta_handle =3D ta_handle;
+	cmd.session_info =3D info;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_CLOSE_SESSION, (void *)&cmd,
+				  sizeof(cmd), &status);
+	if (!ret && status !=3D 0) {
+		pr_err("close session: status =3D 0x%x\n", status);
+		ret =3D -EBUSY;
+	}
+
+	return ret;
+}
+
+void handle_unmap_shmem(u32 buf_id)
+{
+	struct tee_cmd_unmap_shared_mem cmd =3D {0};
+	int ret =3D 0;
+	u32 status;
+
+	cmd.buf_id =3D buf_id;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_UNMAP_SHARED_MEM, (void *)&cmd,
+				  sizeof(cmd), &status);
+	if (!ret)
+		pr_debug("unmap shared memory: buf_id %u status =3D 0x%x\n",
+			 buf_id, status);
+}
+
+int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
+		      struct tee_param *p)
+{
+	struct tee_cmd_invoke_cmd cmd =3D {0};
+	int ret =3D 0;
+
+	if (!arg || (!p && arg->num_params))
+		return -EINVAL;
+
+	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
+
+	if (arg->session =3D=3D 0) {
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return -EINVAL;
+	}
+
+	ret =3D tee_params_to_amd_params(p, arg->num_params, &cmd.op);
+	if (ret) {
+		pr_err("invalid Params. Abort invoke command\n");
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return ret;
+	}
+
+	cmd.ta_handle =3D get_ta_handle(arg->session);
+	cmd.cmd_id =3D arg->func;
+	cmd.session_info =3D sinfo;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_INVOKE_CMD, (void *)&cmd,
+				  sizeof(cmd), &arg->ret);
+	if (ret) {
+		arg->ret =3D TEEC_ERROR_COMMUNICATION;
+	} else {
+		ret =3D amd_params_to_tee_params(p, arg->num_params, &cmd.op);
+		if (unlikely(ret)) {
+			pr_err("invoke command: failed to copy output\n");
+			arg->ret =3D TEEC_ERROR_GENERIC;
+			return ret;
+		}
+		arg->ret_origin =3D cmd.return_origin;
+		pr_debug("invoke command: RO =3D 0x%x ret =3D 0x%x\n",
+			 arg->ret_origin, arg->ret);
+	}
+
+	return ret;
+}
+
+int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id)
+{
+	struct tee_cmd_map_shared_mem *cmd;
+	phys_addr_t paddr;
+	int ret =3D 0, i;
+	u32 status;
+
+	if (!count || !start || !buf_id)
+		return -EINVAL;
+
+	cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	/* Size must be page aligned */
+	for (i =3D 0; i < count ; i++) {
+		if (!start[i].kaddr || (start[i].size & (PAGE_SIZE - 1))) {
+			ret =3D -EINVAL;
+			goto free_cmd;
+		}
+
+		if ((u64)start[i].kaddr & (PAGE_SIZE - 1)) {
+			pr_err("map shared memory: page unaligned. addr 0x%llx",
+			       (u64)start[i].kaddr);
+			ret =3D -EINVAL;
+			goto free_cmd;
+		}
+	}
+
+	cmd->sg_list.count =3D count;
+
+	/* Create buffer list */
+	for (i =3D 0; i < count ; i++) {
+		paddr =3D __psp_pa(start[i].kaddr);
+		cmd->sg_list.buf[i].hi_addr =3D upper_32_bits(paddr);
+		cmd->sg_list.buf[i].low_addr =3D lower_32_bits(paddr);
+		cmd->sg_list.buf[i].size =3D start[i].size;
+		cmd->sg_list.size +=3D cmd->sg_list.buf[i].size;
+
+		pr_debug("buf[%d]:hi addr =3D 0x%x\n", i,
+			 cmd->sg_list.buf[i].hi_addr);
+		pr_debug("buf[%d]:low addr =3D 0x%x\n", i,
+			 cmd->sg_list.buf[i].low_addr);
+		pr_debug("buf[%d]:size =3D 0x%x\n", i, cmd->sg_list.buf[i].size);
+		pr_debug("list size =3D 0x%x\n", cmd->sg_list.size);
+	}
+
+	*buf_id =3D 0;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_MAP_SHARED_MEM, (void *)cmd,
+				  sizeof(*cmd), &status);
+	if (!ret && !status) {
+		*buf_id =3D cmd->buf_id;
+		pr_debug("mapped buffer ID =3D 0x%x\n", *buf_id);
+	} else {
+		pr_err("map shared memory: status =3D 0x%x\n", status);
+		ret =3D -ENOMEM;
+	}
+
+free_cmd:
+	kfree(cmd);
+
+	return ret;
+}
+
+int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
+			struct tee_param *p)
+{
+	struct tee_cmd_open_session cmd =3D {0};
+	int ret =3D 0;
+
+	if (!arg || !info || (!p && arg->num_params))
+		return -EINVAL;
+
+	arg->ret_origin =3D TEEC_ORIGIN_COMMS;
+
+	if (arg->session =3D=3D 0) {
+		arg->ret =3D TEEC_ERROR_GENERIC;
+		return -EINVAL;
+	}
+
+	ret =3D tee_params_to_amd_params(p, arg->num_params, &cmd.op);
+	if (ret) {
+		pr_err("invalid Params. Abort open session\n");
+		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
+		return ret;
+	}
+
+	cmd.ta_handle =3D get_ta_handle(arg->session);
+	*info =3D 0;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_OPEN_SESSION, (void *)&cmd,
+				  sizeof(cmd), &arg->ret);
+	if (ret) {
+		arg->ret =3D TEEC_ERROR_COMMUNICATION;
+	} else {
+		ret =3D amd_params_to_tee_params(p, arg->num_params, &cmd.op);
+		if (unlikely(ret)) {
+			pr_err("open session: failed to copy output\n");
+			arg->ret =3D TEEC_ERROR_GENERIC;
+			return ret;
+		}
+		arg->ret_origin =3D cmd.return_origin;
+		*info =3D cmd.session_info;
+		pr_debug("open session: session info =3D 0x%x\n", *info);
+	}
+
+	pr_debug("open session: ret =3D 0x%x RO =3D 0x%x\n", arg->ret,
+		 arg->ret_origin);
+
+	return ret;
+}
+
+int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg=
 *arg)
+{
+	struct tee_cmd_load_ta cmd =3D {0};
+	phys_addr_t blob;
+	int ret =3D 0;
+
+	if (size =3D=3D 0 || !data || !arg)
+		return -EINVAL;
+
+	blob =3D __psp_pa(data);
+	if (blob & (PAGE_SIZE - 1)) {
+		pr_err("load TA: page unaligned. blob 0x%llx", blob);
+		return -EINVAL;
+	}
+
+	cmd.hi_addr =3D upper_32_bits(blob);
+	cmd.low_addr =3D lower_32_bits(blob);
+	cmd.size =3D size;
+
+	ret =3D psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
+				  sizeof(cmd), &arg->ret);
+	if (ret) {
+		arg->ret_origin =3D TEEC_ORIGIN_COMMS;
+		arg->ret =3D TEEC_ERROR_COMMUNICATION;
+	} else {
+		set_session_id(cmd.ta_handle, 0, &arg->session);
+	}
+
+	pr_debug("load TA: TA handle =3D 0x%x, RO =3D 0x%x, ret =3D 0x%x\n",
+		 cmd.ta_handle, arg->ret_origin, arg->ret);
+
+	return 0;
+}
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
new file mode 100644
index 0000000..b184463
--- /dev/null
+++ b/drivers/tee/amdtee/core.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+#include <linux/firmware.h>
+#include "amdtee_private.h"
+#include "../tee_private.h"
+
+static struct amdtee_driver_data *drv_data;
+static DEFINE_MUTEX(session_list_mutex);
+struct amdtee_shm_context shmctx;
+
+static void amdtee_get_version(struct tee_device *teedev,
+			       struct tee_ioctl_version_data *vers)
+{
+	struct tee_ioctl_version_data v =3D {
+		.impl_id =3D TEE_IMPL_ID_AMDTEE,
+		.impl_caps =3D 0,
+		.gen_caps =3D TEE_GEN_CAP_GP,
+	};
+	*vers =3D v;
+}
+
+static int amdtee_open(struct tee_context *ctx)
+{
+	struct amdtee_context_data *ctxdata;
+
+	ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
+	if (!ctxdata)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctxdata->sess_list);
+	INIT_LIST_HEAD(&shmctx.shmdata_list);
+
+	ctx->data =3D ctxdata;
+	return 0;
+}
+
+static void release_session(struct amdtee_session *sess)
+{
+	int i =3D 0;
+
+	/* Close any open session */
+	for (i =3D 0; i < TEE_NUM_SESSIONS; ++i) {
+		/* Check if session entry 'i' is valid */
+		if (!test_bit(i, sess->sess_mask))
+			continue;
+
+		handle_close_session(sess->ta_handle, sess->session_info[i]);
+	}
+
+	/* Unload Trusted Application once all sessions are closed */
+	handle_unload_ta(sess->ta_handle);
+	kfree(sess);
+}
+
+static void amdtee_release(struct tee_context *ctx)
+{
+	struct amdtee_context_data *ctxdata =3D ctx->data;
+
+	if (!ctxdata)
+		return;
+
+	while (true) {
+		struct amdtee_session *sess;
+
+		sess =3D list_first_entry_or_null(&ctxdata->sess_list,
+						struct amdtee_session,
+						list_node);
+
+		if (!sess)
+			break;
+
+		list_del(&sess->list_node);
+		release_session(sess);
+	}
+	kfree(ctxdata);
+
+	ctx->data =3D NULL;
+}
+
+/**
+ * alloc_session() - Allocate a session structure
+ * @ctxdata:    TEE Context data structure
+ * @session:    Session ID for which 'struct amdtee_session' structure is =
to be
+ *              allocated.
+ *
+ * Scans the TEE context's session list to check if TA is already loaded i=
n to
+ * TEE. If yes, returns the 'session' structure for that TA. Else allocate=
s,
+ * initializes a new 'session' structure and adds it to context's session =
list.
+ *
+ * The caller must hold a mutex.
+ *
+ * Returns:
+ * 'struct amdtee_session *' on success and NULL on failure.
+ */
+static struct amdtee_session *alloc_session(struct amdtee_context_data *ct=
xdata,
+					    u32 session)
+{
+	struct amdtee_session *sess;
+	u32 ta_handle =3D get_ta_handle(session);
+
+	/* Scan session list to check if TA is already loaded in to TEE */
+	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
+		if (sess->ta_handle =3D=3D ta_handle) {
+			kref_get(&sess->refcount);
+			return sess;
+		}
+
+	/* Allocate a new session and add to list */
+	sess =3D kzalloc(sizeof(*sess), GFP_KERNEL);
+	if (sess) {
+		sess->ta_handle =3D ta_handle;
+		kref_init(&sess->refcount);
+		spin_lock_init(&sess->lock);
+		list_add(&sess->list_node, &ctxdata->sess_list);
+	}
+
+	return sess;
+}
+
+/* Requires mutex to be held */
+static struct amdtee_session *find_session(struct amdtee_context_data *ctx=
data,
+					   u32 session)
+{
+	u32 ta_handle =3D get_ta_handle(session);
+	u32 index =3D get_session_index(session);
+	struct amdtee_session *sess;
+
+	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
+		if (ta_handle =3D=3D sess->ta_handle &&
+		    test_bit(index, sess->sess_mask))
+			return sess;
+
+	return NULL;
+}
+
+u32 get_buffer_id(struct tee_shm *shm)
+{
+	u32 buf_id =3D 0;
+	struct amdtee_shm_data *shmdata;
+
+	list_for_each_entry(shmdata, &shmctx.shmdata_list, shm_node)
+		if (shmdata->kaddr =3D=3D shm->kaddr) {
+			buf_id =3D shmdata->buf_id;
+			break;
+		}
+
+	return buf_id;
+}
+
+static DEFINE_MUTEX(drv_mutex);
+static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
+			  size_t *ta_size)
+{
+	const struct firmware *fw;
+	char fw_name[TA_PATH_MAX];
+	struct {
+		u32 lo;
+		u16 mid;
+		u16 hi_ver;
+		u8 seq_n[8];
+	} *uuid =3D ptr;
+	int n =3D 0, rc =3D 0;
+
+	n =3D snprintf(fw_name, TA_PATH_MAX,
+		     "%s/%08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.bin",
+		     TA_LOAD_PATH, uuid->lo, uuid->mid, uuid->hi_ver,
+		     uuid->seq_n[0], uuid->seq_n[1],
+		     uuid->seq_n[2], uuid->seq_n[3],
+		     uuid->seq_n[4], uuid->seq_n[5],
+		     uuid->seq_n[6], uuid->seq_n[7]);
+	if (n < 0 || n >=3D TA_PATH_MAX) {
+		pr_err("failed to get firmware name\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&drv_mutex);
+	n =3D request_firmware(&fw, fw_name, &ctx->teedev->dev);
+	if (n) {
+		pr_err("failed to load firmware %s\n", fw_name);
+		rc =3D -ENOMEM;
+		goto unlock;
+	}
+
+	*ta_size =3D roundup(fw->size, PAGE_SIZE);
+	*ta =3D (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
+	if (IS_ERR(*ta)) {
+		pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
+		       (u64)*ta);
+		rc =3D -ENOMEM;
+		goto rel_fw;
+	}
+
+	memcpy(*ta, fw->data, fw->size);
+rel_fw:
+	release_firmware(fw);
+unlock:
+	mutex_unlock(&drv_mutex);
+	return rc;
+}
+
+int amdtee_open_session(struct tee_context *ctx,
+			struct tee_ioctl_open_session_arg *arg,
+			struct tee_param *param)
+{
+	struct amdtee_context_data *ctxdata =3D ctx->data;
+	struct amdtee_session *sess =3D NULL;
+	u32 session_info;
+	void *ta =3D NULL;
+	size_t ta_size;
+	int rc =3D 0, i;
+
+	if (arg->clnt_login !=3D TEE_IOCTL_LOGIN_PUBLIC) {
+		pr_err("unsupported client login method\n");
+		return -EINVAL;
+	}
+
+	rc =3D copy_ta_binary(ctx, &arg->uuid[0], &ta, &ta_size);
+	if (rc) {
+		pr_err("failed to copy TA binary\n");
+		return rc;
+	}
+
+	/* Load the TA binary into TEE environment */
+	handle_load_ta(ta, ta_size, arg);
+	if (arg->ret =3D=3D TEEC_SUCCESS) {
+		mutex_lock(&session_list_mutex);
+		sess =3D alloc_session(ctxdata, arg->session);
+		mutex_unlock(&session_list_mutex);
+	}
+
+	if (arg->ret !=3D TEEC_SUCCESS)
+		goto out;
+
+	if (!sess) {
+		rc =3D -ENOMEM;
+		goto out;
+	}
+
+	/* Find an empty session index for the given TA */
+	spin_lock(&sess->lock);
+	i =3D find_first_zero_bit(sess->sess_mask, TEE_NUM_SESSIONS);
+	if (i < TEE_NUM_SESSIONS)
+		set_bit(i, sess->sess_mask);
+	spin_unlock(&sess->lock);
+
+	if (i >=3D TEE_NUM_SESSIONS) {
+		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
+		rc =3D -ENOMEM;
+		goto out;
+	}
+
+	/* Open session with loaded TA */
+	handle_open_session(arg, &session_info, param);
+
+	if (arg->ret =3D=3D TEEC_SUCCESS) {
+		sess->session_info[i] =3D session_info;
+		set_session_id(sess->ta_handle, i, &arg->session);
+	} else {
+		pr_err("open_session failed %d\n", arg->ret);
+		spin_lock(&sess->lock);
+		clear_bit(i, sess->sess_mask);
+		spin_unlock(&sess->lock);
+	}
+out:
+	free_pages((u64)ta, get_order(ta_size));
+	return rc;
+}
+
+static void destroy_session(struct kref *ref)
+{
+	struct amdtee_session *sess =3D container_of(ref, struct amdtee_session,
+						   refcount);
+
+	/* Unload the TA from TEE */
+	handle_unload_ta(sess->ta_handle);
+	mutex_lock(&session_list_mutex);
+	list_del(&sess->list_node);
+	mutex_unlock(&session_list_mutex);
+	kfree(sess);
+}
+
+int amdtee_close_session(struct tee_context *ctx, u32 session)
+{
+	struct amdtee_context_data *ctxdata =3D ctx->data;
+	u32 i, ta_handle, session_info;
+	struct amdtee_session *sess;
+
+	pr_debug("%s: sid =3D 0x%x\n", __func__, session);
+
+	/*
+	 * Check that the session is valid and clear the session
+	 * usage bit
+	 */
+	mutex_lock(&session_list_mutex);
+	sess =3D find_session(ctxdata, session);
+	if (sess) {
+		ta_handle =3D get_ta_handle(session);
+		i =3D get_session_index(session);
+		session_info =3D sess->session_info[i];
+		spin_lock(&sess->lock);
+		clear_bit(i, sess->sess_mask);
+		spin_unlock(&sess->lock);
+	}
+	mutex_unlock(&session_list_mutex);
+
+	if (!sess)
+		return -EINVAL;
+
+	/* Close the session */
+	handle_close_session(ta_handle, session_info);
+
+	kref_put(&sess->refcount, destroy_session);
+
+	return 0;
+}
+
+int amdtee_map_shmem(struct tee_shm *shm)
+{
+	struct shmem_desc shmem;
+	struct amdtee_shm_data *shmnode;
+	int rc, count;
+	u32 buf_id;
+
+	if (!shm)
+		return -EINVAL;
+
+	shmnode =3D kmalloc(sizeof(*shmnode), GFP_KERNEL);
+	if (!shmnode)
+		return -ENOMEM;
+
+	count =3D 1;
+	shmem.kaddr =3D shm->kaddr;
+	shmem.size =3D shm->size;
+
+	/*
+	 * Send a MAP command to TEE and get the corresponding
+	 * buffer Id
+	 */
+	rc =3D handle_map_shmem(count, &shmem, &buf_id);
+	if (rc) {
+		pr_err("map_shmem failed: ret =3D %d\n", rc);
+		kfree(shmnode);
+		return rc;
+	}
+
+	shmnode->kaddr =3D shm->kaddr;
+	shmnode->buf_id =3D buf_id;
+	list_add(&shmnode->shm_node, &shmctx.shmdata_list);
+
+	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
+
+	return 0;
+}
+
+void amdtee_unmap_shmem(struct tee_shm *shm)
+{
+	u32 buf_id;
+	struct amdtee_shm_data *shmnode =3D NULL;
+
+	if (!shm)
+		return;
+
+	buf_id =3D get_buffer_id(shm);
+	/* Unmap the shared memory from TEE */
+	handle_unmap_shmem(buf_id);
+
+	list_for_each_entry(shmnode, &shmctx.shmdata_list, shm_node)
+		if (buf_id =3D=3D shmnode->buf_id) {
+			list_del(&shmnode->shm_node);
+			kfree(shmnode);
+			break;
+		}
+}
+
+int amdtee_invoke_func(struct tee_context *ctx,
+		       struct tee_ioctl_invoke_arg *arg,
+		       struct tee_param *param)
+{
+	struct amdtee_context_data *ctxdata =3D ctx->data;
+	struct amdtee_session *sess;
+	u32 i, session_info;
+
+	/* Check that the session is valid */
+	mutex_lock(&session_list_mutex);
+	sess =3D find_session(ctxdata, arg->session);
+	if (sess) {
+		i =3D get_session_index(arg->session);
+		session_info =3D sess->session_info[i];
+	}
+	mutex_unlock(&session_list_mutex);
+
+	if (!sess)
+		return -EINVAL;
+
+	handle_invoke_cmd(arg, session_info, param);
+
+	return 0;
+}
+
+int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
+{
+	return -EINVAL;
+}
+
+static const struct tee_driver_ops amdtee_ops =3D {
+	.get_version =3D amdtee_get_version,
+	.open =3D amdtee_open,
+	.release =3D amdtee_release,
+	.open_session =3D amdtee_open_session,
+	.close_session =3D amdtee_close_session,
+	.invoke_func =3D amdtee_invoke_func,
+	.cancel_req =3D amdtee_cancel_req,
+};
+
+static const struct tee_desc amdtee_desc =3D {
+	.name =3D DRIVER_NAME "-clnt",
+	.ops =3D &amdtee_ops,
+	.owner =3D THIS_MODULE,
+};
+
+static int __init amdtee_driver_init(void)
+{
+	struct amdtee *amdtee =3D NULL;
+	struct tee_device *teedev;
+	struct tee_shm_pool *pool =3D ERR_PTR(-EINVAL);
+	int rc;
+
+	drv_data =3D kzalloc(sizeof(*drv_data), GFP_KERNEL);
+	if (IS_ERR(drv_data))
+		return -ENOMEM;
+
+	amdtee =3D kzalloc(sizeof(*amdtee), GFP_KERNEL);
+	if (IS_ERR(amdtee)) {
+		rc =3D -ENOMEM;
+		goto err_kfree_drv_data;
+	}
+
+	pool =3D amdtee_config_shm();
+	if (IS_ERR(pool)) {
+		pr_err("shared pool configuration error\n");
+		rc =3D PTR_ERR(pool);
+		goto err_kfree_amdtee;
+	}
+
+	teedev =3D tee_device_alloc(&amdtee_desc, NULL, pool, amdtee);
+	if (IS_ERR(teedev)) {
+		rc =3D PTR_ERR(teedev);
+		goto err;
+	}
+	amdtee->teedev =3D teedev;
+
+	rc =3D tee_device_register(amdtee->teedev);
+	if (rc)
+		goto err;
+
+	amdtee->pool =3D pool;
+
+	drv_data->amdtee =3D amdtee;
+
+	pr_info("amd-tee driver initialization successful\n");
+	return 0;
+
+err:
+	tee_device_unregister(amdtee->teedev);
+	if (pool)
+		tee_shm_pool_free(pool);
+
+err_kfree_amdtee:
+	kfree(amdtee);
+
+err_kfree_drv_data:
+	kfree(drv_data);
+	drv_data =3D NULL;
+
+	pr_err("amd-tee driver initialization failed\n");
+	return rc;
+}
+module_init(amdtee_driver_init);
+
+static void __exit amdtee_driver_exit(void)
+{
+	struct amdtee *amdtee;
+
+	if (!drv_data || !drv_data->amdtee)
+		return;
+
+	amdtee =3D drv_data->amdtee;
+
+	tee_device_unregister(amdtee->teedev);
+	tee_shm_pool_free(amdtee->pool);
+}
+module_exit(amdtee_driver_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION("AMD-TEE driver");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
new file mode 100644
index 0000000..10392d6
--- /dev/null
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+#include <linux/psp-sev.h>
+#include "../tee_private.h"
+#include "amdtee_private.h"
+
+static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *s=
hm,
+			 size_t size)
+{
+	unsigned long va;
+	int min_alloc_order =3D *(int *)poolm->private_data;
+	size_t s =3D roundup(size, 1 << min_alloc_order);
+	int rc;
+
+	va =3D __get_free_pages(GFP_KERNEL, get_order(s));
+	if (!va)
+		return -ENOMEM;
+
+	memset((void *)va, 0, s);
+	shm->kaddr =3D (void *)va;
+	shm->paddr =3D __psp_pa((void *)va);
+	shm->size =3D s;
+
+	/* Map the allocated memory in to TEE */
+	rc =3D amdtee_map_shmem(shm);
+	if (rc) {
+		free_pages(va, get_order(s));
+		shm->kaddr =3D NULL;
+		return rc;
+	}
+
+	return 0;
+}
+
+static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *s=
hm)
+{
+	/* Unmap the shared memory from TEE */
+	amdtee_unmap_shmem(shm);
+	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
+	shm->kaddr =3D NULL;
+}
+
+static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
+{
+	if (poolm && poolm->private_data) {
+		kfree(poolm->private_data);
+		poolm->private_data =3D NULL;
+	}
+
+	kfree(poolm);
+}
+
+static const struct tee_shm_pool_mgr_ops pool_ops =3D {
+	.alloc =3D pool_op_alloc,
+	.free =3D pool_op_free,
+	.destroy_poolmgr =3D pool_op_destroy_poolmgr,
+};
+
+static int pool_mem_mgr_init(struct tee_shm_pool_mgr *mgr, int min_alloc_o=
rder)
+{
+	int *order;
+
+	order =3D kmalloc(sizeof(min_alloc_order), GFP_KERNEL);
+	if (!order)
+		return -ENOMEM;
+
+	*order =3D min_alloc_order;
+	mgr->private_data =3D order;
+	mgr->ops =3D &pool_ops;
+	return 0;
+}
+
+struct tee_shm_pool *amdtee_config_shm(void)
+{
+	struct tee_shm_pool *pool =3D NULL;
+	struct tee_shm_pool_mgr *priv_mgr;
+	struct tee_shm_pool_mgr *dmabuf_mgr;
+	int ret;
+
+	pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	priv_mgr =3D kzalloc(sizeof(*priv_mgr), GFP_KERNEL);
+	if (!priv_mgr) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	dmabuf_mgr =3D kzalloc(sizeof(*dmabuf_mgr), GFP_KERNEL);
+	if (!dmabuf_mgr) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	pool->private_mgr =3D priv_mgr;
+	pool->dma_buf_mgr =3D dmabuf_mgr;
+	/*
+	 * Initialize memory manager for driver private shared memory
+	 */
+	ret =3D pool_mem_mgr_init(pool->private_mgr, 3 /* 8 byte aligned */);
+	if (ret)
+		goto err;
+
+	/*
+	 * Initialize memory manager for dma_buf shared memory
+	 */
+	ret =3D pool_mem_mgr_init(pool->dma_buf_mgr, PAGE_SHIFT);
+	if (ret)
+		goto err;
+
+	return pool;
+err:
+	if (ret =3D=3D -ENOMEM)
+		pr_err("%s: failed to configure shared memory pool\n",
+		       __func__);
+	if (pool && pool->private_mgr->private_data)
+		kfree(pool->private_mgr->private_data);
+	kfree(pool);
+	kfree(priv_mgr);
+	kfree(dmabuf_mgr);
+	return ERR_PTR(ret);
+}
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 4b9eb06..6596f3a 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -56,6 +56,7 @@
  * TEE Implementation ID
  */
 #define TEE_IMPL_ID_OPTEE	1
+#define TEE_IMPL_ID_AMDTEE	2
=20
 /*
  * OP-TEE specific capabilities
--=20
1.9.1

