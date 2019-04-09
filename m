Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF502133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PGvMgUWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDIX0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:26:40 -0400
Received: from mail-eopbgr750114.outbound.protection.outlook.com ([40.107.75.114]:65493
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbfDIX0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phgw7RV5TIGCys4B+lmaQrxwhKorMQGQwDNfjSbyZxk=;
 b=PGvMgUWa64YYnX+LjG4fEqCU+7NmncZRoaIg9kpl45ZHZJG3L4njjjiSdh/SsjWxqIx7jGRbUv9L4hZRN6rG1tnJfTfckkgvfh9lhhGN9iJjePG3WWBDHjqcymZda2XSkvLyH42Qw7pxwvWMMeHniN2EsEsaaAUTEpX1JUOGNHI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1727.namprd22.prod.outlook.com (10.164.206.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Tue, 9 Apr 2019 23:26:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 23:26:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes
Thread-Topic: [GIT PULL] MIPS fixes
Thread-Index: AQHU7yutPXnx8kkOlk2rYAfaB5yJVg==
Date:   Tue, 9 Apr 2019 23:26:36 +0000
Message-ID: <20190409232635.qvqzhqtixbjxal4j@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce5729d0-04dc-4335-f3da-08d6bd42cf79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(49563074)(7193020);SRVR:MWHPR2201MB1727;
x-ms-traffictypediagnostic: MWHPR2201MB1727:
x-microsoft-antispam-prvs: <MWHPR2201MB172761C2AB90E3A80A299AFFC12D0@MWHPR2201MB1727.namprd22.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39840400004)(136003)(396003)(366004)(376002)(189003)(199004)(8676002)(6486002)(3846002)(71190400001)(99286004)(81166006)(81156014)(6116002)(106356001)(105586002)(14444005)(256004)(53936002)(476003)(14454004)(44832011)(1076003)(6512007)(5660300002)(486006)(71200400001)(6916009)(9686003)(68736007)(6506007)(386003)(8936002)(33716001)(26005)(42882007)(2906002)(99936001)(54906003)(6436002)(186003)(52116002)(58126008)(66066001)(478600001)(97736004)(4326008)(316002)(305945005)(25786009)(7736002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1727;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XeBY+31Md4HjBu6D7/XLnqo7D+Lv+2gD7roV6gaBCuNx80/kRHbqbMoI7M1d0911xsmPN0Gfd/1+cQUI8BHVU2WDAk1nBgTSGzfCcwqlHRcwWlCKATlyxnSnXvu9pX5zkmvAv+NR7Oi8Kv/kKJgxfgDELp0K0uXj7cui3ZkDdYIbtgBdLZzDkAhOQ9IrmM6NHKTTdNIv8o5tdjMuXDCoNA8jEiLJjQ4SVu43LJGLMIP0Tsh4QE0VU/OW2LtvO3Kq058Gx9nH/nd1CqHnK1jPebTLR+V6KViLX+BOD5yQ21bUxL62+7eR0+000hLjub/315RUvQj9Rl2+SEvFf23NSQs8Im+T/jAStrLEq7+DZDx6il/7ebjHQort/hrPEmG6jxmlF+etlgSpx7ZQW1Crx5qHnOOubNbPpsB/CVKb2xs=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f4igw43id7mmrc7e"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5729d0-04dc-4335-f3da-08d6bd42cf79
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 23:26:36.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f4igw43id7mmrc7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a few small MIPS fixes for 5.1; please pull.

Thanks,
    Paul


The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.1_2

for you to fetch changes up to 6e3572e83dc3563e3b7e742bcb225b42a60cdaeb:

  MIPS: generic: Add switchdev, pinctrl and fit to ocelot_defconfig (2019-04-04 11:14:45 -0700)

----------------------------------------------------------------
A few minor MIPS fixes:

- Provide struct pt_regs * from get_irq_regs() to kgdb_nmicallback()
  when handling an IPI triggered by kgdb_roundup_cpus(), matching the
  behavior of other architectures & resolving kgdb issues for SMP
  systems.

- Defer a pointer dereference until after a NULL check in the
  irq_shutdown callback for SGI IP27 HUB interrupts.

- A defconfig update for the MSCC Ocelot to enable some necessary
  drivers.

----------------------------------------------------------------
Chong Qiao (1):
      MIPS: KGDB: fix kgdb support for SMP platforms.

Horatiu Vultur (1):
      MIPS: generic: Add switchdev, pinctrl and fit to ocelot_defconfig

Thomas Bogendoerfer (1):
      MIPS: SGI-IP27: Fix use of unchecked pointer in shutdown_bridge_irq

 arch/mips/configs/generic/board-ocelot.config | 8 ++++++++
 arch/mips/kernel/kgdb.c                       | 3 ++-
 arch/mips/sgi-ip27/ip27-irq.c                 | 3 +--
 3 files changed, 11 insertions(+), 3 deletions(-)

--f4igw43id7mmrc7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXK0qKwAKCRA+p5+stXUA
3RQ8AP9N1In57qqxpS1uhiq4yGqsaJh5IkAvnxfiFUgE9aXNZAD/RlXfSlduA2F9
ZUS/MnyObbBbM3/FLuXm2LImuvqqoQg=
=/y+I
-----END PGP SIGNATURE-----

--f4igw43id7mmrc7e--
