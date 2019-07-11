Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4AC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058B621537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BpFY76k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfGKHLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:11:22 -0400
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:47245
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbfGKHLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:11:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrfNNmr+bJw2f9OMOyNYpSQocDpv+pbHn9uUuu5y/KT9VfRlztfMxFKzXgBbcWi2Yi5uk9+t5mvKyB0M07kzBbXe2052+mcAYFMOKu3xJvFeTuR/HGToeR3PkE9Y+KMhCmvnaGioS0ykXs+mbgBoc90v8DQSqLoIih8HH2IP/9kKuEK2f42bZu93xrlqGCB1QmEQIqHMObLteaYffL3Dh0ffQSnYfTsUD/mH+f/g2vp8RR25jSnhm3hRdyhuhDgSlhgG2uOoGsp3/EdnThLqVmhkfOaZcgyXPY0ckWGw9wmfkzPWCaI8n6qKm0QKKq08IT4k35+p0NiwcqH+UqI3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiwWImwI+ZZFbWj/Qdqg1Od9ImXDwaVeJIGJewQ8uVo=;
 b=MixKHT0lA1RRsEf3czpVtY+5lDZLZgEltHJ/7swswdbartJQ03divbrG8PFiEnZpqnKCTnEoC3ZuFNqzN9xjbWwHkKPu5CvHMt85ptRcPT9+Dk4ZOu1QHY/RJd3XokffGSlL1CYgkrCKoRW9MhJOkWqpdJht0rVD3wtayRU78t3i4eZ30yjd1CwVb+efL5HST+lW0YQ7vAXLkplDdWbgY+TNglCEoYGZDJyR37a7CoTaG/EC13rms6XiRbJsnlU3nwdage0B/VfSgVrsZYtblqtXHKqZlxel3Bh5IW6CH/y6NCE82lAG04j94rgY5T7c9w94dFqZdXt4+Y8VYiyi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiwWImwI+ZZFbWj/Qdqg1Od9ImXDwaVeJIGJewQ8uVo=;
 b=BpFY76k/BO7kV8Xq3XBa6z0A9E3Ap2VyiBbefuk3VmH8BZ6cNWGcS8M4O38Qdy+zTQUumwSSUCE7Qqtd7tg7IpmbxNgivpNGENsvldmRVjfYu/4KlgEPX+2nZdgmO07x40YRXiSUxEBNDDwrrhqZV1WD/3j0OQwAxVIsOXmGkKg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4743.namprd05.prod.outlook.com (52.135.233.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.5; Thu, 11 Jul 2019 07:11:19 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::f493:3bba:aabf:dd58%7]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 07:11:19 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Xi Ruoyao <xry111@mengyan1223.wang>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Thread-Topic: [GIT PULL] x86/topology changes for v5.3
Thread-Index: AQHVNxtt0mU1kD//MEyJwVSBEnYucabD3RUDgAAKnYCAARnCAA==
Date:   Thu, 11 Jul 2019 07:11:19 +0000
Message-ID: <89EBC357-BEAC-4252-915F-E183C2D350C4@vmware.com>
References: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
 <201907091727.91CC6C72D8@keescook>
 <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
 <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [38.119.166.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1689d86-d5c2-4a25-ac94-08d705cef908
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4743;
x-ms-traffictypediagnostic: BYAPR05MB4743:
x-microsoft-antispam-prvs: <BYAPR05MB4743F88C9DFEDC12569DF483D0F30@BYAPR05MB4743.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(53546011)(6506007)(6916009)(478600001)(81166006)(81156014)(54906003)(26005)(256004)(8936002)(6486002)(102836004)(6436002)(316002)(14454004)(6512007)(76176011)(33656002)(53936002)(5660300002)(2616005)(36756003)(64756008)(66946007)(7736002)(66476007)(76116006)(6116002)(71200400001)(68736007)(3846002)(7416002)(66556008)(2906002)(186003)(99286004)(71190400001)(6246003)(4326008)(86362001)(476003)(11346002)(66066001)(305945005)(8676002)(446003)(25786009)(486006)(66446008)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4743;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sj4bB0ZLjPUFoJ2w85uSibgHjGH9g9Aj8rBk33VU+DTxzvwgizcbcgOR/UQue2GQTbGfK9R28zc8tBm2SWqbaDdO1Eh7KJJQCIlrHeyReJzN/zC+V+hjvnZ3KRRwABrpaJ9MLktntGLm0ra0NmQgWauh9dL4bHkMj8bIX/QbfCIVu4FWeFkMqhNBLjmOzKQud+Chtw/FyXwG0qAdfU7KDqF+18cU5N/AaHA+Nud5eJR0NPk5mCZx2fOZc8p61RWn62lZvGHo4ONPwDI77VctW83TJA5WslDprFhvkZkbY5gDfgDQvydgchJvSRSulEOWXi9RH81J8xyw7F+iN5NYGZnbvpjy40gjjiUaxHDLPwt0PQ6/JLo+FU+FQeBVptoKO8t24mzCwgqw0zAfbrGdWZgTh8l/G3AQ1DAFxwey4ts=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E31F8F29732F4B44939D0C234CC89BA2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1689d86-d5c2-4a25-ac94-08d705cef908
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 07:11:19.4442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 10, 2019, at 7:22 AM, Jiri Kosina <jikos@kernel.org> wrote:
>=20
> On Wed, 10 Jul 2019, Peter Zijlstra wrote:
>=20
>> If we mark the key as RO after init, and then try and modify the key to
>> link module usage sites, things might go bang as described.
>>=20
>> Thanks!
>>=20
>>=20
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 27d7864e7252..5bf7a8354da2 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinf=
o_x86 *c)
>> 	cr4_clear_bits(X86_CR4_UMIP);
>> }
>>=20
>> -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
>> +DEFINE_STATIC_KEY_FALSE(cr_pinning);
>=20
> Good catch, I guess that is going to fix it.
>=20
> At the same time though, it sort of destroys the original intent of Kees'=
=20
> patch, right? The exploits will just have to call static_key_disable()=20
> prior to calling native_write_cr4() again, and the protection is gone.

Even with DEFINE_STATIC_KEY_FALSE_RO(), I presume you can just call
set_memory_rw(), make the page that holds the key writable, and then call
static_key_disable(), followed by a call to native_write_cr4().=
