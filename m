Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60C52184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cc937uCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCNRkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:40:22 -0400
Received: from mail-eopbgr820134.outbound.protection.outlook.com ([40.107.82.134]:64425
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbfCNRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3xG7kEEOfmn068eHFGVBGNIYHb9jk0WSU8n5QXM8/I=;
 b=cc937uCvUgDDA9OwGkfaYjlcku4WbnzKHXiOsXyPk9QGdCZp188YhMds8kv/LWPoEjx+h+KEqx/x4ZbU9LzMzHJ894gCT4TY+nYqEzMrxSA1A9pkeSiycSPfa/Lm7z+AgsFX0skrNckDjAjdVs0fzuYbVx4GyRFucneP8A8Yx4I=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1565.namprd22.prod.outlook.com (10.172.63.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 17:40:16 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 17:40:16 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH] MIPS: Remove custom MIPS32 __kernel_fsid_t type
Thread-Topic: [PATCH] MIPS: Remove custom MIPS32 __kernel_fsid_t type
Thread-Index: AQHU2oz8biJKb9VnB02dJhiRtaA49w==
Date:   Thu, 14 Mar 2019 17:40:16 +0000
Message-ID: <20190314173900.25454-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:a03:114::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6645d8f-54f3-40c6-565c-08d6a8a41e64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1565;
x-ms-traffictypediagnostic: MWHPR2201MB1565:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB15655422973E7E78162DC70AC14B0@MWHPR2201MB1565.namprd22.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39840400004)(376002)(366004)(396003)(52314003)(199004)(189003)(97736004)(7736002)(105586002)(2351001)(8936002)(966005)(54906003)(305945005)(486006)(26005)(102836004)(316002)(106356001)(44832011)(5640700003)(42882007)(50226002)(6486002)(186003)(6116002)(476003)(2616005)(256004)(6436002)(2906002)(3846002)(14444005)(14454004)(66066001)(52116002)(4326008)(81166006)(478600001)(99286004)(25786009)(53936002)(8676002)(6916009)(71190400001)(5660300002)(71200400001)(36756003)(386003)(68736007)(6306002)(6506007)(81156014)(6512007)(1076003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1565;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XqP+B8TINw3rTTbFNc9xPwI/6dIJc1ZPpgJdiudJJNYJAdjKXrC7N1GzNZ55qd7yT+t3WGFm7381xe+2hkN32/EpepNyiR5NQnB7SK+QTih0RKbHli5slH2cKiElxcV+yRvySQARxT8FHaAAXM6FmPEJGRR4kFY8PNAySJL6ckpdifMSShtn2nr/ztUzlmLQxh8Tf5yxXFH2yv0oVAbepBdnWilJAfukGF62gX5jzy2tLEUueZ4izaqYt0i25Br/Ex5wE1MShfouZt+NTeuMDEtrfx4YU3ZCFWfNcO8zIT0bGoU1/YWFTw0iI8F3164HMvZoEcZTc+FKJtIhBVAzTO9P/wU+F4prkKeoS2fnqxhWmw1R1DA7IjzgVzgWSqDbWaHXkAayU98DD6V+B4KQky5+IMYhxJPajsXzf3Yjs9U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6645d8f-54f3-40c6-565c-08d6a8a41e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 17:40:16.2883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MIPS32 kernels we have a custom definition of __kernel_fsid_t. This
differs from the asm-generic version used by all other architectures &
MIPS64 in one way - it declares the val field as an array of long,
rather than an array of int. Since int & long have identical size &
alignment when targeting MIPS32 anyway, this makes little sense.

Beyond the pointlessness this causes problems for code which prints
entries from the val array, for example the fanotify_encode_fid()
function [1]. If such code uses a format specified suited to an int then
it encounters compiler warnings when building for MIPS32, such as:

  In file included from include/linux/kernel.h:14:0,
                   from include/linux/list.h:9,
                   from include/linux/preempt.h:11,
                   from include/linux/spinlock.h:51,
                   from include/linux/fdtable.h:11,
                   from fs/notify/fanotify/fanotify.c:3:
  fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
  include/linux/kern_levels.h:5:18: warning: format '%x' expects argument
    of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=3D=
]

Remove the custom __kernel_fsid_t definition & make use of the
asm-generic version which will have an identical layout in memory
anyway, in order to remove the inconsistency with other architectures.

One possible regression this could cause if is any code is attempting to
print entries from the val array with a long-sized format specifier, in
which case it would begin seeing compiler warnings when built against
kernel headers including this change. Since such code is exceedingly
rare, and would have to be MIPS32-specific to expect a long, this seems
to be a problem that it's extremely unlikely anyone will encounter.

[1] https://lore.kernel.org/linux-mips/CAOQ4uxiEkczB7PNCXegFC-eYb9zAGaio_o=
=3DOgHAJHFd7eavBxA@mail.gmail.com/T/#mb43103277c79ef06b884359209e817db1c136=
140

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
---

 arch/mips/include/uapi/asm/posix_types.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/uapi/asm/posix_types.h b/arch/mips/include/u=
api/asm/posix_types.h
index 6aa49c10f88f..f0ccb5b90ce9 100644
--- a/arch/mips/include/uapi/asm/posix_types.h
+++ b/arch/mips/include/uapi/asm/posix_types.h
@@ -21,13 +21,6 @@
 typedef long		__kernel_daddr_t;
 #define __kernel_daddr_t __kernel_daddr_t
=20
-#if (_MIPS_SZLONG =3D=3D 32)
-typedef struct {
-	long	val[2];
-} __kernel_fsid_t;
-#define __kernel_fsid_t __kernel_fsid_t
-#endif
-
 #include <asm-generic/posix_types.h>
=20
 #endif /* _ASM_POSIX_TYPES_H */
--=20
2.21.0

