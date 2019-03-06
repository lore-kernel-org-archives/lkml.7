Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F15D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LrHJSdoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbfCFGaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:30:46 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:43681
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfCFGal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDgK19jeFXYBBzmKnnfGSm0YIjHrhMFLZkhVWYMdc4g=;
 b=LrHJSdoFnjbOdahym9tcUtmpIytbWHeSEQYzBunoANU+SVgENn5dC154e/YQ1CYQDIFz3iZIle7SKhDz6RyOKBrehJKnp/zH/+XSoKQv4aYRiPCSH3uGdf3XV81sHyAOqgLoi3jTiBRFtAehTTca7lukhEgpIU3EY2z35M+X/Rs=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:37 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:37 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/8] doc: lpspi: Document DT bindings for LPSPI clocks
Thread-Topic: [PATCH V2 2/8] doc: lpspi: Document DT bindings for LPSPI clocks
Thread-Index: AQHU0+YcwcFzwOcp6kCLJ+qifSfD9w==
Date:   Wed, 6 Mar 2019 06:30:36 +0000
Message-ID: <20190306063020.793-3-xiaoning.wang@nxp.com>
References: <20190306063020.793-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190306063020.793-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41ff65b-52f5-4f39-21b3-08d6a1fd3e67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:pw7809qvrCChjhs7WoG1NdNGE2Ad5+xn6JGE7vs?=
 =?iso-8859-1?Q?nJBIi3nz2Ra2kr6UDNu0cCbB9UqNo7MpXK5Bzko/1zyXnlYmv1gwdyuByS?=
 =?iso-8859-1?Q?q8BFJzllZFhIaPuTFZW8klQSEPNP6qScqxpId2AR8JSm5adQguvYYcAoVz?=
 =?iso-8859-1?Q?imiSBh/mcR4XJFL6qYif0UyBXxMuDw7AtWWB2xE2Bz+sBWe/47/mKsk3zx?=
 =?iso-8859-1?Q?sIB7Y60IF78bc0dC0ePKcPKkYCkH2BgGvjYcWDnIYwzWkR9IMSDaOD5wfs?=
 =?iso-8859-1?Q?UwAY62/dODHslimNhqn2pCCivlyYStpHv1I46EaNDR9b5oBcS0vvTpIb5L?=
 =?iso-8859-1?Q?3eTAgbvPZ4NRZbK6r90bYhTfduqC1FfHYNPQExsDDZnpUH0vOTS8i6W0aG?=
 =?iso-8859-1?Q?tHcE/PRMpTv2leq2xJP5OfRHF7wbO0nrb0gyFRwt2SwS4WSV+5PR64ktps?=
 =?iso-8859-1?Q?kL90lTXjPEdptBO9iLZU3WIiSf6CaC6DdkH0nhxeUqFWxREQWGVZdj8s8T?=
 =?iso-8859-1?Q?aBOa7lb6Y1whoHE8HhHtFvEAuWKw3kPhV7+VzdQxyqN01ZgVLCJ1Oydww0?=
 =?iso-8859-1?Q?HcjkKNlcwFBZgXKM3daOOQXnmLqn0pnXMI33UYkczaEkX/lkWxTCvsJIaD?=
 =?iso-8859-1?Q?R16xAs7SCzKxyeLi+jC4R9b3PkOiZASAoD6Y3go5peC2JyaMtdafOBoHdD?=
 =?iso-8859-1?Q?2XEY3KEseRJCTpn39Ey2bECcr2Cj9uXbIULT+YHb1LfsgA78dAXVts6Pg1?=
 =?iso-8859-1?Q?kEkv4iL50u0wuonNyJjJBIOmbQyy6VBKcYuqQRP8nAwGjtS6MaMrQUF5l5?=
 =?iso-8859-1?Q?TowYs8IJAB+x95HD/11sYv7sI9nJmoPhw49enKccUF8vh2DcYBf0Xpp3KM?=
 =?iso-8859-1?Q?y9PZMnGMB8fC7kC9WJv8irxAOn8XL/L8uDwN8DUXzYllz1bL8kY+0nWCzc?=
 =?iso-8859-1?Q?Tno5SDU5LqB/qCfXjAauC7FfZKj+vFgMEU2ka6CHNcjkK/U99Xtd6fJ00+?=
 =?iso-8859-1?Q?AhP/T+GyN+2+qISOV45cn5LLrvwbmsfOxtG8kSaUWksPe5xbxrH9OBKvNQ?=
 =?iso-8859-1?Q?chFcCJtUAdigUP35JmTJkrgQT3iXNvU+W4WDecO7rX8dud5mwAvQuoHcql?=
 =?iso-8859-1?Q?P3AwpFUQcS7RYxKOgHbZfoevj9Idulo1jHp089SNlErOEUN/drC2answ2p?=
 =?iso-8859-1?Q?/yaCGv3y6CTlsEEFN1cyXkLvbGByAUZd85wEAzDz4OpNN6Uf6H2xeGszzc?=
 =?iso-8859-1?Q?qpj+vIWEyoIciUUCDxcMCC+Vdg/BmxLtJTrwmjGi4gwCgg5W7nV6cU9ffG?=
 =?iso-8859-1?Q?KlFzWCSKYc+cImZ7O54DLp8I5Fmq4pB0DDwa8HW2rYRuDWzZaUG5HrMdq8?=
 =?iso-8859-1?Q?I6ZzilRw=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB437371051921E77A1B703F9EF3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(14444005)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Td8vY/um1Cvenq3/CDFec/4MRm8tZ/XnpSbNO819WHbxFzqk7wWQ6ORToHlCrdIxIV/q4FV3HYOPOs23G7/PSV1geDY7ytkpyPUiua6Ngl6plPSJ4u8Gv+XPvG4qLCZsmYI6E6M5IziNfOnYAk3rEiqjyl/iU0JTXLkbP0wDXQosGOP2CzlWz99ZEbAouoUKrOAtn8wYlEXqiNaDi0xq8jNswJUZTgHIOGo/t5fWZHo8C6onXF5toyswyu0P7LVrWIjIgTV+LDZgezVGWqM+ZNhkx2UkXkVCR4sTPqdCoi+IYAoeva/n7Jv5B7b2jMe36Ye+nYK1iQc/fwTFqRyhcmMpVci8jsuFqB0knik+GGvRNlO5XvBpyPw5U8tJON2Owo+DfzIuAQMtUJlJXZDpTH6TNvpJBPlF9Rc7K6Ml9A8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41ff65b-52f5-4f39-21b3-08d6a1fd3e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:36.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add introductions of clocks and clock-names strings.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2:
 - Add this DT-bindings string in this version.
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Docu=
mentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 6cc3c6fe25a3..e71b81a41ac0 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -7,7 +7,11 @@ Required properties:
 - reg : address and length of the lpspi master registers
 - interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
-- clocks : lpspi clock specifier
+- clocks : lpspi clock specifier. Its number and order need to correspond =
to the
+	   value in clock-names.
+- clock-names : Corresponding to per clock and ipg clock in "clocks"
+		respectively. In i.MX7ULP, it only has per clk, so use CLK_DUMMY
+		to fill the "ipg" blank.
 - spi-slave : spi slave mode support. In slave mode, add this attribute wi=
thout
 	      value. In master mode, remove it.
=20
@@ -18,6 +22,8 @@ lpspi2: lpspi@40290000 {
 	reg =3D <0x40290000 0x10000>;
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>;
+	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>,
+		 <&clks IMX7ULP_CLK_DUMMY>;
+	clock-names =3D "per", "ipg";
 	spi-slave;
 };
--=20
2.17.1

