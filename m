Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75394C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E81320659
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GCea3q5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLCFsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:48:54 -0500
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:30981
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfLCFsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:48:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUXkrUwFLCEgd2Sk38Tp3jmM5bvfV927e+caqWKe/K0W2cJ9WGTdR8gV6Br8bVyQtD46v+jgliyZkbIIHs08BHaPQwJQvuAv9pWLq2/QVX9u+wTckZaNyCYbO8tkV4xGmNATNhaxcY/XCzHvPdtdb5y8zx8EMXtZQZmWN0gYkFgDs0VWHp/fuwGPWguId9NKRHS8gUHnmxDyxkE5UcU+HAcvj7Irz8QNgQfwbDy6m9VO2fndPyFlAg1J6XnT1D6DJ1CLETNMVqALmPyYje++ZhcIKodTvvgH/HuuaIkc2TSR/cdh/h78K/lR9Iqtoyjd6iXIdNAVZGiacTginP5eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elvVtsGf7p0iF1K0WNN+fobAiHpVTWtOlfANCuKjZhA=;
 b=bEVxSylFUK/OxrjEojpRKeIOHdgrpxqf/HtJ24IkP0tYr4gf1iTCcdjp/czXuxabbFFeCkE95QTZKmgSvmb0vFVhv2YsGMild5+uxw4vtHg/nO8CR/WjwNcsVMB/y028delUr/dbViHe0RzVEs2MhaMd8BmxHUaqUos2sH2tLZL3f6Q3dJEq0tPe8aleKuIfDG2FtYyPECbxeBMDSjxzwMjq4Npxov928M0ssOB098jKTO4Tb0Tybs1ekNQZIVHfjtxiTqvXamoiLUWQPADt5B3niiLtvh4HuVTk7PcvU3dtLwidsImncjq4U3SDq/EZ6GOrKxqlw0RW5UQi68xfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elvVtsGf7p0iF1K0WNN+fobAiHpVTWtOlfANCuKjZhA=;
 b=GCea3q5mPjGudxwakDOxdEru+LQ68RjOXL6fbbHiHCYdUm+DH6UwL4QrF0wjG7gXbYV7pWGJUWcZMcfN0BTMcm85JRlPf7RSzaLCug5+ZDd68JY++s4zPSgxK4TdHHCf1BXZo7uINPb2F5W/G7wRblrZMgeJWW69kWl2ieQKSv4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1592.namprd12.prod.outlook.com (10.172.70.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 05:48:51 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 05:48:51 +0000
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v2 0/3] TEE driver for AMD APUs
Date:   Tue,  3 Dec 2019 10:26:20 +0530
Message-Id: <cover.1575272984.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c367b8fa-e565-4d74-7e5f-08d777b478ed
X-MS-TrafficTypeDiagnostic: CY4PR12MB1592:|CY4PR12MB1592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB159284820409905BC93E37A6CF420@CY4PR12MB1592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(51416003)(52116002)(966005)(3846002)(6666004)(6116002)(2616005)(4326008)(25786009)(14454004)(6506007)(386003)(26005)(8936002)(478600001)(6306002)(99286004)(47776003)(5660300002)(186003)(7736002)(6512007)(66946007)(16586007)(66476007)(66556008)(316002)(81166006)(81156014)(50226002)(54906003)(14444005)(36756003)(86362001)(6436002)(8676002)(2906002)(66066001)(48376002)(6486002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1592;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpJX9j834lth/6FsYWwVz+BqS1R9ToJS2Lo/X1xyvumt0CS52yiNgQEEMKh4VHTJeHr3TRhbkIeCz0WJgnobFqWdPupB4bG2SxVBm1MoIfGkdE/jzXuFZG/LEbDuBc1nPs40SC3V2vtXE8sxVYaWldUsEuLqaVJqKPa+p7XzgzS7Pc9MJcs547jZ1e/V8DVO2S/QxvILGjr74K8VUbIZzrDe5p47Gdoi5CWakNaI93Lv8ksbiTezLfQ1LZ0AvTMfa/+U8H+akKPrGhSHnAj+/aooncdZYtFmOFnRyupRJJ7cyEhRD/Q8zs8pspd5IpH/dnbR2OFmJTV3xM7MHrkPO/3SqlY+YDKhrQinrIHdgtEN0/FBZtx3wBtIiZ/1v3+OLBdlqQkJmrF0iKQBQIQOcXYERRJxJ9p+GluhYtRMVUnswzM4WzCIP+BypZccW/jYcLbIeeRrOb6DtoO9/vySxkxvjvuAXi1xbE3Z0P71FmE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c367b8fa-e565-4d74-7e5f-08d777b478ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 05:48:51.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPAIYghd1K8h5TVwIhnVYTFjfEO0ocXawZUC1kesNSTuS41IJREOalG3I4jPsq089bA8zvZ6nJZ/NM5BTj85gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1592
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

I shall update [1] with AMD-TEE driver details shortly.

This patch series has a dependency on another patch set titled - Add TEE
interface support to AMD Secure Processor driver.
Link:
https://patchwork.kernel.org/project/linux-crypto/list/?submitter=188843

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

Rijo Thomas (3):
  tee: allow compilation of tee subsystem for AMD CPUs
  tee: add AMD-TEE driver
  tee: amdtee: check TEE status during driver initialization

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
 12 files changed, 1370 insertions(+), 2 deletions(-)
 create mode 100644 drivers/tee/amdtee/Kconfig
 create mode 100644 drivers/tee/amdtee/Makefile
 create mode 100644 drivers/tee/amdtee/amdtee_if.h
 create mode 100644 drivers/tee/amdtee/amdtee_private.h
 create mode 100644 drivers/tee/amdtee/call.c
 create mode 100644 drivers/tee/amdtee/core.c
 create mode 100644 drivers/tee/amdtee/shm_pool.c

--
1.9.1

