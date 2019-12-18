Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F62BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1F218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RD81bRQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLRJo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:44:27 -0500
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:41892
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfLRJoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:44:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daZCnpoudQyZasiFZDJwDXDA2XBO0Mg9xsr+c47H08J2NG1xmkhwZBD5wfZYFUnm8kUQLoSV645ieQ/9i/QAjbS3wADoZSN5tEXsyLcKLSpZbvNr3h8sX+Z5iIBJpy9n8qVzJOwJScMw6UCutp8Svd2Pl+arHX/LlMHYGNtRKFXTtn6q6ScGXXpAWBfyEH6WpgEN1adNHmbQKmu0h5nUbHN6/UXRDjkCRsp5wxD57t4kbPbpCmSoGizczPpFfLlJ3rsuIhS+qypg0J+gLOmrp/yXR1sOrz4cUOACr7qtF5MRW1/YbMKOkqBLqbgrBKp9dtlnMsTetKlpW5oG3Ag+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ8kdml7Uspcnw3Wt1yu6k0bD+zhn0ITPEzX/NhMTN8=;
 b=gJ0W49XbpnB1vhUtCrbAWAHansSHTFb6oPwyr3HFsjSJWYew4bIeIbSglBbuPTmeo+AwImieAvf8YpxwrNB8F19ne4dMoyOzv2c1iFMgTlLXSBCgz+gfMuoLA0sfH775eCEQaxtH1UO1mZhwAGU1Wy5+SSOhstVwXHhw2gpnWG5fwjJmzhLSrMurK1BNhKwc8AIMlyJHQESyCWBC7hC5jSumv81FU4q+7fnQalsZ3yQPrDwwG/oS0iuWMRm3l833wYPzOpsKPGejGlRyjysmRPEOdgwJW3IsfhSvqS1pC7up/9xqqnccg23qtbmgdryG61qhwvzvJ5DA/OV+alxdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ8kdml7Uspcnw3Wt1yu6k0bD+zhn0ITPEzX/NhMTN8=;
 b=RD81bRQPUe3Tg/hZ5EQfMpjGGTLd7rC3JYy07K8CiVCV80p2oDp5KlRZA/Gcyn+ssuLsnDR+eVf6Y05qw5EKcLkFuAfXqoqAsuA789lG6n1aBZK9SA52sCexuqTLtgHKRqF62TyiKU/U+oZYWEywveIYj1qcgTH0MV3kLa1/P1U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 09:44:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 09:44:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: mux: check mux value after set
Thread-Topic: [PATCH] clk: mux: check mux value after set
Thread-Index: AQHVtYe4wU7+6XXnBEmMewbXqrixpw==
Date:   Wed, 18 Dec 2019 09:44:20 +0000
Message-ID: <1576662086-10569-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52b8d3fe-b786-4c8d-479b-08d7839edb26
x-ms-traffictypediagnostic: AM0PR04MB5795:|AM0PR04MB5795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5795D6834985F0858B301D5E88530@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(4326008)(44832011)(6506007)(71200400001)(8676002)(81166006)(81156014)(2906002)(8936002)(52116002)(36756003)(6486002)(26005)(54906003)(6512007)(66446008)(86362001)(64756008)(6916009)(66946007)(5660300002)(478600001)(316002)(2616005)(66556008)(66476007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rabg83IjPT1KBsobf+dSc+ogqUazn7X/WPIyVaI4NkID1G2Q6llpJLrFWwNFhcIj6g+vBgevenr93FokoCCPsdfJR36oZSEnQa7OLrpDPuwmG/yQui/IaMW5v3GNKH+dELVhYNmCS36XNkmGxe0GHMZM2+DbPpKKILVa0N2nxhpCanUYk7XJqIjg6XX+q4S2An/gWpOM5m9yrgiC2rUlQoBDyyc7uFmgaj03kI0d9ZjyRAS70LDafL0uJPXsJd6zhMmb9rSTbxVqmJqpI/yE97Kagly0A0pgpMf+XvFR/g/a+GfWNO7DeeiJkG1ygAbDwlfduJm2uvG0qK84s3zAsnFFnrVhyzbZKYpYPRKxqXUc38lH6iMdEBv0f1/HdPa4TUnIKtpuDm8nkYRyA8sldftpmgfg8VgNhXH6tkSjZKhxxvUouYxI0beoJ9x4lhr0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b8d3fe-b786-4c8d-479b-08d7839edb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 09:44:20.4702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6mRNZsHtFxUFq2NKABguOPvr9s+E74n/kKs4J/YOvUBsw0h8A7JxLaJdGH1aD+GgogNiflmIq1KIS4YqcscZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

check mux value after set to see whether it failed or not.

To some platforms, it might failed to set the mux value because
of the hardware not allow the change, let's catch such case and report,
then it will be easy for us the catch issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-mux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 570b6e5b603b..3e78ec65bffb 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -101,6 +101,7 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 ind=
ex)
 	u32 val =3D clk_mux_index_to_val(mux->table, mux->flags, index);
 	unsigned long flags =3D 0;
 	u32 reg;
+	int ret =3D 0;
=20
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
@@ -117,12 +118,15 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 i=
ndex)
 	reg |=3D val;
 	clk_mux_writel(mux, reg);
=20
+	if (clk_mux_get_parent(hw) !=3D index)
+		ret =3D -EPERM;
+
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
 	else
 		__release(mux->lock);
=20
-	return 0;
+	return ret;
 }
=20
 static int clk_mux_determine_rate(struct clk_hw *hw,
--=20
2.16.4

