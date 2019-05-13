Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10016C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D597020989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WtBtHxlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfEMKCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:02:48 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:46246
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727965AbfEMKCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51w2wRRWGl1icuW9rOaWK/FP4FJyPhcDR14mhuBmDwk=;
 b=WtBtHxlt2e1vuY+6jGcEl5Q6G0wiwHVQ6UHxNT7wF7lZLb0sH27nSyr9ghcwN4v/RpoR9vgHpjozY2xVSrLYYaUwApbwUwI+tGKHxXTS3FVk3wbHXz0BDN1GEWJX4nxM9UOZKrAQ/klNJjBJNt4wq1Rpdd0nGpSGyPl8AF9YANY=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 10:02:43 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::18d6:6f21:db62:4fe7%2]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 10:02:42 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: [PATCH V2 1/2] ASoC: ak4458: rstn_control - return a non-zero on
 error only
Thread-Topic: [PATCH V2 1/2] ASoC: ak4458: rstn_control - return a non-zero on
 error only
Thread-Index: AQHVCXMBC3SEMfh3ak69FlXDGaWtAg==
Date:   Mon, 13 May 2019 10:02:42 +0000
Message-ID: <1557741724-6859-2-git-send-email-viorel.suman@nxp.com>
References: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27e294e4-ee57-439a-0dd5-08d6d78a23d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4800;
x-ms-traffictypediagnostic: VI1PR04MB4800:
x-microsoft-antispam-prvs: <VI1PR04MB480087DE45CC500DCF14F576920F0@VI1PR04MB4800.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(199004)(486006)(44832011)(446003)(66066001)(8936002)(8676002)(36756003)(4326008)(73956011)(66946007)(2501003)(86362001)(14454004)(478600001)(26005)(2201001)(4744005)(102836004)(11346002)(476003)(2616005)(186003)(66446008)(64756008)(66556008)(66476007)(5660300002)(386003)(6506007)(305945005)(54906003)(7736002)(6116002)(316002)(110136005)(2906002)(99286004)(52116002)(25786009)(76176011)(6512007)(71200400001)(71190400001)(68736007)(81156014)(50226002)(81166006)(14444005)(256004)(53936002)(3846002)(6436002)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4800;H:VI1PR04MB4704.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GZJy/5PJF/TPjwj46onvcgiAhwWb/INF6/ph2UCkFKJ12AJB9c4I47cO7LMzCNK0kxDxG6Q3VLHjD+xIVnqkxUepXVD6Qci7d8IvOVollpXVoprcuMCoI+aXbZbfeQF0uwGYnp8qHRucXUn8HDWdkJTGMeVLQ5LHAY1z/oTSy77mIsFdBxg+DZZ6C5Hg+2Waq0FFzZhWGHRLDJjD+HQhfknE++Pv5FE2A75arUSwu2L/FJDxYcneqH8Z0Hh30nX2r4LN6acs6cLo4R3LXrgS2wmqSBbFJAGJeG92aDxbi+kGqCaeCHSkIDgaMBkdZi11qQu77ExKYEa00sVjO+M84B1M3+O07fmlUD48O+nNJPvMTgZyzq0sWYjrS6/J7QD8G59UxQS/2gw0I6lQ1VX/ebH8m/vTUonI4mW2IxAe+2g=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C805288E2D77FF4DBB1B259C50501528@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e294e4-ee57-439a-0dd5-08d6d78a23d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 10:02:42.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_component_update_bits() may return 1 if operation
was successful and the value of the register changed.
Return a non-zero in ak4458_rstn_control for an error only.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/codecs/ak4458.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index eab7c76..baf990a 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -304,7 +304,10 @@ static int ak4458_rstn_control(struct snd_soc_componen=
t *component, int bit)
 					  AK4458_00_CONTROL1,
 					  AK4458_RSTN_MASK,
 					  0x0);
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
=20
 static int ak4458_hw_params(struct snd_pcm_substream *substream,
--=20
2.7.4

