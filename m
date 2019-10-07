Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD4EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CB12133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="lKgg9ZjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfJGXSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:18:09 -0400
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:27147
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729145AbfJGXSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:18:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpzXW9g+Ef75VOCZElEAUoKU6xMWIZR/5kIr5pdDniTQx00tuXxxXapCHCgtGtWirYT56dxGc2GEjYRuZv4hb/g2eyw2OFaXjY+mAihW0rl3Rv181fOL4oOBZlObyn/Oix2O7TjrD6Y76P9xJo+8dDDSJ0d6DnYiyU5aYDTWTB6II5RiljudzkvxnVcIzPkcoGXDrJ03ehtRXPiV72tGp0rT9asFrUQQFyyezC4UTprtwZRv5p1ZmZme+MCGKHaM76L88PZZ+6CM43QESVmhwn122JRVNRpSmj0Nrnw6am2qBiiLAgYn62Jb8ptieRF7QmAWzWn72TEKDDNDlL3Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVuydUpP/ytwpgLVGagQM9NYG1nqPxS+6NcT1OwEgYI=;
 b=Vg/h1wbkCcEQQPVJI5RT0VxT4KSdPCu8OxAvPYzADZ3P+KQHD3l9iBGrRHw/7gI+N88cSz//2z1dV8g14rEBXufTlzmqO0/eIsYahiLvF87Y9y6U5p4O82uOhMWRoNnODj93X913ZE7TNkRfhHumt4mgvY5caDAWDwUSjg/7M/0PlXpoKe3oZZQPcJNHxPJc5kOdRikmPgWKJa8LzNolqw4jTJbTqwU3fG3Ljei4B/j2Q9dOlia0dCx1K8P9xm/29JPMBmnG9NSSX96EpNJlI9DzoLBYLhj1AHsdR/xuXIx170r0/IkUAdi2XqQNwD91IX29Zcm2i03OPfAUUJbhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=mips.com;
 dkim=pass header.d=mips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVuydUpP/ytwpgLVGagQM9NYG1nqPxS+6NcT1OwEgYI=;
 b=lKgg9ZjO7RNb/KUuhwOsKyn3PKTje04TOIwDyvDNlCKmdnHG6u3hwlcsQFCTf37MpwAO24ZUWrIwKzKv0UKeTjeFSdDqsVdBZUXUxg86lqTgRIgt4P8+uSUkTOn+JvPMFVBqm+ju7S43GYL1i6fwJyQgG4iIcyDbbVZt+R8b6qU=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
 CY4PR2201MB1096.namprd22.prod.outlook.com (10.171.223.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 7 Oct 2019 23:18:06 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::9987:ed50:7ca7:d232]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::9987:ed50:7ca7:d232%8]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 23:18:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH] staging/octeon: Use stubs for MIPS && !CAVIUM_OCTEON_SOC
Thread-Topic: [PATCH] staging/octeon: Use stubs for MIPS && !CAVIUM_OCTEON_SOC
Thread-Index: AQHVfWV5h/4dLnhlLUKkJHMTdL4W6Q==
Date:   Mon, 7 Oct 2019 23:18:06 +0000
Message-ID: <20191007231741.2012860-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:6e::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [73.93.155.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10a9a7e4-7774-4786-a772-08d74b7c9bc6
x-ms-traffictypediagnostic: CY4PR2201MB1096:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR2201MB1096EF9D72CE1809990DA7FFC19B0@CY4PR2201MB1096.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(39840400004)(376002)(199004)(189003)(6916009)(66066001)(966005)(2906002)(71200400001)(25786009)(316002)(71190400001)(478600001)(256004)(7736002)(5660300002)(14454004)(1076003)(102836004)(99286004)(52116002)(26005)(305945005)(44832011)(386003)(42882007)(6506007)(2616005)(486006)(6306002)(476003)(6486002)(6512007)(186003)(4326008)(6436002)(36756003)(6116002)(54906003)(81156014)(81166006)(50226002)(8936002)(64756008)(66946007)(66476007)(66556008)(8676002)(66446008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1096;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rwrMWNss/tZluCIMIljKtmdfmy/Hq9ULJoWQH2l5qG+q2sTuwhGafEuvKgqViYOS1N6PlArked0IyLPSbt2yV/FCqAjD7o5QrjXmhJlNtpbvEpCWSrqQhSHz435RLHfJEzGpHqv3S+240+t4M8gDVzgZ8TX/KG/vptb1sD/ONnwhk7B4ceXWVcTe+IiBDdpDqkxF8viFmvoddqOx+GOjoF5R23H/mHoxniiGmbPbh2apJDfO9hEc7AP60MWxtw+c1+HsBh0e/5cJVC3AR5dZhhBub7O21MMor6ogQ6Ykl2pSHW0wZA399J4Z4WBgASn4YZ5Wt6ngk4Qa9P4zz9u4tQb171yG9QvrCJ2czKqfzKZw7Nyzmyrw7y6qGMYYKuIUxto/Gcox+LM8ToDcUkPjkD+Tna9aUuLu+Wb21r6xdFIRfZ3XuXhqq2qE2MB34n0qkTWjGhw1wnr+Q+mVTLsvnw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a9a7e4-7774-4786-a772-08d74b7c9bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 23:18:06.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AR7ktAf+mwSsbPixOhYLMVLrtfkczh54cMubnD2YQjYu0fOHLPv7MgjBf+5UNca0bXpABn+OAU+RqRHThzl5zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building for a non-Cavium MIPS system with COMPILE_TEST=3Dy, the
Octeon ethernet driver hits a number of issues due to use of macros
provided only for CONFIG_CAVIUM_OCTEON_SOC=3Dy configurations. For
example:

  drivers/staging/octeon/ethernet-rx.c:190:6: error:
    'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this functi=
on)
  drivers/staging/octeon/ethernet-rx.c:472:25: error:
    'OCTEON_IRQ_WORKQ0' undeclared (first use in this function)

These come from various asm/ headers that a non-Octeon build will be
using a non-Octeon version of.

Fix this by using the octeon-stubs.h header for non-Cavium MIPS builds,
and only using the real asm/octeon/ headers when building a Cavium
Octeon kernel configuration.

This requires that octeon-stubs.h doesn't redefine XKPHYS_TO_PHYS, which
is defined for MIPS by asm/addrspace.h which is pulled in by many other
common asm/ headers.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
URL: https://lore.kernel.org/linux-mips/CAMuHMdXvu+BppwzsU9imNWVKea_hoLcRt9=
N+a29Q-QsjW=3Dip2g@mail.gmail.com/
Fixes: 171a9bae68c7 ("staging/octeon: Allow test build on !MIPS")
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>

---

 drivers/staging/octeon/octeon-ethernet.h | 2 +-
 drivers/staging/octeon/octeon-stubs.h    | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/octeon-ethernet.h b/drivers/staging/oct=
eon/octeon-ethernet.h
index a8a864b40913..042220d86d33 100644
--- a/drivers/staging/octeon/octeon-ethernet.h
+++ b/drivers/staging/octeon/octeon-ethernet.h
@@ -14,7 +14,7 @@
 #include <linux/of.h>
 #include <linux/phy.h>
=20
-#ifdef CONFIG_MIPS
+#ifdef CONFIG_CAVIUM_OCTEON_SOC
=20
 #include <asm/octeon/octeon.h>
=20
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon=
/octeon-stubs.h
index a4ac3bfb62a8..c7ff90207f8a 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1,5 +1,8 @@
 #define CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE	512
-#define XKPHYS_TO_PHYS(p)			(p)
+
+#ifndef XKPHYS_TO_PHYS
+# define XKPHYS_TO_PHYS(p)			(p)
+#endif
=20
 #define OCTEON_IRQ_WORKQ0 0
 #define OCTEON_IRQ_RML 0
--=20
2.23.0

