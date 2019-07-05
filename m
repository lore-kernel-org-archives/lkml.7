Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E69C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BA42184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="GmPJjx4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGEB0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:26:14 -0400
Received: from mail-eopbgr810084.outbound.protection.outlook.com ([40.107.81.84]:51520
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfGEB0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyr8N5nE5x00DAeGSch/zm71Lo4/OR1ezRx5J/vmHYc=;
 b=GmPJjx4UH9+mer7OAMxQjnvkxAZ3IF0qp3irVUXvCXgXzKYhVy86/j90DIBZdeLG5/2XQMhWQS9rj776H6NF/f/Ji3LhRPZEWE1IvtZy6a1yh0HfNdh0Wgqc9q+3NIUoWV8V/P8/Afc4/XE9kVNXZV1VK+qDyqIXUwbJ0oAZ+mI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5864.namprd05.prod.outlook.com (20.178.50.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.14; Fri, 5 Jul 2019 01:26:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 01:26:10 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [patch V2 21/25] x86/smp: Enhance native_send_call_func_ipi()
Thread-Topic: [patch V2 21/25] x86/smp: Enhance native_send_call_func_ipi()
Thread-Index: AQHVMoZQ1wtoUEJrLk6xt836w3tppqa7PDEA
Date:   Fri, 5 Jul 2019 01:26:10 +0000
Message-ID: <C77F4C58-9CA3-4784-AE98-A9D6EDD4A788@vmware.com>
References: <20190704155145.617706117@linutronix.de>
 <20190704155610.325211809@linutronix.de>
In-Reply-To: <20190704155610.325211809@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [73.93.152.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e246ec79-79f4-410c-b700-08d700e7c2f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5864;
x-ms-traffictypediagnostic: BYAPR05MB5864:
x-microsoft-antispam-prvs: <BYAPR05MB58644DE11D037A1EDABF73FAD0F50@BYAPR05MB5864.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(6436002)(7736002)(14454004)(54906003)(36756003)(71200400001)(2906002)(6486002)(71190400001)(316002)(66066001)(73956011)(53936002)(305945005)(99286004)(76176011)(6512007)(5660300002)(486006)(4326008)(256004)(26005)(478600001)(6116002)(66946007)(186003)(102836004)(8676002)(66446008)(68736007)(66556008)(66476007)(3846002)(81156014)(81166006)(64756008)(11346002)(53546011)(6246003)(6916009)(33656002)(86362001)(2616005)(446003)(25786009)(476003)(229853002)(6506007)(76116006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5864;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hZoYc1UCnTmTnMIGAEoKZS8V9qjBg53AQPoVxicnu12xg+1D3rMtnGyBMylFphiOwwP1mz5+rKwAT9/g5rmDxKXaBHHtaTumfjRWuhFwaTUqDcgPabr4Yc7WRW7gqGccW0Tp8IX6HD5viVraCVRZ8scAv91ti5qiwrRdL4Mz+pSGjhbaVJFkEU0qxB76wWfEdYMkR50zGgJzMP47qbz1FEob36LRBvKrPOn5n2HpudAFpN+IcR6lFNVY48WgFZFVGXzqS6/9euc4KV7GMvT6JM7Vyt8D3PYJnkZZwlX683Wta5BzQ5fq+JL3iEFpNxXjvvTdgRqddronl7SdYRdvGUVgGNuhDae1aQci+lYaXKg+kZR3DZeWkjQ80hBHyQra828Pfs58sD5hiw5VtRE+YDDD0zG1oFkK0wNBKIXUfTM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9DC42EBEF48FC4794CF1D7AB2C3AEEB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e246ec79-79f4-410c-b700-08d700e7c2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 01:26:10.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 4, 2019, at 8:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Nadav noticed that the cpumask allocations in native_send_call_func_ipi()
> are noticeable in microbenchmarks.
>=20
> Use the new cpumask_or_equal() function to simplify the decision whether
> the supplied target CPU mask is either equal to cpu_online_mask or equal =
to
> cpu_online_mask except for the CPU on which the function is invoked.
>=20
> cpumask_or_equal() or's the target mask and the cpumask of the current CP=
U
> together and compares it to cpu_online_mask.
>=20
> If the result is false, use the mask based IPI function, otherwise check
> whether the current CPU is set in the target mask and invoke either the
> send_IPI_all() or the send_IPI_allbutselt() APIC callback.
>=20
> Make the shorthand decision also depend on the static key which enables
> shorthand mode. That allows to remove the extra cpumask comparison with
> cpu_callout_mask.
>=20
> Reported-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
> arch/x86/kernel/apic/ipi.c |   24 +++++++++++-------------
> 1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> --- a/arch/x86/kernel/apic/ipi.c
> +++ b/arch/x86/kernel/apic/ipi.c
> @@ -83,23 +83,21 @@ void native_send_call_func_single_ipi(in
>=20
> void native_send_call_func_ipi(const struct cpumask *mask)
> {
> -	cpumask_var_t allbutself;
> +	if (static_branch_likely(&apic_use_ipi_shorthand)) {
> +		unsigned int cpu =3D smp_processor_id();
>=20
> -	if (!alloc_cpumask_var(&allbutself, GFP_ATOMIC)) {
> -		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
> +		if (!cpumask_or_equal(mask, cpumask_of(cpu), cpu_online_mask))
> +			goto sendmask;
> +
> +		if (cpumask_test_cpu(cpu, mask))
> +			apic->send_IPI_all(CALL_FUNCTION_VECTOR);
> +		else if (num_online_cpus() > 1)
> +			apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
> 		return;
> 	}
>=20
> -	cpumask_copy(allbutself, cpu_online_mask);
> -	cpumask_clear_cpu(smp_processor_id(), allbutself);
> -
> -	if (cpumask_equal(mask, allbutself) &&
> -	    cpumask_equal(cpu_online_mask, cpu_callout_mask))
> -		apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
> -	else
> -		apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
> -
> -	free_cpumask_var(allbutself);
> +sendmask:
> +	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
> }
>=20
> #endif /* CONFIG_SMP */

It does look better and simpler than my solution.

