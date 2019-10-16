Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24735ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D6920873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="YW9IkZL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbfJPCfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:35:11 -0400
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:12964
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfJPCfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQI5yYhszlcmlDg93B90tVeaO+7jx1rrXBV8uSAJOUvvwAEy/VWerEm1bqAEOk+mNioq4EWioYcPf/hSYZJamVkMto26Oo1S4wn3t39Ds7i/Dp4vwY6Nmn1onAadImd/H15skTNdcUJl2B684ZbneNW5zKZ1MZdFTK1SMoDhTliTv5lSGPdUoDU1oXpVyHrRzwaIDcna6Z381aF+V9e9Cm/OGsrs1pGj3/rMXXpFnEwNitaPB5TgWIM/siyLjmdDhD4lQDAkygvshtTatUogi5/w9pdxMs8Ndo8V7BxbGKqBOU7FvmqW8QEbZ/lBDLP7W1JjYxrljqp3ULiNbI53cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MroEzpFdYCMCf9UL8u6bwCJJrVU9qOKA9jJVIZRDQV4=;
 b=Vc7DAA+cP7J1P2xNDzWm4YTNpiKLiFEbxMGjqBcVg3y2dL5bCTwScWwdPJKN/hwD2/gv9nRVML1JrBdjHEkwETrWoo8A1WUdocMlLR43JGpvCzrtRBKKz3PYZmUljxwQUHPx+jpzc+t8qRa1Ip0urDQvDUd3ALB6TIyuTcDUhATIPiw6L9aWSet6EWU3Rl/APxMvzUvzkBXZRvDm5vOdBTj24lE80xJPgM0IDkGqm4lF6ZMNPwBqfUvBa8r2Cdpsex5SeFaXFGhcM49fc8uhQGZXmNWcKBEEtT8YRYe1YT5wm3uSHrA47B8boPMJitWqIW+OyLn9fQVmd5buHZnC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MroEzpFdYCMCf9UL8u6bwCJJrVU9qOKA9jJVIZRDQV4=;
 b=YW9IkZL5AL9oZWK3RbIdoTsWbGWpOUirFjQsCluuMNekTKlwlXCPVRRedmsXn05m8/KoSl/eiVnRtS1KETdHsmbxexs+lW6+9uhAvuk16MS4lRP2aVvihdfuUrcfjdyV8ZE8nBFPk4ABp4ht4cDXG3+z0ervw5wD2nrzWfSxgsI=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2767.jpnprd01.prod.outlook.com (20.177.102.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 02:35:07 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 02:35:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: fix __le16 warnings
Thread-Topic: [PATCH] usb: renesas_usbhs: fix __le16 warnings
Thread-Index: AQHVg3BX7WaejZzh5Uuo1PfP1tSBgKdcjXRg
Date:   Wed, 16 Oct 2019 02:35:07 +0000
Message-ID: <TYAPR01MB4544032F002C7B28E2ED5A19D8920@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191015155044.11858-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191015155044.11858-1-ben.dooks@codethink.co.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b6baa9f-f557-426b-86c4-08d751e17598
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2767:
x-microsoft-antispam-prvs: <TYAPR01MB27674B35CA66AE205DEE9BD6D8920@TYAPR01MB2767.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:190;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(66476007)(66446008)(66556008)(11346002)(6246003)(2906002)(305945005)(4326008)(74316002)(6116002)(3846002)(476003)(486006)(256004)(6436002)(229853002)(14444005)(7736002)(446003)(9686003)(55016002)(64756008)(66946007)(8676002)(81156014)(81166006)(8936002)(2501003)(316002)(478600001)(26005)(186003)(99286004)(14454004)(86362001)(25786009)(6506007)(66066001)(76116006)(102836004)(7696005)(52536014)(76176011)(54906003)(71190400001)(33656002)(110136005)(71200400001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2767;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9J8UyA0/LzPBatADigsA/+jw81NOIiOusDkwnSOD1sfwsttXgdao0VB0fXadx6hVX8JIo/ol5Ho726ecq2cM4ClBpcvkt8P4lBHoydZ1idc3QBmc/lJSPgX0Uc0Lb56hx9qtmsUaHF0ZxAr8zhLlFDmMyD/0Q/lq8cymvybErFeI8nd+SCSrmB1Wcxcq16ijmA3jsNZutv+hze/fIhtzCG/x4HOOZC6peH5rRxQJJTE0rNVb1PAiJ8vtt6hs2onP1lqhn363B+5YhY8qwtmq9mKYhJQWuOnV9kCuWDWlrUnTAAShAIIuB3gRDWJT3Yj31hMzLaObmBpNXbPOwiA1sfw1jXzyb8eGEE92jUZCgKSgJqw/TWbQ4BtzPo+0RA6OIhucHw6rRZL0mSki44Wbirh3EwqQbGq80n6m0cAwISk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6baa9f-f557-426b-86c4-08d751e17598
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 02:35:07.5977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IzPw/gTRXSYVMH1zh+wy2JM/ofVCRDwIYOXeiJhCkVfdCmyRv7sB6OFuThgOPU5JIubcTiPfitVTm/IULwglS6WW4jbEUnhrcjsc5t5vl5c7XNhScyf96nytGn/lfOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> From: Ben Dooks (Codethink), Sent: Wednesday, October 16, 2019 12:51 AM
>=20
> Fix the warnings generated by casting to/from __le16 without
> using the correct functions.
>=20
> Fixes the following sparse warnings:
>=20
> drivers/usb/renesas_usbhs/common.c:165:25: warning: incorrect type in ass=
ignment (different base types)
> drivers/usb/renesas_usbhs/common.c:165:25:    expected restricted __le16 =
[usertype] wValue
> drivers/usb/renesas_usbhs/common.c:165:25:    got unsigned short
> drivers/usb/renesas_usbhs/common.c:166:25: warning: incorrect type in ass=
ignment (different base types)
> drivers/usb/renesas_usbhs/common.c:166:25:    expected restricted __le16 =
[usertype] wIndex
> drivers/usb/renesas_usbhs/common.c:166:25:    got unsigned short
> drivers/usb/renesas_usbhs/common.c:167:25: warning: incorrect type in ass=
ignment (different base types)
> drivers/usb/renesas_usbhs/common.c:167:25:    expected restricted __le16 =
[usertype] wLength
> drivers/usb/renesas_usbhs/common.c:167:25:    got unsigned short
> drivers/usb/renesas_usbhs/common.c:173:39: warning: incorrect type in arg=
ument 3 (different base types)
> drivers/usb/renesas_usbhs/common.c:173:39:    expected unsigned short [us=
ertype] data
> drivers/usb/renesas_usbhs/common.c:173:39:    got restricted __le16 [user=
type] wValue
> drivers/usb/renesas_usbhs/common.c:174:39: warning: incorrect type in arg=
ument 3 (different base types)
> drivers/usb/renesas_usbhs/common.c:174:39:    expected unsigned short [us=
ertype] data
> drivers/usb/renesas_usbhs/common.c:174:39:    got restricted __le16 [user=
type] wIndex
> drivers/usb/renesas_usbhs/common.c:175:39: warning: incorrect type in arg=
ument 3 (different base types)
> drivers/usb/renesas_usbhs/common.c:175:39:    expected unsigned short [us=
ertype] data
>=20
> Note. I belive this to be correct, and should be a no-op on arm.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

