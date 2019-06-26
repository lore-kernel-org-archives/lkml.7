Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23855C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52892146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="kbM9F44p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZBWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:22:42 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:5401
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfFZBWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtYUzf1Rlh6eCknlBy3bwT7sak82uBvKzQe+gPZnIRE=;
 b=kbM9F44pgRAQ9KJtX4vrktU5HUKnn3YsPe8vsp1pe62VWJY7QpZWMbQIEUFIYtgsDGZvp+AkFJNosUnf0+N+On80n994VqzJzdTFi3xT7PyKQKYJccBhjHBQcZJWXYnUJ6XaClnmnBzRpAFN1t/3QU6eO7JdGTGagV091pSeYgM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4950.namprd05.prod.outlook.com (20.177.228.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.9; Wed, 26 Jun 2019 01:22:38 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2008.007; Wed, 26 Jun 2019
 01:22:38 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 8/9] x86/tlb: Privatize cpu_tlbstate
Thread-Topic: [PATCH 8/9] x86/tlb: Privatize cpu_tlbstate
Thread-Index: AQHVIbQreKn7WfxntEmYeeU24A7ls6as/SuAgAA6s4A=
Date:   Wed, 26 Jun 2019 01:22:38 +0000
Message-ID: <E5102C9C-732D-43AC-8A24-9F26F5E2EFD4@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
 <20190613064813.8102-9-namit@vmware.com>
 <aa90347f-d1da-6bd7-dbf0-786f157eb370@intel.com>
In-Reply-To: <aa90347f-d1da-6bd7-dbf0-786f157eb370@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [204.134.128.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1144a2a6-a8f6-412f-40ef-08d6f9d4c71c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4950;
x-ms-traffictypediagnostic: BYAPR05MB4950:
x-microsoft-antispam-prvs: <BYAPR05MB49506AE51014B687489A832DD0E20@BYAPR05MB4950.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(366004)(396003)(189003)(199004)(33656002)(26005)(66066001)(36756003)(6486002)(8936002)(4326008)(186003)(316002)(71190400001)(102836004)(8676002)(3846002)(71200400001)(76176011)(25786009)(81166006)(6916009)(68736007)(6116002)(14454004)(6436002)(81156014)(6512007)(54906003)(53546011)(256004)(66556008)(6246003)(66446008)(73956011)(6506007)(11346002)(476003)(229853002)(64756008)(478600001)(2906002)(2616005)(66476007)(7736002)(446003)(486006)(53936002)(99286004)(91956017)(76116006)(86362001)(305945005)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4950;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PAmNHgXWZZv1kAg29Kq7BC9oqgee0iLpqwrQnuW9joJ6jaV5toNUKm0GyCDFWOSYn8GZjBIg09+xbIDvoA4Vl7vBE+SKzXedEZqdYx21L+tR2RBmPjCUNCfIdmsQBxP8uFwpKyB3rE69MR62/4s2xcR7QpafR81de5a9vrqx0OqphXsNRSTLMeXro4KiZvtN/x5k3gujLwvJoaVXxrXNxPjT8aZ5TsxyeFwyDk7X554GVGTZS2rVh/n+1SpbgjSt9zrxTgMMc55X5LYnltwTy3D6qVq1ODr+zudaRBI9lYUMQXuds2Y0kZjhzOCV2shibJm8LGG334ILZNAZvS62Ui9GzGAaOfHFvrK8QDXcaOa6+OE4HbTvTEMESIa4kNk+n2FzIRLlnT5qzLZI19vSq1tMZy7ZPDQKvAF7lPPdUQ0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C3CDE5838E8224BBB1CA410E1DDDF1B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1144a2a6-a8f6-412f-40ef-08d6f9d4c71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 01:22:38.7345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4950
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 25, 2019, at 2:52 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> On 6/12/19 11:48 PM, Nadav Amit wrote:
>> cpu_tlbstate is mostly private and only the variable is_lazy is shared.
>> This causes some false-sharing when TLB flushes are performed.
>=20
> Presumably, all CPUs doing TLB flushes read 'is_lazy'.  Because of this,
> when we write to it we have to do the cache coherency dance to get rid
> of all the CPUs that might have a read-only copy.
>=20
> I would have *thought* that we only do writes when we enter or exist
> lazy mode.  That's partially true.  We do write in enter_lazy_tlb(), but
> we also *unconditionally* write in switch_mm_irqs_off().  That seems
> like it might be responsible for a chunk (or even a vast majority) of
> the cacheline bounces.
>=20
> Is there anything preventing us from turning the switch_mm_irqs_off()
> write into:
>=20
> 	if (was_lazy)
> 		this_cpu_write(cpu_tlbstate.is_lazy, false);
>=20
> ?
>=20
> I think this patch is probably still a good general idea, but I just
> wonder if reducing the writes is a better way to reduce bounces.

Sounds good. I will add another patch based on your idea.

