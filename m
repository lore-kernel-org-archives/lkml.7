Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5DAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F417F20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h+ZOX8sS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfKZNBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:01:38 -0500
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:19632
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfKZNBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIFeLhdqXdkv5zw+w9ktRQNN20wgizqaRobs+eu5rqCU4q+614XpehWtjhfLUyHvogn1agV3Xsaxd4QGexBEGT+0R70OTb3I/vuwQBtyigP4cWyo6KYaTehnYQyZ0VrUq7nsr1oMCgWbRAjUZI5D5vXmGv6vguM8Sc+ssbxCW3PnZLlJOybrLWMKjr/6PNWMwE9xy9ZNtUXJTg3amVL7u3Q9OdPcN5iwAPy/tqKWGPsQRvOHmpCZ7WlO8DJ7sW5b6yib/EozFxK3STEW+tvsjZlZZtnuPBPL2GD1UcQmGdvlT41ld5WgKmFiaLL+7+iaAT98edU1VtyVEtc0cpTsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCRDdudjByMA/6hV5CglM7LjV/t1LUgpqtR+CcmOWNk=;
 b=Z29r56X5Siex2bbvbvWqbhFDJBDyR4VoaX1dcLSvzgmgvf55wp08tyZbbb5P61cGeI1m6x7fnGcI5OjNFGtYHze372+jtIzXSwnHjVxysQphWwWuDGJOl9c52JsFYES6ETTcWfAakGoonPGRXt8V0Am66SS+St3VingniqXFKAsH7H3ZvArIhqDGOLyfgB/lrE3+xgblt7JmUGARB11iPpH63AJC4amM6GEt8c8AN8V1i94Ro76OQoCHWpvZ3wiLV2Mnfg2xrDikT6iH/4PcysPzX7xmDxBFFCUsw3jTVVslohyr2r2dRxd5t6uZjnJ3caEbFF4iTlaUOkUYMJ1CPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCRDdudjByMA/6hV5CglM7LjV/t1LUgpqtR+CcmOWNk=;
 b=h+ZOX8sSkUFYLMp5kZyfyDhC7YnFcVJjCBfiykRPjtP4w5M2Wsu4VG4s2zVCVa8BFV6pdMLpirvGNfxrL2WQ92zHvefHCJANCv17QYK/T9b6z2UEJL7WZJ5+oQFHV4kAuPUSqptewa7S2ik21N2296l4zuIKMlz6PSqmzy78l84=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from DM5PR12MB1932.namprd12.prod.outlook.com (10.175.89.23) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 13:01:26 +0000
Received: from DM5PR12MB1932.namprd12.prod.outlook.com
 ([fe80::cce8:3bc3:54c7:26ea]) by DM5PR12MB1932.namprd12.prod.outlook.com
 ([fe80::cce8:3bc3:54c7:26ea%8]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:01:26 +0000
Subject: Re: [RFC PATCH 2/2] tee: add AMD-TEE driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
References: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
 <fd7b187b01cccd690dc3c71d6c5f2520bb9e303a.1571818136.git.Rijo-john.Thomas@amd.com>
 <20191105152802.GB22448@jax>
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Message-ID: <02a3f5ea-b4ab-5e9f-d9d3-a5d88bfd4a13@amd.com>
Date:   Tue, 26 Nov 2019 18:31:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191105152802.GB22448@jax>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::22) To DM5PR12MB1932.namprd12.prod.outlook.com
 (2603:10b6:3:10e::23)
MIME-Version: 1.0
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75ae7f83-febc-4f55-b87f-08d77270be80
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:|DM5PR12MB1675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1675771E4CE9267E6EB65C61CF450@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(305945005)(6486002)(2906002)(31696002)(54906003)(186003)(8676002)(6512007)(58126008)(26005)(81166006)(81156014)(30864003)(14454004)(25786009)(86362001)(6916009)(6436002)(4326008)(316002)(478600001)(31686004)(6246003)(7736002)(66476007)(53546011)(6506007)(386003)(2486003)(52116002)(6666004)(229853002)(99286004)(66556008)(230700001)(8936002)(23676004)(66946007)(76176011)(36756003)(47776003)(11346002)(2616005)(3846002)(50466002)(5660300002)(14444005)(446003)(65806001)(65956001)(66066001)(6116002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB1932.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbu6vgOLQAhGIGdx8eLcZgboU3CJLh8TFdtHgs8ot+OX7H/hLvghD98LtxpWbjXxkQYhmzw9g/5pHQLgdHfCaw+8anShVE2BvSNaFM3pIZ+LKmc+j4mBwVVRPzmnmT6JGX9aEK0Uwz65TH3KSCTQR+O7XHMitOszaEGh/Elis4I4l3uYhQ39rjx72fpEEYSXKGaMs7XrZoxxAH5mVOwcgtDr6skxACzjU1kThSi2y1B+7AYemdnDUZtsdhZtbdyg2Br7neGPKeEjRjrwaEnnetbdSPdwX+P6nn711TAs6HMyrakPbLuds5DLuS2zSCuAGluqJXLIf3olXruwWWT9WHgyRMW2c/IxyhpUlgnIvttoR7A/rmuw2qWoqKdKOIBxm4HyBssWPocPRkAA7Xz6P2PEJi2oXQftFPfCQhf99e/AlBHVmA+HDUvOsR/7Tk/T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ae7f83-febc-4f55-b87f-08d77270be80
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:01:26.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxSi71SaKnORwXGLL2+IwBkz9BPurT9roh1ICjgHf5pRUZveb/eIuKxssIH6SKA6xTQDT0ftjlgaUnLkmcKugA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 05/11/19 8:58 PM, Jens Wiklander wrote:
> Hi Rijo,
> 
> On Wed, Oct 23, 2019 at 11:31:01AM +0000, Thomas, Rijo-john wrote:
>> Adds AMD-TEE driver.
>> * targets AMD APUs which has AMD Secure Processor with software-based
>>   Trusted Execution Environment (TEE) support
>> * registers with TEE subsystem
>> * defines tee_driver_ops function callbacks
>> * kernel allocated memory is used as shared memory between normal
>>   world and secure world.
>> * acts as REE (Rich Execution Environment) communication agent, which
>>   uses the services of AMD Secure Processor driver to submit commands
>>   for processing in TEE environment
>>
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>> ---
>>  drivers/tee/Kconfig                 |   2 +-
>>  drivers/tee/Makefile                |   1 +
>>  drivers/tee/amdtee/Kconfig          |   8 +
>>  drivers/tee/amdtee/Makefile         |   5 +
>>  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
>>  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
>>  drivers/tee/amdtee/call.c           | 370 ++++++++++++++++++++++++++
>>  drivers/tee/amdtee/core.c           | 510 ++++++++++++++++++++++++++++++++++++
>>  drivers/tee/amdtee/shm_pool.c       | 130 +++++++++
>>  include/uapi/linux/tee.h            |   1 +
>>  10 files changed, 1368 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/tee/amdtee/Kconfig
>>  create mode 100644 drivers/tee/amdtee/Makefile
>>  create mode 100644 drivers/tee/amdtee/amdtee_if.h
>>  create mode 100644 drivers/tee/amdtee/amdtee_private.h
>>  create mode 100644 drivers/tee/amdtee/call.c
>>  create mode 100644 drivers/tee/amdtee/core.c
>>  create mode 100644 drivers/tee/amdtee/shm_pool.c
>>
>> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
>> index 4f3197d..8da63f3 100644
>> --- a/drivers/tee/Kconfig
>> +++ b/drivers/tee/Kconfig
>> @@ -14,7 +14,7 @@ if TEE
>>  menu "TEE drivers"
>>  
>>  source "drivers/tee/optee/Kconfig"
>> -
>> +source "drivers/tee/amdtee/Kconfig"
>>  endmenu
>>  
>>  endif
>> diff --git a/drivers/tee/Makefile b/drivers/tee/Makefile
>> index 21f51fd..68da044 100644
>> --- a/drivers/tee/Makefile
>> +++ b/drivers/tee/Makefile
>> @@ -4,3 +4,4 @@ tee-objs += tee_core.o
>>  tee-objs += tee_shm.o
>>  tee-objs += tee_shm_pool.o
>>  obj-$(CONFIG_OPTEE) += optee/
>> +obj-$(CONFIG_AMDTEE) += amdtee/
>> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
>> new file mode 100644
>> index 0000000..4e32b64
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/Kconfig
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: MIT
>> +# AMD-TEE Trusted Execution Environment Configuration
>> +config AMDTEE
>> +	tristate "AMD-TEE"
>> +	default m
>> +	depends on CRYPTO_DEV_SP_PSP
>> +	help
>> +	  This implements AMD's Trusted Execution Environment (TEE) driver.
>> diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
>> new file mode 100644
>> index 0000000..ff14852
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: MIT
>> +obj-$(CONFIG_AMDTEE) += amdtee.o
>> +amdtee-objs += core.o
>> +amdtee-objs += call.o
>> +amdtee-objs += shm_pool.o
>> diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
>> new file mode 100644
>> index 0000000..ff48c3e
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/amdtee_if.h
>> @@ -0,0 +1,183 @@
>> +/* SPDX-License-Identifier: MIT */
>> +
>> +/*
>> + * Copyright 2019 Advanced Micro Devices, Inc.
>> + */
>> +
>> +/*
>> + * This file has definitions related to Host and AMD-TEE Trusted OS interface.
>> + * These definitions must match the definitions on the TEE side.
>> + */
>> +
>> +#ifndef AMDTEE_IF_H
>> +#define AMDTEE_IF_H
>> +
>> +#include <linux/types.h>
>> +
>> +/*****************************************************************************
>> + ** TEE Param
>> + ******************************************************************************/
>> +#define TEE_MAX_PARAMS		4
>> +
>> +/**
>> + * struct memref - memory reference structure
>> + * @buf_id:    buffer ID of the buffer mapped by TEE_CMD_ID_MAP_SHARED_MEM
>> + * @offset:    offset in bytes from beginning of the buffer
>> + * @size:      data size in bytes
>> + */
>> +struct memref {
>> +	u32 buf_id;
>> +	u32 offset;
>> +	u32 size;
>> +};
>> +
>> +struct value {
>> +	u32 a;
>> +	u32 b;
>> +};
>> +
>> +/*
>> + * Parameters passed to open_session or invoke_command
>> + */
>> +union tee_op_param {
>> +	struct memref mref;
>> +	struct value val;
>> +};
>> +
>> +struct tee_operation {
>> +	u32 param_types;
>> +	union tee_op_param params[TEE_MAX_PARAMS];
>> +};
>> +
>> +/* Must be same as in GP TEE specification */
>> +#define TEE_OP_PARAM_TYPE_NONE                  0
>> +#define TEE_OP_PARAM_TYPE_VALUE_INPUT           1
>> +#define TEE_OP_PARAM_TYPE_VALUE_OUTPUT          2
>> +#define TEE_OP_PARAM_TYPE_VALUE_INOUT           3
>> +#define TEE_OP_PARAM_TYPE_INVALID               4
>> +#define TEE_OP_PARAM_TYPE_MEMREF_INPUT          5
>> +#define TEE_OP_PARAM_TYPE_MEMREF_OUTPUT         6
>> +#define TEE_OP_PARAM_TYPE_MEMREF_INOUT          7
> 
> These are the same as TEE_IOCTL_PARAM_ATTR_TYPE_* in include/uapi/linux/tee.h
> except that TEE_OP_PARAM_TYPE_INVALID is added. The latter is not defined in
> the GP spec.
> 

We added TEE_OP_PARAM_TYPE_INVALID to avoid magic numbers in code. The rest are,
as you said, based on GP spec.

Do you want us to use the macros (TEE_IOCTL_PARAM_ATTR_TYPE_*) defined in
include/uapi/linux/tee.h instead of redefining them?

>> +
>> +#define TEE_PARAM_TYPE_GET(t, i)        (((t) >> ((i) * 4)) & 0xF)
>> +#define TEE_PARAM_TYPES(t0, t1, t2, t3) \
>> +	((t0) | ((t1) << 4) | ((t2) << 8) | ((t3) << 12))
>> +
>> +/*****************************************************************************
>> + ** TEE Commands
>> + *****************************************************************************/
>> +
>> +/*
>> + * The shared memory between rich world and secure world may be physically
>> + * non-contiguous. Below structures are meant to describe a shared memory region
>> + * via scatter/gather (sg) list
>> + */
>> +
>> +/**
>> + * struct tee_sg_desc - sg descriptor for a physically contiguous buffer
>> + * @low_addr: [in] bits[31:0] of buffer's physical address. Must be 4KB aligned
>> + * @hi_addr:  [in] bits[63:32] of the buffer's physical address
>> + * @size:     [in] size in bytes (must be multiple of 4KB)
>> + */
>> +struct tee_sg_desc {
>> +	u32 low_addr;
>> +	u32 hi_addr;
>> +	u32 size;
>> +};
>> +
>> +/**
>> + * struct tee_sg_list - structure describing a scatter/gather list
>> + * @count:   [in] number of sg descriptors
>> + * @size:    [in] total size of all buffers in the list. Must be multiple of 4KB
>> + * @buf:     [in] list of sg buffer descriptors
>> + */
>> +#define TEE_MAX_SG_DESC 64
>> +struct tee_sg_list {
>> +	u32 count;
>> +	u32 size;
>> +	struct tee_sg_desc buf[TEE_MAX_SG_DESC];
>> +};
>> +
>> +/**
>> + * struct tee_cmd_map_shared_mem - command to map shared memory
>> + * @buf_id:    [out] return buffer ID value
>> + * @sg_list:   [in] list describing memory to be mapped
>> + */
>> +struct tee_cmd_map_shared_mem {
>> +	u32 buf_id;
>> +	struct tee_sg_list sg_list;
>> +};
>> +
>> +/**
>> + * struct tee_cmd_unmap_shared_mem - command to unmap shared memory
>> + * @buf_id:    [in] buffer ID of memory to be unmapped
>> + */
>> +struct tee_cmd_unmap_shared_mem {
>> +	u32 buf_id;
>> +};
>> +
>> +/**
>> + * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
>> + * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
>> + * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
>> + * @size:        [in] size of TA binary in bytes
>> + * @ta_handle:   [out] return handle of the loaded TA
>> + */
>> +struct tee_cmd_load_ta {
>> +	u32 low_addr;
>> +	u32 hi_addr;
>> +	u32 size;
>> +	u32 ta_handle;
>> +};
>> +
>> +/**
>> + * struct tee_cmd_unload_ta - command to unload TA binary from TEE environment
>> + * @ta_handle:    [in] handle of the loaded TA to be unloaded
>> + */
>> +struct tee_cmd_unload_ta {
>> +	u32 ta_handle;
>> +};
>> +
>> +/**
>> + * struct tee_cmd_open_session - command to call TA_OpenSessionEntryPoint in TA
>> + * @ta_handle:      [in] handle of the loaded TA
>> + * @session_info:   [out] pointer to TA allocated session data
>> + * @op:             [in/out] operation parameters
>> + * @return_origin:  [out] origin of return code after TEE processing
>> + */
>> +struct tee_cmd_open_session {
>> +	u32 ta_handle;
>> +	u32 session_info;
>> +	struct tee_operation op;
>> +	u32 return_origin;
>> +};
>> +
>> +/**
>> + * struct tee_cmd_close_session - command to call TA_CloseSessionEntryPoint()
>> + *                                in TA
>> + * @ta_handle:      [in] handle of the loaded TA
>> + * @session_info:   [in] pointer to TA allocated session data
>> + */
>> +struct tee_cmd_close_session {
>> +	u32 ta_handle;
>> +	u32 session_info;
>> +};
>> +
>> +/**
>> + * struct tee_cmd_invoke_cmd - command to call TA_InvokeCommandEntryPoint() in
>> + *                             TA
>> + * @ta_handle:     [in] handle of the loaded TA
>> + * @cmd_id:        [in] TA command ID
>> + * @session_info:  [in] pointer to TA allocated session data
>> + * @op:            [in/out] operation parameters
>> + * @return_origin: [out] origin of return code after TEE processing
>> + */
>> +struct tee_cmd_invoke_cmd {
>> +	u32 ta_handle;
>> +	u32 cmd_id;
>> +	u32 session_info;
>> +	struct tee_operation op;
>> +	u32 return_origin;
>> +};
>> +
>> +#endif /*AMDTEE_IF_H*/
>> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
>> new file mode 100644
>> index 0000000..d7f798c
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/amdtee_private.h
>> @@ -0,0 +1,159 @@
>> +/* SPDX-License-Identifier: MIT */
>> +
>> +/*
>> + * Copyright 2019 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef AMDTEE_PRIVATE_H
>> +#define AMDTEE_PRIVATE_H
>> +
>> +#include <linux/mutex.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/kref.h>
>> +#include <linux/types.h>
>> +#include "amdtee_if.h"
>> +
>> +#define DRIVER_NAME	"amdtee"
>> +#define DRIVER_AUTHOR   "AMD-TEE Linux driver team"
>> +
>> +/* Some GlobalPlatform error codes used in this driver */
>> +#define TEEC_SUCCESS			0x00000000
>> +#define TEEC_ERROR_GENERIC		0xFFFF0000
>> +#define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
>> +#define TEEC_ERROR_COMMUNICATION	0xFFFF000E
>> +
>> +#define TEEC_ORIGIN_COMMS		0x00000002
>> +
>> +/* Maximum number of sessions which can be opened with a Trusted Application */
>> +#define TEE_NUM_SESSIONS			32
>> +
>> +#define TA_LOAD_PATH				"/amdtee"
>> +#define TA_PATH_MAX				60
>> +
>> +/**
>> + * struct amdtee - main service struct
>> + * @teedev:		client device
>> + * @pool:		shared memory pool
>> + */
>> +struct amdtee {
>> +	struct tee_device *teedev;
>> +	struct tee_shm_pool *pool;
>> +};
>> +
>> +/**
>> + * struct amdtee_session - Trusted Application (TA) session related information.
>> + * @ta_handle:     handle to Trusted Application (TA) loaded in TEE environment
>> + * @refcount:      counter to keep track of sessions opened for the TA instance
>> + * @session_info:  an array pointing to TA allocated session data.
>> + * @sess_mask:     session usage bit-mask. If a particular bit is set, then the
>> + *                 corresponding @session_info entry is in use or valid.
>> + *
>> + * Session structure is updated on open_session and this information is used for
>> + * subsequent operations with the Trusted Application.
>> + */
>> +struct amdtee_session {
>> +	struct list_head list_node;
>> +	u32 ta_handle;
>> +	struct kref refcount;
>> +	u32 session_info[TEE_NUM_SESSIONS];
>> +	DECLARE_BITMAP(sess_mask, TEE_NUM_SESSIONS);
>> +	spinlock_t lock;	/* synchronizes access to @sess_mask */
>> +};
>> +
>> +/**
>> + * struct amdtee_context_data - AMD-TEE driver context data
>> + * @sess_list:    Keeps track of sessions opened in current TEE context
>> + */
>> +struct amdtee_context_data {
>> +	struct list_head sess_list;
>> +};
>> +
>> +struct amdtee_driver_data {
>> +	struct amdtee *amdtee;
>> +};
>> +
>> +struct shmem_desc {
>> +	void *kaddr;
>> +	u64 size;
>> +};
>> +
>> +/**
>> + * struct amdtee_shm_data - Shared memory data
>> + * @kaddr:	Kernel virtual address of shared memory
>> + * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
>> + */
>> +struct amdtee_shm_data {
>> +	struct  list_head shm_node;
>> +	void    *kaddr;
>> +	u32     buf_id;
>> +};
>> +
>> +struct amdtee_shm_context {
>> +	struct list_head shmdata_list;
>> +};
>> +
>> +#define LOWER_TWO_BYTE_MASK	0x0000FFFF
>> +
>> +/**
>> + * set_session_id() - Sets the session identifier.
>> + * @ta_handle:      [in] handle of the loaded Trusted Application (TA)
>> + * @session_index:  [in] Session index. Range: 0 to (TEE_NUM_SESSIONS - 1).
>> + * @session:        [out] Pointer to session id
>> + *
>> + * Lower two bytes of the session identifier represents the TA handle and the
>> + * upper two bytes is session index.
>> + */
>> +static inline void set_session_id(u32 ta_handle, u32 session_index,
>> +				  u32 *session)
>> +{
>> +	*session = (session_index << 16) | (LOWER_TWO_BYTE_MASK & ta_handle);
>> +}
>> +
>> +static inline u32 get_ta_handle(u32 session)
>> +{
>> +	return session & LOWER_TWO_BYTE_MASK;
>> +}
>> +
>> +static inline u32 get_session_index(u32 session)
>> +{
>> +	return (session >> 16) & LOWER_TWO_BYTE_MASK;
>> +}
>> +
>> +int amdtee_open_session(struct tee_context *ctx,
>> +			struct tee_ioctl_open_session_arg *arg,
>> +			struct tee_param *param);
>> +
>> +int amdtee_close_session(struct tee_context *ctx, u32 session);
>> +
>> +int amdtee_invoke_func(struct tee_context *ctx,
>> +		       struct tee_ioctl_invoke_arg *arg,
>> +		       struct tee_param *param);
>> +
>> +int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>> +
>> +int amdtee_map_shmem(struct tee_shm *shm);
>> +
>> +void amdtee_unmap_shmem(struct tee_shm *shm);
>> +
>> +int handle_load_ta(void *data, u32 size,
>> +		   struct tee_ioctl_open_session_arg *arg);
>> +
>> +int handle_unload_ta(u32 ta_handle);
>> +
>> +int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
>> +			struct tee_param *p);
>> +
>> +int handle_close_session(u32 ta_handle, u32 info);
>> +
>> +int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id);
>> +
>> +void handle_unmap_shmem(u32 buf_id);
>> +
>> +int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
>> +		      struct tee_param *p);
>> +
>> +struct tee_shm_pool *amdtee_config_shm(void);
>> +
>> +u32 get_buffer_id(struct tee_shm *shm);
>> +#endif /*AMDTEE_PRIVATE_H*/
>> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
>> new file mode 100644
>> index 0000000..e87b0d1
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/call.c
>> @@ -0,0 +1,370 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2019 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/tee.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/psp-tee.h>
>> +#include <linux/slab.h>
>> +#include <linux/psp-sev.h>
>> +#include "../tee_private.h"
>> +#include "amdtee_if.h"
>> +#include "amdtee_private.h"
>> +
>> +static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
>> +				    struct tee_operation *amd)
>> +{
>> +	int i, ret = 0;
>> +	u32 type;
>> +
>> +	if (!count)
>> +		return 0;
>> +
>> +	if (!tee || !amd || count > TEE_MAX_PARAMS)
>> +		return -EINVAL;
>> +
>> +	amd->param_types = 0;
>> +	for (i = 0; i < count; i++)
>> +		amd->param_types |= ((tee[i].attr & 0xF) << i * 4);
> 
> tee[i].attr holds values defined by TEE_IOCTL_PARAM_ATTR_* in
> include/uapi/linux/tee.h so it can currently be 9 bits wide, by masking
> out the lower 4 bits you accept some invalid values
> 

Agreed, with 9 bits wide attribute value, current code will not work as
expected. I shall correct this in next patch revision.

>> +
>> +	for (i = 0; i < count; i++) {
>> +		type = TEE_PARAM_TYPE_GET(amd->param_types, i);
>> +		pr_debug("%s: type[%d] = 0x%x\n", __func__, i, type);
>> +
>> +		if (type == TEE_OP_PARAM_TYPE_INVALID ||
>> +		    type > TEE_OP_PARAM_TYPE_MEMREF_INOUT)
>> +			return -EINVAL;
>> +
>> +		if (type == TEE_OP_PARAM_TYPE_NONE)
>> +			continue;
>> +
>> +		/* It is assumed that all values are within 2^32-1 */
>> +		if (type > TEE_OP_PARAM_TYPE_VALUE_INOUT) {
>> +			u32 buf_id = get_buffer_id(tee[i].u.memref.shm);
>> +
>> +			amd->params[i].mref.buf_id = buf_id;
>> +			amd->params[i].mref.offset = tee[i].u.memref.shm_offs;
>> +			amd->params[i].mref.size = tee[i].u.memref.size;
>> +			pr_debug("%s: bufid[%d] = 0x%x, offset[%d] = 0x%x, size[%d] = 0x%x\n",
>> +				 __func__,
>> +				 i, amd->params[i].mref.buf_id,
>> +				 i, amd->params[i].mref.offset,
>> +				 i, amd->params[i].mref.size);
>> +		} else {
>> +			if (tee[i].u.value.c)
>> +				pr_warn("%s: Discarding value c", __func__);
>> +
>> +			amd->params[i].val.a = tee[i].u.value.a;
>> +			amd->params[i].val.b = tee[i].u.value.b;
>> +			pr_debug("%s: a[%d] = 0x%x, b[%d] = 0x%x\n", __func__,
>> +				 i, amd->params[i].val.a,
>> +				 i, amd->params[i].val.b);
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
>> +				    struct tee_operation *amd)
>> +{
>> +	int i, ret = 0;
>> +	u32 type;
>> +
>> +	if (!count)
>> +		return 0;
>> +
>> +	if (!tee || !amd || count > TEE_MAX_PARAMS)
>> +		return -EINVAL;
>> +
>> +	/* Assumes amd->param_types is valid */
>> +	for (i = 0; i < count; i++) {
>> +		type = TEE_PARAM_TYPE_GET(amd->param_types, i);
>> +		pr_debug("%s: type[%d] = 0x%x\n", __func__, i, type);
>> +
>> +		if (type == TEE_OP_PARAM_TYPE_INVALID ||
>> +		    type > TEE_OP_PARAM_TYPE_MEMREF_INOUT)
>> +			return -EINVAL;
>> +
>> +		if (type == TEE_OP_PARAM_TYPE_NONE ||
>> +		    type == TEE_OP_PARAM_TYPE_VALUE_INPUT ||
>> +		    type == TEE_OP_PARAM_TYPE_MEMREF_INPUT)
>> +			continue;
>> +
>> +		/*
>> +		 * It is assumed that buf_id remains unchanged for
>> +		 * both open_session and invoke_cmd call
>> +		 */
>> +		if (type > TEE_OP_PARAM_TYPE_MEMREF_INPUT) {
>> +			tee[i].u.memref.shm_offs = amd->params[i].mref.offset;
>> +			tee[i].u.memref.size = amd->params[i].mref.size;
>> +			pr_debug("%s: bufid[%d] = 0x%x, offset[%d] = 0x%x, size[%d] = 0x%x\n",
>> +				 __func__,
>> +				 i, amd->params[i].mref.buf_id,
>> +				 i, amd->params[i].mref.offset,
>> +				 i, amd->params[i].mref.size);
>> +		} else {
>> +			/* field 'c' not supported by AMD */
>> +			tee[i].u.value.a = amd->params[i].val.a;
>> +			tee[i].u.value.b = amd->params[i].val.b;
>> +			tee[i].u.value.c = 0;
>> +			pr_debug("%s: a[%d] = 0x%x, b[%d] = 0x%x\n",
>> +				 __func__,
>> +				 i, amd->params[i].val.a,
>> +				 i, amd->params[i].val.b);
>> +		}
>> +	}
>> +	return ret;
>> +}
>> +
>> +int handle_unload_ta(u32 ta_handle)
>> +{
>> +	struct tee_cmd_unload_ta cmd = {0};
>> +	int ret = 0;
>> +	u32 status;
>> +
>> +	if (!ta_handle)
>> +		return -EINVAL;
>> +
>> +	cmd.ta_handle = ta_handle;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
>> +				  sizeof(cmd), &status);
>> +	if (!ret && status != 0) {
>> +		pr_err("unload ta: status = 0x%x\n", status);
>> +		ret = -EBUSY;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int handle_close_session(u32 ta_handle, u32 info)
>> +{
>> +	struct tee_cmd_close_session cmd = {0};
>> +	int ret = 0;
>> +	u32 status;
>> +
>> +	if (ta_handle == 0)
>> +		return -EINVAL;
>> +
>> +	cmd.ta_handle = ta_handle;
>> +	cmd.session_info = info;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_CLOSE_SESSION, (void *)&cmd,
>> +				  sizeof(cmd), &status);
>> +	if (!ret && status != 0) {
>> +		pr_err("close session: status = 0x%x\n", status);
>> +		ret = -EBUSY;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +void handle_unmap_shmem(u32 buf_id)
>> +{
>> +	struct tee_cmd_unmap_shared_mem cmd = {0};
>> +	int ret = 0;
>> +	u32 status;
>> +
>> +	cmd.buf_id = buf_id;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_UNMAP_SHARED_MEM, (void *)&cmd,
>> +				  sizeof(cmd), &status);
>> +	if (!ret)
>> +		pr_debug("unmap shared memory: buf_id %u status = 0x%x\n",
>> +			 buf_id, status);
>> +}
>> +
>> +int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
>> +		      struct tee_param *p)
>> +{
>> +	struct tee_cmd_invoke_cmd cmd = {0};
>> +	int ret = 0;
>> +
>> +	if (!arg || (!p && arg->num_params))
>> +		return -EINVAL;
>> +
>> +	arg->ret_origin = TEEC_ORIGIN_COMMS;
>> +
>> +	if (arg->session == 0) {
>> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = tee_params_to_amd_params(p, arg->num_params, &cmd.op);
>> +	if (ret) {
>> +		pr_err("invalid Params. Abort invoke command\n");
>> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>> +		return ret;
>> +	}
>> +
>> +	cmd.ta_handle = get_ta_handle(arg->session);
>> +	cmd.cmd_id = arg->func;
>> +	cmd.session_info = sinfo;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_INVOKE_CMD, (void *)&cmd,
>> +				  sizeof(cmd), &arg->ret);
>> +	if (ret) {
>> +		arg->ret = TEEC_ERROR_COMMUNICATION;
>> +	} else {
>> +		ret = amd_params_to_tee_params(p, arg->num_params, &cmd.op);
>> +		if (unlikely(ret)) {
>> +			pr_err("invoke command: failed to copy output\n");
>> +			arg->ret = TEEC_ERROR_GENERIC;
>> +			return ret;
>> +		}
>> +		arg->ret_origin = cmd.return_origin;
>> +		pr_debug("invoke command: RO = 0x%x ret = 0x%x\n",
>> +			 arg->ret_origin, arg->ret);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id)
>> +{
>> +	struct tee_cmd_map_shared_mem *cmd;
>> +	phys_addr_t paddr;
>> +	int ret = 0, i;
>> +	u32 status;
>> +
>> +	if (!count || !start || !buf_id)
>> +		return -EINVAL;
>> +
>> +	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
>> +	if (!cmd)
>> +		return -ENOMEM;
>> +
>> +	/* Size must be page aligned */
>> +	for (i = 0; i < count ; i++) {
>> +		if (!start[i].kaddr || (start[i].size & (PAGE_SIZE - 1))) {
>> +			ret = -EINVAL;
>> +			goto free_cmd;
>> +		}
>> +
>> +		if ((u64)start[i].kaddr & (PAGE_SIZE - 1)) {
>> +			pr_err("map shared memory: page unaligned. addr 0x%llx",
>> +			       (u64)start[i].kaddr);
>> +			ret = -EINVAL;
>> +			goto free_cmd;
>> +		}
>> +	}
>> +
>> +	cmd->sg_list.count = count;
>> +
>> +	/* Create buffer list */
>> +	for (i = 0; i < count ; i++) {
>> +		paddr = __psp_pa(start[i].kaddr);
>> +		cmd->sg_list.buf[i].hi_addr = upper_32_bits(paddr);
>> +		cmd->sg_list.buf[i].low_addr = lower_32_bits(paddr);
>> +		cmd->sg_list.buf[i].size = start[i].size;
>> +		cmd->sg_list.size += cmd->sg_list.buf[i].size;
>> +
>> +		pr_debug("buf[%d]:hi addr = 0x%x\n", i,
>> +			 cmd->sg_list.buf[i].hi_addr);
>> +		pr_debug("buf[%d]:low addr = 0x%x\n", i,
>> +			 cmd->sg_list.buf[i].low_addr);
>> +		pr_debug("buf[%d]:size = 0x%x\n", i, cmd->sg_list.buf[i].size);
>> +		pr_debug("list size = 0x%x\n", cmd->sg_list.size);
>> +	}
>> +
>> +	*buf_id = 0;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_MAP_SHARED_MEM, (void *)cmd,
>> +				  sizeof(*cmd), &status);
>> +	if (!ret && !status) {
>> +		*buf_id = cmd->buf_id;
>> +		pr_debug("mapped buffer ID = 0x%x\n", *buf_id);
>> +	} else {
>> +		pr_err("map shared memory: status = 0x%x\n", status);
>> +		ret = -ENOMEM;
>> +	}
>> +
>> +free_cmd:
>> +	kfree(cmd);
>> +
>> +	return ret;
>> +}
>> +
>> +int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
>> +			struct tee_param *p)
>> +{
>> +	struct tee_cmd_open_session cmd = {0};
>> +	int ret = 0;
>> +
>> +	if (!arg || !info || (!p && arg->num_params))
>> +		return -EINVAL;
>> +
>> +	arg->ret_origin = TEEC_ORIGIN_COMMS;
>> +
>> +	if (arg->session == 0) {
>> +		arg->ret = TEEC_ERROR_GENERIC;
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = tee_params_to_amd_params(p, arg->num_params, &cmd.op);
>> +	if (ret) {
>> +		pr_err("invalid Params. Abort open session\n");
>> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>> +		return ret;
>> +	}
>> +
>> +	cmd.ta_handle = get_ta_handle(arg->session);
>> +	*info = 0;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_OPEN_SESSION, (void *)&cmd,
>> +				  sizeof(cmd), &arg->ret);
>> +	if (ret) {
>> +		arg->ret = TEEC_ERROR_COMMUNICATION;
>> +	} else {
>> +		ret = amd_params_to_tee_params(p, arg->num_params, &cmd.op);
>> +		if (unlikely(ret)) {
>> +			pr_err("open session: failed to copy output\n");
>> +			arg->ret = TEEC_ERROR_GENERIC;
>> +			return ret;
>> +		}
>> +		arg->ret_origin = cmd.return_origin;
>> +		*info = cmd.session_info;
>> +		pr_debug("open session: session info = 0x%x\n", *info);
>> +	}
>> +
>> +	pr_debug("open session: ret = 0x%x RO = 0x%x\n", arg->ret,
>> +		 arg->ret_origin);
>> +
>> +	return ret;
>> +}
>> +
>> +int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>> +{
>> +	struct tee_cmd_load_ta cmd = {0};
>> +	phys_addr_t blob;
>> +	int ret = 0;
>> +
>> +	if (size == 0 || !data || !arg)
>> +		return -EINVAL;
>> +
>> +	blob = __psp_pa(data);
>> +	if (blob & (PAGE_SIZE - 1)) {
>> +		pr_err("load TA: page unaligned. blob 0x%llx", blob);
>> +		return -EINVAL;
>> +	}
>> +
>> +	cmd.hi_addr = upper_32_bits(blob);
>> +	cmd.low_addr = lower_32_bits(blob);
>> +	cmd.size = size;
>> +
>> +	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
>> +				  sizeof(cmd), &arg->ret);
>> +	if (ret) {
>> +		arg->ret_origin = TEEC_ORIGIN_COMMS;
>> +		arg->ret = TEEC_ERROR_COMMUNICATION;
>> +	} else {
>> +		set_session_id(cmd.ta_handle, 0, &arg->session);
>> +	}
>> +
>> +	pr_debug("load TA: TA handle = 0x%x, RO = 0x%x, ret = 0x%x\n",
>> +		 cmd.ta_handle, arg->ret_origin, arg->ret);
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
>> new file mode 100644
>> index 0000000..b184463
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/core.c
>> @@ -0,0 +1,510 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2019 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/device.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/firmware.h>
>> +#include "amdtee_private.h"
>> +#include "../tee_private.h"
>> +
>> +static struct amdtee_driver_data *drv_data;
>> +static DEFINE_MUTEX(session_list_mutex);
>> +struct amdtee_shm_context shmctx;
>> +
>> +static void amdtee_get_version(struct tee_device *teedev,
>> +			       struct tee_ioctl_version_data *vers)
>> +{
>> +	struct tee_ioctl_version_data v = {
>> +		.impl_id = TEE_IMPL_ID_AMDTEE,
>> +		.impl_caps = 0,
>> +		.gen_caps = TEE_GEN_CAP_GP,
>> +	};
>> +	*vers = v;
>> +}
>> +
>> +static int amdtee_open(struct tee_context *ctx)
>> +{
>> +	struct amdtee_context_data *ctxdata;
>> +
>> +	ctxdata = kzalloc(sizeof(*ctxdata), GFP_KERNEL);
>> +	if (!ctxdata)
>> +		return -ENOMEM;
>> +
>> +	INIT_LIST_HEAD(&ctxdata->sess_list);
>> +	INIT_LIST_HEAD(&shmctx.shmdata_list);
>> +
>> +	ctx->data = ctxdata;
>> +	return 0;
>> +}
>> +
>> +static void release_session(struct amdtee_session *sess)
>> +{
>> +	int i = 0;
>> +
>> +	/* Close any open session */
>> +	for (i = 0; i < TEE_NUM_SESSIONS; ++i) {
>> +		/* Check if session entry 'i' is valid */
>> +		if (!test_bit(i, sess->sess_mask))
>> +			continue;
>> +
>> +		handle_close_session(sess->ta_handle, sess->session_info[i]);
>> +	}
>> +
>> +	/* Unload Trusted Application once all sessions are closed */
>> +	handle_unload_ta(sess->ta_handle);
>> +	kfree(sess);
>> +}
>> +
>> +static void amdtee_release(struct tee_context *ctx)
>> +{
>> +	struct amdtee_context_data *ctxdata = ctx->data;
>> +
>> +	if (!ctxdata)
>> +		return;
>> +
>> +	while (true) {
>> +		struct amdtee_session *sess;
>> +
>> +		sess = list_first_entry_or_null(&ctxdata->sess_list,
>> +						struct amdtee_session,
>> +						list_node);
>> +
>> +		if (!sess)
>> +			break;
>> +
>> +		list_del(&sess->list_node);
>> +		release_session(sess);
>> +	}
>> +	kfree(ctxdata);
>> +
>> +	ctx->data = NULL;
>> +}
>> +
>> +/**
>> + * alloc_session() - Allocate a session structure
>> + * @ctxdata:    TEE Context data structure
>> + * @session:    Session ID for which 'struct amdtee_session' structure is to be
>> + *              allocated.
>> + *
>> + * Scans the TEE context's session list to check if TA is already loaded in to
>> + * TEE. If yes, returns the 'session' structure for that TA. Else allocates,
>> + * initializes a new 'session' structure and adds it to context's session list.
>> + *
>> + * The caller must hold a mutex.
>> + *
>> + * Returns:
>> + * 'struct amdtee_session *' on success and NULL on failure.
>> + */
>> +static struct amdtee_session *alloc_session(struct amdtee_context_data *ctxdata,
>> +					    u32 session)
>> +{
>> +	struct amdtee_session *sess;
>> +	u32 ta_handle = get_ta_handle(session);
>> +
>> +	/* Scan session list to check if TA is already loaded in to TEE */
>> +	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
>> +		if (sess->ta_handle == ta_handle) {
>> +			kref_get(&sess->refcount);
>> +			return sess;
>> +		}
>> +
>> +	/* Allocate a new session and add to list */
>> +	sess = kzalloc(sizeof(*sess), GFP_KERNEL);
>> +	if (sess) {
>> +		sess->ta_handle = ta_handle;
>> +		kref_init(&sess->refcount);
>> +		spin_lock_init(&sess->lock);
>> +		list_add(&sess->list_node, &ctxdata->sess_list);
>> +	}
>> +
>> +	return sess;
>> +}
>> +
>> +/* Requires mutex to be held */
>> +static struct amdtee_session *find_session(struct amdtee_context_data *ctxdata,
>> +					   u32 session)
>> +{
>> +	u32 ta_handle = get_ta_handle(session);
>> +	u32 index = get_session_index(session);
>> +	struct amdtee_session *sess;
>> +
>> +	list_for_each_entry(sess, &ctxdata->sess_list, list_node)
>> +		if (ta_handle == sess->ta_handle &&
>> +		    test_bit(index, sess->sess_mask))
>> +			return sess;
>> +
>> +	return NULL;
>> +}
>> +
>> +u32 get_buffer_id(struct tee_shm *shm)
>> +{
>> +	u32 buf_id = 0;
>> +	struct amdtee_shm_data *shmdata;
>> +
>> +	list_for_each_entry(shmdata, &shmctx.shmdata_list, shm_node)
>> +		if (shmdata->kaddr == shm->kaddr) {
>> +			buf_id = shmdata->buf_id;
>> +			break;
>> +		}
>> +
>> +	return buf_id;
>> +}
>> +
>> +static DEFINE_MUTEX(drv_mutex);
>> +static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
>> +			  size_t *ta_size)
>> +{
>> +	const struct firmware *fw;
>> +	char fw_name[TA_PATH_MAX];
>> +	struct {
>> +		u32 lo;
>> +		u16 mid;
>> +		u16 hi_ver;
>> +		u8 seq_n[8];
>> +	} *uuid = ptr;
>> +	int n = 0, rc = 0;
>> +
>> +	n = snprintf(fw_name, TA_PATH_MAX,
>> +		     "%s/%08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.bin",
>> +		     TA_LOAD_PATH, uuid->lo, uuid->mid, uuid->hi_ver,
>> +		     uuid->seq_n[0], uuid->seq_n[1],
>> +		     uuid->seq_n[2], uuid->seq_n[3],
>> +		     uuid->seq_n[4], uuid->seq_n[5],
>> +		     uuid->seq_n[6], uuid->seq_n[7]);
>> +	if (n < 0 || n >= TA_PATH_MAX) {
>> +		pr_err("failed to get firmware name\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&drv_mutex);
>> +	n = request_firmware(&fw, fw_name, &ctx->teedev->dev);
>> +	if (n) {
>> +		pr_err("failed to load firmware %s\n", fw_name);
>> +		rc = -ENOMEM;
>> +		goto unlock;
>> +	}
>> +
>> +	*ta_size = roundup(fw->size, PAGE_SIZE);
>> +	*ta = (void *)__get_free_pages(GFP_KERNEL, get_order(*ta_size));
>> +	if (IS_ERR(*ta)) {
>> +		pr_err("%s: get_free_pages failed 0x%llx\n", __func__,
>> +		       (u64)*ta);
>> +		rc = -ENOMEM;
>> +		goto rel_fw;
>> +	}
>> +
>> +	memcpy(*ta, fw->data, fw->size);
>> +rel_fw:
>> +	release_firmware(fw);
>> +unlock:
>> +	mutex_unlock(&drv_mutex);
>> +	return rc;
>> +}
>> +
>> +int amdtee_open_session(struct tee_context *ctx,
>> +			struct tee_ioctl_open_session_arg *arg,
>> +			struct tee_param *param)
>> +{
>> +	struct amdtee_context_data *ctxdata = ctx->data;
>> +	struct amdtee_session *sess = NULL;
>> +	u32 session_info;
>> +	void *ta = NULL;
>> +	size_t ta_size;
>> +	int rc = 0, i;
>> +
>> +	if (arg->clnt_login != TEE_IOCTL_LOGIN_PUBLIC) {
>> +		pr_err("unsupported client login method\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = copy_ta_binary(ctx, &arg->uuid[0], &ta, &ta_size);
>> +	if (rc) {
>> +		pr_err("failed to copy TA binary\n");
>> +		return rc;
>> +	}
>> +
>> +	/* Load the TA binary into TEE environment */
>> +	handle_load_ta(ta, ta_size, arg);
>> +	if (arg->ret == TEEC_SUCCESS) {
>> +		mutex_lock(&session_list_mutex);
>> +		sess = alloc_session(ctxdata, arg->session);
>> +		mutex_unlock(&session_list_mutex);
>> +	}
>> +
>> +	if (arg->ret != TEEC_SUCCESS)
>> +		goto out;
>> +
>> +	if (!sess) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	/* Find an empty session index for the given TA */
>> +	spin_lock(&sess->lock);
>> +	i = find_first_zero_bit(sess->sess_mask, TEE_NUM_SESSIONS);
>> +	if (i < TEE_NUM_SESSIONS)
>> +		set_bit(i, sess->sess_mask);
>> +	spin_unlock(&sess->lock);
>> +
>> +	if (i >= TEE_NUM_SESSIONS) {
>> +		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	/* Open session with loaded TA */
>> +	handle_open_session(arg, &session_info, param);
>> +
>> +	if (arg->ret == TEEC_SUCCESS) {
>> +		sess->session_info[i] = session_info;
>> +		set_session_id(sess->ta_handle, i, &arg->session);
>> +	} else {
>> +		pr_err("open_session failed %d\n", arg->ret);
>> +		spin_lock(&sess->lock);
>> +		clear_bit(i, sess->sess_mask);
>> +		spin_unlock(&sess->lock);
>> +	}
>> +out:
>> +	free_pages((u64)ta, get_order(ta_size));
>> +	return rc;
>> +}
>> +
>> +static void destroy_session(struct kref *ref)
>> +{
>> +	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
>> +						   refcount);
>> +
>> +	/* Unload the TA from TEE */
>> +	handle_unload_ta(sess->ta_handle);
>> +	mutex_lock(&session_list_mutex);
>> +	list_del(&sess->list_node);
>> +	mutex_unlock(&session_list_mutex);
>> +	kfree(sess);
>> +}
>> +
>> +int amdtee_close_session(struct tee_context *ctx, u32 session)
>> +{
>> +	struct amdtee_context_data *ctxdata = ctx->data;
>> +	u32 i, ta_handle, session_info;
>> +	struct amdtee_session *sess;
>> +
>> +	pr_debug("%s: sid = 0x%x\n", __func__, session);
>> +
>> +	/*
>> +	 * Check that the session is valid and clear the session
>> +	 * usage bit
>> +	 */
>> +	mutex_lock(&session_list_mutex);
>> +	sess = find_session(ctxdata, session);
>> +	if (sess) {
>> +		ta_handle = get_ta_handle(session);
>> +		i = get_session_index(session);
>> +		session_info = sess->session_info[i];
>> +		spin_lock(&sess->lock);
>> +		clear_bit(i, sess->sess_mask);
>> +		spin_unlock(&sess->lock);
>> +	}
>> +	mutex_unlock(&session_list_mutex);
>> +
>> +	if (!sess)
>> +		return -EINVAL;
>> +
>> +	/* Close the session */
>> +	handle_close_session(ta_handle, session_info);
>> +
>> +	kref_put(&sess->refcount, destroy_session);
>> +
>> +	return 0;
>> +}
>> +
>> +int amdtee_map_shmem(struct tee_shm *shm)
>> +{
>> +	struct shmem_desc shmem;
>> +	struct amdtee_shm_data *shmnode;
>> +	int rc, count;
>> +	u32 buf_id;
>> +
>> +	if (!shm)
>> +		return -EINVAL;
>> +
>> +	shmnode = kmalloc(sizeof(*shmnode), GFP_KERNEL);
>> +	if (!shmnode)
>> +		return -ENOMEM;
>> +
>> +	count = 1;
>> +	shmem.kaddr = shm->kaddr;
>> +	shmem.size = shm->size;
>> +
>> +	/*
>> +	 * Send a MAP command to TEE and get the corresponding
>> +	 * buffer Id
>> +	 */
>> +	rc = handle_map_shmem(count, &shmem, &buf_id);
>> +	if (rc) {
>> +		pr_err("map_shmem failed: ret = %d\n", rc);
>> +		kfree(shmnode);
>> +		return rc;
>> +	}
>> +
>> +	shmnode->kaddr = shm->kaddr;
>> +	shmnode->buf_id = buf_id;
>> +	list_add(&shmnode->shm_node, &shmctx.shmdata_list);
>> +
>> +	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
>> +
>> +	return 0;
>> +}
>> +
>> +void amdtee_unmap_shmem(struct tee_shm *shm)
>> +{
>> +	u32 buf_id;
>> +	struct amdtee_shm_data *shmnode = NULL;
>> +
>> +	if (!shm)
>> +		return;
>> +
>> +	buf_id = get_buffer_id(shm);
>> +	/* Unmap the shared memory from TEE */
>> +	handle_unmap_shmem(buf_id);
>> +
>> +	list_for_each_entry(shmnode, &shmctx.shmdata_list, shm_node)
>> +		if (buf_id == shmnode->buf_id) {
>> +			list_del(&shmnode->shm_node);
>> +			kfree(shmnode);
>> +			break;
>> +		}
>> +}
>> +
>> +int amdtee_invoke_func(struct tee_context *ctx,
>> +		       struct tee_ioctl_invoke_arg *arg,
>> +		       struct tee_param *param)
>> +{
>> +	struct amdtee_context_data *ctxdata = ctx->data;
>> +	struct amdtee_session *sess;
>> +	u32 i, session_info;
>> +
>> +	/* Check that the session is valid */
>> +	mutex_lock(&session_list_mutex);
>> +	sess = find_session(ctxdata, arg->session);
>> +	if (sess) {
>> +		i = get_session_index(arg->session);
>> +		session_info = sess->session_info[i];
>> +	}
>> +	mutex_unlock(&session_list_mutex);
>> +
>> +	if (!sess)
>> +		return -EINVAL;
>> +
>> +	handle_invoke_cmd(arg, session_info, param);
>> +
>> +	return 0;
>> +}
>> +
>> +int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
>> +{
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct tee_driver_ops amdtee_ops = {
>> +	.get_version = amdtee_get_version,
>> +	.open = amdtee_open,
>> +	.release = amdtee_release,
>> +	.open_session = amdtee_open_session,
>> +	.close_session = amdtee_close_session,
>> +	.invoke_func = amdtee_invoke_func,
>> +	.cancel_req = amdtee_cancel_req,
>> +};
>> +
>> +static const struct tee_desc amdtee_desc = {
>> +	.name = DRIVER_NAME "-clnt",
>> +	.ops = &amdtee_ops,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int __init amdtee_driver_init(void)
>> +{
>> +	struct amdtee *amdtee = NULL;
>> +	struct tee_device *teedev;
>> +	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
>> +	int rc;
> 
> It seems that this driver assumes that there's a TEE to talk to if this
> function is called. What is the expected behavoir if there's no TEE
> available?
> 

The expected behavior if there is no TEE is: amdtee_driver_init() should
fail with -ENODEV. The driver should check for the availability of TEE on
the platform before doing shared pool configuration followed by
tee_device_alloc() and tee_device_register().

I agree in the current design, the driver assumes that there is a TEE to
talk to. This will be fixed in next patch revision.

>> +
>> +	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
>> +	if (IS_ERR(drv_data))
>> +		return -ENOMEM;
>> +
>> +	amdtee = kzalloc(sizeof(*amdtee), GFP_KERNEL);
>> +	if (IS_ERR(amdtee)) {
>> +		rc = -ENOMEM;
>> +		goto err_kfree_drv_data;
>> +	}
>> +
>> +	pool = amdtee_config_shm();
>> +	if (IS_ERR(pool)) {
>> +		pr_err("shared pool configuration error\n");
>> +		rc = PTR_ERR(pool);
>> +		goto err_kfree_amdtee;
>> +	}
>> +
>> +	teedev = tee_device_alloc(&amdtee_desc, NULL, pool, amdtee);
>> +	if (IS_ERR(teedev)) {
>> +		rc = PTR_ERR(teedev);
>> +		goto err;
>> +	}
>> +	amdtee->teedev = teedev;
>> +
>> +	rc = tee_device_register(amdtee->teedev);
>> +	if (rc)
>> +		goto err;
>> +
>> +	amdtee->pool = pool;
>> +
>> +	drv_data->amdtee = amdtee;
>> +
>> +	pr_info("amd-tee driver initialization successful\n");
>> +	return 0;
>> +
>> +err:
>> +	tee_device_unregister(amdtee->teedev);
>> +	if (pool)
>> +		tee_shm_pool_free(pool);
>> +
>> +err_kfree_amdtee:
>> +	kfree(amdtee);
>> +
>> +err_kfree_drv_data:
>> +	kfree(drv_data);
>> +	drv_data = NULL;
>> +
>> +	pr_err("amd-tee driver initialization failed\n");
>> +	return rc;
>> +}
>> +module_init(amdtee_driver_init);
>> +
>> +static void __exit amdtee_driver_exit(void)
>> +{
>> +	struct amdtee *amdtee;
>> +
>> +	if (!drv_data || !drv_data->amdtee)
>> +		return;
>> +
>> +	amdtee = drv_data->amdtee;
>> +
>> +	tee_device_unregister(amdtee->teedev);
>> +	tee_shm_pool_free(amdtee->pool);
>> +}
>> +module_exit(amdtee_driver_exit);
>> +
>> +MODULE_AUTHOR(DRIVER_AUTHOR);
>> +MODULE_DESCRIPTION("AMD-TEE driver");
>> +MODULE_VERSION("1.0");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
>> new file mode 100644
>> index 0000000..10392d6
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/shm_pool.c
>> @@ -0,0 +1,130 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2019 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/slab.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/psp-sev.h>
>> +#include "../tee_private.h"
> 
> Drivers aren't supposed to need to include this file, if there's
> something needed by drivers we could consider moving that part to
> <linux/tee_drv.h>
> 

Sure, I will remove references to tee_private.h in driver code.
The driver needs access to : "struct device dev" member of "struct tee_device"
Can you please add a helper function to access this device structure?
The 'struct device dev' is passed as an argument to request_firmware().
Please refer file: drivers/tee/amdtee/core.c for usage.

>> +#include "amdtee_private.h"
>> +
>> +static int pool_op_alloc(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm,
>> +			 size_t size)
>> +{
>> +	unsigned long va;
>> +	int min_alloc_order = *(int *)poolm->private_data;
>> +	size_t s = roundup(size, 1 << min_alloc_order);
>> +	int rc;
>> +
>> +	va = __get_free_pages(GFP_KERNEL, get_order(s));
>> +	if (!va)
>> +		return -ENOMEM;
>> +
>> +	memset((void *)va, 0, s);
>> +	shm->kaddr = (void *)va;
>> +	shm->paddr = __psp_pa((void *)va);
>> +	shm->size = s;
>> +
>> +	/* Map the allocated memory in to TEE */
>> +	rc = amdtee_map_shmem(shm);
>> +	if (rc) {
>> +		free_pages(va, get_order(s));
>> +		shm->kaddr = NULL;
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void pool_op_free(struct tee_shm_pool_mgr *poolm, struct tee_shm *shm)
>> +{
>> +	/* Unmap the shared memory from TEE */
>> +	amdtee_unmap_shmem(shm);
>> +	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>> +	shm->kaddr = NULL;
>> +}
>> +
>> +static void pool_op_destroy_poolmgr(struct tee_shm_pool_mgr *poolm)
>> +{
>> +	if (poolm && poolm->private_data) {
>> +		kfree(poolm->private_data);
>> +		poolm->private_data = NULL;
>> +	}
>> +
>> +	kfree(poolm);
>> +}
>> +
>> +static const struct tee_shm_pool_mgr_ops pool_ops = {
>> +	.alloc = pool_op_alloc,
>> +	.free = pool_op_free,
>> +	.destroy_poolmgr = pool_op_destroy_poolmgr,
>> +};
>> +
>> +static int pool_mem_mgr_init(struct tee_shm_pool_mgr *mgr, int min_alloc_order)
>> +{
>> +	int *order;
>> +
>> +	order = kmalloc(sizeof(min_alloc_order), GFP_KERNEL);
>> +	if (!order)
>> +		return -ENOMEM;
>> +
>> +	*order = min_alloc_order;
>> +	mgr->private_data = order;
>> +	mgr->ops = &pool_ops;
>> +	return 0;
>> +}
>> +
>> +struct tee_shm_pool *amdtee_config_shm(void)
>> +{
>> +	struct tee_shm_pool *pool = NULL;
>> +	struct tee_shm_pool_mgr *priv_mgr;
>> +	struct tee_shm_pool_mgr *dmabuf_mgr;
>> +	int ret;
>> +
>> +	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> 
> Why isn't tee_shm_pool_alloc() used instead?
> 

That's a good question! 
tee_shm_pool_alloc() was not available initally, and was added later to tee subsystem.
I shall update the driver to use this API in my next patch revision.

>> +	if (!pool) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	priv_mgr = kzalloc(sizeof(*priv_mgr), GFP_KERNEL);
>> +	if (!priv_mgr) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	dmabuf_mgr = kzalloc(sizeof(*dmabuf_mgr), GFP_KERNEL);
>> +	if (!dmabuf_mgr) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	pool->private_mgr = priv_mgr;
>> +	pool->dma_buf_mgr = dmabuf_mgr;
>> +	/*
>> +	 * Initialize memory manager for driver private shared memory
>> +	 */
>> +	ret = pool_mem_mgr_init(pool->private_mgr, 3 /* 8 byte aligned */);
>> +	if (ret)
>> +		goto err;
>> +
>> +	/*
>> +	 * Initialize memory manager for dma_buf shared memory
>> +	 */
>> +	ret = pool_mem_mgr_init(pool->dma_buf_mgr, PAGE_SHIFT);
>> +	if (ret)
>> +		goto err;
>> +
>> +	return pool;
>> +err:
>> +	if (ret == -ENOMEM)
>> +		pr_err("%s: failed to configure shared memory pool\n",
>> +		       __func__);
>> +	if (pool && pool->private_mgr->private_data)
>> +		kfree(pool->private_mgr->private_data);
>> +	kfree(pool);
>> +	kfree(priv_mgr);
>> +	kfree(dmabuf_mgr);
>> +	return ERR_PTR(ret);
>> +}
>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>> index 4b9eb06..6596f3a 100644
>> --- a/include/uapi/linux/tee.h
>> +++ b/include/uapi/linux/tee.h
>> @@ -56,6 +56,7 @@
>>   * TEE Implementation ID
>>   */
>>  #define TEE_IMPL_ID_OPTEE	1
>> +#define TEE_IMPL_ID_AMDTEE	2
>>  
>>  /*
>>   * OP-TEE specific capabilities
>> -- 
>> 1.9.1
>>
> 
> Cheers,
> Jens
> 

Thanks,
Rijo
