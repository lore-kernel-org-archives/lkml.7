Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B9CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306442087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QxzcnifI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfJ2NlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:41:17 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:60534
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388274AbfJ2NlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:41:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDEySlTMA6Ck9g0NpxYBqlE2OPSbVdzb09bkMsh9R9YIY6OmeBIoT8+OrhvzBY9khpls8Vv6FQNKxB4eTLGRTvzCsnWTvMLFmdy7UzALXwyRbXd9c/gsq1bcn4Q782WBZyKNSYxanBk1cyEjodVNkA3U0+7FovvpJVcsnRN4Q+A0dSZjW2iJVZ1twpH0ZDSO4OiWqPc73OXwOxJab1De1fPFXfQEnQSQTzBx8/hFpO6abW7SsCt0UVhUCm8qqfligzeJIdJ1fqH3GL0Mzv2mzSOAgi5irfN4GkwFSEHHkdmWAbkDn505vSThTWR70otb7cFVmiMOwA7a6F6RGxiVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0ojVvQmDmvqqMgdPmxz3y3KJutZczDR4Aa7mO2J/0I=;
 b=I/BiCjKQ5T2IiJ1r/JDTSczqxzuFT89mNbgd0kY59iZ+XZF+XJ73RVPM8+5ZjF3fnu9DG73+PAAQ9/4ghVI9EaYzhbSi2lAQ3SG4qVZvMbzqiVfFG1ob7fMrKKsCEwjgvp1xJoFp8ac38ZTBRXbwVYFyRbGQAwoL+as6ywmM1nqXnNDaQBVg/4WcXiHEuGicHujHVsUG4KwzUS8DMODkAP+iFPKVjI3LuvKfSJf0UJep5q2v/dJh1v/KyBZX+u7hh1+EtX7e8AKUqQFe/5vM+DgOauByT0B4Qh5H4+Tj3SkP8QQUh+WbL9m0+O4+5V/Dn7CngiPQEyoc6gNqAcaUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0ojVvQmDmvqqMgdPmxz3y3KJutZczDR4Aa7mO2J/0I=;
 b=QxzcnifIoegvrAirERz1UfaLtRVrWZ6FVocG8FwykSbS713rIc2DTVZo5fchmSctz0Ou2QxMhY62kL0drMuEI40KTDDZm6ue7JXrsTF3nLyGB5lOMTqSm3Z5NfPHYsSLH5fmTw2i1kh7ZUpmlgmmmrg8+ZsdWu20BDA3R8Jdcx0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.176.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 13:41:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:41:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/7] clk: imx: add hw API imx_clk_hw_mux2_flags
Thread-Topic: [PATCH 4/7] clk: imx: add hw API imx_clk_hw_mux2_flags
Thread-Index: AQHVjl6GZBndHj4ozUe5Pjr40bMdUw==
Date:   Tue, 29 Oct 2019 13:41:11 +0000
Message-ID: <1572356175-24950-5-git-send-email-peng.fan@nxp.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec42eff7-26b7-438f-0acb-08d75c75a8bd
x-ms-traffictypediagnostic: AM0PR04MB5139:|AM0PR04MB5139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB51399942F4FE3A49B9C8FD4C88610@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(6436002)(102836004)(66946007)(4744005)(52116002)(66556008)(66066001)(5660300002)(66476007)(2501003)(81166006)(8676002)(486006)(81156014)(14444005)(6506007)(386003)(66446008)(6486002)(64756008)(256004)(478600001)(26005)(2906002)(3846002)(76176011)(186003)(25786009)(99286004)(71190400001)(71200400001)(6116002)(6512007)(6636002)(54906003)(14454004)(7736002)(36756003)(446003)(11346002)(476003)(2616005)(305945005)(4326008)(44832011)(50226002)(316002)(110136005)(86362001)(2201001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5139;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xz0J5xa+KKaDBW4yE01ZvzomDg1kRfr6vIPmL4BD4uoHxk1GtYZl0srnB7IS4HY5Y3C5/F2lHAyUaUg0AZg4DCk8HNiwWafBawN0IuLdQZcXLsPmAuJmdgNngyqBd9wmKXwwvksxFAvG1izvy38zuk6LOqRBLa2KXL2bNPvv7Xy9RGohF3l0uC8K5rg0HIwd6/RMaQThbALbii7136i+mCnT6yQZMLDKLoJ2JxTco/TzynE4BxH853dr9rjiDOTTyg72oBS4eEtd6UpOi7W7hKWDQyUWNXYay/nWjjX9Byq4NGiP8UnmLeRsbrypEUZ5AosTfNMApLbLYZgIb0ZymOD+f83bmCte8MRHZ1EuzVjv0vK/F0fESlHnUXUQDthxWYAfkkZ+mM+/CVzujP7sVwhnnOBEyqEYcokR3kcXwhjQnN1ijlYtcTIutxuWIajB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec42eff7-26b7-438f-0acb-08d75c75a8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:41:11.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPZsQdQaTrAkCQfmosZ9zHI0CgiHZFpdP1PKC1awRc22r/DhuzbLYLJqbJArraLP1heIY8aiwFZzMb9XIzmbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Introduce hw based API imx_clk_hw_mux2_flags, then we could
convert i.MX8MN clk driver to use hw based APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7d6157f6dcf9..49cbf6e20ad8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -425,6 +425,16 @@ static inline struct clk *imx_clk_mux_flags(const char=
 *name,
 			&imx_ccm_lock);
 }
=20
+static inline struct clk_hw *imx_clk_hw_mux2_flags(const char *name,
+		void __iomem *reg, u8 shift, u8 width,
+		const char * const *parents,
+		int num_parents, unsigned long flags)
+{
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux2_flags(const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		const char * const *parents,
--=20
2.16.4

