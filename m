Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EFDC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC662084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCAUwG8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEOGmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:42:20 -0400
Received: from mail-eopbgr150044.outbound.protection.outlook.com ([40.107.15.44]:2562
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfEOGmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfeAoSAh9pY6aJEyTMPFGf72jowtsN8ztthzBGKAO14=;
 b=iCAUwG8lS3IyFH3G3g7D5Tm2jVLmRnOgSSyHTLgMANMVmuNY9nSa7httEUDBkhAXZK9CI0VoZY10/QLAR4FT2ghAkgW1WMx6cqYytesoRDaxK1nGGVvl2qBtjAnG24z6J0eUZDSjRll4BVki3AgD/7IXI9PfepON27kH0IEr/vg=
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com (20.179.253.81) by
 AM0PR04MB4513.eurprd04.prod.outlook.com (52.135.149.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Wed, 15 May 2019 06:42:13 +0000
Received: from AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::659b:59f5:6a7e:1862]) by AM0PR04MB6468.eurprd04.prod.outlook.com
 ([fe80::659b:59f5:6a7e:1862%5]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 06:42:13 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND V6 0/3] Support more sample rate in asrc
Thread-Topic: [PATCH RESEND V6 0/3] Support more sample rate in asrc
Thread-Index: AQHVCulU+H/G8smYv0qUokhkzamRaA==
Date:   Wed, 15 May 2019 06:42:13 +0000
Message-ID: <cover.1557901312.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To AM0PR04MB6468.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ad8a0e6-2e0a-4ca2-d3e0-08d6d900765f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4513;
x-ms-traffictypediagnostic: AM0PR04MB4513:
x-microsoft-antispam-prvs: <AM0PR04MB4513774162765F9F7DAEC126E3090@AM0PR04MB4513.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(14454004)(26005)(71200400001)(71190400001)(110136005)(52116002)(54906003)(256004)(5660300002)(316002)(3846002)(102836004)(68736007)(66946007)(73956011)(2906002)(64756008)(66556008)(66476007)(66446008)(476003)(186003)(486006)(8936002)(81166006)(6512007)(8676002)(6486002)(2616005)(81156014)(50226002)(66066001)(4326008)(7736002)(305945005)(6436002)(6116002)(36756003)(25786009)(6506007)(386003)(99286004)(2501003)(4744005)(53936002)(86362001)(2201001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4513;H:AM0PR04MB6468.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: naLcFFoUGNLm5ZnFB5Zzqw2xk0790NoI5lBi2dP6kW6eolT4JVQajjetNsWSd1CrIxZRcsu+07zlKtF7Ix49lsnZ8kPPLJzBJZrllwqryZaOly472UXOP/ld7M8nonrSrNSrWJkpJc4RFavCL68W2bkN5wAMd5fxg3IySfntY8Ynns+7kCtKIJQBtpAESVnbowmGZKNZjtLUUwg+XnQJ8q0iYJXfJV6RTMIbZRKmYEHCddEIl7I3p1JBR0O9Zkf6U2+RabRJW/o/TCMLAyuOeylL62ct4stEG53/eZniPmUK7gNJ/TEgpr+Ppzho4ICmUjX3Tpeiz4elEPjL76LoJr42nhqCXqpKhha9PbNTDsbrOQBTcj1yppoD1OO+ofZxNOlFy4yWgWY/uQp68/Cw7BqmK+Y+s+HC4bEO/WJnFEQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <87370C3853C0CE4EAF56FE94A4790CCF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8a0e6-2e0a-4ca2-d3e0-08d6d900765f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 06:42:13.4469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support more sample rate in asrc

Shengjiu Wang (3):
  ASoC: fsl_asrc: Fix the issue about unsupported rate
  ASoC: fsl_asrc: replace the process_option table with function
  ASoC: fsl_asrc: Unify the supported input and output rate

Changes in RESEND V6
- change the Content-Transfer-Encoding to "quoted-printable", for
- "base64" can't be applied

Changes in v6
- add acked-by
- fixed minor issue according to comments in v5

Changes in v5
- fix the [1/24, 8]
- move fsl_asrc_sel_proc before setting

Changes in v4
- add patch to Fix the [8kHz, 30kHz] open set issue.

Changes in v3
- remove FSL_ASRC_RATES
- refine fsl_asrc_sel_proc according to comments

Changes in v2
- add more comments in code
- add commit "Unify the supported input and output rate"

 sound/soc/fsl/fsl_asrc.c | 105 ++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 34 deletions(-)

--=20
2.21.0

