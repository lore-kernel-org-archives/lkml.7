Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E65FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED43B2466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 06:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RSGJmBZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLFGMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 01:12:23 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:34240
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfLFGMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 01:12:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoFqAEkjPeACIL672N8D1lMhxogIt29mFeExGlItaYLqn98jJrh+JD+fQYkwBospYLs1Ae2fOV+R4hQHq0M7rHP4V2Wt3XNi9r+k+buTWCPq+C/oKZ8tkf9T0XtKe7pCh1w7crZ8+saF9mhLb++B0SZBIMD8/lw571PREYqgJqg4rUtRD7693l2cBlLr3gzH3Xr+bWJZ2UKKS4Q1Bwmi4aXM5QGYTX6faLJ4c1Lssn1exzo6guMTeqdm9rbp19iburXwZ3/gpiMtokD1pkyxKQ+NA3Bcgg9iDWxgA3juZTgTo/szE6dopI+L1bmYlhaYAMC7OWZU6uWnMftcIcYcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5pWZ6NtaSyf8auFQMmberX+EXwjUKZTacVzQgRwDo8=;
 b=PG+APk0g1FFsx6EsnHWphsBPyz3xhjiD8MQJEE9s3nKhH/2upZOyVAY363u0MzYfcpZIKF5RcTeLQsSig42do39bMzn+hlPIJAeDe0qlEpwdthOMfIa5V2m44PenEpuLR5PUDL+C04Q4/5vp0yEoSE6a1wazRM+jrAEeSpmUcRVfxMzd+WlBuJBic4YIgo81ucf1sCL7a6PpxV7M7eEDoBe1qAcYU7/n9Xbss4n/A/5rgiSE9eOZ9QBTdqb907DqVRL+CCCFXKq4xFKxV1XERa2x4DPd9ePKfLuXNHtgLpX87dVS+nHEzu2v4Xp54JP06zftzZWI6viJR/2fCmBZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5pWZ6NtaSyf8auFQMmberX+EXwjUKZTacVzQgRwDo8=;
 b=RSGJmBZkGoeQmf2rgcti7VRXK9amoEDQKoIVCsj6tefs22yOZQdi+gP6jQ8gH5uCTQD0uASbNqibOrGpvWgY6UGV0EqXvrXvqnc+W1vyWvm1/+a6DLAgdtkDq1ySGBUJmOCtcHF5np5Wc1jJP3FtSV3iKK4HF0y0Wy2zmE9p0qw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1944.namprd12.prod.outlook.com (10.175.81.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Fri, 6 Dec 2019 06:11:39 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 06:11:38 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
Subject: [RFC PATCH v3 0/4] TEE driver for AMD APUs
Date:   Fri,  6 Dec 2019 10:48:40 +0530
Message-Id: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::28) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dd23edc-fa32-423d-c448-08d77a13275a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1944:|CY4PR12MB1944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB194448E9C015FEE3C2B873C7CF5F0@CY4PR12MB1944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(2906002)(14444005)(50226002)(6666004)(54906003)(52116002)(6506007)(51416003)(8936002)(81166006)(48376002)(50466002)(316002)(99286004)(16586007)(6512007)(36756003)(81156014)(305945005)(6486002)(14454004)(2616005)(478600001)(5660300002)(8676002)(66556008)(66476007)(186003)(4326008)(966005)(66946007)(26005)(86362001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1944;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo8ZrE/WzltKJwwM+ov9Gi/txIAO6o8Po2LFChb2RiMW4NXQ5u+r04Bn55vGldalL2G/nhQG/ryRIdnSCXqEoQbaMXmray7n2bbErUsQSOU0l92N9VooeDJh+KcDxMUy+UtnoJ/OvNxy6y1cgSDOcnbJjTVLqA4HUOkR2AAYnX9M4lDs0t+3XhLMWTKYN6l6BGeHeMCPMIdSaGo9CazF1apWlI1UkdJZXIYcwYE5Z5aaxhs7vP+203offJ/bs9BS5syt2mjEIip1joN81+t46Zol35Yj/UQUbTBCwYSigkQUjFPXRxbpinXnU8ryN/Jtcm/pOaDTWewpJKn4L+0rvRljelv3QeR2RDtQ5s18boJ55+Izzgq07lVZEkpd3fdT/AQDHjFT3izZg1v4citduYl+mu0/myox92fow0o3uleiSFxpm+HdF/dRapVetgSu2YN1QGAzqJGaKHlYDxZcjHt/u9uauEYTPxhzeeDk9gE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd23edc-fa32-423d-c448-08d77a13275a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 06:11:38.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vry3uY3uuFG7Arpyi8FkotbuycPdQsrl9fNrQLndWOWeG0x/+59NUCSA2FKHLSlzlm49aQYUWhGn8QpMzQlDtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces Trusted Execution Environment (TEE) driver
for AMD APU enabled systems. The TEE is a secure area of a processor which
ensures that sensitive data is stored, processed and protected in an
isolated and trusted environment. The AMD Secure Processor is a dedicated
processor which provides TEE to enable HW platform security. It offers
protection against software attacks generated in Rich Operating
System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
running on AMD Secure Processor allows loading and execution of security
sensitive applications called Trusted Applications (TAs). An example of
a TA would be a DRM (Digital Rights Management) TA written to enforce
content protection.

Linux already provides a tee subsystem, which is described in [1]. The tee
subsystem provides a generic TEE ioctl interface which can be used by user
space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
and implements tee function callbacks in an AMD platform specific manner.

The following TEE commands are recognized by AMD-TEE Trusted OS:
1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
   environment
2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory

Each command has its own payload format. The AMD-TEE driver creates a
command buffer payload for submission to AMD-TEE Trusted OS.

This patch series has a dependency on another patch set titled - Add TEE
interface support to AMD Secure Processor driver.
Link: https://lkml.org/lkml/2019/12/4/42

v3:
* Updated [1] with driver details

v2:
* Added a helper API in AMD Secure Processor driver, which can be
  called by AMD-TEE driver during module init to check if TEE is
  present on the device
* Added proper checks for parameter attribute variable
* Used tee_shm_pool_alloc() to allocate struct tee_shm_pool data structure
* Removed all references to tee_private.h header file in driver code,
  except for the file drivers/tee/amdtee/core.c. The driver loads TA binary
  by calling request_firmware(), which takes struct device* as one of its
  arguments. The device 'dev' field is part of struct tee_device, defined
  in tee_private.h

[1] https://www.kernel.org/doc/Documentation/tee.txt

Rijo Thomas (4):
  tee: allow compilation of tee subsystem for AMD CPUs
  tee: add AMD-TEE driver
  tee: amdtee: check TEE status during driver initialization
  Documentation: tee: add AMD-TEE driver details

 Documentation/tee.txt               |  81 ++++++
 drivers/crypto/ccp/tee-dev.c        |  11 +
 drivers/tee/Kconfig                 |   4 +-
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/Kconfig          |   8 +
 drivers/tee/amdtee/Makefile         |   5 +
 drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
 drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
 drivers/tee/amdtee/call.c           | 373 ++++++++++++++++++++++++++
 drivers/tee/amdtee/core.c           | 516 ++++++++++++++++++++++++++++++++++++
 drivers/tee/amdtee/shm_pool.c       |  93 +++++++
 include/linux/psp-tee.h             |  18 ++
 include/uapi/linux/tee.h            |   1 +
 13 files changed, 1451 insertions(+), 2 deletions(-)
 create mode 100644 drivers/tee/amdtee/Kconfig
 create mode 100644 drivers/tee/amdtee/Makefile
 create mode 100644 drivers/tee/amdtee/amdtee_if.h
 create mode 100644 drivers/tee/amdtee/amdtee_private.h
 create mode 100644 drivers/tee/amdtee/call.c
 create mode 100644 drivers/tee/amdtee/core.c
 create mode 100644 drivers/tee/amdtee/shm_pool.c

--
1.9.1

