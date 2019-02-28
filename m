Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C0EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E821850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vpe++gT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfB1G5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:57:17 -0500
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:50120
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfB1G5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKiR4gez6gKT9MZjOHrpMrzfJy/3kmabA2IG1wNK+7Y=;
 b=Vpe++gT6UBT5UNLA8sh1JcyJv3cqdATbrCh4jAA40diD088axE0D+bLN53V2PJS9exGk4updnNIJHj9TD181g7ckqTJOUrosbv54iGVS9ckCh6In+m11TwHfwGewLbsOLd2ggpkVOfrYzUYx8AIbl7ENX68jpQAavqGD6bNjiQQ=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5322.eurprd04.prod.outlook.com (20.176.236.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 06:57:11 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 06:57:11 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/2] can: flexcan: add CANFD BRS and ISO FD support
Thread-Topic: [PATCH 0/2] can: flexcan: add CANFD BRS and ISO FD support
Thread-Index: AQHUzzLULpvzgwYXoEq3ocKsM/7giw==
Date:   Thu, 28 Feb 2019 06:57:11 +0000
Message-ID: <20190228065506.3488-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35fa9f37-5c95-433e-2180-08d69d49f665
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5322;
x-ms-traffictypediagnostic: DB7PR04MB5322:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5322;23:JVdfK8Fu4vL9GYwfi/RoQFsFo/5K9coQ+ly6DcQ?=
 =?iso-8859-1?Q?2+20Fcz+QUHNl1s+TRwUst44DaJK8r7WFqG6/dYRGKO3Wzw0MFtWUIAeob?=
 =?iso-8859-1?Q?pI/41xgferoetMPk+x9n4x92yh170sC/t3Xe+wr2nwhQ1JvXxaWvmDrZ/5?=
 =?iso-8859-1?Q?Qw8hg5atc5HvlQqfDLboiZlrQ/YIPrSzUsxnAbvJfitoh4ycIwAIW0bLbD?=
 =?iso-8859-1?Q?M1GSsLMBujOpnjuGEAqyhJkrlThKgJu+rhck7Psllzem6A+IrWjRCxxN6K?=
 =?iso-8859-1?Q?yBTH7ulEAHGezvH3s+bAteZlau8QVz3Ja3ZRSgS2KkKBWOap2/blGC8E2a?=
 =?iso-8859-1?Q?i3OxgpwXPB3a7Ei1UxPSG4dzn5vhW0xWNU+LgACyzqyUynLUEzhyCkVx4Q?=
 =?iso-8859-1?Q?1WRX5y7lsdAAl3P+xyCX8N2cANVvvFNih/ng8/H0lj3WprG8aeHd1pKZB3?=
 =?iso-8859-1?Q?St24ZduVsBx3U1kTrk7Q6xvOyuOPO1ngCPy5cOKEgM1mdsn3Syrrsdg8VV?=
 =?iso-8859-1?Q?T7pOD9C2kqjiPSdM27vsIYAeQbvVGWaeBDvc4qouf7C9YrQ9lCsPCEHAp3?=
 =?iso-8859-1?Q?wdOewlSezNRg0DzLrc5jnNErzvFQkvpOGxsY90IoxzSvxRYcDk4kEsV5/a?=
 =?iso-8859-1?Q?WlcjD6/MwaIIJMH+vwJyhvclXiSLKUuzKpMpWYpKpE5oEpF+LXZoqyDPoi?=
 =?iso-8859-1?Q?Ws2bfJKo8ebxtkh4IBVFozmp5ofi5yNBADgW5RIv9UgbDfd4KC1Zx+XwCl?=
 =?iso-8859-1?Q?BxlWaEqgczZtRepoH84jnDk7r0i97/bt4qD/ds4wBW6WXxB746o9LqLPMB?=
 =?iso-8859-1?Q?s4tOeQrgYpAEGubjMYuNKQJMe70rlGQ9xGNM1FOgzftSG8hr6uIECsNKkw?=
 =?iso-8859-1?Q?8MOjF1UwAF7Mc+pwQNJyC7zBLsg2jMRRw+pnmOSCDE7uBjZ2rMkg+G2vQc?=
 =?iso-8859-1?Q?tW0vWs6sN/jKJjo0jTwF1+DcI1J2ovkeDSIU6+QjVyL9mXWRMzLIU6bB3R?=
 =?iso-8859-1?Q?3XqFE/5Oq2i5XKqk4+aOxcsOWIuLejCLb0SkdSJvkHE9/LHOXEk/tVihZs?=
 =?iso-8859-1?Q?NNz+840ul74nS7cphC84H4srUOhk+k9PaYFyYDQBgGIOqquD9OA64EIMcZ?=
 =?iso-8859-1?Q?8wIAbjCwwnNdTnL0na0xjT0f6uIxUqoG8jjflJpmfPYkGuDLKvZf3hgp0w?=
 =?iso-8859-1?Q?Y3Ues/z10no8AX9iRXsI/6pZWE7KlYxFfWZFhZjHZP9y8vMRHS868E=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB5322C4B3917F12F33CA74281E6750@DB7PR04MB5322.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(6512007)(53936002)(105586002)(14454004)(25786009)(478600001)(81156014)(81166006)(6486002)(36756003)(52116002)(6436002)(6116002)(3846002)(66066001)(99286004)(7736002)(8676002)(186003)(305945005)(71200400001)(2616005)(476003)(2906002)(71190400001)(2501003)(486006)(256004)(1076003)(5660300002)(26005)(86362001)(316002)(4744005)(102836004)(110136005)(4326008)(106356001)(8936002)(54906003)(50226002)(6506007)(386003)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5322;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xr8BYpdqGPQHoH2PQtvSO7up+x6WZgO63JSNyT1ihpkJfdockpvpPmHqYe1kSDpBtz+8WReBWSPn6lOqAw3/s1Q4dgZq1XrxbjjGlh4fzVeU3XTtPbXh6OIvXP03JTtb/JKAqzshGr4hy9rt0WjwUvT+gflU5oCBRyQY5Mw0KDqR11Wf6aWv/Xo7/MthWrQAO39dy700lK2YqECPDvi0ItoniiLnsfSNq1oWKRxN1VluTst82AWwhi7C5OFQo+97ERfW89d37HddkyvgrC6Q+DKKMYNz+aGmYUo6p77nISqQLTId1V5gBAdLUD5Ocdszj710eVlnQMG01AZ4fg+WHfeLpS+GOGSXSyW1bgshUN/91Msor3izYAk87+cApCVF9vYz6Zc0BNcbm99Lfla11quZK3nljvFbBMcKAHny/7c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fa9f37-5c95-433e-2180-08d69d49f665
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 06:57:08.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

This patch set intends to enable CANFD bitrate switch and ISO FD mode
support.

You may need to firstly review the patch set([PATCH 0/3] can: flexcan:
add imx8qm support).

I noticed that you have been reviewing my patches recetnly, please feel
free to let me know if you want me to rebase the patch about CANFD and
that may easy your patch review.

Thanks a lot.

Joakim Zhang.

Dong Aisheng (1):
  can: flexcan: add CANFD BRS support and improve bittiming setting

Joakim Zhang (1):
  can: flexcan: add ISO CAN FD feature support

 drivers/net/can/flexcan.c | 116 ++++++++++++++++++++++++++++++--------
 1 file changed, 94 insertions(+), 22 deletions(-)

--=20
2.17.1

