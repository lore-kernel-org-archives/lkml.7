Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7579EC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036B206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="okyLbWdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393793AbfIFN4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:56:52 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:23297
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393775AbfIFN4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:56:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWYo6mMieaGocSK+hK7fVQsquCms/6rPQz4yORvjykSHkaio81rpCK6f+xUiWSXLxCWrvFLlSipx5WHCkh+Yuc0C10H+g9diVAzKicummw7dnweBtoBD7BHAeRXEIFOd4yCxy0buMGCsrVus5ScHkMWGMqL1h4smtDBXeX7xEYJU1TjwRs1LPwzcnFitYOCHDjL9HVYxfgkPN37Wx+AdGiV2+TQWjXBhF+b21fI4e1s8T6VNfA65rKTbOxG6JIdQl6eD+JqdXMe9ZphRPkx1TItdYqNwOrNz3S9b6yih2GdcBtfRCokqx2C3fqR1GNoSGUCvVFH5qAjFj6+PbB6rBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV8AXvmPi2NpjYYx3NCFbc2gJzv+RTNwfGRiU2PSHgM=;
 b=ZdcSa0fLSshKOZcEAnNNPZgKknWfkcLynBvhRpPY9O5kv3t1OaxkIxJtKB1nkj6i/Yy287VEb6McqjTOurBNzBlGtcj+UMOwCy/g7AOWn84w0T5LLhkqmgzhdOrLQso2j7zUSH7aEz8TTM2c+aEoETAE7YXmhhZ/y0ypwqikC3ROmfUWY3BQEdOncXttaa7vkkQ/d//a9XdUIDkjrNgodtkZ8VUucDs7dvWAujo7jNZ9Vd+7Lcyy4nFIh/ItERASUuaek9usHfH/lRCd03LhUXg9hkndnL5C9KlXEpkVZf1y1ygF5H/Q0tV2tNgOVlSsvMkBVKcXKNZPaS+0Q+wsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV8AXvmPi2NpjYYx3NCFbc2gJzv+RTNwfGRiU2PSHgM=;
 b=okyLbWdRMWCYJYS6Au4+MwLQH0oFAztsMg8mPkFMuD50BNEVVSGMJ9m7fVJkuNENq7nqN/ceGwcegdwSUd8648ANSJFM8mww3btVp0rdxXDxEzl85Mt/sv017Tym4WS+8v/X791qPCj1d8tlJy2lFLrhNI+aHO4Jzoo/Grnnfes=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 6 Sep 2019 13:56:47 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 13:56:47 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Fancy Fang <chen.fang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure
 to common place
Thread-Topic: [PATCH V2 1/2] clk: imx8mm: Move 1443X/1416X PLL clock structure
 to common place
Thread-Index: AQHVZFNWfQl41vmmtkmNMXjVtPmV0A==
Date:   Fri, 6 Sep 2019 13:56:47 +0000
Message-ID: <VI1PR04MB702336953B1C7E0E2212A10BEEBA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1567776846-6373-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8a027d9-1839-476a-dab8-08d732d20f15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5040;
x-ms-traffictypediagnostic: VI1PR04MB5040:|VI1PR04MB5040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5040BC7B6244C72D8243B88BEEBA0@VI1PR04MB5040.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(3846002)(316002)(110136005)(81156014)(76176011)(8936002)(14454004)(25786009)(8676002)(71190400001)(71200400001)(81166006)(478600001)(6506007)(53546011)(186003)(102836004)(54906003)(6116002)(256004)(99286004)(4326008)(26005)(4744005)(74316002)(305945005)(66446008)(64756008)(66556008)(91956017)(2906002)(7696005)(2201001)(6246003)(7736002)(76116006)(66476007)(66946007)(66066001)(86362001)(476003)(53936002)(33656002)(446003)(2501003)(44832011)(486006)(55016002)(9686003)(7416002)(52536014)(5660300002)(6436002)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5040;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y0dkITIiQR6VZOwohP5/lqfs0kgrmt3SBiIDEIFjNwGvZKOCgGn5VesYmDqmWL2ZdT5bdA0hlCCMCVaPtX88AEfkvDcQgYXVTBHQhW2+rq97Bt1DUt2/qRYQ4iBBkuI3/Cf7ZNNwfJaLlxJr0jrcLoUetF1iGmibct3ZuawUkuLvlSnpEJAoV2F9owbVUJ8IVPVutHgRcHDE651vL4rlBUBVQs8bOW5+GWsEkYVvmh0tixI8KIYA2d9cjFg7OENOksTm/2VFZ3j4rb/dChR81ebrcIFYpjUdMxvLF38ohP4PPpHSKtdfn2LP4I9VheeY8MGegXZ+7n26/aAdpKmK2hQCmk17/b9yWM/vAA1wWLdU2RBjwch5H9d2jtFyrZ5Vu9QrvGcDO2XQe6dtavMgnXhLXuELvPjPFQTupNyRqig=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a027d9-1839-476a-dab8-08d732d20f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 13:56:47.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d76E/ipb0rWGGWB/d6sFYek++/G+xqwJr5sbrZ2LoAl3sAZ4+F8Kh5hVgZV9eBY1M4xdSDcRh+wTkCexSDSBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2019 04:35, Anson Huang wrote:=0A=
> Many i.MX8M SoCs use same 1443X/1416X PLL, such as i.MX8MM,=0A=
> i.MX8MN and later i.MX8M SoCs, moving these PLL definitions=0A=
> to pll14xx driver can save a lot of duplicated code on each=0A=
> platform.=0A=
> =0A=
> Meanwhile, no need to define PLL clock structure for every=0A=
> module which uses same type of PLL, e.g., audio/video/dram use=0A=
> 1443X PLL, arm/gpu/vpu/sys use 1416X PLL, define 2 PLL clock=0A=
> structure for each group is enough. >=0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
For both:=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
