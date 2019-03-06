Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D7AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F5B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RUjL7K/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfCFGai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:30:38 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:43681
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfCFGag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWBk3rHLIltubf+loZie0XxcCb4N54vmQeKKQDEaSmk=;
 b=RUjL7K/uj0sN5NVeoUGZIAFN2M3b5DVFXy2dcDfLObjF9BT5iDc1UkIf9X0DFyt92UcKasgitY+hH1e2VALtVq/6V7cw5sCs+ZaGBChYQ9BTQrKF0om3IL3/2L9aavYZrPpIo9qlCkyaaQfO6yc15s9WVmbY4t5QkTUxAJp/vfY=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:32 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:32 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/8] spi: lpspi: Fix bugs and Add some functions support
Thread-Topic: [PATCH V2 0/8] spi: lpspi: Fix bugs and Add some functions
 support
Thread-Index: AQHU0+YZ73L8cmNVOUu/k4GIGuYMog==
Date:   Wed, 6 Mar 2019 06:30:32 +0000
Message-ID: <20190306063020.793-1-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 7d5fd395-65f2-4f41-77d4-08d6a1fd3bff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:z87gyC2hFSzDjyJOPPUR4vpwzpHUFgZpS2Hie9k?=
 =?iso-8859-1?Q?w8t2r+coO1jLw/4exLV8p7vp2uAztFh0/B54/LqYi0md2JkRiM5IgcCn4E?=
 =?iso-8859-1?Q?GezwKTr8Zf+jnJnEM/NWl/TunERw+VOUFHbjAC9rg710SvXlfSqsFpAzxp?=
 =?iso-8859-1?Q?LlUMdpY0XLGkBLBzi7HmoAEvct1Qg5mXPkwp5FHl/dhgfFAx1a6Ycu1kim?=
 =?iso-8859-1?Q?S28023BEGiCmU1t4y14Kz8MKoZqzqYVKpnU607L/O522GkV5ara+e6oZq1?=
 =?iso-8859-1?Q?fScgwg3vjXwq7J08Zg8wZ4S4hYETc61WwFvZaBZ8UERGrUhNCHmE8vl4Zo?=
 =?iso-8859-1?Q?J965SuNNPPGfRaqS8PPxl2fzK7CNfOxPoHilP/rF7XRSkvf/iUzcFaCj8O?=
 =?iso-8859-1?Q?FIqAftV3+4JT8tYDyzvdtXCWH4B2SmpmgHJQ4yOFp16kS+LbkVBAwQGx+6?=
 =?iso-8859-1?Q?0/V9ltPKbFHd3MBPCCm6ueh8sw/0rbfrphQIihJWU6Gy4wt1KAIkdoGPXl?=
 =?iso-8859-1?Q?tlxNd5FM9Pj+xzjqWO4cbXVFwplX/2/AJm8xi+MYFdOr0mTGxmOWbabn1b?=
 =?iso-8859-1?Q?FZCWDH86T6bEDhUU5H3Na+5OreLOxxBr6Ln1vuBhF5wy6CjL7judQ/iXMB?=
 =?iso-8859-1?Q?g3jAGj098/MdKCFyOEj9FSFjrzE9pHbazk6vSe3vXk7h9n3eXDykd6q3yK?=
 =?iso-8859-1?Q?jhjjTBEBCAwo83eJD/RAARW2xOyoD0Ng3qXMfqx+nTvCoBdM9m4oF3F8JI?=
 =?iso-8859-1?Q?4QQ3+NPOqWoZJ/PJiLMmRL7q/RgacOJ2nVlI0WL3EDkw0WOI+cbU6wjVXG?=
 =?iso-8859-1?Q?Sf/HJlD6SrvrIDbGpwjgr8YPQh9LdpK+fuR30RSdRCO5jazsn4WH3UQNGj?=
 =?iso-8859-1?Q?1zRJYkVHUekLTqrxBO8z6ejsQkHZFUsNHbktzX6WAsY82FZABrIOTPUhQj?=
 =?iso-8859-1?Q?EAdXHls2Qc5JNWmNJX5ZclhRC+ZAWs3uyPn79LfSpFUlU2ZdM8fVfqBn+J?=
 =?iso-8859-1?Q?oNs/gSfWVKjkqd276CKshMLcB/VXqta0QbRNU3rq/J4DuxRD2DajiH8F6+?=
 =?iso-8859-1?Q?yP/jHEUYcyZwmKlbo/zj1wZdSgdcSfYvZcYFuk3G7C+a457COanui1gqM5?=
 =?iso-8859-1?Q?dPKU0aHpakS7a3Gr/jYu3+dkCxvw2OizrCDll489FY1WyyvZ9/qDqUUWxU?=
 =?iso-8859-1?Q?Ho3Lxd2NgCQMQiAiES0Mpe9zjgQsGKraLXh32nvLvexi+o5/DbzXjhl4c7?=
 =?iso-8859-1?Q?whGGQQ5gglvuL2GZFYF9MTIArvcuGm9DIW7WTrWqmjKfVObxAgI2FJ6PLa?=
 =?iso-8859-1?Q?pU=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB437390DEFA97A890976A0592F3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(14444005)(256004)(105586002)(102836004)(50226002)(2501003)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(1076003)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zo6jg5m2VXYMFO8hBPPS+pSbwHfrMItMj/kAf9SSHyaDfAqqL0MzrRoz4N5BqkmvtkjF6+ycqr7EukAK0N7tsTI0fmYac4k1MCmN967x7mMxIjm+YiXchpclRbIeuhlti2TyxhBMUV0NiCst/Kvx48+jvu48KIHglWM+SvFc9Bl3EleCnrmNY3gZhL0R1J04fPr1X5kqk5Sg9w4MiW/5TiKOcsKXdrEN3pDBHP9PPFH7sznkL1/+yph6lBAjjS7s3yckWA9bHNUoHlibZOZhSsIOpc78o7SLOMgFccUM9C/CtscltmWnrrURABP4qZMkB4s97MoevoopAsyWyDEZ4rp2REEpG6Ta+H84zHxBLR6tqKAQuTt8CbwidEmRvmZqCzBAI3UAXqovwn3KHi8yH6CK7FwCN72Y8kmMYkOE6Nk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5fd395-65f2-4f41-77d4-08d6a1fd3bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:32.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Sorry for replying so late. This patchset contains changes based on your an=
d other
reviewers' comments.

As subject, these fucntions support, including:
 - Support i.MX8 series boards;
 - Support cs-gpio fucntion;
 - Support DMA mode for both master and salve mode.

These are some notes about cs-gpio and DMA:
 - cs-gpio:
   Because LPSPI driver don't use default implementation of
   transfer_one_message(), I do the cs-gpio control way as same as the way
   used in spi core;

 - DMA:
   Any frame length longer than half txfifosize will be sent by DMA mode.
   For now, there are some limits:
      1. The maximum transfer speed in master mode depends on the slave dev=
ice,
         at least 40MHz on i.MX8 series (tested by spi-nor on 8qm-lpddr4-ar=
m2
         base board);
      2. The maximum transfer speed I test in slave mode is 15MHz(i.MX7ULP)=
,
         20MHz(i.MX8 series). In order to reach the maximum speed which is
         mentioned in datasheet, the load of connect wires between master a=
nd
         slave should be less than 15pF.

Each patch in this patchset should base on the previous one when applied.

Thank you!

Clark Wang (7):
  spi: lpspi: Add i.MX8 boards support for lpspi
  doc: lpspi: Document DT bindings for LPSPI clocks
  spi: lpspi: add the error info of transfer speed setting
  spi: lpspi: use the core way to implement cs-gpio function
  spi: lpspi: add dma mode support
  spi: lpspi: Add the missing NULL check
  spi: lpspi: Code cleanup

Han Xu (1):
  spi: lpspi: enable runtime pm for lpspi

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt |  10 +-
 drivers/spi/spi-fsl-lpspi.c                   | 543 ++++++++++++++++--
 2 files changed, 495 insertions(+), 58 deletions(-)

--=20
2.17.1

