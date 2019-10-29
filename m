Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DB0CA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB2A217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NhWgqpQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfJ2BVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:21:36 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:35662
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbfJ2BVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:21:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRUzYcJzv8sBcWr31ZjHuaphgdybskZyRCcUJO8blD0WyNpkD9AuDSThiFHz/vHQ1tbDNXy7xY1tobruQZck+XdZGBO5ubMk+UXqete+SrLn20BTGw9vFwdsrcT0kV292wLcVDEo2NrFjXFxGDumXC+fJ+50FbJ/DpUPSlnwjrlq0c3kyvhopTrf+X0I7bxlPFgPveBACbdcS3UZ76CyN3yk5LlHLEo8YNGULOQn3ksNmB4fdzOpuohgGpdbQQK0ESXi97ZJ2xaPYgOj/kQ1BxnpZh989f+tOfDu9W3V9NLpvjv5iypkgaYM2/XVF942SnQgsjsNsNoBG/OC7Q8jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06B8nMCen2Aq7zCYlzh5HKJF/55BGBuLUo3AoilwY1c=;
 b=Lg0J/de6BZ6ePJbmDeq6yjD61rjbbn0Dm5a3TRSF8iLfHhChZcvTG9zloFuCxlTJd1MF6RiompzBaihaiK64YdAf4zQBz0oq7zKnvNRuQwaX34y13vTNyCUDBTnLJTqrBJQ2m3WA8IYcF5l7z7bIujykwQ7I0Rn300797nTcy7hb9HlVV2nSoH4XhYD4JS05hVTTmlT6fEFPG5YPvG3v6v92UDsnDl3IIPISl7aZPi/jLwYOyY7zIe43X6lWZi8/g7Z31/x1u8O0rADu02B9Y3z44F+T8lal8tRhRYXlcyZhXbzfKkpsk0l97UgKDNlcdSCQWKsZN/xmm08pn3O2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06B8nMCen2Aq7zCYlzh5HKJF/55BGBuLUo3AoilwY1c=;
 b=NhWgqpQed3iPlP6naNB/E8bx1WiAFtdZtTH5+EZ9/uf0EpN9GfgZttkKGeQ8p3+XkAd4Uoxw0fYhWV+/hZf0QMDwa6olHVFkdd1E/FvrhAOcaO71KwEGejY/PyBO0l6gXQymzT+vesBDWrTkoIB7/neNkAE/IK8fBevT99XY1nI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4306.eurprd04.prod.outlook.com (52.134.124.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 29 Oct 2019 01:21:31 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 01:21:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] regulator: fixed: add off-on-delay
Thread-Topic: [PATCH 2/2] regulator: fixed: add off-on-delay
Thread-Index: AQHVjfcxRKga6PWwwEWycaXD/sbfZw==
Date:   Tue, 29 Oct 2019 01:21:31 +0000
Message-ID: <1572311875-22880-3-git-send-email-peng.fan@nxp.com>
References: <1572311875-22880-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572311875-22880-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7a04e52-c953-4dea-11b2-08d75c0e5443
x-ms-traffictypediagnostic: AM0PR04MB4306:|AM0PR04MB4306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB430637C100BA0FDFCA72323888610@AM0PR04MB4306.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(71190400001)(66946007)(305945005)(52116002)(2906002)(54906003)(110136005)(102836004)(66476007)(66556008)(64756008)(66446008)(25786009)(7736002)(44832011)(3846002)(6116002)(2201001)(5660300002)(6436002)(6486002)(66066001)(86362001)(99286004)(2616005)(256004)(36756003)(476003)(6512007)(50226002)(8676002)(81166006)(8936002)(2501003)(81156014)(11346002)(316002)(14444005)(486006)(4326008)(446003)(478600001)(186003)(26005)(14454004)(6506007)(386003)(71200400001)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4306;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCwfKTmT6fAO+K6YgLjQbb0BtqEHJ6M8RkSWklw6KmAvU1M3TtEPKRNmiKDaKlFi7nd6PA2lJDG7/8v8x2mJcq48GXGlxZ2Zg/5KYdSXFg09dAI9sXPkzDOvMA2Wtc26NaX02zxlvNxh61lKBeQmE50IBweCqZhgk5WNvYHKP6rekGd13L+kRm7nDC+MUtqsgTggxK18HO5J53iPC7OHE3GSFAaS16FEvWfQ72HeYHxenLEiZGAg5O3nLWPMOhtlURlTDyJZs0e/w63qP/lJLAeUOQoe7lwEUtsk3iRPMc03lxEK22ltl6w9iq68E/kaXSY/QKXk8HMe5JRPzU5OVfNwJbT/6CeRL8Kifcamzt5FmALJ4t8WP0gKke2gjHlCSOBhT7fNwynMH+EXfZs5WlFY9OBmjv7lD6r894lO3XkS88YIktN7P8aVvhrbX74k
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a04e52-c953-4dea-11b2-08d75c0e5443
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:21:31.1902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMIAnQxi0oT5ql7mRuTlgV0h6AMEeJc3wIQ9IrGrNDj7r/MaDXWpWc/tRLys5wllzwwXiWyH1wUwuQgiopXZkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Depends on board design, the gpio controlling regulator may
connects with a big capacitance. When need off, it takes some time
to let the regulator to be truly off. If not add enough delay, the
regulator might have always been on, so introduce off-on-delay to
handle such case.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 There is a checkpatch warning "
 Prefer 'unsigned int' to bare use of 'unsigned' ",
 so I use unsigned int for off_on_delay.

 drivers/regulator/fixed.c       | 2 ++
 include/linux/regulator/fixed.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d90a6fd8cbc7..5dbdc41743f3 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -123,6 +123,7 @@ of_get_fixed_voltage_config(struct device *dev,
 		config->enabled_at_boot =3D true;
=20
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
+	of_property_read_u32(np, "off-on-delay-us", &config->off_on_delay);
=20
 	if (of_find_property(np, "vin-supply", NULL))
 		config->input_supply =3D "vin";
@@ -190,6 +191,7 @@ static int reg_fixed_voltage_probe(struct platform_devi=
ce *pdev)
 	}
=20
 	drvdata->desc.enable_time =3D config->startup_delay;
+	drvdata->desc.off_on_delay =3D config->off_on_delay;
=20
 	if (config->input_supply) {
 		drvdata->desc.supply_name =3D devm_kstrdup(&pdev->dev,
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixe=
d.h
index d44ce5f18a56..623a5c574782 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -36,6 +36,7 @@ struct fixed_voltage_config {
 	const char *input_supply;
 	int microvolts;
 	unsigned startup_delay;
+	unsigned int off_on_delay;
 	unsigned enabled_at_boot:1;
 	struct regulator_init_data *init_data;
 };
--=20
2.16.4

