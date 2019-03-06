Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC84C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2AD20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jf5nU/rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfCFGbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:31:04 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:11489
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729092AbfCFGa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDPUj+q0zv8FBil+gr5fgC6yGbTuJonzzrqYzdjZfm8=;
 b=Jf5nU/rF07xlnCKQ7DuOHpiKGx8VVvzGbDw+JDTNiiS6vAiP0HZxZZ5N0TwBI+1DzvlNg4Y/OLXNCvSH9t6wp0mcmqQ9eLiP7W73YBSjR+lNC95MHtMVcl+DfabP0LC0aqYgC/W4+V83xa2GGWGc3oe6t43UakgKJHJR0l5C6K8=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:50 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:50 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 8/8] spi: lpspi: Code cleanup
Thread-Topic: [PATCH V2 8/8] spi: lpspi: Code cleanup
Thread-Index: AQHU0+YjYKT22qgVc0er9bMf4NkGBA==
Date:   Wed, 6 Mar 2019 06:30:49 +0000
Message-ID: <20190306063020.793-9-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 039e4248-6ccd-457f-8e2d-08d6a1fd45e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:xqykR5jLbOXy/FOFsX09IwJbC67iTden0aho9HP?=
 =?iso-8859-1?Q?Lxi/HRrWp5B2N1dtfgSvMRyaSLYilmlHCjjQDnrmUJl4Qs10MTXrouulx1?=
 =?iso-8859-1?Q?31WEevBD/kdc5EEn/hvBF+2riE/kAoTuo1e/kRiI9UQ+qoUVmmCrniZg6D?=
 =?iso-8859-1?Q?yXbGPTbtne9Kkhm2ovVqotTTESzlDC0elnZZTglCv2t5WH3fBG/Uxvnxbl?=
 =?iso-8859-1?Q?Yvnipg82NUxAn/ZUYHWarG7cfbPcwD1GrwaWzblr4KDzPOT5Z1wxi2Ma34?=
 =?iso-8859-1?Q?eMy6nXMSOVBcQh0lpzinsW3Rw0N2JLrrjy45bITKLWB1yfx4K0FpM6M+m6?=
 =?iso-8859-1?Q?OYr9KNoAthgEYa2TwXlKfw0u2rI/OGpWnlbBIpISSrZv31aGoi+tt1SER8?=
 =?iso-8859-1?Q?KZ49uxOFlkruvU8d7tncxC9U4NuGkRYa5M/IkOW4DceHjEwXnilBdjsnd7?=
 =?iso-8859-1?Q?YxFEhV400aE01Rj5DGX3NumWbZTTl+IYr/XfXcDdBRAI4SK+/5FYZtmmGk?=
 =?iso-8859-1?Q?VMHnvM0Q2uH5Z+CwwRTDficks2SbYlTXNFZzeX2qVRc7AAf7V3Oq3z4sCi?=
 =?iso-8859-1?Q?F0ZWo6IgoxlI8jQz6sdH8WUWpAitjLRcROdcjS70HBRJKTiG/+emb5KW0F?=
 =?iso-8859-1?Q?+xUujXb6ua0xXAEVeOfhTOT6xqq2iBYusrJXkFP6aeOK04Ji7ZuPQjAoUA?=
 =?iso-8859-1?Q?d3MDp5Q97PjojouT6SGoQUxO8MyUt87F/wSDLthb0Hx4erduzSrXAqc4Nj?=
 =?iso-8859-1?Q?kNG0YmMDn4DA8ySKbx+KjNiybPP4KTsFsZzOTeW6vhMkajx/6awwcG6K0m?=
 =?iso-8859-1?Q?O2tHYqXi4wncvCtF2t8Br94sc19ado8U6Y8dvxDHyCuNWhAThOX9pPk033?=
 =?iso-8859-1?Q?SaA2k7k/dqXgWlD/PQSaeHaU2muiLW9E/H2W0LT1kxfviNNJJKaRlNEDrC?=
 =?iso-8859-1?Q?BNXNuIEQjej1lddke2ZogtMVjk/w24wS1rvRimi253+MOsdcsBNjWloHwq?=
 =?iso-8859-1?Q?DCiq+/fodCEjRRqf0kVsJBkrwkHWi3VLH4j+uQOYBof38INLVWZ+iedWJC?=
 =?iso-8859-1?Q?6hGupazSMOVWyLYv7rT3Ta/X3sZ9ei2aOJiLxzE1n7B8n5r+lbpI90dC9V?=
 =?iso-8859-1?Q?dQWHhU0/z+dmkZNKH18GraKHpmul03wbBEpWI16BarDlSlgnMGC9ftRtC0?=
 =?iso-8859-1?Q?BT9P4IvJkcQkFLED11NK+sRhxDZ+FVrRJJneQT3OAJB05Z0WgwlVNExqsk?=
 =?iso-8859-1?Q?Hrw8hU+BwYeD1L5b0iae4Jf4Eleyh0eWRnonaO/IJycWP5xnRnC+g84jvH?=
 =?iso-8859-1?Q?0+p1riyTaZAYvX4Vhtcw2Sen7TdzfN6IW6LGeVcN/A1omVNz/ZKI9mANwb?=
 =?iso-8859-1?Q?pqnmvu1GsL2xSc7AmWe8fLk9rY7vK?=
x-microsoft-antispam-prvs: <AM6PR04MB437330CFDC15C930A792A99AF3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(14444005)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(4744005)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wE9rcnKN9a7roVhlZ9hNOT54KOw3H284384KbViyrZCYBvGyjoMvi3bgn0mJxXHTvcYNVNkEGgrLy1zb6aht2i6oQwLeITLL1b6CDx97EM97sVzclAFj38PhkMr5UPkPDvt7xlhRLpiLLc5zwUpzzDyRM+wvIBED30/5MwPp0ie/Hg9/f99FlU1wPk6Lf0iFZSHF2+xwSaQEVta48UVsqhGDwGX3yEHwtqiDAXo3Bl3km4aF4MNt9xuwx2u607W/VXx0uAriUfPbjQ8ouUfBuZwU/QEVIy3fUjB/e6kB/cNpuGlalkZJwLx44X/mysLbvsrYz/k5+DYHSW/4gmEncEzu2jiAcfv6E2AeRKPRkSHcx4m/xN1NdqYkrfLn4lP1UkEZwSxzXbnRR+qv/LgNHLD5cOg+HoNu/XpvjZ8l+a8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039e4248-6ccd-457f-8e2d-08d6a1fd45e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:50.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the extra space.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2:
 - add this patch in this version
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 2ac3ac5ea50a..1860f066f838 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -345,7 +345,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
 					fsl_lpspi->base + IMX7ULP_CCR);
=20
-	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldiv=
=3D%d\n",
+	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale=3D%d, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
=20
 	return 0;
--=20
2.17.1

