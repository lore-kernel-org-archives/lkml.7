Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B916C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1361C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="M2u2SSxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLJLZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:25:25 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:8794 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:25:24 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: K2CDqsVHx0qJasyK/F6sCP9m05GI79fRm+/dMeT0zCARxozDxNFhPrUWAA8Qfl7+Jl2tvWkwvv
 NVurGr3KZ2zVZVJEcDmB9UNmI3fH9k6yPqIDhMicKIcgmDyE2himPhUzcKtx/fumVfLreprgU+
 wv5caxFPfdB2lyYrJgwnSsGPInTSTIUT9NtQyBvcknxaCYdQmOt8gsmzISHP0SvRNbJqCN3HuQ
 lntdCNAdOX72iAdYZv9JFqr7zHVWrUejQQzpCJ+C9J49NDOKYrMElk8NM9S3OnXjY7D2PoUUY6
 aVs=
X-IronPort-AV: E=Sophos;i="5.69,299,1571727600"; 
   d="scan'208";a="61201737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2019 04:25:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Dec 2019 04:25:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Dec 2019 04:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBHRn4QkLjzLk2lbf3tHb0WfziL3fOVqKPqf3lKceGD6emv89ZIZRbh/8jBcRjHakFQZTsVzFblJCb2Fu7jroKk8qhrjFTgrZDX8WQJcWMxDK4DCsu5J29vOPN5+RW7Pi7MM4SjTerBD89tdnPOZ1PPGgG1HuuPRjeumqsFc/7pRTG4nbAMfPZ3VtuQqjp4P4OCQ1gV2BSt5lBpnHjFF8dNHWmXp9+GbHk8Qauabq8I0lWysW0RjP5o9vYWMy2HNAxx1kJ0zZticEvMxUmMZeZn2IZ44QmMq/5afnX7bBecVyqJCYJNEkE8L5WXkcOwac/bx+RrtHeEyL5+4G7rcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e98rIWgRgDe18zmweDZtY6zrpYQBRfLW6YQDFK28s+I=;
 b=Ndh+6zjlhPIALFro/oW3jZd+vGs/JxPOBq2D49MNaz0u1GEvifQpZV/n1/pP8qcyn0CSpwVRBxskNLgk5ftxRfMePKjmst7jluVfMxmaK45nmfnw8bQeypLe8edyBbCG8y1sFEbBuHhzTOVVuhC7g5fAIBtoJnsUkU50GykoQzw9G4ov+V/NK1sLOJQxxANbse3xGozo7rafykk2paNk3O1GsttddRGWPi8r/3Pn6kqUVhgJKKRv1dp8m8VJoNuljTtiFij6/D9IB4KMLj66nhEiXbd6kBWi54u1Ffii3EZQTMJCddy0dy9LuZ2xzEmhdpxVPvIhDnFbhk/aVwco6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e98rIWgRgDe18zmweDZtY6zrpYQBRfLW6YQDFK28s+I=;
 b=M2u2SSxQMiEBYID5qVQOy74Bzs2uy9ZyyAau7fPzML3K4QSwfQZilUT9/RjkBGkYBIVrFPEsT3lzD3FGTInDhgBKiNJi56/pmUjaMbqcumS14XrRIebOt6Ke0TVU875f0URrMBz/1ffEl4wHkFr5A+/LuMJLE17ylMUfyz+EUsU=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1419.namprd11.prod.outlook.com (10.168.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 10 Dec 2019 11:25:20 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::9039:e0e8:9032:20c1%12]) with mapi id 15.20.2516.018; Tue, 10 Dec
 2019 11:25:20 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <Nicolas.Ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Eugen.Hristev@microchip.com>
Subject: [PATCH] clk: at91: sam9x60: fix programmable clock prescaler
Thread-Topic: [PATCH] clk: at91: sam9x60: fix programmable clock prescaler
Thread-Index: AQHVr0yBHk78Bfo1XUyRKbpCjE+1Hw==
Date:   Tue, 10 Dec 2019 11:25:19 +0000
Message-ID: <1575977088-16781-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:205:1::14) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c435ebc7-cf2e-49f2-1724-08d77d63a3ad
x-ms-traffictypediagnostic: DM5PR11MB1419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14194693A7E7DA8ADA46FD03E85B0@DM5PR11MB1419.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(5660300002)(71200400001)(478600001)(66556008)(66446008)(107886003)(6486002)(6506007)(4326008)(52116002)(6512007)(54906003)(36756003)(186003)(64756008)(8936002)(86362001)(316002)(81166006)(26005)(8676002)(81156014)(110136005)(66476007)(2906002)(66946007)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1419;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhxlCgd2lxKiB6T9FspfOwWWixqrTUgJZwghjdHI9BeaigwSKhFSxBfHefRcirVfzffkDww1/HkF6/cwn5TXRmHf0Ets4R9pbYmMcKW0qYnKRjpXyU5ni6eQ34KcRS4uLCa4pBJfvPczoRvHkhc4UpGLbG8kZo70UitJtL9hlI6+nQoKM5c9NsO5uZOeTMt/O33GyqVqVpL/sCt7do6xSK0rNyxP+TatO+W3Z4Sni+eQZN26ds3vEyBYI6qiuSp9iLtghbD1KBntU8GlAYkO88nUCHlzek0t8i+dYp/OBYOF6Z+5HhaxWzWN8VWIXOadFnLN86rXs/kZ0u1U0daqiqlzoB4InyT5f1iKSToQYZIHOLKCL90dOM+AtFKGxYpt7Cx324Z+loyOfEaDBb2vqC0qQZUjcT5AP745Qi/5taU1O6i6u77rH7E2B+ZsPFFU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c435ebc7-cf2e-49f2-1724-08d77d63a3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 11:25:20.0847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNMuVy9TX8g1xA/SOuMHj4QlgvDqjAqgD4zSEt0TqOJJ23LplBExTPfSmljbFo0NbgqV7hzaKR/VGJPnw4R+OKK0VZmAkRBt9Ohr3iqwyrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

The prescaler works as parent rate divided by (PRES + 1) (is_pres_direct =
=3D=3D 1)
It does not work in the way of parent rate shifted to the right by (PRES + =
1),
which means division by 2^(PRES + 1) (is_pres_direct =3D=3D 0)
Thus is_pres_direct must be enabled for this SoC, to make the right computa=
tion.
This field was added in
commit 45b06682113b ("clk: at91: fix programmable clock for sama5d2")
SAM9X60 has the same field as SAMA5D2 in the PCK

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/clk/at91/sam9x60.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 86238d5..77398ae 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -47,6 +47,7 @@ static const struct clk_programmable_layout sam9x60_progr=
ammable_layout =3D {
 	.pres_shift =3D 8,
 	.css_mask =3D 0x1f,
 	.have_slck_mck =3D 0,
+	.is_pres_direct =3D 1,
 };
=20
 static const struct clk_pcr_layout sam9x60_pcr_layout =3D {
--=20
2.7.4

