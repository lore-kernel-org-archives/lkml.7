Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E969DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D4F2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="IRLL/zmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfHZQ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:26:07 -0400
Received: from mail-eopbgr790049.outbound.protection.outlook.com ([40.107.79.49]:10815
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729338AbfHZQ0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWXQPYT6fH47p6KKXYtcINducogqtS3fwe10SDf2M5D9FF6+wxWzHoeExDjpbwadyjxKE5/aV8rqm1NsCmr8akBpHnPfcuQj0EIPQe9ijXbR3+gyXhLjsWHbXLvOJevyBI6W/5FItoHEOPyYqtq6IT5SQxgaVGk0fEjfeQCyG+sG0TZ0fOtQZX6mHMsuibqjjSsavJCUZBe4eAqeiQTKkZCQVJmyLOQPYXYmUTzc78V+VHI6+u0bk6122N1744FSIWjUx6zxBhkx4g+SsrGiFQWEhsEAc3IvVcV7FVmNODQCyeKxPHmMEQtnuGh30RKJ5Xe3VvjOB0eFney1TC8kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMRmjMpv5ehreJ1emeqjYb7xwtVP0OjM8MOCTAuz8mY=;
 b=mSvPNxhl8Y/rXzppqZisdnYCNB9Lej+NxOhy3A0KtbK/5cU0UoLvLUEOgw00eSEp50T9TTkxz+WPrae36B7q7VjFZLHsavrfaS+rskz8J+LgkL5h5orJY7jTVIlwvzWMaNOXLay4SIffFo+LhtOd1U3rSzpH/vINWIxXAJ3hOfYbPQyA4tfAtV0CFbImI6MKvwt8iYU5nY48TUZljUPDKvVzxlXd5VwCg6izadHSF2bpVVMtPVhzalfdNNhSXQG8SXGb4uN416AUNDUMDmhn2+/vMZWrDNimAlv16cRbmkK18cvr/FjWg3tUxNMBxy8K1yd8vnwhVtXSwP6fdy+LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMRmjMpv5ehreJ1emeqjYb7xwtVP0OjM8MOCTAuz8mY=;
 b=IRLL/zmfpiwuSoc+k1JuF1WBJ3F3L5UjV8f8yQg9iFVuCJH5gmDP/dvtPk+IjXEP4ars1mzJMuD016/oZ9KmBvZcS6OnaWb7Yc2qQNpNNdtq7ODOQFXPDcfRn/18p1s7fnsg9p3ddgPLf+8DKcvWL67hB0SZ3/W4nN4EebXbl2w=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5367.namprd05.prod.outlook.com (20.177.127.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Mon, 26 Aug 2019 16:25:59 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Mon, 26 Aug 2019
 16:25:59 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Topic: [PATCH v4 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Thread-Index: AQHVWkGNDY5DvSQvLUGQ0OCwuZ1BlKcNoV8A
Date:   Mon, 26 Aug 2019 16:25:58 +0000
Message-ID: <98DE1002-07A4-450A-BE13-CE2B5D0CB89C@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
 <20190823224153.15223-2-namit@vmware.com>
In-Reply-To: <20190823224153.15223-2-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d330c1cc-c806-4175-2260-08d72a421430
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5367;
x-ms-traffictypediagnostic: BYAPR05MB5367:
x-microsoft-antispam-prvs: <BYAPR05MB53673498CAF962AD690DC81AD0A10@BYAPR05MB5367.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(6436002)(81166006)(4326008)(36756003)(7736002)(3846002)(6116002)(305945005)(53936002)(25786009)(6246003)(5660300002)(229853002)(81156014)(71190400001)(2906002)(71200400001)(6506007)(102836004)(54906003)(76176011)(110136005)(99286004)(33656002)(186003)(53546011)(26005)(316002)(256004)(8676002)(14444005)(8936002)(66066001)(76116006)(476003)(2616005)(11346002)(478600001)(6486002)(486006)(86362001)(14454004)(66476007)(66556008)(64756008)(66446008)(66946007)(446003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5367;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4M9NXC9/6chYFM5wbgpPA2dti7/w5XTaxpBb9KYAn2JGPiSpCtYL0pFkZT/1egAKFKtRjd5GqEa/qLrXNZTGLLIDlg3br10hPdoWsQqKvji96ZMJimXNQBP375ISszEb8szdQRQv8RoBAtt4yhv080wIe1DssBOX111D6+w04lAnGBENg/RB77rfh1Xd9cbj/5HEVANfbNmUvyH5LR1crpqercXCtL1C3uiic2X2TfRE+hv4o+kA4qTKevGz5bcXBUnHXXIoHaopZd8pryRSa8XX06GHbPaL8b0mlJWKlxPHo4e/GN5S5cf7FNnJUneR2/3z5r1BjkLlhKUlPf9MYqTQWQY9KzYiIxYfSQetw73d+mhfN4dETGLsUeQ+cM0ds36kJ/rHePfTp7M1y7VcPX+TBHS5/BL1ZoNB+Jfq9X8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92F8ADE6852E9643877EAC07DEFC28DE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d330c1cc-c806-4175-2260-08d72a421430
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 16:25:58.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPoHAiIbi2FTLqiG1fZF7zlhiCgUKMtKFYl7EIJTicQ1bokbffejejYgkfNsjBWAnn9ykOIEaSUwQQpqwjc8Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Aug 23, 2019, at 3:41 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
> Currently, on_each_cpu() and similar functions do not exploit the
> potential of concurrency: the function is first executed remotely and
> only then it is executed locally. Functions such as TLB flush can take
> considerable time, so this provides an opportunity for performance
> optimization.
>=20
> To do so, introduce __smp_call_function_many(), which allows the callers
> to provide local and remote functions that should be executed, and run
> them concurrently. Keep smp_call_function_many() semantic as it is today
> for backward compatibility: the called function is not executed in this
> case locally.
>=20
> __smp_call_function_many() does not use the optimized version for a
> single remote target that smp_call_function_single() implements. For
> synchronous function call, smp_call_function_single() keeps a
> call_single_data (which is used for synchronization) on the stack.
> Interestingly, it seems that not using this optimization provides
> greater performance improvements (greater speedup with a single remote
> target than with multiple ones). Presumably, holding data structures
> that are intended for synchronization on the stack can introduce
> overheads due to TLB misses and false-sharing when the stack is used for
> other purposes.
>=20
> Adding support to run the functions concurrently required to remove a
> micro-optimization in on_each_cpu() that disabled/enabled IRQs instead
> of saving/restoring them. The benefit of running the local and remote
> code concurrently is expected to be greater.
>=20
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
> include/linux/smp.h |  34 ++++++++---
> kernel/smp.c        | 138 +++++++++++++++++++++-----------------------
> 2 files changed, 92 insertions(+), 80 deletions(-)
>=20
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 6fc856c9eda5..d18d54199635 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -32,11 +32,6 @@ extern unsigned int total_cpus;
> int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
> 			     int wait);
>=20
> -/*
> - * Call a function on all processors
> - */
> -void on_each_cpu(smp_call_func_t func, void *info, int wait);
> -
> /*
>  * Call a function on processors specified by mask, which might include
>  * the local one.
> @@ -44,6 +39,17 @@ void on_each_cpu(smp_call_func_t func, void *info, int=
 wait);
> void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
> 		void *info, bool wait);
>=20
> +/*
> + * Call a function on all processors.  May be used during early boot whi=
le
> + * early_boot_irqs_disabled is set.
> + */
> +static inline void on_each_cpu(smp_call_func_t func, void *info, int wai=
t)
> +{
> +	preempt_disable();
> +	on_each_cpu_mask(cpu_online_mask, func, info, wait);
> +	preempt_enable();
> +}

Err.. I made this change the last minute before sending, and apparently
forgot to build, since it does not build.

Let me know if there is anything else with this version, though.=
