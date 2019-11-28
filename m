Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B21208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b09TRwvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfK1Amk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:42:40 -0500
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:65442
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbfK1Amk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:42:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbiPY0wdOjeaHu9mfPSzteQkXUxkT6mCGwH0jbQWMjgjnrWvfYberG+9AaV9s6wTeRxQ+nJcc3fI/+3cMk+Ft8g4mx92NM/KZnvb8/MbhCyaF+HtPetph7LQ+m0kQWWrBZX1PTKG0/0AaQHAK0dQhSgOZHXVqxmXiN9qY5JgaeE72gEa29XPGnkpK+VY/6DL2VOR+SY9QC1XYQuKsg+AeMKl2lCz9K52svEe+zujIJz9Wgwwc6CyHBxflZnk9GQO6etxkD4T/5VrexoMFdNBHgtmArGwRAVkd5Gj1NNzVUx2OQ1kGjIL1ar/7PhBgALuQu0KFM+LmadrF85oyoSqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf4gwPPxy9d6mYE0SZTGHLpfVcGh86u6qJfk71OU1O8=;
 b=eDXrGpsXeWbcCiLX+8o/SjwutvUGbeb2A1Jc2WaTazjRatIFMQHuGaD9+WjLUjH+dkdxnB9k9tFifimfHFMZH6y7lFnFzBPPS69Iv6ombD81L/dg5tCdr4+M7uBP01bgZbTdc9kgbi/v/xkVjlY5hDCrQEfsmCfB5nRt0UGsT896CuFy1/9dI1ziIQrDt1IaXNurIr0aWWSRiUrtZA5EOBzSvNSJMk0gTqMlZS4f40Zq30qnfNgjH8g8zkpkpcPT1QkLIh3+KLYZWwQKhLSg+j5MC5Cqz9oze7tDcouSEw/Za8DGxKh2ny3jhajDmtnxRMlgCkh7L5gl3WCs1BdySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf4gwPPxy9d6mYE0SZTGHLpfVcGh86u6qJfk71OU1O8=;
 b=b09TRwvlybdiwP+cYBJU+2WbKlpPqJ2E93nA4FqP1FPbv2PR9mYEanT71PPJfg8lsIJc1s6MTb8C+ecobWTnGa5UtUYDecQk0OQf0p9le5GlKcNyXlAej7C2K1xSRk83QTIA2L/LqErk+t4RmTjpFg0/nqXzliuP+JD2BwxscZE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM6PR12MB3610.namprd12.prod.outlook.com (20.178.198.149) by
 DM6PR12MB3755.namprd12.prod.outlook.com (10.255.172.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 00:42:34 +0000
Received: from DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::5dfd:e70f:379a:98c9]) by DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::5dfd:e70f:379a:98c9%5]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 00:42:33 +0000
Date:   Thu, 28 Nov 2019 00:42:25 +0000
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
Message-ID: <20191128004225.GA11539@ashkalra_ubuntu_server>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
 <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
 <20191126184527.GA10481@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126184527.GA10481@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To DM6PR12MB3610.namprd12.prod.outlook.com
 (2603:10b6:5:3a::21)
MIME-Version: 1.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 916bafcc-00c2-4e5a-0c0c-08d7739bda78
X-MS-TrafficTypeDiagnostic: DM6PR12MB3755:|DM6PR12MB3755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37552FA517C409BCC6280BAD8E470@DM6PR12MB3755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(54094003)(199004)(51444003)(189003)(33716001)(7416002)(8936002)(58126008)(316002)(33656002)(6506007)(186003)(8676002)(229853002)(26005)(47776003)(386003)(99286004)(86362001)(478600001)(14454004)(25786009)(54906003)(7736002)(6916009)(305945005)(45080400002)(966005)(4326008)(3846002)(23676004)(6666004)(6116002)(6306002)(81166006)(6486002)(44832011)(66946007)(2870700001)(66556008)(81156014)(2906002)(5660300002)(11346002)(446003)(52116002)(66476007)(6436002)(2486003)(1076003)(50466002)(6246003)(6512007)(9686003)(66066001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3755;H:DM6PR12MB3610.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0l7Vgh/teLbokgITuKFwlLmJCXpmtJ6TTu3jdIq+F7e+GKxIWULFHS6q6F8hNGclrrHhXanKTcW4EKr/QUbX+2ExGjzTKc0R8CZ2j0OCmVnnv4hjkIHTYCEAMKFnwCu6008MsIce8SjyUuPsb2EjFjXI8cqCPURTjddy5drxdSyFROyO+FWBqPO7GFL1QD9DLQ5sJoXH3SnOrg391yqywlt+kyoTo8XK2iuv6eNv8AVNPyNTUi6mIm0YfiHckUU6FkudY36894dtOnlD25K5Mlcx4YlWEIAc7tZUcqjqOdGMOxb3ubnnQo22SbVWRx35oOV1za58O3lIyP3L5fyfVTBSZkUwQqNsc1mOxkXxRcUWBiCDVsvTnpwnRPbKDfdPd+QZBGy6AqXJ2Lw2dNnKrvTkPLX7/Aa3LLbdmTmgIXQwGDN/PUe5nZbbo0EBQmXbrTF5XfkE+XZzTa56KOX1B8PBWcbphxu9FbDyO+9ltU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916bafcc-00c2-4e5a-0c0c-08d7739bda78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 00:42:33.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikbiAkUxNQLbgFpFmwyGi3NzV2ewqDMYm+XM6FlJ0aGz/iUi7/L4/MjlVw/OzcZ4zj/IiVXixh1mtyM705whJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't we leverage CMA instead of SWIOTLB for DMA when SEV is
enabled, CMA is well integerated with the DMA subsystem and handles
encrypted pages when force_dma_unencrypted() returns TRUE. 

Though, CMA might face the same issues as SWIOTLB bounce buffers, it's
size is similarly setup statically as SWIOTLB does or can be set as a 
percentage of the available system memory.

Thanks,
Ashish

Tue, Nov 26, 2019 at 07:45:27PM +0100, Christoph Hellwig wrote:
> On Sat, Nov 23, 2019 at 09:39:08AM -0600, Tom Lendacky wrote:
> > Ideally, having a pool of shared pages for DMA, outside of standard
> > SWIOTLB, might be a good thing.  On x86, SWIOTLB really seems geared
> > towards devices that don't support 64-bit DMA. If a device supports 64-bit
> > DMA then it can use shared pages that reside anywhere to perform the DMA
> > and bounce buffering. I wonder if the SWIOTLB support can be enhanced to
> > support something like this, using today's low SWIOTLB buffers if the DMA
> > mask necessitates it, otherwise using a dynamically sized pool of shared
> > pages that can live anywhere.
> 
> I think that can be done relatively easily.  I've actually been thinking
> of multiple pool support for a whіle to replace the bounce buffering
> in the block layer for ISA devices (24-bit addressing).
> 
> I've also been looking into a dma_alloc_pages interface to help people
> just allocate pages that are always dma addressable, but don't need
> a coherent allocation.  My last version I shared is here:
> 
> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgit.infradead.org%2Fusers%2Fhch%2Fmisc.git%2Fshortlog%2Frefs%2Fheads%2Fdma_alloc_pages&amp;data=02%7C01%7CAshish.Kalra%40amd.com%7Cc977f3861fdd40b8f06508d772a0cf1b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637103907325617335&amp;sdata=4FzBxGNqNn36CxpU%2FgQ4socs7InNDgAZlTspBMfUsIw%3D&amp;reserved=0
> 
> But it turns out this still doesn't work with SEV as we'll always
> bounce.  And I've been kinda lost on figuring out a way how to
> allocate unencrypted pages that we we can feed into the normal
> dma_map_page & co interfaces due to the magic encryption bit in
> the address.  I guess we could have a fallback path in the mapping
> path and just unconditionally clear that bit in the dma_to_phys
> path.
