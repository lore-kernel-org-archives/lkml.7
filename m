Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B16C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90589206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XXJabd61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfDYTNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:13:24 -0400
Received: from mail-eopbgr810048.outbound.protection.outlook.com ([40.107.81.48]:60480
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbfDYTNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0LsipdEkuLyNmTkXVXMgfR+UKS4SD6EhxnHPsFh6VQ=;
 b=XXJabd61L5roZWK0/zvLSnZQ2IicdD65NHnO4vO9vnSLloG3DtS5zp4yRIpAsUEsw+EutUM8JLahZXtbDmMq1JHH2dyk3p2AhOrtdG6UhpGmdq11XAbjTA3LaQtBDVymokdycSnO3IWv0jy1ZMMObGylP8ctaXZ77rpmzvBrWlE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6054.namprd05.prod.outlook.com (20.178.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.11; Thu, 25 Apr 2019 19:13:17 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 19:13:17 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Topic: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Index: AQHU+5HncRUmcKTEhES/sxCi8aqoJ6ZNProA
Date:   Thu, 25 Apr 2019 19:13:17 +0000
Message-ID: <F2218F7E-2011-4AAA-B3A3-F13A1A438204@vmware.com>
References: <20190425180828.24959-1-namit@vmware.com>
In-Reply-To: <20190425180828.24959-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0044e05-c183-4f19-48dc-08d6c9b212b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB6054;
x-ms-traffictypediagnostic: BYAPR05MB6054:
x-microsoft-antispam-prvs: <BYAPR05MB60549B3BC986584FCCA7B9D2D03D0@BYAPR05MB6054.namprd05.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(6116002)(6436002)(186003)(11346002)(102836004)(3846002)(476003)(36756003)(2906002)(305945005)(86362001)(81166006)(6506007)(81156014)(14444005)(7736002)(446003)(66446008)(486006)(66476007)(76116006)(64756008)(66066001)(26005)(2616005)(8936002)(73956011)(71200400001)(71190400001)(83716004)(5660300002)(66556008)(229853002)(66946007)(6486002)(76176011)(4326008)(53546011)(25786009)(256004)(6512007)(8676002)(97736004)(99286004)(316002)(478600001)(53936002)(6246003)(54906003)(82746002)(110136005)(33656002)(68736007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6054;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kqir9mD+sc6WP/yaP2autiLm5oh3VhXTwVwx2F6ZRog0vY6EBlNFHipxqAlXT1exftEg7DV+scq4l+4mONUmzmYmN2T5DEHEqfRuBRyWA6Kh1HA1IMFz+1QkJGwqynaxzc8j/dwyTP1CaNlGCDyATqRd+u7f6Yb5QryTh8SP0OvHXz3tCcNtaQyZefV7gyN51uRXJY/4elnXCo03GGu0P+wR38ga2CmC24pv4SRtuXcfacrykAAvvZqvewV1YL+XVbkmZY1QmjguUGikqPULWhxlriGwdMYVBsL1oaRa8o+xBmGrIHs88pRYnxvDZv8YtpBH9aVrgyUPdAx9wUH16TbPQsQGPTCS2lVVLRKv6q5Pckx9t9XR3X93nxRybsijxxpY/SuTyZwLsO8lRBqvR3pRDue+tgiGp1jbdx9Tikc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2817D4BEA80C3F4693347DEB60D2C8C6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0044e05-c183-4f19-48dc-08d6c9b212b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 19:13:17.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 25, 2019, at 11:08 AM, Nadav Amit <namit@vmware.com> wrote:
>=20
> Move flush_tlb_info variables off the stack. This allows to align
> flush_tlb_info to cache-line and avoid potentially unnecessary cache
> line movements. It also allows to have a fixed virtual-to-physical
> translation of the variables, which reduces TLB misses.
>=20
> Use per-CPU struct for flush_tlb_mm_range() and
> flush_tlb_kernel_range(). Add debug assertions to ensure there are
> no nested TLB flushes that might overwrite the per-CPU data. For
> arch_tlbbatch_flush() use a const struct.
>=20
> Results when running a microbenchmarks that performs 10^6 MADV_DONTEED
> operations and touching a page, in which 3 additional threads run a
> busy-wait loop (5 runs, PTI and retpolines are turned off):
>=20
> 			base		off-stack
> 			----		---------
> avg (usec/op)		1.629		1.570	(-3%)
> stddev			0.014		0.009
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nadav Amit <namit@vmware.com>
>=20
> ---
>=20
> v1->v2:
> - Initialize all flush_tlb_info fields [Andy]
> ---
> arch/x86/mm/tlb.c | 100 ++++++++++++++++++++++++++++++++++------------
> 1 file changed, 74 insertions(+), 26 deletions(-)
>=20
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 487b8474c01c..aac191eb2b90 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -634,7 +634,7 @@ static void flush_tlb_func_common(const struct flush_=
tlb_info *f,
> 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
> }
>=20
> -static void flush_tlb_func_local(void *info, enum tlb_flush_reason reaso=
n)
> +static void flush_tlb_func_local(const void *info, enum tlb_flush_reason=
 reason)
> {
> 	const struct flush_tlb_info *f =3D info;
>=20
> @@ -722,43 +722,81 @@ void native_flush_tlb_others(const struct cpumask *=
cpumask,
>  */
> unsigned long tlb_single_page_flush_ceiling __read_mostly =3D 33;
>=20
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_in=
fo);
> +
> +#ifdef CONFIG_DEBUG_VM
> +static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
> +#endif
> +
> +static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct=
 *mm,
> +			unsigned long start, unsigned long end,
> +			unsigned int stride_shift, bool freed_tables,
> +			u64 new_tlb_gen)
> +{
> +	struct flush_tlb_info *info =3D this_cpu_ptr(&flush_tlb_info);
> +
> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * Ensure that the following code is non-reentrant and flush_tlb_info
> +	 * is not overwritten. This means no TLB flushing is initiated by
> +	 * interrupt handlers and machine-check exception handlers.
> +	 */
> +	BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) !=3D 1);
> +#endif
> +
> +	info->start =3D start;
> +	info->end =3D end;
> +	info->mm =3D mm;
> +	info->stride_shift =3D stride_shift;
> +	info->freed_tables =3D freed_tables;
> +	info->new_tlb_gen =3D new_tlb_gen;
> +
> +	return info;
> +}
> +
> +static inline void put_flush_tlb_info(void)
> +{
> +#ifdef CONFIG_DEBUG_VM
> +	/* Complete reentrency prevention checks */
> +	barrier();
> +	this_cpu_dec(flush_tlb_info_idx);
> +#endif
> +}
> +
> void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> 				unsigned long end, unsigned int stride_shift,
> 				bool freed_tables)
> {
> +	struct flush_tlb_info *info;
> +	u64 new_tlb_gen;
> 	int cpu;
>=20
> -	struct flush_tlb_info info =3D {
> -		.mm =3D mm,
> -		.stride_shift =3D stride_shift,
> -		.freed_tables =3D freed_tables,
> -	};
> -
> 	cpu =3D get_cpu();
>=20
> -	/* This is also a barrier that synchronizes with switch_mm(). */
> -	info.new_tlb_gen =3D inc_mm_tlb_gen(mm);
> -
> 	/* Should we flush just the requested range? */
> -	if ((end !=3D TLB_FLUSH_ALL) &&
> -	    ((end - start) >> stride_shift) <=3D tlb_single_page_flush_ceiling)=
 {
> -		info.start =3D start;
> -		info.end =3D end;
> -	} else {
> -		info.start =3D 0UL;
> -		info.end =3D TLB_FLUSH_ALL;
> +	if ((end =3D=3D TLB_FLUSH_ALL) ||
> +	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
> +		start =3D 0UL;
> +		end =3D TLB_FLUSH_ALL;
> 	}
>=20
> +	/* This is also a barrier that synchronizes with switch_mm(). */
> +	new_tlb_gen =3D inc_mm_tlb_gen(mm);
> +
> +	info =3D get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
> +				  new_tlb_gen);
> +
> 	if (mm =3D=3D this_cpu_read(cpu_tlbstate.loaded_mm)) {
> -		VM_WARN_ON(irqs_disabled());
> +		lockdep_assert_irqs_enabled();
> 		local_irq_disable();
> -		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
> +		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
> 		local_irq_enable();
> 	}
>=20
> 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -		flush_tlb_others(mm_cpumask(mm), &info);
> +		flush_tlb_others(mm_cpumask(mm), info);
>=20
> +	put_flush_tlb_info();
> 	put_cpu();
> }
>=20
> @@ -787,22 +825,32 @@ static void do_kernel_range_flush(void *info)
>=20
> void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> {
> -
> 	/* Balance as user space task's flush, a bit conservative */
> 	if (end =3D=3D TLB_FLUSH_ALL ||
> 	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
> 		on_each_cpu(do_flush_tlb_all, NULL, 1);
> 	} else {
> -		struct flush_tlb_info info;
> -		info.start =3D start;
> -		info.end =3D end;
> -		on_each_cpu(do_kernel_range_flush, &info, 1);
> +		struct flush_tlb_info *info;
> +
> +		preempt_disable();
> +
> +		info =3D get_flush_tlb_info(NULL, start, end, 0, false, 0);
> +
> +		info =3D this_cpu_ptr(&flush_tlb_info);
> +		info->start =3D start;
> +		info->end =3D end;

Err.. This is wrong. I will send v3 shortly.

