Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353EBECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02522086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="aq3EATsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfJPCd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:33:57 -0400
Received: from mail-eopbgr1400124.outbound.protection.outlook.com ([40.107.140.124]:15136
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfJPCd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:33:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO1xb7HyXvrrkzixxOjR8JARmBSwufa6B8GIoxNEjyNO705Yd20k1ph7oRHi+uJGDWNIYpRV1uAKvNFi3Ofhjdg/6ru7qWvCmsK73XZskJc1Act884vrQ0/oRbM5DX+3zvL+BqNMkDAeA04Lcs2UFbjiPgJcVqu8XblgwjzNeEW/fw4iuKWMGGhlrM8zNQhB74O1vRS8Pb/2UVn9V0mLef5rVtdDxsWkk2MLMyr3huyXMwKob1wdwImRs/v5UWfUIXfa4Iq66KY9i2bf3T2IGjpBoGAhBZM8SUFgfBy3duc6qtBWLZYzriaJe86GhxO1zQG4uuECtp7E2XqSEChIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9/03ZeJdh9GusIEpK34xfWt4qWrz9b6FXLgQoiCVto=;
 b=Lj47T7oa1j0x2zEDynizJ/o4fZu2mv1E6ldIwahEjSqmGMbVL6as0Z1BSOG4OyGia0mIHjgtmG9jLkd2FzKYF2hOSVLdQW6UqCGivPXw1EsZ0zlCRx7Tn0vBQMtRToTajHd+30XaWguFg6h1uj5ZthNkor+SQHSxUecbDB1CUF33eDMQ2IBZWCIr3RJd0+YyXsNS0hm88gynQpuKURNCgT7CJlE0CvZY2sXD0HPelg9jKODEcQEY9yIND+EV8wvgK/bTOgmQMCtQSSPWgYHLrMWGwWOqS0mLBMQ960APGtJhOjuypdNOqbq/OwUali0+y6+oKIloeB8yxWVyE6xVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9/03ZeJdh9GusIEpK34xfWt4qWrz9b6FXLgQoiCVto=;
 b=aq3EATsHjzHZ80d3Y4S+06xRXXYaaizABkhd/G/BkVPUxR3+EwZxfy4ysWAAg6eXE5WFInwbQm3fp51I4UfbhgLtFUx75YalYGmR9YbBETZ3W34KHEuhFrJdzhXsICHkpoBdkH4uW/WjcJtUtZKNVCUcbVipYvgSJDog980gAeY=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2767.jpnprd01.prod.outlook.com (20.177.102.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 02:33:53 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 02:33:53 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: fix type of buf
Thread-Topic: [PATCH] usb: renesas_usbhs: fix type of buf
Thread-Index: AQHVg215oHe6LRh5mk6lGIz3ahK8IKdcjOdg
Date:   Wed, 16 Oct 2019 02:33:52 +0000
Message-ID: <TYAPR01MB45444200737D0CAB2DC7873FD8920@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20191015153017.10858-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20191015153017.10858-1-ben.dooks@codethink.co.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0951df9d-162d-4a0a-2326-08d751e14915
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB2767:
x-microsoft-antispam-prvs: <TYAPR01MB2767FAF6A57EE928C57E8A06D8920@TYAPR01MB2767.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:157;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(66476007)(66446008)(66556008)(11346002)(6246003)(2906002)(305945005)(4326008)(74316002)(6116002)(3846002)(476003)(486006)(256004)(6436002)(229853002)(14444005)(7736002)(446003)(9686003)(55016002)(64756008)(66946007)(8676002)(81156014)(81166006)(8936002)(2501003)(316002)(478600001)(26005)(186003)(99286004)(14454004)(86362001)(25786009)(6506007)(66066001)(76116006)(102836004)(7696005)(52536014)(76176011)(54906003)(71190400001)(4744005)(33656002)(110136005)(71200400001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2767;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6Za6TDQH6IZoFam+y9g6qKd77sC/YfX85kuV6+wd0/EsW6SNBTAmrd4EXnkiwmNXM1uQ58awMFkTbBMBk8ldgGekf9CkaVJzu7DaSL2DC3lxiRNP3BcxfYtjQ+MP/My+8jgkSoBe7YIbmlmG+6Xq/X0TKcPSL62t2v12DpCGgz3e3hmUE5FwGQYLSP7j5n+IzuVrp3cxv4ETK9J+wvqpE90WcXiutEH1vQ3rsNLwqgfvS41+rvt+qxzNPEupQ3T07hYriK8f23MKRhkeH9Fhyu/cHWN7VETwsk1dy1XhGuCCd9FLZvyGe8RwX1X2VSqxRTIadaYZfNF3/BHnnrxxgZ7uXSlynmwIeaqxvsHh+0UmAaMO7zn/YAyWo4JshXWxhHsXUYzzje15/+g8LmABjZWpcSg85xt9hgoLkAtaC0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0951df9d-162d-4a0a-2326-08d751e14915
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 02:33:52.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ba/IjsqsBS/C1sOLpKa5gys7YKNoGEeYUjIINWVX09VYiUuDwE1cvDbXSJY3m2PuF/vezJhsTZwd4djruHlfDarxu6nmnrt0/9gNAB6eHJz8zr2MoD6Ne4JCiImnGnuH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> From: Ben Dooks (Codethink), Sent: Wednesday, October 16, 2019 12:30 AM
>=20
> Fix the type of buf in __usbhsg_recip_send_status to
> be __le16 to avoid the following sparse warning:
>=20
> drivers/usb/renesas_usbhs/mod_gadget.c:335:14: warning: incorrect type in=
 assignment (different base types)
> drivers/usb/renesas_usbhs/mod_gadget.c:335:14:    expected unsigned short
> drivers/usb/renesas_usbhs/mod_gadget.c:335:14:    got restricted __le16 [=
usertype]
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I also found a parse warning in the usbhsg_recip_handler_std_set_device().
So, I'll make a patch to fix the warning.

Best regards,
Yoshihiro Shimoda

