Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14205206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="ERNrG7gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfH0Itt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:49:49 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:29862
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0Its (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:49:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj5CPOQRxwtAZDDiyNrwCZryVsdjK0Apu2GTAPbbENS4b5yxowsvLSyGPv7pEstIAj+/vHFHtmNjbsgEwKh8kScaDxljGafK8XvwJ6WM7gz+LMeN+vd3qzI7sSLbw4pxXo8Z53GiS6Z2tl9JvSH+LgqiQTk0JhGayzD3dOyh1PfppxoRoj2eVm+oCgor8fBpNutt9zTGUgZQ8sEBPwA2CLrWUNH49rMbBteeIrSvcR8K5t4wruBHhvqShUVXJBp1HY+VG19lTXwCi+UBZnNlZLwl7to/r8zF29nlyWiJtR4hX+A0q3rG3CJ+kVWn4unxgbaa8YoSEm0eDJ6kKG3yZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQTP9LUrBEghk8sJjwnNlHmKbUzChUXNIUtw6Yr0H8M=;
 b=BMISf+eGkj69+T2omcqp6U6sH5XAVkGtLqJ3gQNh9EIRkb+1K9qStZmSWNG+RqK9FIN13S6Icn9dh2PestM8gRcLIJK6LkK2KF0+N9BcpZeitzo156GONvf5PvufrzTb+ON8vjdxZfymsjGr/q5m0bLAbTHdFGmKtIvDBe6pJ/9cbXRiu+Fw4yYgx6v0mFhBoKdcq2TIjgzd5dYFyJ/Fb/szP31BSTt/1LGEGKvXmHBkBbsvO1ECl7Ekc2GUl9JC6Uaf2TlYgrvvBlIe/Ofp4nXSOwTke6oaQ53Bl6mED5SneVopT36aF1Z7DoLLUmr3uQg/C1CL77BUm3An/z05ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQTP9LUrBEghk8sJjwnNlHmKbUzChUXNIUtw6Yr0H8M=;
 b=ERNrG7gQw7UKFEXEvW9mYhOEzTZ42Vwl3LIwb17K4DumWUvGYQJMlTo3gtciYvk2Nc0nJKoQ04Cg1UKbyN1CbRLIO0yjmQ95fHDTZ9hDu8jva3oir+RiTiM7oDtru/RMJnNSLzvaNM9tj4u5Z2LJOr2rKqfgE0MtnTQtpn82bKA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:49:45 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:49:45 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 8/8] regulator: sy8824x: add SY20278 support
Thread-Topic: [PATCH 8/8] regulator: sy8824x: add SY20278 support
Thread-Index: AQHVXLRg4PGZgykKs0KGwPdKu4llcA==
Date:   Tue, 27 Aug 2019 08:49:45 +0000
Message-ID: <20190827163830.2c94f29b@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::34) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1da5e0f5-faa5-4e7f-c5e7-08d72acb8286
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB42636FD0E9B4FBA450A6A17FEDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(4744005)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VMUhzFgFIwdnTrMzvzEwfgaYv0X4vBP1Vgcn9MynTmEJHFw6T5snqwb2/s0sMr3EgTXIqtK06CSHD7Q3MWR1TLTeSnk1GygPNpiuKQrwbLgLMv0MpJyhbd0SMvXjQ6XjzJoNAfu3kveNvAkVJ5D8+gZQxbAB1j2QPNB5oNXcwkYLrpnAV2gq7OBHt+pPivYw79cANfxFBVfw384FowDM88tfBRd3aCPTOkpWeCeZ28GoDSDFFkKaklJHwunTuZabSvTQAJ8dajEQRq0XEFku1XpmKBiI+/t3wACr/oQIYKdwri9Yqqj9+jYlyR56KCqScrTwGLKrii7LsBomvWtUJpElZ+HkYuRIeOFHKuBGdzieXEy1kRVgtyWPXNAgjmQqpz0UKb5un1mxpkSLx1zJU45gF2Y42LUB8LWzhvDr1ZY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <145127370B2AE446AA4E171BAC01F1E5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da5e0f5-faa5-4e7f-c5e7-08d72acb8286
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:49:45.4581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feifYkyBEuWiyOwtXK02XxgKzUC/knjg4PwgnPg+8mxy0N6he+3uf1JoecxSpJ/lFjN2dOZ/9Ux/HieGjssEXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The differences between SY8824C and SY20278 are different regs
for mode/enable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8824x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 9410c3470870..1a7fa4865491 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -180,6 +180,15 @@ static const struct sy8824_config sy20276_cfg =3D {
 	.vsel_count =3D 128,
 };
=20
+static const struct sy8824_config sy20278_cfg =3D {
+	.vol_reg =3D 0x00,
+	.mode_reg =3D 0x01,
+	.enable_reg =3D 0x01,
+	.vsel_min =3D 762500,
+	.vsel_step =3D 12500,
+	.vsel_count =3D 64,
+};
+
 static const struct of_device_id sy8824_dt_ids[] =3D {
 	{
 		.compatible =3D "silergy,sy8824c",
@@ -193,6 +202,10 @@ static const struct of_device_id sy8824_dt_ids[] =3D {
 		.compatible =3D "silergy,sy20276",
 		.data =3D &sy20276_cfg
 	},
+	{
+		.compatible =3D "silergy,sy20278",
+		.data =3D &sy20278_cfg
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sy8824_dt_ids);
--=20
2.23.0.rc1

