Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE71C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 01:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE112075C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 01:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YhKxk9Bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfK2B6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 20:58:06 -0500
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:49345
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfK2B6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 20:58:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N21cpKkO0ISPXNIQp7P4FVOnFwYW640PTMkK9Mnl7XA3XMG0OWCghaHz3U5MJhQZE7N38AoOOumE+kkQiUcBCHgcItREIER+Znu86MORTHqyTgLENBFN38lP5S0t42EGkFePzDrUaPsLuqLxg0tCMSdtihk2CyCF9o92cQOy2GR3A6DQzB+K0v+vJtYWLktNV//hZXlDlKCVuul86wXnQESBncUD0O4FV+ezyuiwuyJmmknR52h68lB339Uklxcd2FPjOIJ7FydfQdv788S7V4mR9wz4aBBBNHL25noxKFRPwsvurYWrVG2IsNPIv3IMihJZVmvC9vyR6BRKOY522g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jseS7COUUvsIGqfI0wiDkwMn+nimDDi4LQCVc/rLbY=;
 b=CW6ttAt0dwz/TgNCdzOJHAxqq9YfNIxU1cCoHYBuXNwX5kX3eiKlAc2I/Fn6qJ+LlqXCBU4dUAP8ZDd23JFjZ1RPOQYMxyirKS7bOlpEoD4oYcE71qyQYLuFNMt1MnFQeVFTHnIv+w5x9v/SNy1eYRbo20wghJZ+8WwP5ItOLiovq0EmcUttpIjYU2ev3YYYv5s56r7kc0b3OBZ8FmL92yNmOmpGOFhYaFzJo1BcVWd8BrczoHjyNceKDLclHrBJb1Iu7/FRYaQQwko+rw141aS7HUtIjtJv7i/jIctT/pPsLUI5kEmQrWxmOZDWr7sMBEeI479Y1nxhWKV7loTv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jseS7COUUvsIGqfI0wiDkwMn+nimDDi4LQCVc/rLbY=;
 b=YhKxk9BmjA5PoVJwrRUzZNr/2KelJRnZigUCogz3H6fHBticm1PGL7IRfni8KNauCVXSsEAOXukG6ay1XAufabVdGDxDKtgDt5ABnN6V+8QiEPJ6n0Gx9QLW2UzVID6VwVDmhFYAwEhYIprY4o8zRP1LTQjAdGGXzeDd0FzHyLw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM6PR12MB3610.namprd12.prod.outlook.com (20.178.198.149) by
 DM6PR12MB4075.namprd12.prod.outlook.com (10.141.187.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 01:58:02 +0000
Received: from DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::5dfd:e70f:379a:98c9]) by DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::5dfd:e70f:379a:98c9%5]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 01:58:02 +0000
Date:   Fri, 29 Nov 2019 01:57:55 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Message-ID: <20191129015730.GA13084@ashkalra_ubuntu_server>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
 <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
 <20191126184527.GA10481@lst.de>
 <20191128004225.GA11539@ashkalra_ubuntu_server>
 <20191128070538.GB20274@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128070538.GB20274@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN1PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:802:20::37) To DM6PR12MB3610.namprd12.prod.outlook.com
 (2603:10b6:5:3a::21)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3d0f977-799b-4732-5b91-08d7746f90db
X-MS-TrafficTypeDiagnostic: DM6PR12MB4075:|DM6PR12MB4075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40750FC1E600AFCE5BA482C78E460@DM6PR12MB4075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(6512007)(33716001)(7736002)(6486002)(6246003)(6436002)(81166006)(9686003)(8676002)(4326008)(81156014)(8936002)(2906002)(76176011)(52116002)(99286004)(26005)(44832011)(386003)(23726003)(6116002)(16586007)(58126008)(316002)(5660300002)(6506007)(54906003)(446003)(11346002)(7416002)(14454004)(3846002)(1076003)(86362001)(478600001)(6916009)(6666004)(47776003)(66066001)(25786009)(50466002)(186003)(66556008)(66476007)(305945005)(66946007)(33656002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4075;H:DM6PR12MB3610.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3h0zwu9ANicvvNt1q+K6LTqWxg7XkVRdiC3bTbTL74PKiUi2muvb+l8/j76OTWyfnNNQFXb8WX5mHGzfof4BTeDrmsXpLD4kcCLY29iHOKcjVFSz4MGTRukuUplzaS+ToCRezqwrSp9zwhNU5b4M3zfiheeF7ttMh+SHwMPv1Mpif2/UQvN18g4UoMfD+123UXXtRx4JzORqEW2ud0S3JlZ+R9i+TSfmbitF9V40d8Np2BXI+6YP2FjBJ+VcAc80ZrQ4xRgx6r0BJFVJqqLjpcujpS6LT5z2o+VmEDqa2gSda3scfoHoNawDyp176z9gh1HwHZrsj3G9xgtoqHUQRXV/dBQqUik6dLTRwnoFdhq7j7hGVyWR8IM5TNAaA6bJESyPwRAyz/5GZ2IEfPJSMfHa3bid97C6VRtKhHZGh8T+j/PRu1KrStB08rHRG+Kh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d0f977-799b-4732-5b91-08d7746f90db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 01:58:02.0689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJDv0xbU4KCNcZpWwcwhdJQlmiYY9o8L2MuCEE6s+9KZfCzu/kcw57Jv3x9uQEBzaNxZSDEWp1FktRF76Ck5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:05:38AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 28, 2019 at 12:42:25AM +0000, Ashish Kalra wrote:
> > Why can't we leverage CMA instead of SWIOTLB for DMA when SEV is
> > enabled, CMA is well integerated with the DMA subsystem and handles
> > encrypted pages when force_dma_unencrypted() returns TRUE. 
> > 
> > Though, CMA might face the same issues as SWIOTLB bounce buffers, it's
> > size is similarly setup statically as SWIOTLB does or can be set as a 
> > percentage of the available system memory.
> 
> How is CMA integrated with SEV?  CMA just gives a contiguous chunk
> of memory, which still needs to be remapped as unencrypted before
> returning it to the user.

Looking at the implementation, i see that CMA is accessible using
dma_alloc_coherent() and the buffer allocated by dma_alloc_coherent()
either using the CMA or the page allocator, will be marked/tagged as
unencrypted and returned to the user.

But for dma_map_xx() interfaces, the memory will need be remapped as
unencrypted memory (as you mentioned).

Thanks,
Ashish
