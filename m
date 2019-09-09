Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B069C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319DE20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Sj7mytou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388213AbfIIPav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:30:51 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48270 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfIIPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:30:50 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: jSqiRYevo/KKLynuArCmlaNFfB63DQFLw5yov61/yqo0aDK9BX5dPyPfRJX0wKm9yjkxZWMG0e
 pQmjz4sTT37roBk5XWJmxoHuzsEDFZHy0ALssVuqHgr/TSJaQ1EZknyT6asjoDbYIVA3CuipYv
 fEiorDChFYEezN9pLocyQZMiwcuo9mw9lkJzhPL+PqFF/cu2nOqqGACxeC9/s4u4TLJyKM8bwQ
 V+DlYoPte4ayfF0p4RjU5I5EPLk27yI+LNyPcvxpQa9E8vDgbMtBWRe0yiC28Q5lxkVKONL7S/
 myw=
X-IronPort-AV: E=Sophos;i="5.64,486,1559545200"; 
   d="scan'208";a="48227775"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2019 08:30:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 08:30:33 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 9 Sep 2019 08:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gihRW+FBNaTfip4A8qbx+gK6qHvlR5UZDB4o4lJmsm1gqN/BrGEafU8l8OSXBkVEi/cCjUidoSVZ9tVbWt9uGeAEKEcwlC9P3oUS0PnQXNRTsiJqhPIp6Wr5g9TcBBlO99n2s4+clD7YaXiIgoy++IpJBCfqdrjgv1HBf7OdIcH5iZoohOYqtmDrmuFmb40zSkx2qXVQ+5kYcExMc1TODoZGvje0mhenQvj21Znnv6PHdg5s0zJxKOm49k0jDSlf8X3i8cp3yxF3HTVOFF6V4xBSQtJ6mxGDU/OwcLxrMBK5/ann4jar2O9atZjc5WNn1XL53T+ZYtAhjK2RncJCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grW6ysqqSk5ZRRbyFDA+0V7NWPDD7oWitlhBOcNTWGI=;
 b=jJch7N97qWkV/uxdnND2LDEoDTNsMMFcIPPg+90Zxcs+27eS+ag5GY1qozy5/U22w/PkMSPZca1SsdNN5dyvoVScn8CMkolja8mTXVKiHHjeS+yuhkoSDWEtD0Hnr8EyloeV5A3NscJVhDkHri5E91p/MKwSx4cLBDPeMbNgTqTYD2JYkaH5HL8pEBAMHpMHkGB8MzfjtgP5X8kb/nth6b5+/lnyL5mSed3xOD0k42plMLqUijXvke7v3bjpKJAqtqM2+QTcxxDJLFQy6JSMJSxhaySsWwTYR1Ix2WpC4Wfv/4WZKorJogvDsgLu5V9sWzPfuyxv4Vc0FUa9uaWKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grW6ysqqSk5ZRRbyFDA+0V7NWPDD7oWitlhBOcNTWGI=;
 b=Sj7mytouE4B1ni65OqgqQj578ymn6sUa49wC/zb9wVjU6Ripgpx3oeGjRLc7ywGWVgeol5guBExhMhREPHnTxEmRUKQT8szOw5IFg6La2nby246tODR5o7+Y3lyLioU+4q3sVJQHkZKfIosxp0k8A9pO9l73LLBrXHnWoCrxKsU=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1899.namprd11.prod.outlook.com (10.175.87.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 15:30:31 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 15:30:31 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/2] clk: at91: fix update bit maps on CFG_MOR write
Thread-Topic: [PATCH 1/2] clk: at91: fix update bit maps on CFG_MOR write
Thread-Index: AQHVZyOErB+auWwbkU29bShNogGERg==
Date:   Mon, 9 Sep 2019 15:30:31 +0000
Message-ID: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7698ad3-a1aa-4e43-3caf-08d7353aa657
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1899;
x-ms-traffictypediagnostic: DM5PR11MB1899:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB18996E442C3AD545E8CE0C97E8B70@DM5PR11MB1899.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(316002)(4744005)(99286004)(14454004)(2501003)(486006)(66556008)(305945005)(66446008)(64756008)(2906002)(5660300002)(66476007)(6512007)(476003)(2616005)(26005)(102836004)(2201001)(53936002)(6436002)(8936002)(15650500001)(8676002)(52116002)(36756003)(54906003)(81166006)(81156014)(86362001)(110136005)(6506007)(66946007)(14444005)(256004)(3846002)(6116002)(186003)(7736002)(6486002)(71190400001)(71200400001)(66066001)(107886003)(478600001)(386003)(25786009)(4326008)(50226002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1899;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cwJtJOLttR4V/RPe8ZlpKh1+SWbf6FWpnvVUUhmwRCpykdxuAM+ET05zS3V8CTYPrjI7fuzPRZoB3WJOdhQklpO3F+p3CmWtS9kXm9PoEETZbymrLZn2htlHZLr7Te4XEnnXIBYilF4ei62WAzohbn9ljlUHAkZ7XSqdlTPqRQuPu5g/Ar2CGU+U4P0EH8BnfgU6oRY+qt1YPJq5V1/v7Z9OpvlC3bFFbGPsczHqqxN6gYapM+QO6CBnb76tZXxIfIUwGWEPDg/6+cRiFdHLvJ+PmVh052/6uP+2b6yBTn3ptoDyKhrwncMNDQt9Guhah24O3CIOHOs4Y/x+sDs2RRN6V9cIOcrOvvzzUgxgNvliAL/ZR90XZFZnMdE98v5eTuvWfk/uLrljl4FT3H7Abq63sLD6OgYkklf+3qiYVlI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7698ad3-a1aa-4e43-3caf-08d7353aa657
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 15:30:31.5992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 46G8rA3xbY7x5gTkkRAaDNEv8Pa0DD5Ku59Qe5AIJA6YDx91DkdhNdj3aSUNis6NaMRcZHsAM6KUxnhV8AK8tpvxhHT5NKUXCW/+m/pdRUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The regmap update bits call was not selecting the proper mask, considering
the bits which was updating.
Update the mask from call to also include OSCBYPASS.
Removed MOSCEN which was not updated.

Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/clk/at91/clk-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index f607ee7..ebe9b99 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -152,7 +152,7 @@ at91_clk_register_main_osc(struct regmap *regmap,
 	if (bypass)
 		regmap_update_bits(regmap,
 				   AT91_CKGR_MOR, MOR_KEY_MASK |
-				   AT91_PMC_MOSCEN,
+				   AT91_PMC_OSCBYPASS,
 				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
=20
 	hw =3D &osc->hw;
--=20
2.7.4

