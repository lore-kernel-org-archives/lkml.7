Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02532C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C8A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="02mGQ+kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfLKMNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:13:35 -0500
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:6062
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbfLKMNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:13:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu6GawxZbCmOKLULY7D9wt6iuqT310SyUGHFtDdBlwgvH4xV6srDnXVORbVDUoVfwsifDyIh/6IQ0nrqh9/x4du3U74FCh3xxfAeSQJ5GRtUEXHlp5ETk9oqJn3erboAordfsrFRhVboctSDVLQDRGRO9qBroXYQPeJUEa9Lq0q0urklKTcNQaZ2HkCmgx1huWUAPiPTB6hTIEE4Xx6mul2gy8GE6s/CPfQ2+4jejPm7eRe11ggCXnodb7dw1HjyL4ekk5hBxsCj3gLeR6LXbjdd7WyKPXUHj/DkJD/t6UypaUEHk6NCLLn+18Lu9lEA8qXURKe75AW7jHIZhNYKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgDwmdfGpdt75eJ8asuQlamJJKdo6gEj2e8PZ4pgJhI=;
 b=gmnJjeGn8Rtcq/e1lZa3GJPw1z7RDCfVXuYhF7c11OPrkRB4lYenUk+U8V+4S2i+//geCzy9ENb9vtuMdiyHx3Y0mIuRp7SbsEuT7kvgHgoOYRO3FCWolXQKfsP+Pz3/r5pQCYvSQywfLRbXnupDgwj/7keHlG0+up49lgf3PlO8Lj6WH5uppnfRkb0JbTimn5RM+YxoQYYqXl2NDaggisU0BcO6llP9NGtoSGsFPPHZeKgnk+f9NjVWjoJA33+Wp32oQNhq/jj91LsmfnsXNko2faz7c32a3g4fMsJZADu9jn3IJBctu3s6ZQbK792017xJmcy5PNrpfwMJfqE8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgDwmdfGpdt75eJ8asuQlamJJKdo6gEj2e8PZ4pgJhI=;
 b=02mGQ+kdvjhqrnXRZZUBZukktYDGqeXEJjO9pG9J7zD7eFT2oaRYhWaZtssTqLROXoSZg8O5XOhD/3go2FstCTCkHfEx1PIdRsDMuZShCK7bkAjtWSkHdRtmnOvsRVzkIQyQ9RE0VFW2jWqquokwcrwqX5dlAvEXmkHOx12Eu64=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3967.namprd12.prod.outlook.com (10.255.238.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Wed, 11 Dec 2019 12:12:52 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 12:12:52 +0000
Subject: Re: [PATCH] ntb_perf: pass correct struct device to
 dma_alloc_coherent
To:     Logan Gunthorpe <logang@deltatee.com>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>,
        Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com, will@kernel.org,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
 <fd958d1b-5abc-b936-2f21-429326a6e5de@deltatee.com>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <c70955ba-516f-19e6-6dbf-3bf864114fb1@amd.com>
Date:   Wed, 11 Dec 2019 17:42:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <fd958d1b-5abc-b936-2f21-429326a6e5de@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0e1a932-36b9-4829-fb02-08d77e33723b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:|MN2PR12MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3967DB4834B8DAA57CCA8430E55A0@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(478600001)(966005)(6486002)(36756003)(2906002)(6512007)(81166006)(8936002)(4326008)(81156014)(66556008)(26005)(45080400002)(5660300002)(6666004)(4001150100001)(186003)(66476007)(53546011)(2616005)(52116002)(31686004)(31696002)(6506007)(66946007)(316002)(8676002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3967;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmJss8oxY9j/DcOSLXQxZZzdlPpUim/Fm1OmsIQWFkvWOEIkhhFPFenkrWcCfqqxzQWCFC7bJMnsXiiORlh/6RxVAAnu1uysyICkdWp00N59GB1sR39wCmEPCIA/PpbKdN91ULpOo5K3JvVwVCPG8HoICLVyimbM6Pm4y5KAP/JRh/PhY7iSUsAxqpD763AqsDef+F0Tb3vI9gmsMD4LK4comb864FYJl+q1A+cPuffjQffsJhwp6Kt/EzEVrbhpdOvA+Vi5oUKSzRc4+SwhwmLivKUPTLT+kiqAiynUD0Vb9jUmn2Kj2Sx1phGA6gPk3+uev7altaLJb3KkRuQ4UtnpKTpmAaQC3L3A+QeX/nXUeecy32upKJCmEC25mf2dE2HUJvp5aMYLeorYidorphl6MqqRNwSKA2lr40/5X4AYRIi3AvZY33uHx7qEIgpXRyD2OlTbsXjSI5pIU+XxNYXGveymRh11zcss6p5sgRU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e1a932-36b9-4829-fb02-08d77e33723b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 12:12:52.2769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqFuiEVWcvNOr9FDB2EK9FwSGIToe86sGyHTb5bKFkQLqbyVwkCNQKGQcpmY1wzxAw142t4UtRkCf/sbYQ3r5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/2019 11:01 PM, Logan Gunthorpe wrote:
> [CAUTION: External Email]
>
> On 2019-12-10 6:07 a.m., Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> Currently, ntb->dev is passed to dma_alloc_coherent
>> and dma_free_coherent calls. The returned dma_addr_t
>> is the CPU physical address. This works fine as long
>> as IOMMU is disabled. But when IOMMU is enabled, we
>> need to make sure that IOVA is returned for dma_addr_t.
>> So the correct way to achieve this is by changing the
>> first parameter of dma_alloc_coherent() as ntb->pdev->dev
>> instead.
>>
>> Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Yes, I did the same thing as one of the patches in my fix-up series that
> never got merged. See [1].
>
> Hopefully you can make better progress than I did.
>
> While you're at it I think it's worth doing the same thing in ntb_tool
> as well as removing the dma_coerce_mask_and_coherent() calls that are in
> the NTB drivers which are meaningless once we get back to using the
> correct DMA device.
Yes, What you said make sense. I will address your comment in the next version of patch, but I will break them down into two separate patches.
>
> Thanks,
>
> Logan
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20190109192233.5752-3-logang%40deltatee.com%2F&amp;data=02%7C01%7CSanju.Mehta%40amd.com%7C1f043932c1c1425a836908d77d96e265%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637115959326469198&amp;sdata=BoDyfqTML39JhIvO7%2FvYGnKNRKe2rSKgZxJ0uT6dtsQ%3D&amp;reserved=0
>
>> ---
>>  drivers/ntb/test/ntb_perf.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
>> index f5df33a..8729838 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
>>               return;
>>
>>       (void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
>> -     dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
>> +     dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
>>                         peer->inbuf, peer->inbuf_xlat);
>>       peer->inbuf = NULL;
>>  }
>> @@ -588,8 +588,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
>>
>>       perf_free_inbuf(peer);
>>
>> -     peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
>> -                                      &peer->inbuf_xlat, GFP_KERNEL);
>> +     peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
>> +                                      peer->inbuf_size, &peer->inbuf_xlat,
>> +                                      GFP_KERNEL);
>>       if (!peer->inbuf) {
>>               dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
>>                       &peer->inbuf_size);
>>
