Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC55C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5DA20842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ogte9SnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbfIFPPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:15:32 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14089 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731738AbfIFPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:15:31 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kNlfqB3Z9T3a3tGN/B2YhgEHAuMrJEF6UQiwPzMhZYUv51wBs59xLikh7X4x4nbOIuf4W4HY7k
 FbYmPdQSTvbekWPoSDekXZQpx+ZPaTN7pcPXWFuK1O2CERQIWIepdMahAcowuOyXROgrRVBP56
 hWsUBJu3whpv+FIQle48jPaGYnRLDaWw8qdL97mID3xIUp/UbDuq7M16o6YRsrIhdCsVyysQHe
 FYQm98nmk0Qs5a7DrgHd93i1h3fK2kPXqNC7zVgL7ytbnvFXldeK5cTYyRGjslnhsU8Gc51GPk
 7NQ=
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="47981057"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2019 08:15:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Sep 2019 08:15:30 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 6 Sep 2019 08:15:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQsmBfXqE+6XGUywVLG+kkTrU6Yf+23niKE3cdjiOOJU1vJs/hnS8Pokk17wZ4FXAQIzobK00KWOS7BhMc1U8gcgN0c/2rim6uGPvPXOa/COTBnybzEsMMIkA1HAzG+QycWFdqDmXXpUH3qsKgRiDToMbn/C7e9U8W1uGL/ssbl0vsnuYUPiF3H2xc865RbRtZFbv5qhFpweuCMJUukxymHpwg7Ojpp/2vOCRxMWSmB/rB488ShzHIN/8wo8OXY6/xzkxMCUaYwy5ctI64NMMcbnHOjXJLNLoEmZOGbTgXfZ+G/+9Fbg4guckHhVutSC46DXlr2JmQtXeLN6PUqAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXbqQs9qWCvCP5FTtUs7MUJoDCLgi9VpXDY/0LySCmk=;
 b=RzGRVo9PsqWyBI2nuE1z4LAQpew75C6hJZ11knhCFSMkX7x1rWxwkPkpxaVoqy5NxDoxgxBKv0SIso58p+RhtyqIXgXByzCIsUj++W4hJ3HySy4zF4V26SEG+WX3rKQ2bLh3+Jp9YYcc9gjeZYnvhMTPJ5NOhJ3JuynqjvhY5I+TWW6gf++XPycRYXrnbG6lwG8B8v1f9NLc8zvRyqyz87RNUBuqOU9Kw/c9MtHB3Jtx32jc8hlLBMgoe80NlUzidMgzboqU9osgt95+cQa1iWFpHydBfG2WRJ0B4LdlUC/eLyKCcCIh5JQ0enwLyhcyfXWjZloNG13TaAUoS33l1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXbqQs9qWCvCP5FTtUs7MUJoDCLgi9VpXDY/0LySCmk=;
 b=ogte9SnMSZtdoCsonVKUjTYwE0rYCCYUKsCAi5PShM6BcRN+aSsXhcvZfzNeD+Nv+aMYaIYaYdff6wlkWRi7NBD+zN0SGh+Pdvtz13JdgSTABDsgpbLC7UWdZbLYZXCvGEbQa09/oI3MsK64uw/nyxZH1gSkYpiaNI+SxnEZep0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3567.namprd11.prod.outlook.com (20.178.251.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 6 Sep 2019 15:15:28 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2220.024; Fri, 6 Sep 2019
 15:15:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH] memory: atmel-ebi: switch to SPDX license identifiers
Thread-Topic: [RESEND PATCH] memory: atmel-ebi: switch to SPDX license
 identifiers
Thread-Index: AQHVZMXq5kIdACEWKECKbJSG274dew==
Date:   Fri, 6 Sep 2019 15:15:28 +0000
Message-ID: <20190906151519.19442-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0062.eurprd03.prod.outlook.com
 (2603:10a6:803:50::33) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2037cd61-fced-4a5f-c843-08d732dd0ca9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3567;
x-ms-traffictypediagnostic: MN2PR11MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3567764930D6AA51A7F2A68BF0BA0@MN2PR11MB3567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(64756008)(66946007)(66446008)(66476007)(66556008)(476003)(36756003)(2616005)(486006)(6506007)(99286004)(386003)(102836004)(110136005)(52116002)(186003)(6486002)(316002)(66066001)(26005)(256004)(5660300002)(2201001)(478600001)(14454004)(4744005)(71190400001)(71200400001)(6436002)(86362001)(7736002)(1076003)(305945005)(53936002)(6512007)(2501003)(107886003)(8936002)(3846002)(8676002)(81156014)(81166006)(25786009)(2906002)(50226002)(6116002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3567;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YvYSAC2MwP6jHYrS+SC6kofRoR6wII2RZBs22h2C0N3KTijkE+uLe+0qE3AptLnGz9opm2J8KioHx+Y8/hE7K+lX9s5kFkze8fFLdyIQ59XugC+n0EcT1DY4iC/Xfa7Jc4j0a4ODmMMPJ215wNLKmT6N5h8lv++6x73D11g+QwfwUo0Z/N5nYa3MGA+VVjKuR3IZvQvqb2EeAQsv6ZzYnOlAytQ3lR6wTRwMIhVlBPgeOf2V1T1tju0F9ADIZWG3Iiq4J3V23fgsUL238CGB8SJkoNMaD6koUxxuphJg6sI7RHXVeNoRHDuSydljy55daCAp/yDW9vQ3XLAG/nn7dcaMbbgpbDz+dp2xbhwd85ul58QCEzvxjzmNHd55/UULze+w6bksWYcunqJSgBG0IIEZYaByY/obtCbtcdYlHYY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2037cd61-fced-4a5f-c843-08d732dd0ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 15:15:28.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uevX4fMbRq1YaDD13vy3uN6jXB9hXbSWgeojuSk6JgKGKlZNklJYFp/DcFx3gkiwbfoElME/GPBEYHMn8iAOFYTy4WbnncsL29OjKQkP2OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Adopt the SPDX license identifiers to ease license compliance
management.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/memory/atmel-ebi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 111e09a5b4e9..20252bea8635 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * EBI driver for Atmel chips
  * inspired by the fsl weim bus driver
  *
  * Copyright (C) 2013 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
=20
 #include <linux/clk.h>
--=20
2.9.5

