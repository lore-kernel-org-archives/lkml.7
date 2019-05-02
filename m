Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B118C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4A02089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GOeBl2cW";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Mhtx4AIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEBI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:28:05 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54530 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726159AbfEBI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:28:04 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x428K7sq027610;
        Thu, 2 May 2019 01:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=AJnjTbtQKNDiHUvR/Et9zpGCDpQiI/GWOcEHAS9GjKw=;
 b=GOeBl2cW+JGcdWLcV783+JzmW7Aor9KPr+I0dLhOwADZsB9P0BFGjAGMeR7GUirPXFTc
 djBa4BOpIc0PAg/r/llpIteWMwfdS/ohxc9JNOZs1U2Yc/OcY0P72VXsJcjAawKjpnkA
 NPut+GeeyYhSsVZPQpfuIzfHJ55fW/nfjNTi+sYSpi2Nr7LPCclS+kW5SKY8WujE0OZb
 DMKuDy1n4FL3w6oRfxN7tVyDqfNJAGU0OiubIx4Hv57jrc6f+pmNtgR608KlnbAHHgrn
 0BrznSrwXJiPZ3pNRciVKkNcizXwrL3jiFEXsFIGKG73pSmgtzMEeg3TSqgvJtgHnJRW pQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2s7gk4afw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 01:27:53 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 2 May
 2019 01:27:53 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 2 May 2019 01:27:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJnjTbtQKNDiHUvR/Et9zpGCDpQiI/GWOcEHAS9GjKw=;
 b=Mhtx4AIMtyRA+xYie4BCkxlMcZockR9h6TN8siHz/1/wVRQzvZ71KefRrdOj+3DZsqR9tE5pJn3ofc2HokQCJqZAyC7AobPltCySf554M2rnxwoZUcEpjGGO/Hp5V3TVZdOHkxc1Y1RGZ2qNZ6YE9PUkEkrXnwo4q5HrkdmrQwY=
Received: from DM5PR18MB1578.namprd18.prod.outlook.com (10.175.224.136) by
 DM5PR18MB1401.namprd18.prod.outlook.com (10.173.211.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 08:27:50 +0000
Received: from DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::28da:f8bb:4901:b0aa]) by DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::28da:f8bb:4901:b0aa%10]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 08:27:50 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [RFC] Disable lockref on arm64
Thread-Topic: [RFC] Disable lockref on arm64
Thread-Index: AQHVAMDuiGdhpYBMrkiBLQqY4hG0yQ==
Date:   Thu, 2 May 2019 08:27:50 +0000
Message-ID: <20190502082741.GE13955@hc>
References: <20190429145159.GA29076@hc>
 <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
In-Reply-To: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To DM5PR18MB1578.namprd18.prod.outlook.com
 (2603:10b6:3:14d::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.208.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5707948-4818-4c71-442b-08d6ced81051
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR18MB1401;
x-ms-traffictypediagnostic: DM5PR18MB1401:
x-microsoft-antispam-prvs: <DM5PR18MB1401610B612A94AE58F685F3D8340@DM5PR18MB1401.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(54906003)(73956011)(316002)(25786009)(229853002)(186003)(6436002)(446003)(7736002)(53546011)(476003)(386003)(99286004)(6916009)(26005)(52116002)(11346002)(6486002)(6116002)(6506007)(76176011)(8676002)(66066001)(8936002)(102836004)(33716001)(81156014)(6246003)(107886003)(9686003)(4326008)(5660300002)(2906002)(6512007)(3846002)(66946007)(66556008)(33656002)(66476007)(66446008)(64756008)(1076003)(305945005)(14454004)(81166006)(256004)(53936002)(478600001)(5024004)(14444005)(86362001)(71200400001)(68736007)(486006)(71190400001)(88384005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1401;H:DM5PR18MB1578.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bUIe9pVyWAOkLRh3Dzv+JTF0pT7r+up8i85lwP0DLQj8x+it3WooDqEVltJdUg7tCQS/t9gRJKcmuRvJBsbiV0P5aW/6pdJrO289QHDhPX0Ysn5lKMVHxFYyg7vK9260TZlDX0NSyujpVKNCNuOn71oiqcnLxYQb3xgxA4o9AE6t+rfdqwfHcF213TjhHiK5Ra6Q9AtKytwVB7lNVJSktKJnt8p/8ICiF3Rj9Fckaksz8LWFC5THH3PYtsHAf/rG8GzYrv0EOS9mb86Vmy1bouH9jUV3vVDP6L+GReylkOwjdPDo7DOnHFlFsiSq7Kc4H5D08xcupe7TFkwKGi60F0wYRHKkf6PoqIrDgjSHufOCUoeBmw6cvi68Nqn9ARWfevZsFDerqP6toO2DCnIf6T+LVLw3Y2S+YYu4rV8Ckeg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA9753A4232DB742A473B8D7CFA2454E@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f5707948-4818-4c71-442b-08d6ced81051
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 08:27:50.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1401
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:41:08AM -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 7:52 AM Jan Glauber <jglauber@marvell.com> wrote:
> >
> > It turned out the issue we have on ThunderX2 is the file open-close seq=
uence
> > with small read sizes. If the used files are opened read-only the
> > lockref code (enabled by ARCH_USE_CMPXCHG_LOCKREF) is used.
> >
> > The lockref CMPXCHG_LOOP uses an unbound (as long as the associated
> > spinlock isn't taken) while loop to change the lock count. This behaves
> > badly under heavy contention
>=20
> Ok, excuse me when I rant a bit.
>=20
> Since you're at Marvell, maybe you can forward this rant to the proper
> guilty parties?

Sure :)

> Who was the absolute *GENIUS* who went
>=20
>  Step 1: "Oh, we have a middling CPU that isn't world-class on its own"
>=20
>  Step 2: "BUT! We can put a lot of them on a die, because that's 'easy'"
>=20
>  Step 3: "But let's make sure the interconnect isn't all that special,
> because that would negate the the whole 'easy' part, and really strong
> interconnects are even harder than CPU's and use even more power, so
> that wouldn't work"
>=20
>  Step 4: "I wonder why this thing scales badly?"
>=20
> Seriously. Why are you guys doing this? Has nobody ever looked at the
> fundamental thought process above and gone "Hmm"?
>=20
> If you try to compensate for a not-great core by putting twice the
> number of them in a system, you need a cache system and interconnect
> between them that is more than twice as good as the competition.
>=20
> And honestly, from everything that I hear, you don't have it. The
> whole chip is designed for "throughput when there is no contention".
> Is it really a huge surprise that it then falls flat on its face when
> there's something fancy going on?

I'll see how x86 runs the same testcase, I thought that playing
cacheline ping-pong is not the optimal use case for any CPU.

My assumption was that x86 probably doesn't suffer that much because
of cpu_relax() -> pause insn could slow down the retry rate.

> So now you want to penalize everybody else in the ARM community
> because you have a badly balanced system?

Not really, as I intentionally did not include a patch and sent this as
RFC.

> Ok, rant over.
>=20
> The good news is that we can easily fix _this_ particular case by just
> limiting the CMPXCHG_LOOP to a maximum number of retries, since the
> loop is already designed to fail quickly if the spin lock value isn't
> unlocked, and all the lockref code is already organized to fall back
> to spinlocks.
>=20
> So the attached three-liner patch may just work for you. Once _one_
> thread hits the maximum retry case and goes into the spinlocked case,
> everybody else will also fall back to spinlocks because they now see
> that the lockref is contended. So the "retry" value probably isn't all
> that important, but let's make it big enough that it probably never
> happens on a well-balanced system.

Agreed, your patch would solve the issue for ThunderX2. Limiting the
retry attempts was one of the things I tried beside extending the number
of NOPs in cpu_relax().

> But seriously: the whole "let's just do lots of CPU cores because it's
> easy" needs to stop. It's fine if you have a network processor and
> you're doing independent things, but it's not a GP processor approach.
>=20
> Your hardware people need to improve on your CPU core (maybe the
> server version of Cortex A76 is starting to approach being good
> enough?) and your interconnect (seriously!) instead of just slapping
> 32 cores on a die and calling it a day.
>=20
>                 Linus "not a fan of the flock of chickens" Torvalds

>  lib/lockref.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/lib/lockref.c b/lib/lockref.c
> index 3d468b53d4c9..a6762f8f45c9 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -9,6 +9,7 @@
>   * failure case.
>   */
>  #define CMPXCHG_LOOP(CODE, SUCCESS) do {					\
> +	int retry =3D 15;		/* Guaranteed random number */			\
>  	struct lockref old;							\
>  	BUILD_BUG_ON(sizeof(old) !=3D 8);						\
>  	old.lock_count =3D READ_ONCE(lockref->lock_count);			\
> @@ -21,6 +22,8 @@
>  		if (likely(old.lock_count =3D=3D prev.lock_count)) {		\
>  			SUCCESS;						\
>  		}								\
> +		if (!--retry)							\
> +			break;							\
>  		cpu_relax();							\
>  	}									\
>  } while (0)

