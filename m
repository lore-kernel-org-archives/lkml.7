Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF0FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF50206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ADuwUoBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNM7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:59:40 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31452 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKNM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:59:40 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: FSA0O0765n7L3C9Yr3iD9dmDDu6JVkKy0OapKx2mFV0Quo9MT1BRg9+G4kaP8w+9oZBQjgiJz4
 xDct3bi6r5L8m2/P4hjd8K5ofhNt9yaRjYvdHGxfvpBLSQ2tdIlAsuXYTRPTvxqh7wsg2ambWU
 UFD0iIfYjcBfDKaD4trRD6NgytGPQxocRozs4PeTOgKantBgox8/Av9ERo/0uc5Sm6Siz2PIgm
 nIUcNfuKZmK8DtFL64mg4jvu6q5UVhyP6X5BdL2x5CoQBbQVutqMf5+X2xYbLfUPaEX1/5zQZE
 WWA=
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="58387366"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2019 05:59:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 05:59:28 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 14 Nov 2019 05:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chrdN16UFZzcCrrIfsx3Xs6R5juqOKG8JJ6fvjyc/81GBQyJxZ/BiTVmj0kj8BBSye6HhbiBaJeo7OI8AQix/INZA5BZT4L3AUDVEFF90U7VHKNw4d23CVB8vn9YFx+NtyoyeTkbXJuEDbR+WArWLiGp0MLwMbXd0CeRM531xxSmEaUCUhHcllUG6lyEqrAS/qLdVPRSBR2LCN2aVEtuNJQiZwxehRf0i4pns7Ka7sjvJ0xzb9ZpWxn+GVcwC90+qKDJLANuIDNMs8BTdZpz/ULxkVD++tYOWPUEhT955rWG9HtOxxeifyi8TfZobTYoIwMfTR+WOipRDNccpDw29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgi4KUmgtAqvBxEJ5EkY30MBonwFHCpgb5hrAe9juvI=;
 b=I54ZsgwnZt0N4hwyd2YK5mm0TFneF75XDYBGs8SulayOGZYBoCgm1fgS5wAynKp+hyi4KPzFOL6V9Pw6s9sqQ/oYw42tRDmwY77w1gmRg1bTuVlESj9L9CBVneIEK/a+rRHnCX03qTfHCUnml0n9q2a4NvkXKVTu8Uc53kN7cwZKRRx98zWWjqHcPch+IHDNhHOHDHBjtBmJn7qKQCAzaJG0auCm0fS0FvUWwhm/WKL3wrEWreDddvhv7+uhzU76sgacODjidVwvZWTAp6nYyV7Ui1kSu5JbFoCSgiQnm8EadMKvD8VR+ta81dJAd2DsftfBf9V3Zou+Vsk1UewUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgi4KUmgtAqvBxEJ5EkY30MBonwFHCpgb5hrAe9juvI=;
 b=ADuwUoBMCOYpeubvD6vTG8YjMqr7yYzlrPPtiwZcn158U8w2exDfeDB++D3LPDkjuWGCh9PsgS+BPkrQRkY+NZTsyLwc0Ig6B7kuVD03wveU/scN65NvJgHavAwGEvGTPh5ccVMT0J7oIhSU77o4CaHTrlEeLZQWgxfoR+2LSH4=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1739.namprd11.prod.outlook.com (10.175.90.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 14 Nov 2019 12:59:27 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::d594:bcd0:98a9:d2c8%4]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 12:59:26 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <adrian.hunter@intel.com>, <Ludovic.Desroches@microchip.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Eugen.Hristev@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
Thread-Topic: [PATCH] mmc: sdhci-of-at91: fix quirk2 overwrite
Thread-Index: AQHVmutY8PrRRVBLH0yPsWaQJRdwZg==
Date:   Thu, 14 Nov 2019 12:59:26 +0000
Message-ID: <1573736352-3597-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::38) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a96394a-fa8c-4d3b-cc3a-08d769027aaf
x-ms-traffictypediagnostic: DM5PR11MB1739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB173990A63E36BD24181A72DCE8710@DM5PR11MB1739.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(2501003)(6486002)(66946007)(6436002)(6512007)(6116002)(50226002)(36756003)(4326008)(5660300002)(81166006)(107886003)(66446008)(64756008)(66556008)(66476007)(8676002)(81156014)(8936002)(66066001)(4744005)(99286004)(2906002)(52116002)(316002)(25786009)(3846002)(110136005)(71190400001)(14454004)(86362001)(6506007)(476003)(486006)(2616005)(478600001)(2201001)(102836004)(71200400001)(256004)(14444005)(186003)(305945005)(386003)(26005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1739;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcAvn/9+5MsoogZDn9h66j2gLQnxE4mDESBXC/MCsRgiB9qnY2MdacHovZKSVNHbIpvpFXJbZ+ItZoYO4z7UpfQhyZOyaAcRqpElvoe7NErTYiN6snul9GzMIQvghtq9KCV2/DFBbs/0le/jMsfptxPkQlIcNIt0qt7mLZRlCC79GcNkzw3eoSNRDrPgK8lOIXH6QddFPT/Xl5RuJO6E2qUj8TBiDjJaCZvLCKpoieN+6wfwL8m2eAcSUcoHHcyh7l6EELKJS4pn8qPSqZRaRecYBB9M75cA9c7OI8mCwN15kgOku9sej8/HTB6J7yxN5Rx7IqBQ+FpXMmtxIg+NHKcbVkdXmVyGdEy2hUWp1GO+RSrPTYMKG0xaeRZ34NVr/iRWPCBOAD1YAvNTM5ZCvyj7fQng6xC49PYrN355eJXEwwR7VebgmbCK4uw5/w6y
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a96394a-fa8c-4d3b-cc3a-08d769027aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 12:59:26.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R1jc+2NozdvmlkCYO59REy9VpK/AeZqpP/42vhhBZk4DLNxNxPQ5LaxhPTVlhr4hq5eOjW+PYn/oZt3ms9jpZRDRUtgu9LfJGjoYnE2Bio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The quirks2 are parsed and set (e.g. from DT) before the quirk for broken
HS200 is set in the driver.
The driver needs to enable just this flag, not rewrite the whole quirk set.

Fixes: 7871aa60ae00 ("mmc: sdhci-of-at91: add quirk for broken HS200")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

 drivers/mmc/host/sdhci-of-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-a=
t91.c
index 496844a..5fe6684 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -389,7 +389,7 @@ static int sdhci_at91_probe(struct platform_device *pde=
v)
 	pm_runtime_use_autosuspend(&pdev->dev);
=20
 	/* HS200 is broken at this moment */
-	host->quirks2 =3D SDHCI_QUIRK2_BROKEN_HS200;
+	host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_HS200;
=20
 	ret =3D sdhci_add_host(host);
 	if (ret)
--=20
2.7.4

