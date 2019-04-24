Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A81C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6184A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="bsH/Aabd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbfDXVA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:00:29 -0400
Received: from mail-eopbgr710105.outbound.protection.outlook.com ([40.107.71.105]:31136
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728550AbfDXVA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOT/+DUgszLcrbfaRdbO/zO1M2y8tlf7cIV6MkIKZE4=;
 b=bsH/Aabdsis9J5+43i92pghL3T2zWua5TZi9bJYAWMXNtkzaIwGXeD8ie8UczXnc7rwEPIUuhm7Er0xsouhkllofUonp9S5hSh9HZ5k7Uqu06MvMuFw/XN/CD2p7Jc8gGrqkyiEdu8vfLECRDBQ20AlNL8vsgEtqxnZTELZbYc4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1184.namprd22.prod.outlook.com (10.174.171.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Wed, 24 Apr 2019 21:00:25 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:00:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/5] mips/atomic: Fix cmpxchg64 barriers
Thread-Topic: [RFC][PATCH 1/5] mips/atomic: Fix cmpxchg64 barriers
Thread-Index: AQHU+pvwawy65CxsF0GOpcWZvtS0jqZLzDwA
Date:   Wed, 24 Apr 2019 21:00:25 +0000
Message-ID: <20190424210019.knq4nijg3xoqxzhg@pburton-laptop>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.579563933@infradead.org>
In-Reply-To: <20190424124421.579563933@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b347710a-afb5-4766-55ed-08d6c8f7df9a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1184;
x-ms-traffictypediagnostic: MWHPR2201MB1184:
x-microsoft-antispam-prvs: <MWHPR2201MB118427C3012DD48EB0D9F336C13C0@MWHPR2201MB1184.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39850400004)(396003)(366004)(376002)(346002)(189003)(199004)(229853002)(33716001)(478600001)(486006)(6916009)(44832011)(6246003)(53936002)(6512007)(9686003)(6486002)(4326008)(6436002)(97736004)(7416002)(99286004)(25786009)(6116002)(3846002)(256004)(64756008)(66556008)(66446008)(52116002)(316002)(54906003)(66476007)(11346002)(71200400001)(66946007)(73956011)(81166006)(71190400001)(81156014)(58126008)(66066001)(2906002)(6506007)(446003)(8936002)(386003)(76176011)(476003)(42882007)(14454004)(68736007)(26005)(186003)(5660300002)(1076003)(7736002)(102836004)(305945005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1184;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uqua0xzxYTj6Dq7GbH3qjcWpi8WsdxG9AxdID8sXeeOOD0GDmzKsPYZ8KlAPEvvRDUIAD0sEsoP3erC2C/FMeWMtF3BfsJyidRjOWUiwCx4kMQA5/v3nRwULUWIR8Rwegj5nDWrTw8RaRuWT/utFtAC/dPfK5QnjiRdvVHx5Cs1VEUk2t2SuH5e40LVoKVSLxHnW7cfeUtzrwzIEVDD5PlMr1Z2uIUcZ/KZaBGjEAul4JbEK8EewEOfxwuxYZW3kfqAezKwpxBUbn9blnVnaBpKvC7n7ZVdsG5DxAV8Mgq4FK4vnep5ZyRdliOnRpv9YG8H2LKQfrIAWyaJnVFLNIHyjrFevJWs4m0zG5dTbOnVDrfhjF/FVWBjbWM77BWqn0Rfd6D0YRbphZTfVlQDYV3C591dQg1kpa0Ae3Dr2W9A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74F48E10B6823E4A86FEA110A04070FE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b347710a-afb5-4766-55ed-08d6c8f7df9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:00:25.7137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Apr 24, 2019 at 02:36:57PM +0200, Peter Zijlstra wrote:
> There were no memory barriers on cmpxchg64() _at_all_. Fix this.

This does looks problematic, but it's worth noting that this code path
is only applicable to 32b kernels running on 64b CPUs which is pretty
rare. The commit message as-is suggests to me that all configurations
are broken, which isn't the case (at least, not in this respect :) ).

>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/mips/include/asm/cmpxchg.h |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> --- a/arch/mips/include/asm/cmpxchg.h
> +++ b/arch/mips/include/asm/cmpxchg.h
> @@ -290,9 +290,11 @@ static inline unsigned long __cmpxchg64(
>  	 * will cause a build error unless cpu_has_64bits is a		\
>  	 * compile-time constant 1.					\
>  	 */								\
> -	if (cpu_has_64bits && kernel_uses_llsc)				\
> +	if (cpu_has_64bits && kernel_uses_llsc) {			\
> +		smp_mb__before_llsc();					\
>  		__res =3D __cmpxchg64((ptr), __old, __new);		\
> -	else								\
> +		smp_llsc_mb();						\
> +	} else								\
>  		__res =3D __cmpxchg64_unsupported();			\

It would be good to also add braces around the else block, and I believe
checkpatch should be complaining about that ("braces {} should be used
on all arms of this statement").

Thanks,
    Paul

>  									\
>  	__res;								\
>=20
>=20
