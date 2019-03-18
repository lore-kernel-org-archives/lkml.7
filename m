Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4055C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D81421871
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IYvum3aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCRXIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:08:20 -0400
Received: from mail-eopbgr800138.outbound.protection.outlook.com ([40.107.80.138]:52592
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfCRXIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoOrLTiFuHPp4CklAWRuCqlmNMaxZ8P8rj4jua4cCYQ=;
 b=IYvum3aWQlU6e2prPQn9+WuoHPB8DAdxImK64J69qTP3eZJIsN2ez+4/4Rh+AIXtu3Tip0uR+lkyA3c4y2CaJa29X6KR68aI1eKDR59w8Dh+RQL2EyTbsYOHXfYI/yUIUiy4IiQK5CI/V734jN1hgSWpnlS36H9mVYYhBmdsH2c=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1312.namprd22.prod.outlook.com (10.174.162.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 23:08:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 23:08:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MIPS fixes
Thread-Topic: [GIT PULL] MIPS fixes
Thread-Index: AQHU3d94ix5fKgQ110WR0iICnJ1Kkg==
Date:   Mon, 18 Mar 2019 23:08:16 +0000
Message-ID: <20190318230815.m7amgekprnajav7i@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:a03:54::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a8c3b2a-fe81-4d3e-84aa-08d6abf69a94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR2201MB1312;
x-ms-traffictypediagnostic: MWHPR2201MB1312:
x-microsoft-antispam-prvs: <MWHPR2201MB131288E454A11C562DA8885AC1470@MWHPR2201MB1312.namprd22.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(136003)(346002)(39840400004)(396003)(199004)(189003)(6916009)(81166006)(71190400001)(26005)(8676002)(14454004)(33716001)(102836004)(186003)(42882007)(1076003)(5660300002)(66574012)(81156014)(2906002)(106356001)(71200400001)(6486002)(53936002)(3846002)(6436002)(6116002)(316002)(54906003)(25786009)(58126008)(4326008)(9686003)(6512007)(105586002)(478600001)(256004)(66066001)(99286004)(52116002)(14444005)(99936001)(486006)(305945005)(44832011)(97736004)(6506007)(386003)(7736002)(476003)(68736007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1312;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Us8xZiC31ApCnlWAE/PEtOqL4NsXOB1Qws3z3HaYa2DJbwft/KciWfb7LkCgw+B4dAKa7+fkBCihgBH8LUwNNLNkiMQlAryT372npRtWlBuqBWhcDgOBU0ncGBpvOKeShVSALA3W/JXIhfBjNcyHFez2HFfYb0Of3fe9jrXtI6MY7KA44Ee/Rc2SEUSAAv5spZs2RbvbznYX0KKxcGjBjtLBGVyxwO2TfsZbcySndRxHB+2ePVsWCOtYXHLSXiWRtpqM5DLQt2nBB1TOOuy/S0qaJpRaa+vsDXx38aCPP8ROg2wnm0odZe/LYDCqQf6SRoE5Kdwl9PbpR7m39rc24zrrg611ipocW+V4StWoUkgAso7CRKlGAeRkv2RAYkZn7eCixI2KYE1hbWOM/T7j2G6YAW7FLXhzAGtzf3LiTUQ=
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3n7qezv7pgx6nkh"
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8c3b2a-fe81-4d3e-84aa-08d6abf69a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 23:08:16.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v3n7qezv7pgx6nkh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Below is a set of MIPS fixes for 5.1; please pull.

Thanks,
    Paul

The following changes since commit aeb669d41ffabb91b1542f1f802cb12a989fced0:

  MIPS: lantiq: Remove separate GPHY Firmware loader (2019-02-25 14:17:10 -=
0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fi=
xes_5.1_1

for you to fetch changes up to f6cab793d4a70808e4946baa8f5df4ea9adacc82:

  MIPS: Remove custom MIPS32 __kernel_fsid_t type (2019-03-14 11:31:20 -070=
0)

----------------------------------------------------------------
A small batch of MIPS fixes for 5.1:

- An interrupt masking fix for Loongson-based Lemote 2F systems (fixing
  a regression from v3.19).

- A relocation fix for configurations in which the devicetree is stored
  in an ELF section (fixing a regression from v4.7).

- Fix jump labels for MIPSr6 kernels where they previously could
  inadvertently place a control transfer instruction in a forbidden slot
  & take unexpected exceptions (fixing MIPSr6 support added in v4.0).

- Extend an existing USB power workaround for the Netgear WNDR3400 to v2
  boards in addition to the v3 ones that already used it.

- Remove the custom MIPS32 definition of __kernel_fsid_t to make it
  consistent with MIPS64 & every other architecture, in particular
  resolving issues for code which tries to print the val field whose
  type previously differed (though had identical memory layout).

----------------------------------------------------------------
Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Paul Burton (1):
      MIPS: Remove custom MIPS32 __kernel_fsid_t type

Petr =C5=A0tetiar (1):
      mips: bcm47xx: Enable USB power on Netgear WNDR3400v2

Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqacti=
on.

 arch/mips/bcm47xx/workarounds.c          |  1 +
 arch/mips/include/asm/jump_label.h       |  8 ++++----
 arch/mips/include/uapi/asm/posix_types.h |  7 -------
 arch/mips/kernel/vmlinux.lds.S           | 12 +++++++-----
 arch/mips/loongson64/lemote-2f/irq.c     |  2 +-
 5 files changed, 13 insertions(+), 17 deletions(-)

--v3n7qezv7pgx6nkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXJAk3gAKCRA+p5+stXUA
3a7uAQCkFJH9V46y8ngVY+d3WbUQJe/qJWA1zNxFYn4ONYkCBgD7BKRtqVckjTn1
M8bxCFWqudAU+zqHYCHInL2HPXYZhgE=
=/K+I
-----END PGP SIGNATURE-----

--v3n7qezv7pgx6nkh--
