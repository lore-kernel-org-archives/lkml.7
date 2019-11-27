Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A425C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78BB20722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXJJrPJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK0Imz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:42:55 -0500
Received: from mail-eopbgr790084.outbound.protection.outlook.com ([40.107.79.84]:58496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfK0Imz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:42:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Koyge/fpbC+89b+bMu+HNcrQqweVPZrK9OQBrH+o9T6Rdu2+CB4jrTJJsiTmr6v9ad7mHgz/ztDGCL0klrzECPw88RFCJTtuQkMnn1A7ZL8w62c8IhZi+NqpnuFzZDJ1Lr9WC6IesKTSDUZdj76Mk1kn54ejr0zSreEOZvICrHAK34pVKjAAwfUBcwdUCtDxBcX5ZqKZ0lbZG008kI37kXz7vOa/7q+2v51SOtZhmXtyIodoPZbgJYwkcKMxWA9fD/pyNN+P4iBz3CR9nDbh5C+23zPpumIOITMAUBWqriazuyJsVlGJ1KST8TIw0X/jNAkfUde45FmVSpr9+tBW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjArgt8xEC3XRZ4TzMt//d5skXR3LOTrFiLTmqoRQms=;
 b=iB6Hm9s1TR7fUY8KpH1WrE3QkACrVgCzci3vhgD/8o18MKebnD8Qr95ZX24OowDnYApTqTlnl+DcP4ekrKCosShaLjRfk8hQYx90w14mjCo7Bb2GFP8VQuqDKBUh5kOEk7SITUlxaHfkS3hHdhN1RqNmZxC/VzgC2SSSJtFuokXamIB/pR+yM+P6oqGuZb7y6HOSJ9nNOyjE1Ci1unYRLo5lgpiapxPwVi3ZybKsNbZUHMm+src666twMijDcZ/d7UaHk+vu3m+7g/KpTCctXvwjDupcTLbVaYQHv3vgBtHbe6GbUauV03S5H6uUYVS7EJNb+8/wy871nSGTi2I+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjArgt8xEC3XRZ4TzMt//d5skXR3LOTrFiLTmqoRQms=;
 b=KXJJrPJbUqDoO65YYmCLEJtLAN5FjmMxH83AuuuYLFBrYuR6Gohw89Xfez+rruFd3mcvKTueC2uGFunPqblzxeJBPntWKS9+/DDmivVZEH5XMBbtfQ0j1ITn/Er/ribR1SHBsvX39jkAuN64/s/5SwvU8ASSoOon1ix9F3tdGIs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1211.namprd12.prod.outlook.com (10.168.239.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 08:42:51 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 08:42:51 +0000
Subject: Re: [PATCH 1/2] mm: Add and export vmf_insert_mixed_prot()
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191126202717.30762-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e1a5ce03-1b8d-8118-de95-b53901e94b50@amd.com>
Date:   Wed, 27 Nov 2019 09:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191126202717.30762-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:205:1::26) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23aa8fc9-fb06-4a08-148d-08d77315c9b7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1211:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1211B651519727476708FC9A83440@DM5PR12MB1211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(31686004)(446003)(11346002)(4326008)(50466002)(65806001)(47776003)(316002)(2616005)(186003)(46003)(2486003)(58126008)(229853002)(65956001)(6246003)(81166006)(81156014)(66556008)(386003)(66476007)(8676002)(6506007)(52116002)(7736002)(54906003)(76176011)(66946007)(23676004)(5660300002)(478600001)(6436002)(99286004)(6116002)(7416002)(8936002)(305945005)(6512007)(25786009)(6666004)(14454004)(86362001)(31696002)(2906002)(6486002)(36756003)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1211;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBwR4X1OeyHbwTFRpSndhJTtxNfxBFxCX+BLPN+6QiWJnW/zGWJAkg2LEMSgCYzxYdwogvLc4dtPU2DQAJ7IW7f7fxCWffx2EhQuq8TNXg2y0Dwn/2GwLp/pXO9rIKZbeFoPHNepGM9f4Td50fM/3wsukTuuD+1pUmsAljlSsSO/kxwYP/TG/sBY5sDK9n9oET3VTx1r95aPRfAmpXdRGzBVqEXHL91y5vywZ0a1XQ9aegkOJCjeC9Z6BTkz6f2Oe6UVs62mj4k5UElp9QK5zapfaPC9MIWuwzTofbK+aVnPtP5C9niyreoCRajOAZNzH67/mVSvUammoxBhuJ1q5Xg+t9ZFHfxdQ9SQk03QnKZ3Kfuort7QJ8YIPMppCQoclpKQ/oNjxws4B7IHdrnpcKLI77D8zhF3EdXqQG8l0TT8ovIIukIn0btupXbflTWV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aa8fc9-fb06-4a08-148d-08d77315c9b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 08:42:51.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLwdRiy11Jamxybl+T00UeynIieq/+3Yghcu08UusxpMHXLqCHunzTVBvDUgcaI2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.11.19 um 21:27 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> The TTM module today uses a hack to be able to set a different page
> protection than struct vm_area_struct::vm_page_prot. To be able to do
> this properly, add and export vmf_insert_mixed_prot().
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   include/linux/mm.h |  2 ++
>   mm/memory.c        | 15 +++++++++++----
>   2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc292273e6ba..29575d3c1e47 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2548,6 +2548,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>   			unsigned long pfn, pgprot_t pgprot);
>   vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>   			pfn_t pfn);
> +vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
> +			pfn_t pfn, pgprot_t pgprot);
>   vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
>   		unsigned long addr, pfn_t pfn);
>   int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
> diff --git a/mm/memory.c b/mm/memory.c
> index b1ca51a079f2..28f162e28144 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1719,9 +1719,9 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
>   }
>   
>   static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
> -		unsigned long addr, pfn_t pfn, bool mkwrite)
> +		unsigned long addr, pfn_t pfn, pgprot_t pgprot,
> +		bool mkwrite)
>   {
> -	pgprot_t pgprot = vma->vm_page_prot;
>   	int err;
>   
>   	BUG_ON(!vm_mixed_ok(vma, pfn));
> @@ -1764,10 +1764,17 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
>   	return VM_FAULT_NOPAGE;
>   }
>   
> +vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
> +				 pfn_t pfn, pgprot_t pgprot)
> +{
> +	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
> +}
> +EXPORT_SYMBOL(vmf_insert_mixed_prot);
> +
>   vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>   		pfn_t pfn)
>   {
> -	return __vm_insert_mixed(vma, addr, pfn, false);
> +	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, false);
>   }
>   EXPORT_SYMBOL(vmf_insert_mixed);
>   
> @@ -1779,7 +1786,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
>   vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
>   		unsigned long addr, pfn_t pfn)
>   {
> -	return __vm_insert_mixed(vma, addr, pfn, true);
> +	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, true);
>   }
>   EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
>   

