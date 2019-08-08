Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53942171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a9nfLLi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfHHIfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:35:46 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43644 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHIfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:35:45 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kh1u7GSs1wP09QQqdQWKtWlIfhbCNLj9oMYmWRoirqRXZQAyxpPLY/gewcMlLeCZFy+KX7X7UY
 NoQy4KqYsxDE9pkTKFDbuTfj8fPgw994JRjeAo8S98ooJP7WLo1kTsH1b7NlbYmUA5Twwr3VT9
 tI1XI12ksXsi81H3aG2ycVD9mv27gUrDgKgCJpMTtlbglZeEOAqDPboh67qtWLAhSjL/Cjvabf
 rQUK3qEfpcqX1aHSlsdAl2mAnIYOD7Fv4h54oeW9WSIBF1DhAkimrq2fyYHQg6WDgMjfUflxZ9
 8/U=
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="44412903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Aug 2019 01:35:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Aug 2019 01:35:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 01:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH+dqJ2z0cEFvMiSjDFmmapLEHWw07N5BKbkqu5R1lOjPtwsJTdPVVt28aISvhMmvrTjQKvS823Vp+hLQeYg2ovTzjENcZ0QhPtOlY8i4znmsh6QZ9LoHSmnYkFDRj84hjlX6wMA2VziTlBu9bkqRcDaJTPLgypkVfUZbIbwc9oKDL5zgHKNCi/++9izRM2MbJwdBqHZCOOTKiA6L2mda45Fr2/3GKgzahyXRREJweslE7aFD/W4YUtkI8HubMf3+QRCq1IvuJ+uz5TKZ+QyOKtPt9CrkNULPZ5180kQwD5JT8bCssq2JX7NQYB1VCgNziZ71Fz9EU2eFiVhPrDU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WU79edz2INKG8i+Jz6gV+gBXew9C3gmAnwP1I44fBk=;
 b=iaz7pinY6sVnNTlhgPChUZGbna0fkheF5bRJiAUIqpX6uOoOPASv2JdL6vc7VeV4c6gydENSEBc/MEW3QFIJ8IwtsJSNNHNfa5FU5GAJYy2kQW7fhKjoAs1NQTu61PAlJbBuHh56PPxzSoYEfNU22mYGT+zfnjISOS6gBvaOxkuK6sTDyzjCSVd4hDgZbctu24h/7J3PNbFgsXj12kpcPc4Tufr0n9w6RN0BxqKEfwj7iB3f9WeCgNIUPdClvam8x2eGqTZ0UDS1g5RaB8irA1PCvQvm0byiLEzBmsSe3eYRnkd94JU5A7lDvXjJCM7gfiuU/8p8b6iZVG9u8lNHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WU79edz2INKG8i+Jz6gV+gBXew9C3gmAnwP1I44fBk=;
 b=a9nfLLi+OaLwXRDg2dZeEvU5EiaOU1sWPxM9EuXkVcOPiX9HusVmm3U7bHIj1mTauNTTj9y/9l+4vSBMgzgOfD1IRUU7EMgc4uJ5KROevfJOwaArP6Pd0HM3hp+NOni4cQTn28Fr9Rc2nNMfb8/VTPE3a3ZtimTN4zwP88Q+uoY=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1545.namprd11.prod.outlook.com (10.172.36.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Thu, 8 Aug 2019 08:35:40 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::c457:dc57:6e6f:f4f3]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::c457:dc57:6e6f:f4f3%10]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 08:35:40 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Thread-Topic: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
Thread-Index: AQHVTcRCu4nz/dUi80G6GVwFCxrwfA==
Date:   Thu, 8 Aug 2019 08:35:40 +0000
Message-ID: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:803:104::33) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc942a3d-4e94-48a7-3564-08d71bdb64e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1545;
x-ms-traffictypediagnostic: DM5PR11MB1545:
x-microsoft-antispam-prvs: <DM5PR11MB154506113B38DF6AA3794BCFE8D70@DM5PR11MB1545.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(26005)(66066001)(64756008)(66556008)(66476007)(66446008)(6116002)(3846002)(2501003)(2906002)(66946007)(14454004)(256004)(36756003)(6486002)(2201001)(6436002)(86362001)(305945005)(7736002)(53936002)(81156014)(99286004)(81166006)(4326008)(478600001)(6512007)(8676002)(316002)(52116002)(25786009)(486006)(2616005)(476003)(71200400001)(71190400001)(102836004)(107886003)(386003)(4744005)(50226002)(6506007)(186003)(5660300002)(8936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1545;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sTVCFikAGlMKkbdIVDbW8Nli45NzQUi+k+E+fq5cWWXEHhKfEn1xtVF92PuSvnqyywuJ+00dpCF7iGLcpt8sf///RSHkKHYavCuYDWZKjnOSKqTa5OVuQIcCXVQP/ZXoBcjjs3QP99toHyPWbsxI5k4yGOviuiDeJk9U7J9SfNMBFeJ+piGkaWWbrGI21d1VN4NpGGKc6W7T5Fu7udO0V3OHvx65Ypb0EuSydSck2IaAReEY+uqTrMsGOq/fgo+5UzIeqx+n3OsobMYuvXp/NfpSnh8RDw3eSeXftc62Ubf91f+ECtJCEfI7ZLIyACKoYwiUfABzMQ0mZlZYsCdPdco1B3MDZ48/caHh8p1RZs7jlLQvU8DaSyYVohUD1TbnFwZsHFK/FjAdc8Grb1pdZaI8tt5vbSlLZ9Dwe+7hyEI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc942a3d-4e94-48a7-3564-08d71bdb64e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 08:35:40.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQyWwqpW+7DSjjtyOqWz6w3FpgUJbDRizhBu10qvDpsoAZfFAkQvCXiqaGa5g4kKh+Lxs78ub4B9Kybslm/BSCySNakLCibQVPInaKyNxXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

HS200 is not implemented in the driver, but the controller claims it
through caps.
Remove it via quirk.
Without this quirk, the mmc core will try to enable hs200, which will fail,
and the eMMC initialization will fail.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-a=
t91.c
index 57fe3b2..3a8c6d8 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -370,6 +370,9 @@ static int sdhci_at91_probe(struct platform_device *pde=
v)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
=20
+	/* HS200 is broken at this moment */
+	host->quirks2 =3D SDHCI_QUIRK2_BROKEN_HS200;
+
 	ret =3D sdhci_add_host(host);
 	if (ret)
 		goto pm_runtime_disable;
--=20
2.7.4

