Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70949206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KODiLK7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfLPNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:05:25 -0500
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:17288
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727553AbfLPNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:05:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVEZQv5AKz3Z3aBUq8+CLMMLDNWT3q9fJasdx/TsgekQped6XF/lKXAlQDozYHPjrQ20NxR9OVovGtljowbItHZiEiZRMpfoUQGnV8ETvjMcJwG6DbCfc7V5NjWPu1IKEEZ+s5Ya8sTjXR97cO0BdutaRGTl11C0CNiSMLLJQmlXqL5chz5Q2ck+h7tI+SOZUK+/Rts4Zi9G48EA5UUbIZGx3qa7GK/Qgo9pW5t3zongjZqsCLiPEyz3gZ88a5D3rF28jnL4E7VUL0YO3dJijE0TpTTPPs4t5nNQIrkmwPrXkQUcF4GzAiZYJYNB/m+TcYeLHgfZJdH1XORQ1UH3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miIx7Z4eQljjS+4PZaIIWDcLrkNwVAwcbXDtvrXsiWI=;
 b=KYNWeysV9Cak+eBEC6uAm+BvKzK9gC4+oGoHhJJoxoSE1gxY88pZF4C3+PmUATTOL0Ve9C67a1aqcV76VwRmP3fCjdqeL1V3K5L9XmsWNhi2CXv7r9qXEtInCb3VdjPND8fybVsnrBUuceCwf6F/vR/OZVM/hcoYz3SV/8X1A8AbdTLQyG0/7nYCawpCVgC/o+1A7lI9WejHrkER4iWuaIvGuEityViBTxWL5uqEEx8Tb1Qe/LhWvd/YJ2n1uf/hC7XDlm7avBVbTDArkq8ysshjPQBaPyVFe3NlZlZOAcEsk2lU+a8g/7ARycqXx/V+b2MO3EyIaJZ/0kJsHQc4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miIx7Z4eQljjS+4PZaIIWDcLrkNwVAwcbXDtvrXsiWI=;
 b=KODiLK7v/eb+3gRRi9nBnSogydT++Q7X10TEkZvCyHHAbAb5id1Jwn8WtYeL0vyQ7RBg3On1UTgQyOHYDDDtM/C3oerQnwMDB7aDNgDWXXMtqZd46MS8Tc4ut/dSxBnG1aMx3SBmzCO42CIFmTYZmdigEMbxCxTGLnVLn36P7IY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1413.namprd12.prod.outlook.com (10.168.165.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 13:05:19 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::9be:baba:170f:3e2]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::9be:baba:170f:3e2%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 13:05:19 +0000
Subject: Re: [RFC PATCH v3 0/4] TEE driver for AMD APUs
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Nimesh Easow <Nimesh.Easow@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <cover.1575608819.git.Rijo-john.Thomas@amd.com>
 <f7803de4-b09d-cfb7-9289-7abf5dde37c0@amd.com> <20191216123911.GA11788@jax>
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Message-ID: <d09adcce-3004-bc3f-b9d1-69b57107b468@amd.com>
Date:   Mon, 16 Dec 2019 18:35:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191216123911.GA11788@jax>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::22) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38ba4c4d-a315-48d8-7c0b-08d782289a00
X-MS-TrafficTypeDiagnostic: CY4PR12MB1413:|CY4PR12MB1413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1413FCAB0690E1B4BEE4B2FECF510@CY4PR12MB1413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(5660300002)(53546011)(6916009)(66476007)(186003)(66946007)(66556008)(2616005)(45080400002)(26005)(4326008)(6666004)(6486002)(478600001)(966005)(8936002)(31696002)(86362001)(316002)(2906002)(81166006)(8676002)(31686004)(6512007)(81156014)(52116002)(54906003)(36756003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1413;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8ztUFBfnegPWGV+nZDyJtg6t1em2PNmaEJ002zmsTpxpKjgkJBT81uS1O/9WJCtQDMdjd07ZALC6C8IsVC/PK5U3hJF+u0vbbPPFlFSsPJI8dZ/XHeSjJB8LrVBIlv8miZfWrIK/ny7eqPV+bcIAU51CPg2Ml0+mpo5Vad3hgxb6/b80IHZIu+WB5bkruFfMLhyOLICy5unZNBRsd24nQMqFlteXrOv/9SymP5Co6F5ChywC0qS4JVFy3DihQ2lXW4WPnCe4yv3NL2p4rcMdM3XN2S/4+vMEFf+/wqkRUTcl2CDZ0CaKy2yTnrGKd5GmRgl9aQGWZDhf8ZDDOB9qMKDMV+z0yMU8L4IDyLtWw9UGL2jXDmnly4IBOTHi8HT+pgm3wt9PXjPn+Cvlu+cjM5yPju35wwomy2XnLYkGDJ0y2rw5FVHwo3qnMuXisLJVtkcnuIMQj6k7fCIAKRndTmfVakLNJnHNNTmWlUk+Gs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ba4c4d-a315-48d8-7c0b-08d782289a00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 13:05:19.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUTAXYGliszFwauMJwYKslzWxttC6r6Li828mEONQCU7XYlLWbQARt/K89pYmwof156pgXibtQEpWNd7yw5b6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Herbert

Hi Jens,

On 16/12/19 6:09 pm, Jens Wiklander wrote:
> Hi Rijo,
> 
> On Thu, Dec 12, 2019 at 06:04:24PM +0530, Thomas, Rijo-john wrote:
>> Hi Jens,
>>
>> Please let me know if there are any comments for this patch series. I
>> shall address them, if any, and post for next review.
> 
> This looks good, I have no further comments.
> 
> How do you intend to upstream this? There's the dependency towards "Add
> TEE interface support to AMD Secure Processor driver"
> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F12%2F4%2F42&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C3be32c79103640faefdc08d78224f703%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637120967585713342&amp;sdata=I2lQNxu%2BBeIrL3Yk09IOYlUGsxWeCmLJhCcFuyqSJkA%3D&amp;reserved=0) to take into account too.

Thanks! If you are okay, can you give an Acked-by so that I can ask the crypto
subsystem maintainer to pull these patches as well.

Thanks,
Rijo

> 
> Thanks,
> Jens
> 
>>
>> Thanks,
>> Rijo
>>
>> On 06/12/19 10:48 am, Rijo Thomas wrote:
>>> This patch series introduces Trusted Execution Environment (TEE) driver
>>> for AMD APU enabled systems. The TEE is a secure area of a processor which
>>> ensures that sensitive data is stored, processed and protected in an
>>> isolated and trusted environment. The AMD Secure Processor is a dedicated
>>> processor which provides TEE to enable HW platform security. It offers
>>> protection against software attacks generated in Rich Operating
>>> System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
>>> running on AMD Secure Processor allows loading and execution of security
>>> sensitive applications called Trusted Applications (TAs). An example of
>>> a TA would be a DRM (Digital Rights Management) TA written to enforce
>>> content protection.
>>>
>>> Linux already provides a tee subsystem, which is described in [1]. The tee
>>> subsystem provides a generic TEE ioctl interface which can be used by user
>>> space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
>>> and implements tee function callbacks in an AMD platform specific manner.
>>>
>>> The following TEE commands are recognized by AMD-TEE Trusted OS:
>>> 1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
>>>    environment
>>> 2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
>>> 3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
>>> 4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
>>> 5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
>>> 6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
>>> 7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory
>>>
>>> Each command has its own payload format. The AMD-TEE driver creates a
>>> command buffer payload for submission to AMD-TEE Trusted OS.
>>>
>>> This patch series has a dependency on another patch set titled - Add TEE
>>> interface support to AMD Secure Processor driver.
>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F12%2F4%2F42&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C3be32c79103640faefdc08d78224f703%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637120967585713342&amp;sdata=I2lQNxu%2BBeIrL3Yk09IOYlUGsxWeCmLJhCcFuyqSJkA%3D&amp;reserved=0
>>>
>>> v3:
>>> * Updated [1] with driver details
>>>
>>> v2:
>>> * Added a helper API in AMD Secure Processor driver, which can be
>>>   called by AMD-TEE driver during module init to check if TEE is
>>>   present on the device
>>> * Added proper checks for parameter attribute variable
>>> * Used tee_shm_pool_alloc() to allocate struct tee_shm_pool data structure
>>> * Removed all references to tee_private.h header file in driver code,
>>>   except for the file drivers/tee/amdtee/core.c. The driver loads TA binary
>>>   by calling request_firmware(), which takes struct device* as one of its
>>>   arguments. The device 'dev' field is part of struct tee_device, defined
>>>   in tee_private.h
>>>
>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2FDocumentation%2Ftee.txt&amp;data=02%7C01%7CRijo-john.Thomas%40amd.com%7C3be32c79103640faefdc08d78224f703%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637120967585713342&amp;sdata=3nmaMDGsdbqRdR3ocM0xoEFsNRbd2IgUj6tvCKJhk2w%3D&amp;reserved=0
>>>
>>> Rijo Thomas (4):
>>>   tee: allow compilation of tee subsystem for AMD CPUs
>>>   tee: add AMD-TEE driver
>>>   tee: amdtee: check TEE status during driver initialization
>>>   Documentation: tee: add AMD-TEE driver details
>>>
>>>  Documentation/tee.txt               |  81 ++++++
>>>  drivers/crypto/ccp/tee-dev.c        |  11 +
>>>  drivers/tee/Kconfig                 |   4 +-
>>>  drivers/tee/Makefile                |   1 +
>>>  drivers/tee/amdtee/Kconfig          |   8 +
>>>  drivers/tee/amdtee/Makefile         |   5 +
>>>  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
>>>  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
>>>  drivers/tee/amdtee/call.c           | 373 ++++++++++++++++++++++++++
>>>  drivers/tee/amdtee/core.c           | 516 ++++++++++++++++++++++++++++++++++++
>>>  drivers/tee/amdtee/shm_pool.c       |  93 +++++++
>>>  include/linux/psp-tee.h             |  18 ++
>>>  include/uapi/linux/tee.h            |   1 +
>>>  13 files changed, 1451 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/tee/amdtee/Kconfig
>>>  create mode 100644 drivers/tee/amdtee/Makefile
>>>  create mode 100644 drivers/tee/amdtee/amdtee_if.h
>>>  create mode 100644 drivers/tee/amdtee/amdtee_private.h
>>>  create mode 100644 drivers/tee/amdtee/call.c
>>>  create mode 100644 drivers/tee/amdtee/core.c
>>>  create mode 100644 drivers/tee/amdtee/shm_pool.c
>>>
>>> --
>>> 1.9.1
>>>
