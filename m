Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17641C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A5F2067C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="PCthEBHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfFGQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:38:50 -0400
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:39808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729953AbfFGQit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u31db9cncyYvFwo7prcnAHGSX8++uNa7cP9ZwKvsRjM=;
 b=PCthEBHcgPg8lHyvg9FPooCbzsoRk0hlgj6mr8IwEhLQp6HkTwJhk2zqTxAgcRN9HmAlmZI6GyplDz52yxHPa/cOiL9RHAmtQNUNQHBNEYawvNHdX4n4cbtlo/ycvqx06798a5ynj5kY+mC0cDLjSkMtXvI9CQ3ZTY5uSKEnxSM=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5026.namprd05.prod.outlook.com (20.177.241.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 16:38:45 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::ac1f:2cd2:fa9c:a886%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 16:38:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [bug report][stable] kernel tried to execute NX-protected page -
 exploit attempt? (uid: 0)
Thread-Topic: [bug report][stable] kernel tried to execute NX-protected page -
 exploit attempt? (uid: 0)
Thread-Index: AQHVG4jKPNn+Vxg1aUiHBnctqPni6KaP/2uAgABocgA=
Date:   Fri, 7 Jun 2019 16:38:44 +0000
Message-ID: <D0F0870A-B396-4390-B5F1-164B68E13C73@vmware.com>
References: <5817eaac-29cc-6331-af3b-b9d85a7c1cd7@linux.alibaba.com>
 <bde5bf17-35d2-45d8-1d1d-59d0f027b9c0@linux.alibaba.com>
In-Reply-To: <bde5bf17-35d2-45d8-1d1d-59d0f027b9c0@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5be428c3-8d60-477f-45aa-08d6eb669baf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR05MB5026;
x-ms-traffictypediagnostic: BL0PR05MB5026:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BL0PR05MB50265010205D988939D95BC5D0100@BL0PR05MB5026.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(53754006)(478600001)(54906003)(76176011)(7736002)(36756003)(64756008)(6506007)(66476007)(53546011)(25786009)(66446008)(66556008)(5660300002)(229853002)(446003)(73956011)(11346002)(91956017)(76116006)(83716004)(8936002)(86362001)(68736007)(66946007)(71200400001)(71190400001)(14454004)(66066001)(305945005)(82746002)(6246003)(966005)(102836004)(486006)(6916009)(316002)(2616005)(476003)(81166006)(81156014)(6436002)(6116002)(53936002)(2906002)(3846002)(8676002)(99286004)(14444005)(256004)(6486002)(33656002)(26005)(186003)(6512007)(6306002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5026;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oOTHzMqTkv5ZyLYF7h7Pajbi6nZq5nEb/xB6+Z5kB8KWjYwGUYuRWymAsp6h862Wisc/MuEJXUDN7lSH5SlOt8B+Sj/Ju4me4nUaLlQmM0fA0wFQCCS0F78pSNoIa6l2L5uZQBHCQXcMsy3In/NkSQ+ayavkymLCsg0okn3wtu/2Bb7XxcuPOMXyNrCaQTRthik9ZpJuK6iz4OTZZJfG/oK74GhRLYrpctVMf/5CeEwm1vYIX/br/k2HzPKPewMYsKqMC6r1JQWjBhsgccsi6qlgdvWdQJfOx6yAOJbfoNW2xfd7TQ0lxPErxXq/9nbgWAOeQa6Do/Gnm/RC75EWl+j7EdwL5GGJJMTVA6M1TTQQTX63h2J2Wrs/gMDGToGZOdtg5yC4YE31rFG35bZY4JNUjPW0W2IEEZRmnOlI7MY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9A7326C0CB6254DAE185F98A5E2CFA1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be428c3-8d60-477f-45aa-08d6eb669baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 16:38:44.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 7, 2019, at 3:24 AM, Joseph Qi <joseph.qi@linux.alibaba.com> wrote=
:
>=20
> Hi all,
> Any idea on this regression?=20

Sorry for the late response (I assumed, for some reason, that you also foll=
ow=20
the second thread about this issue).

Anyhow, it should be fixed by backporting some patches which were mistakenl=
y
missed.

See https://lore.kernel.org/stable/20190606131558.GJ29739@sasha-vm/

Regards,
Nadav


> Thanks,
> Joseph
>=20
> On 19/6/5 18:23, Joseph Qi wrote:
>> Hi,
>>=20
>> I have encountered a kernel BUG when running ltp ftrace-stress-test
>> on 4.19.48.
>>=20
>> [  209.704855] LTP: starting ftrace-stress-test (ftrace_stress_test.sh 9=
0)
>> [  209.739412] Scheduler tracepoints stat_sleep, stat_iowait, stat_block=
ed and stat_runtime require the kernel parameter schedstats=3Denable or ker=
nel.sched_schedstats=3D1
>> [  212.054506] kernel tried to execute NX-protected page - exploit attem=
pt? (uid: 0)
>> [  212.055595] BUG: unable to handle kernel paging request at ffffffffc0=
349000
>> [  212.056589] PGD d00c067 P4D d00c067 PUD d00e067 PMD 23673e067 PTE 800=
000023457f061
>> [  212.057759] Oops: 0011 [#1] SMP PTI
>> [  212.058303] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 4=
.19.48 #112
>>=20
>> After some investigation I have found that it is introduced by commit
>> 8715ce033eb3 ("x86/modules: Avoid breaking W^X while loading modules"),
>> and then revert this commit the issue is gone.
>>=20
>> I have also tested the same case on 5.2-rc3 as well as right at
>> upstream commit f2c65fb3221a ("x86/modules: Avoid breaking W^X while
>> loading modules"), which has been merged in 5.2-rc1, it doesn't
>> happen.
>>=20
>> So I don't know why only stable has this issue while upstream doesn't.
>>=20
>> Thanks,
>> Joseph


