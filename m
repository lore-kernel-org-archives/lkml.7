Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE6EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4122082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ECuD991k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfIKLJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:09:29 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:52198
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfIKLJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKYfTlFVZu6gtcIC3go4OlOCaIJGQ2B3sPa6WD4YLnHQsDpw/i2UqACTGacA/QMKhSbpTuCSDV2iP5M2hIFYvAVr/5oA6EnUG/uVcMISDB2CJvQX2kDC2gaatrEZd7RYMXmfuHJMeUq/rHIWecQQSStJcAegnGj18umJndYct6l2kMzZ87YAVC+SrxBv7fTkVfhEYjLeXeiZa/C4Z8cHmLUT1h1wVYrSk3eEhkMBNwtQl5SVJvs792+ZIW+dmPXvJCgAcXz5UAY5Ygf/YntYFpz7Y5pwYdzxLk04B5niUnWnm+Qh7prxYKNSJI31LIXXj3jO9u30hbes2E1+pboW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZeuVOHtM+l5Z2h5Aa8sMGBRWICmGD68JfIElQz7ryw=;
 b=MedMnh+LAqmSDqqYCG2A4RT9teFPaWeUkai3hiuYtT/UB0iujbEIJ+EfytZaIXiaAB56/he4LVeewkl/IYGE9r3UulYYmDboB0msDKiyI+4Ndqp7dlJIG+vUGpx0xMhoPzaQyz6GqBz3602TWSUZRfFuzqLchh20cSfnmyzBrv/7LSDLMWEYK6EOxc6erKibOZ+O02YRg8aPS/+U5XA/qKnleyGXySLffydVdd9I29fa19Myyq2pxsduIm4u4HlkIdevS6cZZjMPA2V0WzRvBeGVDZR0chWBe8ouPAviBc0zm2xJZqHDgoFCNwFycRSZvsrsX6z3SsqcEYRdGjnilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZeuVOHtM+l5Z2h5Aa8sMGBRWICmGD68JfIElQz7ryw=;
 b=ECuD991kKXGZIjOjnzznLEr7ZxdI2vZaoH3D1y8/WWE/dQp25YjvP6JDZDhfONsoy7s8QMdMhVoP6sroeu4QMH6oLlOQnF1xRY7xmE4mibeHClUr6lZs3Brvn0wftHgjM9ffphyAWAKkOHcyQTdlM1b9uHjCSeS68vcW5B/5ja0=
Received: from DB7PR05MB5338.eurprd05.prod.outlook.com (20.178.41.21) by
 DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Wed, 11 Sep 2019 11:09:24 +0000
Received: from DB7PR05MB5338.eurprd05.prod.outlook.com
 ([fe80::fb:7161:ff28:1b3b]) by DB7PR05MB5338.eurprd05.prod.outlook.com
 ([fe80::fb:7161:ff28:1b3b%5]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 11:09:24 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>
Subject: Re: [ipv6] d5382fef70: kernel_selftests.net.fib_tests.sh.fail
Thread-Topic: [ipv6] d5382fef70: kernel_selftests.net.fib_tests.sh.fail
Thread-Index: AQHVaIaB0Jdf4B6CikCpDWkGLd2lkKcmUayA
Date:   Wed, 11 Sep 2019 11:09:24 +0000
Message-ID: <20190911110921.GA18429@splinter>
References: <20190911095121.GU15734@shao2-debian>
In-Reply-To: <20190911095121.GU15734@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::35) To DB7PR05MB5338.eurprd05.prod.outlook.com
 (2603:10a6:10:64::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9271fcd3-1585-40f6-4a11-08d736a88136
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB4138;
x-ms-traffictypediagnostic: DB7PR05MB4138:|DB7PR05MB4138:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB41389B52A8436AA961547234BFB10@DB7PR05MB4138.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(51914003)(189003)(199004)(14454004)(25786009)(8936002)(478600001)(99286004)(9686003)(76176011)(8676002)(81156014)(6512007)(476003)(52116002)(4326008)(2906002)(71190400001)(966005)(7736002)(6486002)(86362001)(186003)(6916009)(229853002)(6436002)(6246003)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(1076003)(5660300002)(486006)(53936002)(81166006)(11346002)(446003)(305945005)(316002)(256004)(54906003)(6116002)(3846002)(5024004)(14444005)(26005)(6306002)(66066001)(33716001)(6506007)(386003)(71200400001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4138;H:DB7PR05MB5338.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lcoe8dVKBDXdb3WmMwflVtcrSz5yYbd+P4bOkkqPTT04S0Hf6z2pqQAfxj147sPlGWZGY3vu6Y0zKp0oRRQ0EHF/tXpI7cgfRHVJ3oWZf8K9YmRmjmPxpC90M2XhDSY73w341HZVuzgopTeHWZSJKfkwd8iAoRnugDAb0cG7BjL3lwpSIbjuQ0b9tvo0qK/p2hpulsT49dGJUwvy58V4LT/Bly2W/8cAsLe4EFhpP43J5t50pIG1TKEbte4xtLmftimHygZ+EkQwvYMhpz/a0z+OxdagV42P1JKKqeHh6Sj9cw3u8GKzYmZn3rhIkFE8YdxQjstGQ/kwn8/ah+tLPcvlPq2e+vzKgYVXO/t8C8j+LuVWAACpyqtjMfoGWcyPuzgc51rZZIcsws9NSwxupaaa04pOgI2Y8TJrbZtgzM0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2429B0B77758E640B661C1C648B266AF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9271fcd3-1585-40f6-4a11-08d736a88136
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 11:09:24.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYAe6wpQieZtLqCCEUZmDsUwkh+CtrsfDNGVrRUY+KYgssKfDAqF58KkrqMtzr4RpRDn8r5N5VlQd+BLOqGxIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 05:51:21PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: d5382fef70ce273608d6fc652c24f075de3737ef ("ipv6: Stop sending in-=
kernel notifications for each nexthop")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>=20
> in testcase: kernel_selftests
> with following parameters:
>=20
> 	group: kselftests-02
>=20
> test-description: The kernel contains a set of "self tests" under the too=
ls/testing/selftests/ directory. These are intended to be small unit tests =
to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>=20
>=20
> on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 1=
6G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>=20
>=20
> # selftests: net: fib_tests.sh

...

> # Tests passed: 137
> # Tests failed:  12
> not ok 13 selftests: net: fib_tests.sh

Thanks for the report, but I can't reproduce this. Used your attached
config and booted a kernel with the HEAD you mentioned:

$ uname -r
5.2.0-rc5-01201-gd5382fef70ce

$ ./fib_tests.sh
...
Tests passed: 150
Tests failed:   0

Also tested: net, net-next, master

All look fine. Plus, I'm pretty sure I ran this test before initially
submitting the patchset.

Can you reliably reproduce these failures on current kernels or is this
some random failure you noticed while testing the mentioned commit?

Thanks
