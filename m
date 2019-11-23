Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E6FC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CD520679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXLXHNbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKWPjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:39:18 -0500
Received: from mail-eopbgr730082.outbound.protection.outlook.com ([40.107.73.82]:63148
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfKWPjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:39:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzjecrXxozocU+FlYYhFN5zyO/t2ov3lV1w+8AOCWhfR4v8FFUnpx0jj6e7zUohWwQAoVrowcPpNOL5q4u1LIkWwe7V0anN8fy5wX4F+y1HFssRdecHeueVaJE+yTfPl1nBoSIwHA95Dau8H7lsHA7tyUedIC0y23vzYSIMEvVInZVwWRGzrrFEXcMWoHQtagWBjCDw5cCb90IXF9ebck1mtqeZFLGGwbMRH8mUvSuKn6n9gB0uYo3IjtVzCOzAXQy9Yg/V/1sSRISYy19KYtICztonKUGx5+M01gMVUh0t2xtDzcqCfHKne6WcQ559TmVI3pJtkwx5xzg6YtiJKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duFfUypJu1Onm9BuFt83gXYaP6GR9NbxMAJRJqGl5Ec=;
 b=YE5mBTMQjVodkM9tngXvRrDhdcNxn7iL5z7Pv9vcu+/niiuOFJKKQSuJTQBurfqrVLy0v0PzZjxMrns++kfP0TQBtqNGTdJKJmFxUnjuQj2k+wtlGtdnBhmDWiD5xAAHy44AISseSmLlYw7Plk5znrZ0BxfQJQ3p9KjBWztEDYMFQ0I2iij7ljYe3Ht2lWFOR5H/C1dCbnSll3KZrL0r33xX9XnFKHWlZA13fRhvtNMaQSnoTq3/iEo0+q+geLatDynK94o8HtdndSkmCx5GzocPnGZv0VXo5Uax071xsyLAoGuS7H3s+3sCRqLqsuVd2yUl+IJKpnamBHYaSTqVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duFfUypJu1Onm9BuFt83gXYaP6GR9NbxMAJRJqGl5Ec=;
 b=KXLXHNbADsaxCpevb0YHKo4xCwJMwAtNKvHqy8C+VraSb87CX4pRsXf8gozxt9+WgMy6GLjJ3tjow80uHW6cjGRt/VaVh8Y3fAxDb7dCRAWwX5jH8x9UFiforR5TxdY7x6YId7f5mCTzOmPnKNfHvg8LUgJGp7de8he9xlSEAJg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.71.154) by
 DM6PR12MB2716.namprd12.prod.outlook.com (20.176.116.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Sat, 23 Nov 2019 15:39:14 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::dd0c:8e53:4913:8ef4]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::dd0c:8e53:4913:8ef4%5]) with mapi id 15.20.2474.022; Sat, 23 Nov 2019
 15:39:14 +0000
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <Ashish.Kalra@amd.com>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
Date:   Sat, 23 Nov 2019 09:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191122140827.0ead345c.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd94fe0b-97c8-4385-813a-08d7702b4964
X-MS-TrafficTypeDiagnostic: DM6PR12MB2716:|DM6PR12MB2716:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB271684CC09EA31FF2D5CFAE9EC480@DM6PR12MB2716.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0230B09AC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(85644002)(54094003)(7416002)(99286004)(229853002)(58126008)(6486002)(54906003)(110136005)(6436002)(316002)(6506007)(36756003)(6306002)(47776003)(2486003)(23676004)(305945005)(7736002)(53546011)(2616005)(8936002)(76176011)(6512007)(66066001)(6666004)(52116002)(31696002)(66556008)(66476007)(6246003)(186003)(4326008)(81166006)(2906002)(81156014)(31686004)(386003)(11346002)(65956001)(86362001)(446003)(25786009)(3846002)(14444005)(478600001)(14454004)(50466002)(26005)(966005)(5660300002)(66946007)(65806001)(6116002)(45080400002)(8676002)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2716;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2vib5ye18d1zIDJzonS+tli736ytG/nOcaZmNgvgF5Gz9UP/FDoMUwrQlSducb18kiRL4ofXAkfk8/cIgMiC1ghwbsmxtSMtmeoL5GTEpGMJw3N6E5pD98WaVnqC5XiIRS6fd1aTvORfk8ttrxDH1+Q1TUMpKDXxMdrBQBzhllzLAK3V125sHSbLUGUPuWMQ4dPbENrBzrcWOKqBz7lVBzvT3lrSiFlNYuX9JKg1uSFLtOVojZ0JgjjdfUSKx9bwM+678IO/zvh19WMOvNYPUaQn2tigTpyQYyzPmnrqggGw9uN7LBC7dSJDbfQNiqvCDYgYkNsWWZmlxJt1pBrEncuwur5VqCv8hLNt3UDyeMp+JVY6NQ0J1E+rIMpo28XAFGD3emId2FH1P6Eb7OQovB7dZCBmYUOykwMTTrFFnyvLElw+IQ1SCkHUUUEn+pGFJKMLYxXV0R6iHUeqLdku/azyz0F6/XttVVEseNerrc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd94fe0b-97c8-4385-813a-08d7702b4964
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2019 15:39:13.7459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3b2NrBMezGtiGkzLNgpZSow6ZOAjDNaQxItwLVMcGuBMeKFNL8qbSC1AEtqFzAuuJakA55NXOre0EknFjk//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/19 7:08 AM, Halil Pasic wrote:
> Thanks Michael!
> 
> Actually I also hoped to start a discussion on virtio with encrypted
> memory.
> 
> I assume the AMD folks have the most experience with this, and I very
> much like to understand how do they master the challenges we are all
> facing.
> 
> My understanding of IO in the context of AMD SEV is that the user
> is responsible for choosing the swiotlb command line parameter of the
> guest kernel so, that the guest never runs out of swiotlb. And that
> not doing so may have fatal consequences with regards to the guest. [1]
> 
> The swiotlb being a guest global resource, to choose such a size, one
> would fist need to know the maximal swiotlb footprint of each device,
> and then apply some heuristics regarding fragmentation.
> 
> Honestly, if somebody asked me how to calculate the max swiotlb
> footprint of the most common virtio devices, I would feel very
> uncomfortable.
> 
> But maybe I got it all wrong. @Tom can you help me understand how this
> works?

Yes, SWIOTLB sizing is hard. It really depends on the workload and the
associated I/O load that the guest will be performing. We've been looking
at a simple patch to increase the default SWIOTLB size if SEV is active.
But what size do you choose? Do you base it on the overall guest size? And
you're limited because it must reside low in memory.

Ideally, having a pool of shared pages for DMA, outside of standard
SWIOTLB, might be a good thing.  On x86, SWIOTLB really seems geared
towards devices that don't support 64-bit DMA. If a device supports 64-bit
DMA then it can use shared pages that reside anywhere to perform the DMA
and bounce buffering. I wonder if the SWIOTLB support can be enhanced to
support something like this, using today's low SWIOTLB buffers if the DMA
mask necessitates it, otherwise using a dynamically sized pool of shared
pages that can live anywhere.

Thanks,
Tom

> 
> In any case, we s390 protected virtualization folks are concerned about
> the things laid out above. The goal of this patch is to make the swiotlb
> full condition less grave, but it is by no means a full solution.
> 
> I would like to work on improving on this situation. Obviously we have
> done some thinking about what can be done, but I would very much like to
> collect the opinions, of the people in the community that AFAICT face
> same problem. One of the ideas is to try to prevent it from happening by
> making swiotlb sizing dynamic. Another idea is to make the system deal
> with the failures gracefully. Both ideas come with a bag of problems of
> their own (AFAICT).
> 
> According to my research the people I need to talk to are Tom (AMD), and
> Ram and Thiago (Power) and of course the respective maintainers. Have I
> missed anybody?
> 
> Regards,
> Halil
> 
> --
> 
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FAMDESE%2FAMDSEV%23faq-4&amp;data=02%7C01%7CThomas.Lendacky%40amd.com%7Cd733eab74c7346b72fb608d76f4d175d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637100249200530156&amp;sdata=mUISWUHYJfLE3c1cYoqC%2B3uzM8RtpnffyMlrX84oGug%3D&amp;reserved=0
> 
> On Tue, 19 Nov 2019 08:04:29 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> Will be in the next pull request.
>>
>> On Tue, Nov 19, 2019 at 12:10:22PM +0100, Halil Pasic wrote:
>>> ping
>>>
>>> On Thu, 14 Nov 2019 13:46:46 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>
>>>> Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
>>>> virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
>>>> a very realistic scenario for guests with encrypted memory, as swiotlb
>>>> may run out of space, depending on it's size and the I/O load.
>>>>
>>>> The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
>>>> error, despite the fact that swiotlb full is in absence of bugs a
>>>> recoverable condition.
>>>>
>>>> Let us change the return code to -ENOMEM, and make the block layer
>>>> recover form these failures when virtio-blk encounters the condition
>>>> described above.
>>>>
>>>> Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>>> ---
>>>>
> [..]
> 
