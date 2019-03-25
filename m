Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9462B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="W/QcETU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfCYMQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:16:42 -0400
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:63102
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729280AbfCYMQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9BDhb6F0I0eZd+ZcV/FdvkWY9mmy2Ma5SS2rR3wo20=;
 b=W/QcETU/u41DgBa5fOmi5M0nEQSvdif3gY07tAAxBEd/mdILfG587wNLKjmMIkEeMB5cMhvFlsNthPWBLQff+8pNbaiDTTI5GKjISiWLCwIpbqZueUtN7SnxV/XyW1Q1UV2Lmncw2fao6gByrhwf0BFsfmygCevd5kJxu+zE8Dg=
Received: from AM0PR05MB6100.eurprd05.prod.outlook.com (20.178.119.209) by
 AM0PR05MB4577.eurprd05.prod.outlook.com (52.133.59.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 12:16:38 +0000
Received: from AM0PR05MB6100.eurprd05.prod.outlook.com
 ([fe80::85ee:723:721e:51f9]) by AM0PR05MB6100.eurprd05.prod.outlook.com
 ([fe80::85ee:723:721e:51f9%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 12:16:38 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     syzbot <syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Subject: Re: WARNING in bpf_prog_kallsyms_add
Thread-Topic: WARNING in bpf_prog_kallsyms_add
Thread-Index: AQHU4eeJ1m0yzc5n0kio41mHfIAb0KYcRV6A
Date:   Mon, 25 Mar 2019 12:16:38 +0000
Message-ID: <20190325121635.GA10590@splinter>
References: <000000000000f302fc057ea3b499@google.com>
 <000000000000557b4c0584cdabed@google.com>
In-Reply-To: <000000000000557b4c0584cdabed@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::36) To AM0PR05MB6100.eurprd05.prod.outlook.com
 (2603:10a6:208:12e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4db1b64-9133-4898-38d4-08d6b11bbaec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4577;
x-ms-traffictypediagnostic: AM0PR05MB4577:
x-ms-exchange-purlcount: 8
x-microsoft-antispam-prvs: <AM0PR05MB45778C9A42D07EA7D5A34914BF5E0@AM0PR05MB4577.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(68736007)(7736002)(305945005)(71190400001)(71200400001)(5660300002)(9686003)(2906002)(110136005)(478600001)(2501003)(86362001)(53936002)(229853002)(6306002)(6436002)(6246003)(256004)(8936002)(106356001)(33656002)(81156014)(4326008)(6116002)(8676002)(7116003)(1076003)(97736004)(316002)(66574012)(33716001)(446003)(52116002)(102836004)(476003)(6512007)(81166006)(186003)(3846002)(26005)(105586002)(6486002)(11346002)(486006)(966005)(25786009)(54906003)(76176011)(7416002)(6506007)(386003)(66066001)(99286004)(14454004)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4577;H:AM0PR05MB6100.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: okMDQjsLLuDEmKFzaRFcA6dSGo7pWgvKvaXA6EfOZltrhCABqYeKmqH0ivSTvEYeTurGLd0xDg8NcghreDKMym0JmHr+cPPCvOWtYfhJrIBE6gfp29+J/X+I4Ev9q0liUMlsU/Oev+cWHObt4bTzpduFhZIUItOzf8ghL1Ro58FYZyl5tRzZ0qN0+U0YLyXnOG2ewhPy7yrLWAwKqcZ/L/wY0rqfmf3iqo0BnJDjzhCiBQKNGNJzeTEOM/njWBJEytX4b41StTle4QOdf7Nn3TBhPIEIGvmrErt477YEy+YbXeRDtIuPdocMQCdMpn+WFZR6NVjrKfT5wD7nx3F6gHZ1yFFwAQm847QYdFD//P7W7cDWIe5DPjCMBG3NJEQtBQlzXhuq91Dgzwv0K7i4mBdj5OanUeCX20xQH+PYsIs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <435B9CE2D715634EABDB7AC1379F0337@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4db1b64-9133-4898-38d4-08d6b11bbaec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 12:16:38.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dmitry

On Sat, Mar 23, 2019 at 07:16:01PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
>=20
> commit 7607dd35fc34893214284cca740d015154d20452
> Author: Ido Schimmel <idosch@mellanox.com>
> Date:   Mon Jul 17 12:15:30 2017 +0000
>=20
>     mlxsw: spectrum: Trap IPv4 packets with Router Alert option
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14e0ac0720=
0000
> start commit:   645ff1e8 Merge branch 'for-linus' of git://git.kernel.org=
/..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D16e0ac0720=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12e0ac0720000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D20271e14bc1c8=
7f0
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D987e48d84abddbe=
2506d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c69d20c00=
000
>=20
> Reported-by: syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com
> Fixes: 7607dd35fc34 ("mlxsw: spectrum: Trap IPv4 packets with Router Aler=
t
> option")
>=20
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

Dmitry,

The bisection is probably wrong. Above mentioned commit is specific to
mlxsw which is not even present in the provided kernel config.

I see that this also appears in the web interface [1] which might be
misleading to some people. Might be worthwhile to add a command for
syzbot that tells it that bisection is wrong?

[1] https://syzkaller.appspot.com/bug?id=3Db658eb696c8279d9951a4ceea79efba8=
a1d12467
