Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PRICE_CATALOG,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C84920873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=POLIGRAN.onmicrosoft.com header.i=@POLIGRAN.onmicrosoft.com header.b="VGP/byHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfJ3WRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:17:53 -0400
Received: from mail-bgr052100128070.outbound.protection.outlook.com ([52.100.128.70]:6318
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbfJ3WRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:17:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrgfscCbC0XH7/9furjEZy5prBFTdqD0QynsD3fyeNvwWRbp7YoqE6osQqokAxnGd06xiPm0afRAEkH5GvQ6/SSZJJzh/Qb17Yr4Z3azhqOgxn8Ef+rL1fozQson6JlBhLaNmp1X+DvZdup8j8qQd3t4Qo7xhi8HySOyjaY0HtPvoPD+0xcNTnTsQQ9iul2vCxrkNU7+ph0xRtIGNE2IVvGMo8PVKGi5je8E24afIHD5L0yaiJk0xYOQ8IXRB71Lf/7uVS2/Ezc3eEWKPViVGopgcgvoPx1MgrVfMiYTdKmqKtSvrhXssVzLffk7d1V8P3jWys6UJsmkhvgwzLFSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajbqNiUWrHn4UVc7Wow1U28fxgN776bdgvtODo9SY2w=;
 b=H2xze1OAPA2Wt7C60UyGfnADCFkUgJ3qy2RL537kaBuqN2gX4NrjQbcxfVJqld6EhLas+vepJ94uXr2xJPemuAMYTZufyTkQV6RIFuSh/OBRF3vHYlRsVVleATNs6ry/HsM5i2g3VGrodnQTNBFAJ/OazgvD+2zFfz1cKDVa+0i2e2TtzkoKx1oDI7uc4PILs7HUnQ94h7tIXV/mcSLfFtfVUx/bPIg/Fj4x7Ko2tzNyCvesZf5mIgrlNZU0kvO9k8OcfFRjNwOto6FVnxm7W82UyaM++ukpkvWuQmlbUigqhLPSdBW+z7KJhtCtmGs6JtnmFxTBAzgZz01YuVLFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=poligran.edu.co; dmarc=pass action=none
 header.from=poligran.edu.co; dkim=pass header.d=poligran.edu.co; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=POLIGRAN.onmicrosoft.com; s=selector2-POLIGRAN-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajbqNiUWrHn4UVc7Wow1U28fxgN776bdgvtODo9SY2w=;
 b=VGP/byHm96XVs7eGVc/6dY69O4USLA9em3IPzsOtMBpsi4gpVkdPXyZlH4eYI/IbSngVws3Y9vBGv5m5Cf7jQpGkOE6KoYvmzg8tdqziIoiylzZZ7kHhu9/6XcalOVStcPewmPbb+2CIc4f0D6XCJ6fBdRi9Ah5kM3wPHEUxmXE=
Received: from BN6PR03MB3107.namprd03.prod.outlook.com (10.174.234.16) by
 BN6PR03MB2835.namprd03.prod.outlook.com (10.175.126.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Wed, 30 Oct 2019 22:17:51 +0000
Received: from BN6PR03MB3107.namprd03.prod.outlook.com
 ([fe80::4b7:7cfe:3c8b:26a1]) by BN6PR03MB3107.namprd03.prod.outlook.com
 ([fe80::4b7:7cfe:3c8b:26a1%5]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 22:17:51 +0000
From:   LEONARDO CEBALLOS VALLEJO <leceballos1@poligran.edu.co>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Spec.
Thread-Topic: Spec.
Thread-Index: AQHVj2PlzL2gYn703UKz3q+yh7rr6w==
Date:   Wed, 30 Oct 2019 20:52:09 +0000
Message-ID: <BN6PR03MB31078FD9638CC54ECB774251A3600@BN6PR03MB3107.namprd03.prod.outlook.com>
Reply-To: "gleltd@hotmail.com" <gleltd@hotmail.com>
Accept-Language: es-CO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR07CA0083.eurprd07.prod.outlook.com
 (2603:10a6:207:6::17) To BN6PR03MB3107.namprd03.prod.outlook.com
 (2603:10b6:405:44::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leceballos1@poligran.edu.co; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [197.211.58.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 681a2f19-a41e-461c-e4d2-08d75d7b0840
x-ms-traffictypediagnostic: BN6PR03MB2835:
x-microsoft-antispam-prvs: <BN6PR03MB28357B91AC25D0107292C99EA3600@BN6PR03MB2835.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(86362001)(102836004)(305945005)(62860400002)(52536014)(386003)(55236004)(3480700005)(43066004)(8796002)(8676002)(2906002)(5003540100004)(66806009)(74316002)(5660300002)(6506007)(6436002)(88552002)(6916009)(7736002)(55016002)(9686003)(8936002)(66446008)(81166006)(5640700003)(81156014)(66556008)(66946007)(64756008)(33656002)(2351001)(186003)(476003)(25786009)(14444005)(486006)(6246003)(316002)(71190400001)(3846002)(71200400001)(256004)(6116002)(66476007)(478600001)(10916006)(558084003)(786003)(229853002)(7116003)(2501003)(26005)(2860700004)(99286004)(6666004)(52116002)(7696005)(14454004)(66066001);DIR:OUT;SFP:1501;SCL:1;SRVR:BN6PR03MB2835;H:BN6PR03MB3107.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: poligran.edu.co does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOp+d8JFagFFZQgDUAfjr62boWaCG2kuU/vEyicCct3WJ6BpdC6mHhe5ryhH7r8UPqXMuaXF7n3G0KWtUuzJ2DyG240kx9g7lZcCqPM9T3onRyrjFq2/FkZBILgzid21KFoP900exrZNMxElwJjTQSPEVyXt/M+Jco00+7C82DhAJNqEJeUB1LxCNOianCrzpCOImvRAHFELP28kRcN7lZaSXyGPJyV58aGr1HjwSpoiQDy7dphtPJg/mVf1D4YSbN9vvMDDE81/Elp42mlXDQfmMp6P9fmRM3a/27edCva4BXQOaW/4wir/dLcexsnRorb80+PPTRnkKsMvmqdg3IyIJLimi4UnqVCtZBWYsm12fppZD/eLD1IWEFd44NjkB2C3eXKvonAY2TOME7UlMVQATR9RJv0X5Z4/lJvwIk7Au3nQMrgxEGDHhWskAPus
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B6CBF6EE740DFD42BD1CB58253390F89@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: poligran.edu.co
X-MS-Exchange-CrossTenant-Network-Message-Id: 681a2f19-a41e-461c-e4d2-08d75d7b0840
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 20:52:09.8624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd505be5-ec69-47f5-92df-caa55febf5fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0uBhgV3mxZ+gZ2+dHIC8f1+pbszlbSZGCnmFmxknbV/3tjiihldbKhEnLhaD1WipHjrPDlB8keVTHYF/vGcePOhhIXhLKyARLbSvDsWvdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel@vger.kernel.org

My company is interested in your quality product, kindly send your company =
latest catalog/price list for urgent order.

Leonardo(Export Manager)
Pacific Packaging Industries
Block 1, Suite 101,office land
building, USA
Tel: (791) 271-7458
