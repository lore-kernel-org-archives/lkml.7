Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E84C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469E22133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="fcfezGbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfGETTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:19:06 -0400
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:35031
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfGETTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQrQX548Ps5+G0nK840p7UGrRZU42ChwDS8z+quoApw=;
 b=fcfezGbwPeDgRfe3CmslycfJXGEcbATYL+EQreeetqlJFnXXKNDg/PgiVPKSAzQ314wpd9GTKh7smiwoHaAfp6yi4nn+BeduizQ1NPrCV/h9CUtteYR9i88BvLj+Pw9gX6Q52yABceYvhqp2xEBHEaq+T05MPEmQh8HlRRyDMqo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6296.namprd05.prod.outlook.com (20.178.51.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Fri, 5 Jul 2019 19:19:02 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 19:19:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
Thread-Topic: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
Thread-Index: AQHVMoZMtPlqY/V5ZEyMHlztWSLTMqa8LOGAgAA7FAA=
Date:   Fri, 5 Jul 2019 19:19:02 +0000
Message-ID: <66E585C6-468E-4EFD-931C-47BFF5E104EB@vmware.com>
References: <20190704155145.617706117@linutronix.de>
 <20190704155608.636478018@linutronix.de>
 <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
In-Reply-To: <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d43a5096-b418-4b94-e26a-08d7017da3cc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6296;
x-ms-traffictypediagnostic: BYAPR05MB6296:
x-microsoft-antispam-prvs: <BYAPR05MB6296832B426489FD8989957FD0F50@BYAPR05MB6296.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(66476007)(66946007)(73956011)(6512007)(14454004)(186003)(66556008)(64756008)(66446008)(71190400001)(71200400001)(76116006)(478600001)(229853002)(53936002)(316002)(68736007)(2906002)(54906003)(81156014)(8936002)(305945005)(7736002)(36756003)(81166006)(6116002)(8676002)(3846002)(6506007)(53546011)(6916009)(446003)(2616005)(256004)(11346002)(33656002)(486006)(476003)(14444005)(26005)(76176011)(66066001)(4326008)(25786009)(86362001)(6486002)(6436002)(5660300002)(99286004)(102836004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6296;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w3MOVKH7A2WJpsoLL8HTbyoWmJpRVBxgddlvVNumyt/5GZihUljNxopUrOh6JatlcjCcCwCvdEUDynELG7xDBpx/7caruqipqq4RLj5oDfWJQtjPOlVkd8/J0zfW6nj9axcT0RzeM+P19xl46vczhJA+Jq7FOQQYUPexmGQ9YuBmh6jsl968HiOG27VIPq5QlFaV/BxDRrbiFoyC0JcXiveX7XUyqczjRg+RSJ7/R9mg9tTOKXpK5rq9xKJ8t+xo8xVZoP08WS1ScAgkAuvaQiE1Kg0kmmkZ5cP89500x2yK7r/v+jDdjyd5PPK6SSu01m7Ts7PZd97iIMyzVQuYT6UtZniCwkLmdQU+ChNlNNxsX8XmIcnjlAsv89LHXhjXSr2UT3ANyTHiiJhzUJw+pZMKlqX6r7jJzSP6kldyP/8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76F792A931C74D4EBEB4F93C831426EC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a5096-b418-4b94-e26a-08d7017da3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 19:19:02.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 5, 2019, at 8:47 AM, Andrew Cooper <andrew.cooper3@citrix.com> wro=
te:
>=20
> On 04/07/2019 16:51, Thomas Gleixner wrote:
>>  2) The loop termination logic is interesting at best.
>>=20
>>     If the machine has no TSC or cpu_khz is not known yet it tries 1
>>     million times to ack stale IRR/ISR bits. What?
>>=20
>>     With TSC it uses the TSC to calculate the loop termination. It takes=
 a
>>     timestamp at entry and terminates the loop when:
>>=20
>>     	  (rdtsc() - start_timestamp) >=3D (cpu_hkz << 10)
>>=20
>>     That's roughly one second.
>>=20
>>     Both methods are problematic. The APIC has 256 vectors, which means
>>     that in theory max. 256 IRR/ISR bits can be set. In practice this is
>>     impossible as the first 32 vectors are reserved and not affected and
>>     the chance that more than a few bits are set is close to zero.
>=20
> [Disclaimer.  I talked to Thomas in private first, and he asked me to
> post this publicly as the CVE is almost a decade old already.]
>=20
> I'm afraid that this isn't quite true.
>=20
> In terms of IDT vectors, the first 32 are reserved for exceptions, but
> only the first 16 are reserved in the LAPIC.  Vectors 16-31 are fair
> game for incoming IPIs (SDM Vol3, 10.5.2 Valid Interrupt Vectors).
>=20
> In practice, this makes Linux vulnerable to CVE-2011-1898 / XSA-3, which
> I'm disappointed to see wasn't shared with other software vendors at the
> time.

IIRC (and from skimming the CVE again) the basic problem in Xen was that
MSIs can be used when devices are assigned to generate IRQs with arbitrary
vectors. The mitigation was to require interrupt remapping to be enabled in
the IOMMU when IOMMU is used for DMA remapping (i.e., device assignment).

Are you concerned about this case, additional concrete ones, or is it about
security hardening? (or am I missing something?)=
