Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746DC20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e2dfL6iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKVH5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:57:00 -0500
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:61262
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfKVH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:57:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFtNn3CdKNluBlyS3DdJFrDC0+ZgA2oGLrQt9ti+K/Xb/FHYFAzNVqgrGvn4oI/Ci+6g5vVF0I+F77RplwlF3Xvc4rT7N/Z+z7FquaEGv1t1gNVIg6rb9eavdqqPHoODrF6GHqbSFAAc55YM0kgzazdss/ppEa9H5okgyC8oQ1iLPcXGoc2H9eBg2gVtb8g4rtF8+1WJlC0YsrZhaRCwn9kYgRcSWSoGOOEQsLHt/u3dVJk37DI+N2pDGhj4SJW5NkuXxu2WHqF1RfpkXGM/rJidutwQHCm5WB4A1vb6fPsGMECIuyMsBcQ9rFKVJcUPfqTnddLv19177NOmzE34Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzi+V84V86ZKbhw7QU9ksxpenLpTZvyv6Ll5XQlrEuA=;
 b=D+kDOZJnciUr23iDwNMwQXmWx402ZEQMrfznS3NF2KOYam7eLGUCo+440Y1L6c0Q3po+dKaGXizjEAGoys22KXzry1Ltty3BKk43fV/LQUuuqnecRMQ3i2Xy0txiPqp4bl+H5HbiwILVik6IStfDtvjXaG3SdornyynkGirI95rJzL/yosUSeRCFyCp8AuaW1E2M6oChpgz09+o2gXwgJ+DEoJkWXzbqjgIuoOzBCN49TXEt389msGGqzZosJ2mYdWmfJhBe20jQHsQ8j2orlyySKMyzSb09K8fz66sjZLZ6cUtzkoNCsDrIa8Mbcypryb5zFANUsW+6C8/eAFN3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzi+V84V86ZKbhw7QU9ksxpenLpTZvyv6Ll5XQlrEuA=;
 b=e2dfL6iLaub887SrYZRS/s9IoAWrbcuxkdQZs4uGWzrd7V9KInWC3zPtuxWF9RMkgmb058DVFCqNHN+Oneem3zcUnynNkL8yThaWvqNHmmh17GcT4MpxaU12l4BmnO/eKt5zyzyoFoCkfCW6tW9H+XtO2NninWR0N18474TPfz8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5937.eurprd04.prod.outlook.com (20.178.114.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Fri, 22 Nov 2019 07:56:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 07:56:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/9] clk: imx: Trivial cleanups for clk_hw based API
Thread-Topic: [PATCH 0/9] clk: imx: Trivial cleanups for clk_hw based API
Thread-Index: AQHVnuLWT6CchFdcV0y5WK5bSM6NyqeW1t9Q
Date:   Fri, 22 Nov 2019 07:56:52 +0000
Message-ID: <AM0PR04MB4481B956515863CC096852B888490@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ca59c18-3495-40a1-1061-08d76f2189be
x-ms-traffictypediagnostic: AM0PR04MB5937:|AM0PR04MB5937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB593722CB849613A319CC475888490@AM0PR04MB5937.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(3846002)(71200400001)(316002)(54906003)(110136005)(99286004)(256004)(305945005)(86362001)(74316002)(7736002)(55016002)(8936002)(9686003)(6436002)(6636002)(229853002)(71190400001)(6506007)(33656002)(7696005)(186003)(5660300002)(76116006)(44832011)(66476007)(64756008)(25786009)(66446008)(102836004)(66556008)(14454004)(66946007)(52536014)(478600001)(6246003)(446003)(11346002)(2906002)(6116002)(4326008)(81156014)(8676002)(76176011)(26005)(66066001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5937;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kXmfkc6z+G+BzjYbA11X5HKYI8c2iwSi3BRfhlDMZ59T8C0aHXm41Isk2L6vmatYwVbrjDmAl9R7nDSKTkrjENMhvdybA+Sq+op5cRpuj6kEmuB3Ow1YkoHutGAy+F9Ezzi9nLID5KCt34MSWJn93/KqcXwWVDW9hbqaeF6BQHQohudkpIMB5kpHx4u9qhra451vf92OASiTHtdQGiWIFpDkbtil7eQW1g80gejf68oKU3GrQuv4JsR43bCbuQMyoDe9+A2lWZbL+CVpJMDTDzdO49Hs7ZPw2VSZiByyrUIwGY9c72uZ+cuos7iTA5SBCvj9iZ9FPo1Rr7wZjPPSNFBGq5OcS4de18T9SWhyJRDQc3uzcz+xsnTu1ssYNfLxOCIyzUY699krFRIUu2C3vyMr3X8xU3hwTE/TqthoiqNbBLd9pHDtUKP6vv6Ls3FV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca59c18-3495-40a1-1061-08d76f2189be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 07:56:53.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caqGq/Gj7FoH1cKKfowZRu/eITf3d2bVfLPFvtg4cgMo5keXc6ZtvBHOlYbEALcA4O8KTOXHoBwC2YnOc2eMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/9] clk: imx: Trivial cleanups for clk_hw based API
>=20
> These changes are cleanups for the clk_hw based API i.MX clock drivers
> switch longterm effort. As mentioned in the commit messages, the end goal
> here is to have all the i.MX drivers use clk_hw based API only.
>=20
> I've put these all in a single patchset since they do not impact in any w=
ay the
> expected behavior of the drivers and they are quite obvious trivial ones.
> More patches to follow for the older i.MX platforms but those might not b=
e as
> harmless (and trivial) as these ones.

For the patchset,

Reviewed-by: Peng Fan <peng.fan@nxp.com>

>=20
> Abel Vesa (9):
>   clk: imx: Replace all the clk based helpers with macros
>   clk: imx: pllv1: Switch to clk_hw based API
>   clk: imx: pllv2: Switch to clk_hw based API
>   clk: imx: imx7ulp composite: Rename to show is clk_hw based
>   clk: imx: Rename sccg and frac pll register to suggest clk_hw
>   clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
>   clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
>   clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
>   clk: imx7up: Rename the clks to hws
>=20
>  drivers/clk/imx/clk-composite-7ulp.c |   2 +-
>  drivers/clk/imx/clk-divider-gate.c   |   2 +-
>  drivers/clk/imx/clk-frac-pll.c       |   7 +-
>  drivers/clk/imx/clk-imx7ulp.c        | 182
> +++++++++++++++++------------------
>  drivers/clk/imx/clk-pfdv2.c          |   2 +-
>  drivers/clk/imx/clk-pllv1.c          |  14 ++-
>  drivers/clk/imx/clk-pllv2.c          |  14 ++-
>  drivers/clk/imx/clk-pllv4.c          |   2 +-
>  drivers/clk/imx/clk-sccg-pll.c       |   4 +-
>  drivers/clk/imx/clk.h                |  69 +++++++------
>  10 files changed, 153 insertions(+), 145 deletions(-)
>=20
> --
> 2.7.4

