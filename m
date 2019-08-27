Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957FDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2C02186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="QiWhnLAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfH0IsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:48:07 -0400
Received: from mail-eopbgr680051.outbound.protection.outlook.com ([40.107.68.51]:62004
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfH0IsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:48:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQUTEIrM/IKaaEtcTJPqJ//T9OycQJXF+e6kiq78PqpakkXokPyEKY6x7vcwZVwSkjohfklTBrBRivoIumtJmXhayqF1cmnuhrbTMcxRds9D0YYxp2x7A7HGVaVrMb9zjEjKsOtdraKUOOyauaUYPwBaH3PTnKo4ZYTPRbCjvAlAAQ3s8TXLFTgNrg1kx3o8JUVK+3QVdCDI6CSpJAqrl12Y2vLO3gS711zaXlbLNgVYxQMCKq5ZWRdDYswlduv8+u4rM/D1j8X4fAJQ/uoVFM02szSkO8tHx7Ar4qPetg1KvkNCoXqtfuegYKFJpAqYpZRQPl7sp0pi+4nB2uwcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGpE63J3u/bXrLMI4LFs5+4k3hv9G4uzthqViaUDK8Y=;
 b=Ah/LrdwnJRhoXWj4K9kUh47exsnnVbKuWgqlDbeWBFLNyh5QL7xY3sNhA2cC/8arfmBwtjFzUPcuHHihbWlu4yhwdd3JTfevL6t2Z5bJG1RxP9dP7yg27NAuVnUnBQ2CN7U+Q2+pfaF8+ZHtszTVpwVY4TA/byN4e/dsoPIf8WmIYRfN6/WfuwsNhAjynyv/Uw45kF7F8NdKnagV5Iq1G0t9jAoaXN+BLoBxGpJl9P5MXjfbBfBIJvuWEaZI17IqyGX6KRbfc9/fRtMeHyPczw5oFIvBHnrcpO8NNm0h5r481fx753MAFlAJQDuq9dYbDr2IaQZzus+QF7NsaHlwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGpE63J3u/bXrLMI4LFs5+4k3hv9G4uzthqViaUDK8Y=;
 b=QiWhnLAoJ4Tu6Eu59c7+xJ6HhRinUcHFA5VHz4SON/j09ajN9Lv60ZtK9ldxBDk2rOT2F5rJpmZh6otBo3kFcMrzhJ3Yw92UhC8zx9oBLNHx86bm5SEgfp3gOWurWsuKTmh8YBlAknzFoBYac/aiANm749qfGE3ZwiqmrNVejFQ=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:48:04 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:48:04 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 5/8] dt-bindings: sy8824x: Document SY20276 support
Thread-Topic: [PATCH 5/8] dt-bindings: sy8824x: Document SY20276 support
Thread-Index: AQHVXLQkGAbmVSmzq0yO0C6b3GKjFA==
Date:   Tue, 27 Aug 2019 08:48:04 +0000
Message-ID: <20190827163650.47ed1213@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:404::17)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cf48c23-9084-4d61-2a00-08d72acb4661
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB42635F9D4D00D7F95B69BECFEDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(14444005)(4744005)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZsdXPY1ZXCpH/3S2SwIv7NSBDkiptKCiTqDzLxDl1a/0jmIXCUGlhxPxW9MOQ25iySwf/bRs78mXb12kddOIX65MmoY8gRHRqo+5y+Io0mkEMx24xq/jt+YWM2flSL+Fxgu92JsbTmuNtB/sv2Ok+EKyQizsyu/nX7olCqtCVqu+4xs+6L/d1igzMYHRB0TXGBAOV9k/qCZ+EkibdGFtb5R02MdaWyQgpUUCRqKY3eQnu6YI0tTQXLGPj0zTn/RI7jKaNl/XiYXFxSDIcKvgd7WuqHD7K+Yv0oNxcala58d9RwHpEdxn5Zx8/0iVSastWosDNEIl5ozqrmysRXt4g27URR1Yl7YsKvmqZ5Vbt+8GAKXS12MR4oY+STTklZj1OOiePL7xrS3ja63gWYXNNkul0wtRgCaSnxvMCXKFke4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D4BC65675A5164DBFCEBDAFA12051F4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf48c23-9084-4d61-2a00-08d72acb4661
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:48:04.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwFFK/O/Q7CZ3VLOArmO8ojwLiDw4kfIo/ZQisFcucWlQISkQhlx3I6Im4yAX2eHf9Kmnl/ANDZgVjQ3BKJn+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY20276 is an I2C-controlled adjustable voltage regulator made by
Silergy Corp. The differences between SY8824C and SY20276 are
different vsel_min, vsel_step, vsel_count and regs for mode/enable.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/regulator/sy8824x.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Docu=
mentation/devicetree/bindings/regulator/sy8824x.txt
index 31fefa3baa71..28600541b5de 100644
--- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
+++ b/Documentation/devicetree/bindings/regulator/sy8824x.txt
@@ -1,9 +1,10 @@
-SY8824C/SY8824E Voltage regulator
+SY8824C/SY8824E/SY20276 Voltage regulator
=20
 Required properties:
 - compatible: Must be one of the following.
 	"silergy,sy8824c"
 	"silergy,sy8824e"
+	"silergy,sy20276"
 - reg: I2C slave address
=20
 Any property defined as part of the core regulator binding, defined in
--=20
2.23.0.rc1

