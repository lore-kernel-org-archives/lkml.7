Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E5C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70565217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISrC8fdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEULEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:04:08 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:28132
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfEULEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JCKRJ/rZ5z3f2Y54LW83v4tUbvidtizOVuCM8lLLss=;
 b=ISrC8fdRNh5Kkj54KhALQM+u1ftNtZ9XKkFq6pUzGTspr4eGrdnJtdQbUJcuo4eUbsigHUmtQHL2JM7yrTVxyi2Oj8w8MKf6r9xPihLb8CDD7g36ADeQXJzM4EPOAXi+YVAdnaUKzkbvr9WrydUvPGaxA9cvljSeB2ZfuqQ0lN0=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5235.eurprd04.prod.outlook.com (20.177.41.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 11:03:57 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 11:03:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] soc: imx: soc-imx8: Avoid unnecessary of_node_put()
 in error handling
Thread-Topic: [PATCH 1/2] soc: imx: soc-imx8: Avoid unnecessary of_node_put()
 in error handling
Thread-Index: AQHVD7YvdNtmZ2uz6UeyYdwfC+FzEA==
Date:   Tue, 21 May 2019 11:03:57 +0000
Message-ID: <AM0PR04MB6434C99FC1B4F12477F94064EE070@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <1558430013-18346-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08b4d7ba-1115-4e59-1d18-08d6dddc05b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5235;
x-ms-traffictypediagnostic: AM0PR04MB5235:
x-microsoft-antispam-prvs: <AM0PR04MB5235967920BB3111B1C45F64EE070@AM0PR04MB5235.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39860400002)(346002)(366004)(199004)(189003)(486006)(6246003)(6116002)(2906002)(102836004)(8676002)(14454004)(186003)(44832011)(305945005)(26005)(229853002)(9686003)(7736002)(86362001)(316002)(476003)(53546011)(76176011)(6506007)(256004)(25786009)(2501003)(3846002)(7696005)(478600001)(6436002)(66556008)(446003)(54906003)(64756008)(4326008)(66476007)(110136005)(33656002)(73956011)(66446008)(66946007)(76116006)(52536014)(53936002)(74316002)(99286004)(81156014)(8936002)(55016002)(4744005)(5660300002)(66066001)(71190400001)(81166006)(71200400001)(68736007)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5235;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9VFXH3YvISyNLG4GB6VTwK9Bl4++Tb/xNUdFRmvhR4Gbh1/pWIxWP4xtbR0RBly5pwnNfIv6KNpCG/gdRCT+QkG3OgsVSJIYsbBRGrgs5xngq2fPbnuuPzNMKT6YugoK+KR8BuaYLQyluG0y1GyJiaYa8AGLOV8d2h3I2HvB3RcJB2J2QMPSW2XY/NgijiDbFJ2t5nym7GZZ4+QNWaKoCGMHdxTfoCYzAR2r9csBKX0e6I9/lR12sMxJoc01Cs4Z6zQVN6Xn7+x+4PA15Il3hUy+WICdVXdf+PzQZUWys3fSS3YLbSQrL6OPLViZvGig1IdNahjFT35Pff42M9YYafYYfhD53OVJA2U7z1x08Ur9v+UlqGae/eKeER5lnixtLpAIw6MhfIl3G2+sbnHX2nUlXKFuR3v0q6ULOhPrZP4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b4d7ba-1115-4e59-1d18-08d6dddc05b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 11:03:57.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/2019 12:18 PM, Anson Huang wrote:=0A=
> of_node_put() is called after of_match_node() successfully called,=0A=
> then in the following error handling, of_node_put() is called again=0A=
> which is unnecessary, this patch adjusts the location of of_node_put()=0A=
> to avoid such scenario.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
For both:=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
I was thinking that maybe you could of_node_put as soon as you were done =
=0A=
with it but the model is read straight into soc_dev_attr so just freeing =
=0A=
everything at the end makes more sense.=0A=
