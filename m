Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4908C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C47520731
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISqHh8hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKUM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:58:41 -0500
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:9535
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfKUM6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 07:58:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHktlwDiKrLx/R4Ac6SBRMG2OwGyo5XM81WQITECoI9TWowEBWMc3F1dc/2GvOkxMALlOI5KvxIES4DWK2Df/rXjGk0+FRuAfaodzjvQfeFTBsgoAcimQoTRuu5g8WIsfRvfAFuJK1m+ciVHPT/ABx6TMJCUzox2KOAxc0TFULA4aSIh62qODdWQjAetpnBNXaMzIpIx616HRDnR77FjT3t6CmdqOKBt4926JWZOJHiFpykER7LilPnMPZcrhm75fcLmGI5cQrBj6PFYxJH9Uw4CrSc97w5FmstD+jR10qB6fuhHz06O6ZKT/bYPQH3qUznlWb8GZxsvdmRuVusXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClcAYLd4GgSuYVnliFsPHtJ3vEZCqcPMxy6yQxfvJQo=;
 b=UezZzjkiKck+6q9owVcQX2+HJBgtUiu5paK2vQHbq9p3L2PWIfewntHdDvio/yWHZfJ4pWbasaqgvD0UgS8VrK+9j22U+hql+fAhUuu4Gf8ECy12a0UWMPjdlRmICWAYZdNXmK5e8A3qGnaodLPLHQD/YhxL5DDqFIyMbkIwxYnZIX/XfUoI6zOT5RCcSB4bMIUxLgHKKzhFAlcE4FdPltiaako+NQLUxo0PpJkX+qaBTFfnDaH7Kj7fansJyxRSTNJ/iSNyY6veUDqPbfOWT2MGyLQBpVkIYyLCkkmNRXuNZmtvppVvAZexG5+/WtK4PV7NtHFbGJ3/jQ/jPw6MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClcAYLd4GgSuYVnliFsPHtJ3vEZCqcPMxy6yQxfvJQo=;
 b=ISqHh8hrHifC97V9Nr9Ykz98IsMm2XFyQA5akJfvdei9WgCjpqOSDBHWHmhzzgLLG5d6SF0h77Ve+CfAZ3IqW6cyZp5BEEFB4mZxflw2Q8WpBxlmhWq7++MvxMD6orqGdh+7x883iOk9OiwBckqVYKpO+dHu1tVu+ULhAZYQjVA=
Received: from DB6PR0402MB2789.eurprd04.prod.outlook.com (10.172.245.7) by
 DB6PR0402MB2806.eurprd04.prod.outlook.com (10.172.246.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 21 Nov 2019 12:58:38 +0000
Received: from DB6PR0402MB2789.eurprd04.prod.outlook.com
 ([fe80::d74:de31:c437:de23]) by DB6PR0402MB2789.eurprd04.prod.outlook.com
 ([fe80::d74:de31:c437:de23%8]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 12:58:38 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
Thread-Topic: [PATCH 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
Thread-Index: AQHVlLo+tMQz8IpuI0agMYPX0++eD6eVrMrw
Date:   Thu, 21 Nov 2019 12:58:38 +0000
Message-ID: <DB6PR0402MB27897CF7F5755E98340721FDE04E0@DB6PR0402MB2789.eurprd04.prod.outlook.com>
References: <1573055536-21786-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1573055536-21786-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77cfc662-0f40-4c73-ae27-08d76e8286e2
x-ms-traffictypediagnostic: DB6PR0402MB2806:|DB6PR0402MB2806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2806FEAC5BB490ACEA6AF829E04E0@DB6PR0402MB2806.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(86362001)(66476007)(74316002)(66446008)(66946007)(7736002)(55016002)(76116006)(9686003)(3846002)(11346002)(26005)(8936002)(5660300002)(2906002)(110136005)(316002)(2501003)(54906003)(4326008)(6246003)(99286004)(229853002)(6116002)(66556008)(25786009)(305945005)(64756008)(7696005)(14454004)(4744005)(33656002)(6436002)(8676002)(186003)(81156014)(478600001)(81166006)(6506007)(102836004)(52536014)(71190400001)(76176011)(44832011)(256004)(446003)(66066001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2806;H:DB6PR0402MB2789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qbo908xevVupBNL8jkDLDzXatZ2yxyJ5hUpmL+oZfJwk17v694h6Jn1Q3ltZZOzqRLzX6M5MA5RG6X8dKzYatdJSIL55h/Q1Z2fg28YE1dEL5VMo+W78Gi3DbRTMfyT1RHS3tsnW8B5665yR6LvM0cOvFjuDyDjo6fxm09MkGMcMltLPp+Wd7pbTCUPdpp5CzWUpnKIBdXkggkK4DUAoTKRNUNTBkJCu8QIy8GEvU9llnFJ7DJcNmJPCSc8AuS+6gadVjA/jB+2RVRrLiJixRbfxFkfVDJ4/6GHjDC8fXv8gZwSLo0+jFHrwTRxaLKAAFDC01M8FB171yp2m3YM/vvJFKvzHGLuJZmj7L5ZuItWonbqGojtSye+0nPHR8ENxwe6J7pvpLERfuX5jNzDVEB3p+WErrPtlWP+GEpYhIM0z/cXy00ZO4qaobaHO0O9J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cfc662-0f40-4c73-ae27-08d76e8286e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 12:58:38.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nm7cawzk7lmtvP+asIuAxBo1u37ajtiLiTvCMmfjIZtuc2gfdH7GRRpo1Kmm7t+YhsZjILwI5ZNq87RCJ3Ks2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH 0/2] arm64: dts: lx2160a: add EMDIO1 and phy nodes
>=20
> This patch set adds the External MDIO1 node and the two RGMII PHYs
> connected to it.
>=20
> Ioana Ciornei (2):
>   arm64: dts: lx2160a: add emdio1 node
>   arm64: dts: lx2160a: add RGMII phy nodes
>=20
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 27
> +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 11 +++++++++
>  2 files changed, 38 insertions(+)
>=20

Hi Shawn,

Could you please take a look at this patch set?

Thanks,
Ioana


