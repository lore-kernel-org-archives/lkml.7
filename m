Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB993C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C58D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="UIeyAUWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDXXRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:17:24 -0400
Received: from mail-eopbgr790118.outbound.protection.outlook.com ([40.107.79.118]:47344
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbfDXXRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TzHotYuDGXzgxdu76lOchTJYwQ2/xMHxzi134FrJPo=;
 b=UIeyAUWHmFpQ0IzBG2F68AY9isd9nPQXb7XY0Qt6SZogMOz/0WBzAe9Ci5aQyVZqbRUQIOy+xN0THz8nOvkF+/dmUI2rlIonroAQzylpFVcEDqpYU7lVU/aN2fehJw2cS7PXp6GWDnyXJetbU0BKFLqcjw6V9Mu6YpQPVOwQdrQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1168.namprd22.prod.outlook.com (10.174.168.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 23:17:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 23:17:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
Thread-Topic: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
Thread-Index: AQHU+rH+AJnCxtNxUESFNInzrhwEUaZL3nOAYM0M9Xb8+at4gA==
Date:   Wed, 24 Apr 2019 23:17:18 +0000
Message-ID: <20190424231717.os4p6fq7fbx6afxa@pburton-laptop>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
 <20190424152502.14246-11-mathieu.desnoyers@efficios.com>
 <20190424220609.4kryfcgsv46iu3ds@pburton-laptop>
 <2114325810.1301.1556147523476.JavaMail.zimbra@efficios.com>
In-Reply-To: <2114325810.1301.1556147523476.JavaMail.zimbra@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 811f4b0f-87b9-474d-778a-08d6c90aff13
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1168;
x-ms-traffictypediagnostic: MWHPR2201MB1168:
x-microsoft-antispam-prvs: <MWHPR2201MB1168A3F4FCEE699DD4DBED57C13C0@MWHPR2201MB1168.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(346002)(396003)(39850400004)(376002)(189003)(199004)(66556008)(14454004)(11346002)(25786009)(3846002)(486006)(316002)(5660300002)(66446008)(6116002)(44832011)(6246003)(476003)(64756008)(54906003)(386003)(256004)(4744005)(4326008)(99286004)(52116002)(446003)(76176011)(58126008)(66476007)(73956011)(2906002)(53936002)(68736007)(186003)(26005)(6506007)(66946007)(1076003)(42882007)(102836004)(71190400001)(66066001)(33716001)(8936002)(7416002)(8676002)(93886005)(81156014)(305945005)(6916009)(97736004)(7736002)(229853002)(478600001)(81166006)(71200400001)(9686003)(6436002)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1168;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gmg+h0qu0ojPZZOME8OXroHv6vCHsDLgX8V1ND3VEfeatLRrCVBvVF9uhQhHBOc116sqa9zlLPrNyDUVWhk0hTZa1rbwUDhZa1zoFo86gXDCdfu9UDurzQxwiuqKV+EYdizrEgyNBTsLgddg4gGQPcNOvXKvquH9w7RKMCeFtWqgM8CSt0vDrIpp8WZUIBkCh1ma+2a4it5/7MvJ0n6+zAqD/LbDGGj3rr6X1EXe7TsrMefJauJObxNSsEShshZRxsJrG02tznw1qRQ0d7FSW5J0EcvoYUTF6Eie97e7GLv0X9YGTRblxiwStCPd9LnHyLmZD+Ir6+AvkBb1kznRIMqXrki2HizzaPTdozB4yCMA5yZHizl0fybFZ/rXV3O0jUoB0A/WMlpUTB2VUtVfgROF5G/j84I0hp5NloPm0gc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A34332AA4ED79447ACBC8144BDE8D8AC@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f4b0f-87b9-474d-778a-08d6c90aff13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 23:17:18.7827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Apr 24, 2019 at 07:12:03PM -0400, Mathieu Desnoyers wrote:
> Does the following comment above the forest of #ifdef work for you ?
>=20
> /*
>  * RSEQ_SIG uses the break instruction. The instruction pattern is:
>  *
>  * On MIPS:
>  *      0350000d        break     0x350
>  *
>  * On nanoMIPS32:
>  *      00100350        break     0x350
>  *
>  * On microMIPS:
>  *      0000d407        break     0x350
>  *
>  * For nanoMIPS32 and microMIPS, the instruction stream is encoded as 16-=
bit
>  * halfwords, so the signature halfwords need to be swapped accordingly f=
or
>  * little-endian.
>  */

I'd probably just say nanoMIPS rather than nanoMIPS32, because when we
get nanoMIPS64 in the future it'll be a superset of nanoMIPS32 & the
break encoding will be the same.

But otherwise it looks good to me :)

Thanks,
    Paul
