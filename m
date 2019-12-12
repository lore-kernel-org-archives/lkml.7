Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0060C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6721655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ox7L8w6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfLLIwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:52:12 -0500
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:6268
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbfLLIwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:52:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln6NqOWpXRwOoc9pfqu14ltLe98OSrRt3OxX2vqluahTnITmsz5lRLJpKbnxB6o2BEmImFUVYr7MafYb4OJcNDaAa2APXldK30DB5xcJ6NtkzItBwKceMlKNNg5NA9lkAAMXeG46Q7rEsFUihPkOwSs0LVGm/NnXcibpsM1psBulfb/TNbElxwXdVTp/V94nPfeygLjgcNBXks72I/tceO8sVOZjHW5UTIrJsN3P0eJ8VH1uI6CuxXrrqty84wDrdlcB67nKpbU/ULVkp6nNCoCz42u/a2rF7inOpBueozW+slQtlH6VN24CSWdzBHiqTfPXzNraHKilgDu0oWI9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlETBiJocwo3nGutkO+oNp6dDml2VMD+PWs2dmp1yc=;
 b=edRjhR85wGIthinBXoROGlcLeFlRy+3EP+0wgcWJixCvts40KdPA/+PSKye81NQpK6F3PIwckI0Zk6jxXHuF6mbrWahsZZaJHe4yFUkCa8t8axHNb6f9zTqJlON/uhjaRZfl4LFCAQCJpn2S+I30URGX5LnBCsegD+rxkHj2xguq/pl/qoUq7Ku0Q9800O0Jou1JmBCAJ7gDfUBEUE70eKIj9uwkL8BcvvhiMB7IYZ01CmxbYZMaSqBTxKXMc1tlmfNXMdEc3mkuRE5NTBtU9qle4VQM4mXq0sKU3DIVc3MXVwVeDMXqn66U7rvRRBeg5AAXjwgsXyMPG1TnaejkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlETBiJocwo3nGutkO+oNp6dDml2VMD+PWs2dmp1yc=;
 b=ox7L8w6XyvHmwB4/hVTVLbWR4hqmswTfJn5qSYjaZe117QhomffIUmaNZO0uLSKEY5xNYU9qxN+1HqKPF8VZANsxxLgGyhRDW6va4hLa45X0trygwhD9VraT3xRvnnfrZwhNcshBJ2uuTfdmJdYbsPhULukl8VJdvVP9N8nEN1w=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB7133.namprd05.prod.outlook.com (52.135.37.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 12 Dec 2019 08:51:30 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2538.012; Thu, 12 Dec 2019
 08:51:29 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     =?iso-8859-1?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 1/2] mm: Add a vmf_insert_mixed_prot() function
Thread-Topic: [PATCH v4 1/2] mm: Add a vmf_insert_mixed_prot() function
Thread-Index: AQHVsMjdT4HXSyfPGEWKrVNodB6x1w==
Date:   Thu, 12 Dec 2019 08:51:29 +0000
Message-ID: <MN2PR05MB6141C9205BBA112F43309D2FA1550@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191212084741.9251-1-thomas_os@shipmail.org>
 <20191212084741.9251-2-thomas_os@shipmail.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eee84b28-9902-400e-a743-08d77ee07b23
x-ms-traffictypediagnostic: MN2PR05MB7133:|MN2PR05MB7133:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB7133FEB2C3D9AF17F7A28E28A1550@MN2PR05MB7133.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(66574012)(186003)(26005)(9686003)(4326008)(55016002)(71200400001)(33656002)(53546011)(76116006)(5660300002)(91956017)(66946007)(316002)(54906003)(86362001)(110136005)(2906002)(66446008)(66476007)(64756008)(66556008)(81166006)(478600001)(8676002)(52536014)(6506007)(7696005)(81156014)(8936002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB7133;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y6+DPB//7MPAdsroIwQpu7wRYrajzJcdy+HAnW2NU6O04gQmacDA+lXUWjIgNMBEy3YN23Z9ji34mrZvGmlQvdB7wH1/Bu53xESKN7XX6pWNgIhgjyg5jSKaXitjG9XxNua3HhZ6xtO7Fw23e8B0iKyiQnECYCvyCjdnHKOW8v1mbvrXFHrouzJjpQWTKBGNQaUQrR/2eOCKj4CHRXNKjMEFXBN7VzFZcPfdMX2bxS17WdFhvzUqbYrtiISHAa4oPWOrnioyZiuTSqWrbtjHkYM91jZcvM0GsZwGRGmIHL+igyC+WQVVBZ6tdmGdbnBvvJ1b6kr0d6wk0e75/MGc8S5cbtvwEALx5FRHPK/e4TlYWfOpGFUCnH6A+UzHJXF/3V5ihr0lJUZOBtkE6D1Fx8G4aUZgx2esOUlcliR8QJCeRG7MVv0GqpSQjhK6/v9
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee84b28-9902-400e-a743-08d77ee07b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 08:51:29.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PA8vliywME4MRBw37xc/rYWcxHCE1GDyhVb++OWehw+ba6hwpbWhrHF8mmMb/wmoHE60hbXcLh4+mOppD8vI5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 9:48 AM, Thomas Hellstr=F6m (VMware) wrote:=0A=
> From: Thomas Hellstrom <thellstrom@vmware.com>=0A=
>=0A=
> The TTM module today uses a hack to be able to set a different page=0A=
> protection than struct vm_area_struct::vm_page_prot. To be able to do=0A=
> this properly, add the needed vm functionality as vmf_insert_mixed_prot()=
.=0A=
>=0A=
> Cc: Andrew Morton <akpm@linux-foundation.org>=0A=
> Cc: Michal Hocko <mhocko@suse.com>=0A=
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>=0A=
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>=0A=
> Cc: Ralph Campbell <rcampbell@nvidia.com>=0A=
> Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>=0A=
> Cc: "Christian K=F6nig" <christian.koenig@amd.com>=0A=
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>=0A=
> Acked-by: Christian K=F6nig <christian.koenig@amd.com>=0A=
> ---=0A=
>  include/linux/mm.h       |  2 ++=0A=
>  include/linux/mm_types.h |  7 ++++++-=0A=
>  mm/memory.c              | 43 ++++++++++++++++++++++++++++++++++++----=
=0A=
>  3 files changed, 47 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/include/linux/mm.h b/include/linux/mm.h=0A=
> index cc292273e6ba..29575d3c1e47 100644=0A=
> --- a/include/linux/mm.h=0A=
> +++ b/include/linux/mm.h=0A=
> @@ -2548,6 +2548,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struc=
t *vma, unsigned long addr,=0A=
>  			unsigned long pfn, pgprot_t pgprot);=0A=
>  vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long ad=
dr,=0A=
>  			pfn_t pfn);=0A=
> +vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned lo=
ng addr,=0A=
> +			pfn_t pfn, pgprot_t pgprot);=0A=
>  vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,=0A=
>  		unsigned long addr, pfn_t pfn);=0A=
>  int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsig=
ned long len);=0A=
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h=0A=
> index 2222fa795284..ac96afdbb4bc 100644=0A=
> --- a/include/linux/mm_types.h=0A=
> +++ b/include/linux/mm_types.h=0A=
> @@ -307,7 +307,12 @@ struct vm_area_struct {=0A=
>  	/* Second cache line starts here. */=0A=
>  =0A=
>  	struct mm_struct *vm_mm;	/* The address space we belong to. */=0A=
> -	pgprot_t vm_page_prot;		/* Access permissions of this VMA. */=0A=
> +=0A=
> +	/*=0A=
> +	 * Access permissions of this VMA.=0A=
> +	 * See vmf_insert_mixed() for discussion.=0A=
=0A=
Typo. will of course be vmf_insert_mixed_prot() in the final version.=0A=
=0A=
=0A=
