Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375CEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FE720859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="JcdbTYix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfDVS1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:27:54 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:7586
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbfDVS1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6zKlP1dH160JdJbl4L+Aje+OGJx9G6U4B4gAByKL5k=;
 b=JcdbTYixAfThwENTt4dUzkHEv1R7KcQkzobuI9uCzW2Q3kNIokeJCjfzEqHDWtWb/EYiMvG8ypkTwE1AWq25vn8qG6yNRsA8spFwimbCReTbDjPKE8g0c7FlB+/mnhUZ62R4e2x3fRy8us1dkkSn0yJHLCcMp4jPzLFM1p+vQHM=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1743.namprd22.prod.outlook.com (10.164.206.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Mon, 22 Apr 2019 18:27:50 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 18:27:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes for 5.1
Thread-Topic: [GIT PULL] MIPS fixes for 5.1
Thread-Index: AQHU+TkXVidzLi/fv0qYsw3EuHXccA==
Date:   Mon, 22 Apr 2019 18:27:49 +0000
Message-ID: <20190422182744.2764mje5ohnaubz4@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ca58cf0-8475-4a6f-e90c-08d6c750397e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(49563074)(7193020);SRVR:MWHPR2201MB1743;
x-ms-traffictypediagnostic: MWHPR2201MB1743:
x-microsoft-antispam-prvs: <MWHPR2201MB1743B7A469E07680EBD68A6FC1220@MWHPR2201MB1743.namprd22.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39840400004)(366004)(396003)(136003)(376002)(199004)(189003)(478600001)(66066001)(486006)(316002)(53936002)(58126008)(5660300002)(54906003)(25786009)(68736007)(476003)(44832011)(99936001)(256004)(6916009)(6512007)(9686003)(14454004)(6116002)(97736004)(3846002)(8936002)(52116002)(71190400001)(71200400001)(102836004)(73956011)(186003)(6506007)(33716001)(386003)(1076003)(305945005)(6486002)(7736002)(26005)(8676002)(4326008)(66446008)(66556008)(66476007)(64756008)(66616009)(66946007)(81156014)(42882007)(6436002)(2906002)(81166006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1743;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4B+rDynS6Sft8xByOyicwvpJJu5Mz8M6QB3g4uG6lnggQr2SkAlgMFGeh4UDMGzf4WGXMzdVOKiKlhAcMb/iqzORz+lJp+JXP2aOtEfKJb34DDt3kDHNONKpoNP1vwCWF47XZ1uIE8fBdzzYn4XTnV9JOpfHBIE/rUSJmpzWu945dyPLY99Uk/AmYbQXjLoEe/xm+I4TxgUoI8BZ2XVA+6sJVpfR4Flb7yhvcRiJlCYOjEZFWVBKA1JwtD8s8cgrHP5FQrAmr6EwOGhrN8gTFtxvgg7IsTd+xwx75501ARmTH+jP+LAp+zDTmQS3ZAEi7GVekq4HR9LwPWvOCI3UP35yjrIB9cA3dco8c8WijTX1KZE+I8ylL1MtGNyAXEx/JQWp16/hQ2t5cRqLK/KxQzNGktnUYtaBR21ueo+NBzQ=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="drixcpo43ybdgotk"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca58cf0-8475-4a6f-e90c-08d6c750397e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 18:27:50.0097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--drixcpo43ybdgotk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here are a couple more MIPS fixes for 5.1; please pull.

Thanks,
    Paul


The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fi=
xes_5.1_3

for you to fetch changes up to a1e8783db8e0d58891681bc1e6d9ada66eae8e20:

  MIPS: perf: ath79: Fix perfcount IRQ assignment (2019-04-16 15:09:10 -070=
0)

----------------------------------------------------------------
A couple more MIPS fixes:

- Fix indirect syscall tracing & seccomp filtering for big endian MIPS64
  kernels, which previously loaded the syscall number incorrectly &
  would always use zero.

- Fix performance counter IRQ setup for Atheros/ath79 SoCs, allowing
  perf to function on those systems.

And not really a fix, but a useful addition:

- Add a Broadcom mailing list to the MAINTAINERS entry for BMIPS systems
  to allow relevant engineers to track patch submissions.

----------------------------------------------------------------
Aurelien Jarno (1):
      MIPS: scall64-o32: Fix indirect syscall number load

Florian Fainelli (1):
      MAINTAINERS: BMIPS: Add internal Broadcom mailing list

Petr =C5=A0tetiar (1):
      MIPS: perf: ath79: Fix perfcount IRQ assignment

 MAINTAINERS                      |  1 +
 arch/mips/ath79/setup.c          |  6 ------
 arch/mips/kernel/scall64-o32.S   |  2 +-
 drivers/irqchip/irq-ath79-misc.c | 11 +++++++++++
 4 files changed, 13 insertions(+), 7 deletions(-)

--drixcpo43ybdgotk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXL4HngAKCRA+p5+stXUA
3Zj3AP98lM8JdVox5RMUfbndw8EZje88IPjbKnMdTD3el66luwEAjfrRtaCPH8nz
ONfrFsGz5JUOgWHCvllm18j+A4dgJAA=
=Zqkg
-----END PGP SIGNATURE-----

--drixcpo43ybdgotk--
