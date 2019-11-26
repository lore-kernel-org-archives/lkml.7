Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2AFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCCD206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i/k3fVNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfKZNBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:01:06 -0500
Received: from mail-eopbgr730054.outbound.protection.outlook.com ([40.107.73.54]:24507
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfKZNBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:01:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0ybpQ4jc7dFIfBaimcJPZuvB3gWoZ9uylPR42nP+WwOTVVF5i8rw0D7YC+g6gwNfDlqc7zQhzbh7IELF+6iEv+qgRV/BzZNNiVwO83HBBPjHSWagyNsNs72N8xlenZIFrOEZIc/VkOf5yBbNvM7hctQR//oN8HLZkZXIJboFdQRh1kxQuBz9OAYyHGutQ+OVL/hHWI6UDlLEBt96Vm+2Cr3ab9tv6C17vdveHMBrPwmXQWXMrxnOosEvZDSpaNfTRoTigUgeegSWPHZjO9rcrjR51gxU5oe4ug39t40hVxC3ep0BoXFOTvkgmaMjSWue3rTdtrYf3Eww8pc3SezBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQRy47rxdH/mPCmYQwqVzDEwtEMm5y7+3NeiDCgmcBA=;
 b=E51dIWpyldRv2Z7hM1FegB2I1h0Qk+3PLNAbRHDDbBDkSPo6XCQHR/92aYskZsLF7Y8JKU5nUHR+7HhgW61MBZy9rzPGzXHypUBcqBXIwf4ZCJiP+6TtOGwHh6LRZEGB8+MWa5f79Z+DdAc9Mqz81EtC93/hpNTL2rL8gmkVsmiuIaI44u2seR22VgJfJBstjUTqJ4bzin/nFCFnj7n5WAoBOWtonfGDx/+4heVA6P9pEB12JzRBFzz7FqxHpZx+IigF+XkuLWHsoVB5bv0wOBDOk+TKntnDLCn3Kv5+87kOjZuH5A+YSDQucQCrd0H+5MBtCttJot4oYnnfSDabvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQRy47rxdH/mPCmYQwqVzDEwtEMm5y7+3NeiDCgmcBA=;
 b=i/k3fVNhoLxPB7upfh7O6QlPGWkBtfey5nzq+P16+RxepV9vTEo7klvjvMRjKWq903bmClvsRvRTN1Ps6QFcy0K2yqdLURsbl7na0H99aAVO7ewUTaDMk1E+VBRftP5ubwgWfrpQLMBD1wTnOWwtuXuzKtSQ1XsY6wqNnxVzN84=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from DM5PR12MB1932.namprd12.prod.outlook.com (10.175.89.23) by
 DM5PR12MB1675.namprd12.prod.outlook.com (10.172.34.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 13:01:02 +0000
Received: from DM5PR12MB1932.namprd12.prod.outlook.com
 ([fe80::cce8:3bc3:54c7:26ea]) by DM5PR12MB1932.namprd12.prod.outlook.com
 ([fe80::cce8:3bc3:54c7:26ea%8]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 13:01:02 +0000
Subject: Re: [RFC PATCH 0/2] TEE driver for AMD APUs
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
References: <cover.1571818136.git.Rijo-john.Thomas@amd.com>
 <20191105151731.GA22448@jax>
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Message-ID: <5a6f17c6-c74c-0b03-c94e-6234ee7d305f@amd.com>
Date:   Tue, 26 Nov 2019 18:30:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191105151731.GA22448@jax>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To DM5PR12MB1932.namprd12.prod.outlook.com
 (2603:10b6:3:10e::23)
MIME-Version: 1.0
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc05f12a-d895-448e-501f-08d77270b093
X-MS-TrafficTypeDiagnostic: DM5PR12MB1675:|DM5PR12MB1675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1675EFF1F94F7232AF7591AACF450@DM5PR12MB1675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(305945005)(6486002)(2906002)(31696002)(54906003)(6306002)(186003)(8676002)(6512007)(58126008)(26005)(81166006)(81156014)(14454004)(25786009)(86362001)(6916009)(6436002)(4326008)(316002)(478600001)(31686004)(6246003)(7736002)(66476007)(53546011)(6506007)(386003)(2486003)(52116002)(6666004)(229853002)(99286004)(66556008)(230700001)(8936002)(23676004)(66946007)(76176011)(36756003)(47776003)(11346002)(2616005)(3846002)(50466002)(5660300002)(966005)(14444005)(446003)(65806001)(65956001)(66066001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1675;H:DM5PR12MB1932.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P55JxutYqbw+D77YC2hU1dmaf8PqRmnPpE6eOEfqbpGziFH+B6+NvcxHnkHvVurb0d0BWXpVOjq2qL4vHyXXPq98lqlZ6wabZrvijv0ixybd2zhusOBX3g57s6WyK5+JbCHHRdp0EDoEt5XANN954n5uea17RxwGDESv1w2x1VanV/R4F2VfTGoqcYb7ZmPhrCpZyyG7ty5BuFvQmQccjpUla2yIZEl706Fz2q2pAEA/+dbpcNBILOU0j0OGJoSEaDYE2VLKt8YXIxq+jQl7lW1KXTcoICVZKgx/7zIs9xOXASy2HnpBCVSCbPvO02kVqkj84c44yT+BywtD63k3K8Hi3Hjnzypr+AANn1aSawY2YyQJ5BDJs22olIL05cFg+HqNiE9VfWV08cM9zDAqwg7e50pybxcpKpoJ4Hsbf1nKeq4NnnEC41u73qgHQXMUivpbgNr00RHUHgqdvkH45bs5Wp/EcE3Mi08lv8ewjes=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc05f12a-d895-448e-501f-08d77270b093
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 13:01:02.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBs620kg9ZgIHyuxwQ/1YXoWuCOmiMp4e3w4m0S6jjZi4XmP6xu2H6TaHOeIbOr5lqgX5miyDd2RYadAhE8jWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 05/11/19 8:47 PM, Jens Wiklander wrote:
> Hi Rijo,
> 
> On Wed, Oct 23, 2019 at 11:30:56AM +0000, Thomas, Rijo-john wrote:
>> This patch series introduces Trusted Execution Environment (TEE) driver
>> for AMD APU enabled systems. The TEE is a secure area of a processor which
>> ensures that sensitive data is stored, processed and protected in an
>> isolated and trusted environment. The AMD Secure Processor is a dedicated
>> processor which provides TEE to enable HW platform security. It offers
>> protection against software attacks generated in Rich Operating
>> System (Rich OS) such as Linux running on x86. The AMD-TEE Trusted OS
>> running on AMD Secure Processor allows loading and execution of security
>> sensitive applications called Trusted Applications (TAs). An example of
>> a TA would be a DRM (Digital Rights Management) TA written to enforce
>> content protection.
>>
>> Linux already provides a tee subsystem, which is described in [1]. The tee
>> subsystem provides a generic TEE ioctl interface which can be used by user
>> space to talk to a TEE driver. AMD-TEE driver registers with tee subsystem
>> and implements tee function callbacks in an AMD platform specific manner.
>>
>> The following TEE commands are recognized by AMD-TEE Trusted OS:
>> 1. TEE_CMD_ID_LOAD_TA : Load Trusted Application (TA) binary into TEE
>>    environment
>> 2. TEE_CMD_ID_UNLOAD_TA : Unload TA binary from TEE environment
>> 3. TEE_CMD_ID_OPEN_SESSION : Open session with loaded TA
>> 4. TEE_CMD_ID_CLOSE_SESSION : Close session with loaded TA
>> 5. TEE_CMD_ID_INVOKE_CMD : Invoke a command with loaded TA
>> 6. TEE_CMD_ID_MAP_SHARED_MEM : Map shared memory
>> 7. TEE_CMD_ID_UNMAP_SHARED_MEM : Unmap shared memory
>>
>> Each command has its own payload format. The AMD-TEE driver creates a
>> command buffer payload for submission to AMD-TEE Trusted OS.
>>
>> This patch series has a dependency on another patch set titled - Add TEE
>> interface support to AMD Secure Processor driver.
>>
>> [1] https://www.kernel.org/doc/Documentation/tee.txt
> 
> Please add a section in Documentation/tee.txt describing the AMD-TEE driver.
> 

Sure, I will update Documentation/tee.txt describing the AMD-TEE driver.

Thanks,
Rijo

> Cheers,
> Jens
> 
>>
>> Rijo Thomas (2):
>>   tee: allow compilation of tee subsystem for AMD CPUs
>>   tee: add AMD-TEE driver
>>
>>  drivers/tee/Kconfig                 |   4 +-
>>  drivers/tee/Makefile                |   1 +
>>  drivers/tee/amdtee/Kconfig          |   8 +
>>  drivers/tee/amdtee/Makefile         |   5 +
>>  drivers/tee/amdtee/amdtee_if.h      | 183 +++++++++++++
>>  drivers/tee/amdtee/amdtee_private.h | 159 +++++++++++
>>  drivers/tee/amdtee/call.c           | 370 ++++++++++++++++++++++++++
>>  drivers/tee/amdtee/core.c           | 510 ++++++++++++++++++++++++++++++++++++
>>  drivers/tee/amdtee/shm_pool.c       | 130 +++++++++
>>  include/uapi/linux/tee.h            |   1 +
>>  10 files changed, 1369 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/tee/amdtee/Kconfig
>>  create mode 100644 drivers/tee/amdtee/Makefile
>>  create mode 100644 drivers/tee/amdtee/amdtee_if.h
>>  create mode 100644 drivers/tee/amdtee/amdtee_private.h
>>  create mode 100644 drivers/tee/amdtee/call.c
>>  create mode 100644 drivers/tee/amdtee/core.c
>>  create mode 100644 drivers/tee/amdtee/shm_pool.c
>>
>> -- 
>> 1.9.1
>>
