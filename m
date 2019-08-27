Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B089206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="X/3IPcia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfH0IoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:44:17 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:55424
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbfH0IoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGl3brtLrMQhi73eK1O8JTf4qJBg4NX8ioxGnMOn46OX3WUoUEcEgBQHEqhUDSozwm+cpFJg1TYvUtg1h6m9/iSufqfh9iqpddTTdrrqI8CtLJyYsULFUdyxDyi4n9OndWwasuEHpFu5/yI6tM2jaInTDYbBS9MJgTURZk+VoY++KTEihlKEEMB7TQ8fKPetg183BfTiKpkICfnb1ULl5Di5z4QUlMpcqfgWg6o8osGNVcD84U78ZViwiWhc1bBsql5tD2Zc0RSp6iyGDgvXUH2E6I8JWBVp+Z8wjURbu5Ymn18a6woatDLaSV814A0fKbvJ1rJ60VNFh6BO7Zwbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGruqD4MiFZn5TZVoL8n9jJi0jOsLBXbJ4HNmLaRXEw=;
 b=Eu2Fx1MbKMXR73g1QMIohbQp9FArNU+ehDSgW2MD0+R4sXql1rzEev0jGXXysJJsZI9XVWjoFeitvS8JTKD8fNXrf9JduiPTYPG/bzkr+D0iQpUhvpaqc2LEZAY2lX3XqL8oBanQLOiXsSJgY9dc7j2wGu1U+C9cv15YMxYVBonuDJKiVgbif3u+xKTCeOwcnBA37BZHX822ngOBUBoBOh+S2+WwNx2WCwcZ7C+Xgs/m7RbjFh6LbHmQB0zK+zd+y5Zy3I1eeTf2R7SkqBxgDau32K/VhkKZYKaUCOyrIGLbJOHQsNa5eeMni3m8vVSzNioIW+erhh0gKltlg0Brgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGruqD4MiFZn5TZVoL8n9jJi0jOsLBXbJ4HNmLaRXEw=;
 b=X/3IPciaFu3yesB5QrFT/JlADB0G5pfNdMEPa9RK6CH4+5y/yvi2/jD1jK0njPgw4AIBx8RUc+Tbdww+a9+d650mhnRms/2cKHNY3Klr8j2/6229h+eZkdxSNTZ7hAxIJWgTPk8BvPTK7BXRAZN0t48r3x+6X0aWYh5Y6xRLXto=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:44:13 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:44:13 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 0/8] regulator: support Silergy SY8824C/SY8824E etc.
Thread-Topic: [PATCH 0/8] regulator: support Silergy SY8824C/SY8824E etc.
Thread-Index: AQHVXLOaXwIuKKIVAUyLjyjf+ULZFQ==
Date:   Tue, 27 Aug 2019 08:44:13 +0000
Message-ID: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:2::15) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d112c37d-7bc7-4da6-2875-08d72acabc9a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB4263FF9C1826FBA18D9F7FAEEDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(4744005)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MLKrsnI9hlHHTkGWjVQM15dSNFw0hKBlf0Tl8MAeq0HXiHBxCMIukx5/jlZDnK58yWiN81ejb4DVnABSJUjFfO3sPNbCd1GjWLG82WlBW4ut4il9+zTrn74cc3Uy1j4AE8EoCRhaNrQWMZ7JnBU4vUsKX5KCbqwF/Ne0RGEGyF1GgXLTI0StNd2NdZZ7wCUlwi2sfVONOz6kojC2g3UGY9HlMbR+UTbtk3/0XBgrY1QXmrODMNd4637L/0ciE68wPB0Sx+oMCyi+X8/Bj5PeHxcwdTsxRI3eyoX1s7fv2Q1cwNPb1NA3lxnClc4n4LeI45tO5IArjF/EMz6AJC3Y+j/LMqrgcArWXQa/kTAwC0XNFC34HDcMqJXYd5rEl4s9OJBeedLNpWSlA5BQOwADZnPqh5PrDaiRKFHBmU5Wtb8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E388B72B7E360E4DB68B1B5C65106AF7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d112c37d-7bc7-4da6-2875-08d72acabc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:44:13.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYhu0b8UBWBjAUi1m0emXDR0I9JIRnmLIF8gkqihEmIGztIYykMsXFwTJNMQ1YKIhYFvyHmlkHCBV5JHIAtQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Silergy SY8824C/SY8824E/SY20276/SY20278 regulator.

Jisheng Zhang (8):
  regulator: add binding for the SY8824C voltage regulator
  regulator: add support for SY8824C regulator
  dt-bindings: sy8824x: Document SY8824E support
  regulator: sy8824x: add SY8824E support
  dt-bindings: sy8824x: Document SY20276 support
  regulator: sy8824x: add SY20276 support
  dt-bindings: sy8824x: Document SY20278 support
  regulator: sy8824x: add SY20278 support

 .../devicetree/bindings/regulator/sy8824x.txt |  24 ++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/sy8824x.c                   | 231 ++++++++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt
 create mode 100644 drivers/regulator/sy8824x.c

--=20
2.23.0.rc1

