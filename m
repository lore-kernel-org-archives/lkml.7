Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C942C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74FA2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b20Kj6sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfLLMei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:34:38 -0500
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:63107
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729170AbfLLMei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:34:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx3DMFoaV4wQagXk6ZPpKB+eU0cBfVeLN42VN2JwMdbunMYAVutxwsFj2gE1SwV3RVwWXqSNZpWFCc5UdKrKSJFec81t3i1O/Io1pwbJwYF5jTqFF/K6WucXbBNba0lQ75DWJ9Qk4XMUJ2lmX2MSnGTgRrhLN8AR8EibxK419UcSLiPkwJyTbDM5Spp9NtmSU0EstTNvZW8trR4gACgHrQzxcKVQc7DlTgX4TvcBUb/0BFsniFYImugyM8aj7GHxYg0B+yVH1NhHys65JE4eqraWmdBB5fa/8RrcB9TeJxRcbZg2bXYpZyuhvPC+Ou+REWnS/RRlD4QUyhY/oNJlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ENQdJc4+TFEmmoFlrgz6EzYOKUk6+9FLOxleSAK/J0=;
 b=RzI3a5fgnTbQYlK6AJd2hqNu/abdGv51YV2FaoRT35muE3u+aCFfgzfhFkdiFuZdA6bnjw9E3Z9ufO69DS/oV7YXuxUib27YxxIZB5Jg4LD2f7M0r/pseX4AU1q8qJio2NYN4PBvihaiDNEfp4/UiY/BKEw0GMuMWYn/EGo1y5v++wWLe9VfD0iftq4zz62G008hvEOzBQhQ995Mzlb7afVVY6NYX9esvaynfw7OjDGNcRzEipediuag30irw7FksX2nyFy9ZuruXTvwIKfo9PXmJsbfW2Jjz0+TjU9U4gPOwMSyeggJWzq/my/pNOe2U4+Be69/duJ0XCU6eEiSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ENQdJc4+TFEmmoFlrgz6EzYOKUk6+9FLOxleSAK/J0=;
 b=b20Kj6sLn4cqJCh1JREQFx2+mi31EVJn0bJXDB+ffOEzmitZ6nDFDvteTiWO8NDIHPCBpAglvK3i95Jgdb4helzYGntCZbsJyyeyvWnzbOt/8qKBaWlossIvJHhn2GrEUhpfp1B8pr9xdgayS6IaKs7Az11eLhAurMge4YCiTfQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1575.namprd12.prod.outlook.com (10.172.71.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 12 Dec 2019 12:34:35 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::cd8b:1d7e:31c2:e8b4%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 12:34:35 +0000
Subject: Re: [RFC PATCH v3 0/4] TEE driver for AMD APUs
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>
References: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Message-ID: <f7803de4-b09d-cfb7-9289-7abf5dde37c0@amd.com>
Date:   Thu, 12 Dec 2019 18:04:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::13) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5600b12d-bb99-48e5-36f3-08d77effa518
X-MS-TrafficTypeDiagnostic: CY4PR12MB1575:|CY4PR12MB1575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB15756D1025093DE82FEA943ECF550@CY4PR12MB1575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0249EFCB0B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(36756003)(2616005)(81156014)(8936002)(66556008)(8676002)(81166006)(6666004)(54906003)(31686004)(66946007)(316002)(6506007)(66476007)(53546011)(52116002)(4326008)(6486002)(6512007)(478600001)(31696002)(26005)(186003)(5660300002)(2906002)(966005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1575;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dGcQPpCktljPU/ggbxHCEmgC/CoYB24tP/asPcb/IvlPnLCNuhov/9jqDIa4Q1blGmV6paRIHMc943gMWa8x2F2VhSl0UWiPwankbQglgWC7TUIcZ+0av94/1n4Bm2dMfCV1VCKXTGEocFf8RHxB3pHOjX5RimcZ9Exlrl0J/3c+2aPHoPfWp2e/zW40qSk8zR8rXzTl3LEiZJlhVLPH8bWB3octSOg4Hx1qEEYQB1c2i5v3/MB936kOFAI9Ms1FKEZiIzV2Cukl8WzvpCibLsXyQ6xBz/4k9nUT3T4Zu3Wvrst23iTMiZfILbll/fGMubcfuOqK3BLpUdCTN7Fnh9FdQv2cvjrZCyWHmxbakaW5P0sACapAolBj71dGv0l8O97SZurd7FNyXeUiG3u/W6CNXToTsbQttYBic2QQRLCtkbCWgucufruQaTjPgkij
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5600b12d-bb99-48e5-36f3-08d77effa518
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2019 12:34:34.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bd0bMNZFUNBg1EvqZUVifJFtC0Uhg7QMzpdthBfah8UBvTX+17yHq0SC91yIZaVZFE+o3pY5OnG+5BQPYGWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Please let me know if there are any comments for this patch series. I
shall address them, if any, and post for next review.

Thanks,
Rijo

On 06/12/19 10:48 am, Rijo Thomas wrote:
> This patch series introduces Trusted Execution Environment (TEE) driver
> for AMD APU enabled systems. The TEE is a secure area of a processor which
> ensures that sensitive data is stored, processed and protected in an
> isolated and trusted environment. The AMD Secure Processor is a dedicated
> processor which provides TEE to enable HW platform security. It offers
> protection against software attacks generated in Rich Operating
> System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
> running on AMD Secure Processor allows loading and execution of security
> sensitive applications called Trusted Applications (TAs). An example of
> a TA would be a DRM (Digital Rights Management) TA written to enforce
> content protection.
> 
> Linux already provides a tee subsystem, which is described in [1]. The tee
> subsystem provides a generic TEE ioctl interface which can be used by user
> space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
> and implements tee function callbacks in an AMD platform specific manner.
> 
> The following TEE commands are recognized by AMD-TEE Trusted OS:
> 1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
>    environment
> 2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
> 3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
> 4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
> 5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
> 6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
> 7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory
> 
> Each command has its own payload format. The AMD-TEE driver creates a
> command buffer payload for submission to AMD-TEE Trusted OS.
> 
> This patch series has a dependency on another patch set titled - Add TEE
> interface support to AMD Secure Processor driver.
> Link: https://lkml.org/lkml/2019/12/4/42
> 
> v3:
> * Updated [1] with driver details
> 
> v2:
> * Added a helper API in AMD Secure Processor driver, which can be
>   called by AMD-TEE driver during module init to check if TEE is
>   present on the device
> * Added proper checks for parameter attribute variable
> * Used tee_shm_pool_alloc() to allocate struct tee_shm_pool data structure
> * Removed all references to tee_private.h header file in driver code,
>   except for the file drivers/tee/amdtee/core.c. The driver loads TA binary
>   by calling request_firmware(), which takes struct device* as one of its
>   arguments. The device 'dev' field is part of struct tee_device, defined
>   in tee_private.h
> 
> [1] https://www.kernel.org/doc/Documentation/tee.txt
> 
> Rijo Thomas (4):
>   tee: allow compilation of tee subsystem for AMD CPUs
>   tee: add AMD-TEE driver
>   tee: amdtee: check TEE status during driver initialization
>   Documentation: tee: add AMD-TEE driver details
> 
>  Documentation/tee.txt               |  81 ++++++
>  drivers/crypto/ccp/tee-dev.c        |  11 +
>  drivers/tee/Kconfig                 |   4 +-
>  drivers/tee/Makefile                |   1 +
>  drivers/tee/amdtee/Kconfig          |   8 +
>  drivers/tee/amdtee/Makefile         |   5 +
>  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
>  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
>  drivers/tee/amdtee/call.c           | 373 ++++++++++++++++++++++++++
>  drivers/tee/amdtee/core.c           | 516 ++++++++++++++++++++++++++++++++++++
>  drivers/tee/amdtee/shm_pool.c       |  93 +++++++
>  include/linux/psp-tee.h             |  18 ++
>  include/uapi/linux/tee.h            |   1 +
>  13 files changed, 1451 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/tee/amdtee/Kconfig
>  create mode 100644 drivers/tee/amdtee/Makefile
>  create mode 100644 drivers/tee/amdtee/amdtee_if.h
>  create mode 100644 drivers/tee/amdtee/amdtee_private.h
>  create mode 100644 drivers/tee/amdtee/call.c
>  create mode 100644 drivers/tee/amdtee/core.c
>  create mode 100644 drivers/tee/amdtee/shm_pool.c
> 
> --
> 1.9.1
> 
