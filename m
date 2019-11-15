Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4502077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UC5CBGGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfKOKSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:18:04 -0500
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:60129
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbfKOKR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:17:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcnZklfBnrpJeaG1O034/vm8J/Zpl2JiVrQeTAPoDJcf9W402QS7lH3ccqlhsqPzjetO0ystHkqnNfU1qQOltUGX7twLwYlbmq1EbjKX3NHiXztQqAJuQxPJKGDImimKlDSF8U9mRtU89IHA8ZkEuhqai3fFsAtXyWPdib1fmiq8OwL7QUisWQapKOdlew4qX1FDA9ipHvk1R2WL3WLMp5622NJK2S2+jDHWpm1fcymeGfKrCgRCRfNLqbB2RAWdipjcbmD1CxT4kR9v8jzCIFK0sTfvD/pDFYDk6XfpCjECsimpqkrpULrcwI6Gx7XICPxWmPHDHqsyt+fLrocFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORHQ659aoEtcRnPnkP0sXH/YF5tOtOqc4+oMh2DDYs8=;
 b=LEB50cZmVNHpEgN/pV57q4z2cjNkX+2SmHm4Jk6y/7Yq8EgxKV9WlocFHLdmdwJo0syuumog3bEfwOgZfeWyFEWSRrQTYYpMWqKC40XAgPetqaFh2ejwYPcx80qUGLQ6j+BlSA2ToB/Um8Ry7W9GtG0+B167DBJFi5Y2WNnUymzDHkmiyUItX/8g86BC1LdGshCeVWJOBzd3nUeixa+MsUKt0YANT+zxRolRS8/8lTeWu+/fX+DYBuo/SgfKtYWoWBF+oLFqCu80uto3/pPAIHxHS5GJhuanBHiE9FUSNDKlrHK+G98vIF0N1csx3PnjIJ75cKfOUN9IBnJj2TDmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORHQ659aoEtcRnPnkP0sXH/YF5tOtOqc4+oMh2DDYs8=;
 b=UC5CBGGcJSKT6sOr0W5WuORevxedHRPn0u8HRNZ7bTTuOnOrRKMllhyb+tOVhD9b4Lec0bp0QNGpdTi3lr/sNyxcirBJd4HAe89Bike5l8DCWu484LNdWWv5TnL/rK/uh9LF5wn3w9Czr7UepcaQsckyKBA2t/YzKQRMkyaCGWw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5395.eurprd04.prod.outlook.com (20.178.113.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Fri, 15 Nov 2019 10:17:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Fri, 15 Nov 2019
 10:17:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] clk: clkdev: Replace strlcpy with strscpy
Thread-Topic: [PATCH] clk: clkdev: Replace strlcpy with strscpy
Thread-Index: AQHVm53x+DXjeUQoqE+Ge0GGT57azw==
Date:   Fri, 15 Nov 2019 10:17:53 +0000
Message-ID: <1573812819-5030-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:2f::19) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f884cdf-06ce-4738-5d4f-08d769b513aa
x-ms-traffictypediagnostic: AM0PR04MB5395:|AM0PR04MB5395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5395FCD25E55205FA00C276388700@AM0PR04MB5395.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(66446008)(14454004)(2906002)(86362001)(52116002)(6116002)(3846002)(66066001)(7736002)(305945005)(14444005)(71200400001)(71190400001)(256004)(2501003)(6512007)(99286004)(6436002)(6486002)(478600001)(102836004)(110136005)(54906003)(386003)(6506007)(26005)(316002)(186003)(8936002)(25786009)(486006)(44832011)(36756003)(50226002)(4326008)(8676002)(81156014)(81166006)(66476007)(2616005)(476003)(64756008)(66556008)(5660300002)(66946007)(156123004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5395;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMvi4djVH0GjPZ+Wzlu/K2CD7lMsQBhX6n51JJTh4RByGU6keid38QOu663jTgJHVm6WhwVoevgfGCluRuE8+y7UazMcrHDn01TAF8+KyjUaa5Qx8V8YCfN9trKnijW+RhuaEDzKIXKoQK3obsFKxw09Qigy3AlP3MMjbXTtHOG/PqwwXJXxa6K5eOKY/4pSQnM2/kpgXqhhaLpsCnMugrG9T7vG29F0ymUKQQ5J24lZGYcQA+JBP/8DpWMqKGOW9/UQ+v34p0K3P1nZazbAuY/6icMTKtB2vGTbcS4IgrFv7nZxG5we7ZWmNBFslhJc0pLxpDqGleXpg+9xGS9LKakWStk9MRFPlOvM+6tWzKnoJDiELxRfXWfK98XH567IFL5PmvlAeQVlEgrkBDaov2A9O4MI4fX7jaZgInsCHs5oxdiFd5t7V7Ip0UCkGxVM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f884cdf-06ce-4738-5d4f-08d769b513aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 10:17:54.0191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdJglKf7R/U4zV+fuVmD2OS+As4W3z+4ki+1K8hy5Drhi8cUhQKJaCRbl3gxPdtSzrSyPz6pkoP2UwgHn5iGIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5395
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The implementation of strscpy() is more robust and safer.

The strscpy was introduced to fix some API problems around strlcpy.
strscpy is preferred to strlcpy() since the API doesn't require
reading memory from the src string beyond the specified "count" bytes,
and since the return value is easier to error-check than strlcpy()'s.
In addition, the implementation is robust to the string changing out
from underneath it, unlike the current strlcpy() implementation.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clkdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0f2e3fcf0f19..ee56109bc0b4 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -165,7 +165,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, co=
nst char *dev_fmt,
=20
 	cla->cl.clk_hw =3D hw;
 	if (con_id) {
-		strlcpy(cla->con_id, con_id, sizeof(cla->con_id));
+		strscpy(cla->con_id, con_id, sizeof(cla->con_id));
 		cla->cl.con_id =3D cla->con_id;
 	}
=20
--=20
2.16.4

