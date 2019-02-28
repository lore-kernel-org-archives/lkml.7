Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94569C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FE12075B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="XVVULZTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfB1XR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:17:26 -0500
Received: from mail-eopbgr820095.outbound.protection.outlook.com ([40.107.82.95]:12001
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfB1XRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrYn5/uz07Y2O1z1Y1J0TWyxBVNm8yYuAxx0jz8tzlk=;
 b=XVVULZTgJzC6ynbh3+HmUkUSsuW6wm/e+HhATapbdhTyFUcCDtRhhjyLxBVL4z2zjlVM9pFVPcVsZoogViTGqEUJwUVFPhDB1aQqvZvAi11XP/Hfej+vFrDs1bemAu/2+edD8xjtWvZdybC1KrST3lgzumJWb9sWphY1AJ6Rnc4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1374.namprd22.prod.outlook.com (10.174.160.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 23:17:22 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 23:17:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: MIPS fixes for 5.0
Thread-Topic: MIPS fixes for 5.0
Thread-Index: AQHUz7vC0R5+NeFkpUisfeO+e0Gddg==
Date:   Thu, 28 Feb 2019 23:17:22 +0000
Message-ID: <20190228231720.uvzxfn6jpvmtcnra@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18a52d59-0a0e-4e36-848f-08d69dd2e46e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1374;
x-ms-traffictypediagnostic: MWHPR2201MB1374:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1374;23:UpdwUahw5o5H0s13JykAorLmD9jDW5o+j6DYPBQ?=
 =?us-ascii?Q?mP9Re37UkSuTUfGk4YgJ3BZRVBY+N1WS8Z24U010C2rZeArnb2dTTx3C62/A?=
 =?us-ascii?Q?L+JAiH088itl/R9tWJFR7KAxcb9HCbP3J0auLhA+Onn+CzSV2Qe4EXEDENEx?=
 =?us-ascii?Q?fhDddsHm1Ts39FIP0G4Dwv7/W7P0175lftZod3IlyKY9y2Pr4Y+sSDd5EL4U?=
 =?us-ascii?Q?2rAdDogitN2nj7BhI/9S0pWhxmZpJUsSTkvWab+uHh9RMdU7fFgMGt39gj96?=
 =?us-ascii?Q?AQLqfCj905j/qI6CICQ82u35+eVIsk92giOyS6rQij/V/DE6552UCl8buZhs?=
 =?us-ascii?Q?6rDAJzzueqfV68cXfl18Fv2TFTITZwlm3ICR4MpvZRYESn3KiPbME9dsiZ5m?=
 =?us-ascii?Q?8fU5oT/WusN7X8sqCDiWJ+8R3BmCsWvflRm7D6EMz95YWLsrhuUR2hlpal0i?=
 =?us-ascii?Q?WY4lv3eOHmgm5dJd3Rk/bl+RDIzsOLnoq8WssEepCMygCw/y7kR1PQKpJmtf?=
 =?us-ascii?Q?avxJ0BnsxicJgX5YbRY/tExiTiRbHmr6NZuiqiCLAvIJuTKzxbqyYGF9PPif?=
 =?us-ascii?Q?cOLtx3JDs1tQwYE0oLqHhL+GPVkQtpJem5ORekSC1NeNDVFS3oRgooi5Tc2y?=
 =?us-ascii?Q?6PSsWfPwHF+8vjGTTMqpA2mbguQGu6hHOe2LyIkNevKjVbgbWeVVrOQxxuJy?=
 =?us-ascii?Q?DezGVSVEu0rYYsjif6ojh0HCpTH/gCaK5mI5u95V2S/3lr0l0dVO8BNIrzZm?=
 =?us-ascii?Q?ITBqPsfF3RpVyP0pMD5wcSdHwALoHvt0qwrwX+hK1gHH+nQkl5248uQUIV+Q?=
 =?us-ascii?Q?pdYTVT6EUEFmm7A1SyPpOEV/7zQ63eU/pe71MGgiHkYYPbupjs9ubkXwQQ49?=
 =?us-ascii?Q?Xe++z9FFs2g2ZlkJeBdi1QtJF2n7MCykrB1GVmCbn2jSGkFGAfhECHm0Yem+?=
 =?us-ascii?Q?kSAqJ+f8HMOmePVABX8YHJyJgs5edbXG2O/OvmoTB/SU2BsLVxQXonoMl0Af?=
 =?us-ascii?Q?H1Jyus6cOkVkmxm08WtXpqSAHUOrFQsToR8rgRzvqlbSgYf0cbWIG9vv1FiK?=
 =?us-ascii?Q?ZZ+z0wYeJRHj7KQO19Cvb+f5WE6rCEk9JRujnPsvIGWZ+ghCqMBpDAV9oT+1?=
 =?us-ascii?Q?Im0nas/UptUuUF5Ld/3AYV5pRy74b5IV2lrKdwfSRBOI+3/yjlZi/+5Ww41k?=
 =?us-ascii?Q?TZ4HblP8CcH2ylAoRIXgv7ydPkZ5XmTzpqeqs?=
x-microsoft-antispam-prvs: <MWHPR2201MB13742C2667DF64C473BF8CC8C1750@MWHPR2201MB1374.namprd22.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39850400004)(136003)(376002)(366004)(346002)(189003)(199004)(2906002)(6916009)(33716001)(105586002)(58126008)(8676002)(316002)(54906003)(8936002)(305945005)(81156014)(7736002)(106356001)(14454004)(68736007)(97736004)(3846002)(25786009)(7116003)(81166006)(478600001)(6506007)(102836004)(66066001)(9686003)(256004)(6116002)(53936002)(6512007)(4326008)(99286004)(42882007)(71200400001)(6436002)(71190400001)(1076003)(26005)(186003)(386003)(52116002)(6486002)(476003)(5660300002)(44832011)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1374;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HpRUFLbXQDlM/91hMaBdP052dBEOY+3o4REM/yYU693YEpywyT36fVjxC+VDcx1ngXV+81dJySJ1fYgQchKyJZHAdd78X34RItgyfWd3jKn2yhIr5U5OCvfR/lcVUBt7yDzekO9b+ojdFoBBRH2Qzoa7j8mr9QABJSXSpmZkzAJy4zolxBMxG9x2pPpJlV04HoCxS5LW1tGkcNXe6/oHgKY75P22SACEG/zuVtlTjp+jCLgce+0BNkZWx69nqc3PJeLWGUV0feq+4t09ShBRk2Mq/qwwmZGZe/Z8NiSV8I9to0S/kYfpHTk2kBIoN7KUjAVK47O1lEcYmtVRDSxtJWoy3jOKmh3LQUiTKXAluI+n1+7nKIXgzHOduaWeTe4EwxMJdJ8CMkcy5B2W4fsQ5vyNPHzfVE+f9Fo3xvQe3oI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C643F12E55A454893A17A0B6D80DF02@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a52d59-0a0e-4e36-848f-08d69dd2e46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 23:17:22.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a few late fixes it'd be great to squeeze into v5.0. They're
all pretty straightforward. Please pull.

Thanks,
    Paul

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9=
:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fi=
xes_5.0_4

for you to fetch changes up to e0bf304e4a00d66d90904a6c5b93141f177cf6d2:

  MIPS: fix memory setup for platforms with PHYS_OFFSET !=3D 0 (2019-02-27 =
18:49:29 -0800)

----------------------------------------------------------------
A few more MIPS fixes:

- Fix 16b cmpxchg() operations which could erroneously fail if bits 15:8
  of the old value are non-zero. In practice I'm not aware of any actual
  users of 16b cmpxchg() on MIPS, but this fixes the support for it was
  was introduced in v4.13.

- Provide a struct device to dma_alloc_coherent for Lantiq XWAY systems
  with a "Voice MIPS Macro Core" (VMMC) device.

- Provide DMA masks for BCM63xx ethernet devices, fixing a regression
  introduced in v4.19.

- Fix memblock reservation for the kernel when the system has a non-zero
  PHYS_OFFSET, correcting the memblock conversion performed in v4.20.

----------------------------------------------------------------
Christoph Hellwig (1):
      MIPS: lantiq: pass struct device to DMA API functions

Jonas Gorski (1):
      MIPS: BCM63XX: provide DMA masks for ethernet devices

Michael Clark (1):
      MIPS: fix truncation in __cmpxchg_small for short values

Thomas Bogendoerfer (1):
      MIPS: fix memory setup for platforms with PHYS_OFFSET !=3D 0

 arch/mips/bcm63xx/dev-enet.c | 8 ++++++++
 arch/mips/kernel/cmpxchg.c   | 3 +--
 arch/mips/kernel/setup.c     | 3 ++-
 arch/mips/lantiq/xway/vmmc.c | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)
