Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F88C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D34206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="oNl+EDHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgAHWGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:06:23 -0500
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:10053
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbgAHWGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:06:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1dFQRgk9eItNdTdk9jxcG2RskVr5RBV+EQNuPyZzgti5g1DKy9JzvY6nKr3DOYJXGLWeMEB49OLK35f4SEC39u0EEo5jCVbq6MHOFikMc8IQ8XHd9QxDWzwvueAspNX8K7t8lKjohuK7rTCaMFEeF9fi7T8i42jzapflKyVxfjYm7V0ZHPO5QEl7IuYNszb3qcBvsEqJY96fkYt0TNRg8bDCXzMOwE2Hnxrk6MTW8eT2wXHNdjoVBJu39PQOsEhI8QpMMg4HIQlP5oNSHpAYJz9LMJpSAB/oRJ0Aj5Zmru3OmoIHlTLnuiejIoNv4Ya/ZYE/9eP4UkgrkkWMrPY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is435NasdJMaUfP0yEiQkUVd1ShjOnNBE79DIDLbpeQ=;
 b=YdygwUa92Ml95ButM3f9ud7GFvY/5QYBoxwh4bmvm3MXTiRaxX2/FvO0yycj8FLj98Sj25DdSYjmyZTG5VlAc8cOjPxNpxdoWoL30HJ/lXXhOGdzC8wAYZqj71CUCMDrI0B8Op1hn+fjA0P++eWJLTsxWWJFS9snv+b1GH23ikoxClmr/mjPehw8VQM2Cp5YbZcwyeUjpQbvway0iyHUt+w9S0Vxy53B9InSf9YaCtyWwEE7mMW1qwYinI/7rbgNpa/9EQUGssi6zS/nxjhKVQJrzHnQy9ICTG1yT1pdejMwWYX2TaEMMpZrff/oX8QGHPmRAC9kT65KYBljXHL+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is435NasdJMaUfP0yEiQkUVd1ShjOnNBE79DIDLbpeQ=;
 b=oNl+EDHOs2/KKAmsD733HCHw99RaKtCj/RrGqUvt4fXzeN5pCXJ2iAD34L2d9C/JO8DgrOyYaE3JD5hwYUROcgeBfwT8xKWoly+2iBmBf7BVuqfN0ptvsrY2sviOEV+AvoilfS4rcXUcFbaQ5s1Nce0Um69QoI4dzw78iix/T9M=
Received: from DB7PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:10:36::38)
 by DB6PR0501MB2310.eurprd05.prod.outlook.com (2603:10a6:4:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 8 Jan
 2020 22:06:18 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by DB7PR05CA0025.outlook.office365.com
 (2603:10a6:10:36::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Wed, 8 Jan 2020 22:06:18 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 8 Jan 2020 22:06:17 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 9 Jan 2020 00:06:19
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 9 Jan 2020 00:06:19 +0200
Received: from [172.16.0.23] (172.16.0.23) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 9 Jan 2020 00:06:14
 +0200
Subject: Re: [PATCH v10 6/9] nvme: Export existing nvme core functions
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200108174030.3430-1-logang@deltatee.com>
 <20200108174030.3430-7-logang@deltatee.com>
 <707b39a3-b58a-44b7-7ffa-0c2bd3f28e21@mellanox.com>
 <2d8a1cc2-be58-176e-b12b-8dbc5dab8739@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f8a934d6-dc09-7211-650e-7cf45e24f9f2@mellanox.com>
Date:   Thu, 9 Jan 2020 00:06:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2d8a1cc2-be58-176e-b12b-8dbc5dab8739@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.23]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(186003)(54906003)(2616005)(36756003)(110136005)(16576012)(5660300002)(478600001)(336012)(53546011)(16526019)(26005)(966005)(356004)(81156014)(86362001)(31696002)(4326008)(8676002)(70206006)(36906005)(316002)(70586007)(31686004)(8936002)(81166006)(2906002)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2310;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27c0b797-e24e-458a-af3a-08d79486fc72
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2310:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2310333FC653F6B2A03ED816B63E0@DB6PR0501MB2310.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQQihdgPXVxhybdP7JimlHyNybbi7YZMj5Q9UuQ4zBE97ilrEj4L4Xcphpz0VY67dX5uUi7eQL+XxRB2MIut3C5nTQE3QBJDNAgPxIW+u378lQPod+YdOzuoOzOY299PXCUcs5ApyzR/gQ9BX9uS1ojMOUySFRfisKlUEW+7MS408kGAnzzagAhtmGunRRwrD8TAQKU3tzNiRdF2QYp2xtkFclhyArhbnV5dM0FsNpRLs+2EfROmD7Su0tPDY+SidmLqLe/V5XHuu9K+73gDgzlemDxI3CmT4lVQVL5kCHyUNimyRE8jkHimR2bk1KfuqITueKkiJ4ku6tYLLGdAgdRz/SxPjayWvLn8gJBLmy2ZgKlJp0I6JIhNgoJ8mMSb0M/2f6IOL1j5GC8N6NsBl2zwhZzryfrQtoKALlfXKq3fZdqcK/lbmjlCsGFLkuC5zsqsC9nNf+OW26yQ6FnUkqBky8Yvm8hvj2lV5vTIDQaCfcj/1Mz3MF/FvhC4LuiwQ1kKMSHFk77PIrpUQRmmvxPh3ZcaKOmeLpE4inXc68VF8vf3YeDqZ/wVW+h56TMW4EzN4Dsg3PgizCVoRyMVOg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 22:06:17.6185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c0b797-e24e-458a-af3a-08d79486fc72
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2020 11:50 PM, Logan Gunthorpe wrote:
>
> On 2020-01-08 2:48 p.m., Max Gurtovoy wrote:
>> On 1/8/2020 7:40 PM, Logan Gunthorpe wrote:
>>> Export nvme_put_ns(), nvme_command_effects(), nvme_execute_passthru_rq()
>>> and nvme_find_get_ns() for use in the nvmet passthru code.
>>>
>>> The exports are conditional on CONFIG_NVME_TARGET_PASSTHRU.
>>>
>>> Based-on-a-patch-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> ---
>>>    drivers/nvme/host/core.c | 14 +++++++++-----
>>>    drivers/nvme/host/nvme.h |  5 +++++
>>>    2 files changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index d7912e7a9911..037415882d46 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -463,7 +463,7 @@ static void nvme_free_ns(struct kref *kref)
>>>        kfree(ns);
>>>    }
>>>    -static void nvme_put_ns(struct nvme_ns *ns)
>>> +void nvme_put_ns(struct nvme_ns *ns)
>>>    {
>>>        kref_put(&ns->kref, nvme_free_ns);
>>>    }
>>> @@ -896,8 +896,8 @@ static void *nvme_add_user_metadata(struct bio
>>> *bio, void __user *ubuf,
>>>        return ERR_PTR(ret);
>>>    }
>>>    -static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct
>>> nvme_ns *ns,
>>> -                u8 opcode)
>>> +u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>> +             u8 opcode)
>>>    {
>>>        u32 effects = 0;
>>>    @@ -982,7 +982,7 @@ static void nvme_passthru_end(struct nvme_ctrl
>>> *ctrl, u32 effects)
>>>            nvme_queue_scan(ctrl);
>>>    }
>>>    -static void nvme_execute_passthru_rq(struct request *rq)
>>> +void nvme_execute_passthru_rq(struct request *rq)
>>>    {
>>>        struct nvme_command *cmd = nvme_req(rq)->cmd;
>>>        struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>>> @@ -3441,7 +3441,7 @@ static int ns_cmp(void *priv, struct list_head
>>> *a, struct list_head *b)
>>>        return nsa->head->ns_id - nsb->head->ns_id;
>>>    }
>>>    -static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl,
>>> unsigned nsid)
>>> +struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>>    {
>>>        struct nvme_ns *ns, *ret = NULL;
>>>    @@ -4225,6 +4225,10 @@ EXPORT_SYMBOL_GPL(nvme_sync_queues);
>>>     * use by the nvmet-passthru and should not be used for
>>>     * other things.
>>>     */
>>> +EXPORT_SYMBOL_GPL(nvme_put_ns);
>>> +EXPORT_SYMBOL_GPL(nvme_command_effects);
>>> +EXPORT_SYMBOL_GPL(nvme_execute_passthru_rq);
>>> +EXPORT_SYMBOL_GPL(nvme_find_get_ns);
>> Since this is the convention in the driver, can you export the symbols
>> at the end of each function ?
> Christoph specifically asked for these to be exported at the end of the
> file within an #ifdef CONFIG_NVME_TARGET_PASSTHRU.

I see.

Are we good with the fact that the functions are not static when 
CONFIG_NVME_TARGET_PASSTHRU is not defined ?

> Logan
>
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
