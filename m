Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B83C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7874206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tqAjREXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFUOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:36:12 -0400
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:1795
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfFUOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX5L5F8xPNoJ5V01tQB34FROEeVHHpne1sUFjq/ejGY=;
 b=tqAjREXxnx8hE2bqXIoeIy3DDhwPviqOBrxrnYOVFBwek97GDcXe2IsPRK6kZugNUCWRsrwywSgu0DHg3djMSlRFNEmk5QCGzrA/LTW0F/HAUkE70obv1f8NK5rB7KnMSGfPAkfAjmfFhUsHHVHcS2qyEch61Sz9IfGHVzgy/A8=
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com (20.179.12.12) by
 DB8PR08MB5243.eurprd08.prod.outlook.com (20.179.15.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 14:35:54 +0000
Received: from DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::b4db:b3ed:75ff:167]) by DB8PR08MB4105.eurprd08.prod.outlook.com
 ([fe80::b4db:b3ed:75ff:167%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 14:35:54 +0000
From:   Steve Capper <Steve.Capper@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "david@redhat.com" <david@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        James Morse <James.Morse@arm.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH V6 3/3] arm64/mm: Enable memory hot remove
Thread-Topic: [PATCH V6 3/3] arm64/mm: Enable memory hot remove
Thread-Index: AQHVJlX53xPGOkVoAU2rO4Hf7Xy7J6amMIYA
Date:   Fri, 21 Jun 2019 14:35:53 +0000
Message-ID: <20190621143540.GA3376@capper-debian.cambridge.arm.com>
References: <1560917860-26169-1-git-send-email-anshuman.khandual@arm.com>
 <1560917860-26169-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1560917860-26169-4-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [82.20.117.196]
x-clientproxiedby: DM5PR18CA0057.namprd18.prod.outlook.com
 (2603:10b6:3:22::19) To DB8PR08MB4105.eurprd08.prod.outlook.com
 (2603:10a6:10:b0::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.Capper@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 255e8f05-0120-466c-08c8-08d6f655c382
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR08MB5243;
x-ms-traffictypediagnostic: DB8PR08MB5243:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB8PR08MB5243320303F4912FC6AAB43881E70@DB8PR08MB5243.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(66446008)(5660300002)(3846002)(229853002)(54906003)(66066001)(8676002)(6246003)(6486002)(6862004)(81156014)(4326008)(6436002)(316002)(81166006)(66476007)(66556008)(6512007)(66946007)(53936002)(14444005)(99286004)(58126008)(8936002)(44832011)(76176011)(7416002)(6636002)(26005)(33656002)(446003)(102836004)(7736002)(64756008)(486006)(52116002)(6116002)(186003)(73956011)(476003)(25786009)(71200400001)(71190400001)(2906002)(86362001)(11346002)(6506007)(386003)(68736007)(478600001)(14454004)(305945005)(256004)(1076003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5243;H:DB8PR08MB4105.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dlqzxa4c3rI15RIYjatdpzG4RA3W30poknff97UGqg+YZ9slzXe1e90bipr9EPWaFPm2KynI0rxMfy7783taBsoETxHXuo888UztQ8fXKJQF2B93AbjfNkqXuSINJnnnUBOH1UK8c+SFcgYHrhw6a12K6kEbUeGomLLQ5NAjXOVcHmqQ8SRlCv3KxSHn60nmHIApe7W2iOE0B4YEgqoAgEtRFRBCvK9SX6WKXKBbZkkPWaqSK3dKGprAn44V+1VP1WaDh5o6U7+UNTBqyaK52f6Epjsks/FHE5wvtNLNP+u3SZ3lAe8XkkcTPnRJLGInzsb3vfiS6UFSQN3JWQePxJVTQxXkPPT8eLv3x4spesy6ktZQ0gEtbEmSQ7Gpz5iA/CDbqNf4sNHGFdD8eEWcXoXhl2uK6xX1lnHSPp0rY8Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13FA276463D2474F8F2A95257EB18BC4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255e8f05-0120-466c-08c8-08d6f655c382
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 14:35:53.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Steve.Capper@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5243
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Wed, Jun 19, 2019 at 09:47:40AM +0530, Anshuman Khandual wrote:
> The arch code for hot-remove must tear down portions of the linear map an=
d
> vmemmap corresponding to memory being removed. In both cases the page
> tables mapping these regions must be freed, and when sparse vmemmap is in
> use the memory backing the vmemmap must also be freed.
>=20
> This patch adds a new remove_pagetable() helper which can be used to tear
> down either region, and calls it from vmemmap_free() and
> ___remove_pgd_mapping(). The sparse_vmap argument determines whether the
> backing memory will be freed.
>=20
> remove_pagetable() makes two distinct passes over the kernel page table.
> In the first pass it unmaps, invalidates applicable TLB cache and frees
> backing memory if required (vmemmap) for each mapped leaf entry. In the
> second pass it looks for empty page table sections whose page table page
> can be unmapped, TLB invalidated and freed.
>=20
> While freeing intermediate level page table pages bail out if any of its
> entries are still valid. This can happen for partially filled kernel page
> table either from a previously attempted failed memory hot add or while
> removing an address range which does not span the entire page table page
> range.
>=20
> The vmemmap region may share levels of table with the vmalloc region.
> There can be conflicts between hot remove freeing page table pages with
> a concurrent vmalloc() walking the kernel page table. This conflict can
> not just be solved by taking the init_mm ptl because of existing locking
> scheme in vmalloc(). Hence unlike linear mapping, skip freeing page table
> pages while tearing down vmemmap mapping.
>=20
> While here update arch_add_memory() to handle __add_pages() failures by
> just unmapping recently added kernel linear mapping. Now enable memory ho=
t
> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>=20
> This implementation is overall inspired from kernel page table tear down
> procedure on X86 architecture.
>=20
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

FWIW:
Acked-by: Steve Capper <steve.capper@arm.com>

One minor comment below though.

>  arch/arm64/Kconfig  |   3 +
>  arch/arm64/mm/mmu.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 284 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6426f48..9375f26 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -270,6 +270,9 @@ config HAVE_GENERIC_GUP
>  config ARCH_ENABLE_MEMORY_HOTPLUG
>  	def_bool y
> =20
> +config ARCH_ENABLE_MEMORY_HOTREMOVE
> +	def_bool y
> +
>  config SMP
>  	def_bool y
> =20
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 93ed0df..9e80a94 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -733,6 +733,250 @@ int kern_addr_valid(unsigned long addr)
> =20
>  	return pfn_valid(pte_pfn(pte));
>  }
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void free_hotplug_page_range(struct page *page, size_t size)
> +{
> +	WARN_ON(!page || PageReserved(page));
> +	free_pages((unsigned long)page_address(page), get_order(size));
> +}

We are dealing with power of 2 number of pages, it makes a lot more
sense (to me) to replace the size parameter with order.

Also, all the callers are for known compile-time sizes, so we could just
translate the size parameter as follows to remove any usage of get_order?
PAGE_SIZE -> 0
PMD_SIZE -> PMD_SHIFT - PAGE_SHIFT
PUD_SIZE -> PUD_SHIFT - PAGE_SHIFT

Cheers,
--=20
Steve
