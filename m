Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3883CC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024D5206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S03AhBky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAHIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:30:39 -0500
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:43782
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbgAHIai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:30:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULfymETQ6FGb0C+an5/+BJeqYLZXc1G+ASi1L1Y8VyDWeIJd7b+SRc1YQNmH9b+gt88BbEiq6MhPmaSXNr+vrA/Z6KmahBbSZdaQbLkoYj6GYF0OrPrRPClabhVowadD5bsXxIW/Z6OibqfiV1TDMsKnONaINWVkadWuOQFP2apbW8pCCLHj2wvEwc/hQItkES18C13tuEEHd/BNNOep5SsyehCuqhkm2K79L/7K6ux81sNl1dcnrnllRLvzTYAcOJx+hSpo+ojn7y1ijCxIVAoA33PsYfUy0jENsGxAu2uOzflRG6Tm/A6LrVi0udKZ8eQwf0e9M1Ow2t4DmEhbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubWuDKneieWqZqps87Cf73MhpxpseCyT4FuguI/XZuw=;
 b=RG2hVW5kOZVK86yus3kRZe3Z95ou7ARMJEJPxjV9UFFUwmmoNsa/DR631aFeFTOn9nsfcgGzRs2MwMWW6+mi4flG6tVU8o9k3ER9pc+SqryJywMC0njVfkn+ucLi4zursxW0ijBaUk56kdIsPnATbfyZqjyUuKcM+ZAe/p4O2lyeY0W4WPMJysTapCGPOLvxDNIcEJp2Q6ksqaxSS4mCEyIG4wyVTcbXRZYwtaFcJ1lDIKW4iue+uvBMacjq0tf69ri1E5g0qMBwBT2tx2/jtXGteQvMTR8b+HW9RrY/v3ALvY0BceT4BpdHhhbUVnq7uxLdua08Yud6X0lsc/n+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubWuDKneieWqZqps87Cf73MhpxpseCyT4FuguI/XZuw=;
 b=S03AhBkyR5ltWVJK986wN7oUzwD1Q9RPp9JWikEa9AJqaN/J+0MMRZlFDL1jEBzvfnNiIQphm630EhvGZcvZcoYywyutQiREWvJ0AdV7yQrTPixY8EnPt03nZd0TY2LxUDKRqdOOjO3vrFYGMn+s9aGXvswChI28/shORXdKSvg=
Received: from DB8PR04MB5786.eurprd04.prod.outlook.com (20.179.10.31) by
 DB8PR04MB6457.eurprd04.prod.outlook.com (20.179.248.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 08:30:34 +0000
Received: from DB8PR04MB5786.eurprd04.prod.outlook.com
 ([fe80::6d98:adb8:f7cc:394]) by DB8PR04MB5786.eurprd04.prod.outlook.com
 ([fe80::6d98:adb8:f7cc:394%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 08:30:34 +0000
Received: from localhost (89.37.124.34) by AM7PR04CA0022.eurprd04.prod.outlook.com (2603:10a6:20b:110::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 08:30:33 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "t-kristo@ti.com" <t-kristo@ti.com>, Peng Fan <peng.fan@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 1/4] clk: imx: gate4: Switch imx_clk_gate4_flags() to
 clk_hw based API
Thread-Topic: [PATCH V3 1/4] clk: imx: gate4: Switch imx_clk_gate4_flags() to
 clk_hw based API
Thread-Index: AQHVxccHqL7Ov6gaike6khrnD2xGWKfgcDiA
Date:   Wed, 8 Jan 2020 08:30:34 +0000
Message-ID: <20200108083031.kpcmlujhpu5fein2@fsr-ub1664-175>
References: <1578448417-17760-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1578448417-17760-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM7PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::32) To DB8PR04MB5786.eurprd04.prod.outlook.com
 (2603:10a6:10:a8::31)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d9bea7a-41cd-4159-8d91-08d794150773
x-ms-traffictypediagnostic: DB8PR04MB6457:|DB8PR04MB6457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB64570767E8DBFBA2ECC3D227F63E0@DB8PR04MB6457.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(9686003)(316002)(6636002)(2906002)(86362001)(71200400001)(33716001)(8936002)(8676002)(54906003)(7416002)(81166006)(81156014)(6496006)(52116002)(1076003)(956004)(53546011)(4326008)(5660300002)(66946007)(26005)(66476007)(6862004)(66556008)(478600001)(44832011)(66446008)(64756008)(6486002)(186003)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6457;H:DB8PR04MB5786.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MU6svVdXrTt8Tzi4m0HxoNCBk06EYYuSJDfUWy9m+BagPGrJf4kFgSY4ps75IjLUMORqmjivqIFaY+uOQ1ys9d1f0ybDBkWhwi8w2bdreIbwbW0OBmMKRLOMc/PotKpAxOknE68PfeoC9xdU6FlA7UUth/jxOSBkjy1kfRrP49MrReo6C4I+z5K6QKXgXI7RfBCCGGt39Ckm9fCy9eJP3uenlI0M1PKhcIzMhoLoNxNFd2Nm6SjakTi+czUPhvt47Hw+XIr8/CT0jDH7FkggsqdCndCUycQXtzuHkEWJRTg1n0WQS8gWYwZgpT1ceAkIYVI3LDfC+xTTq5nKVzrbolzuoeWk4qdbFOQKztRfCuBC9V5kSjJ5XGggkwE8vNRId4bbSbPUpdYZeZvepMT61BNVe+T7VcNOQKPBsJphctZGudOSv/cohhXP/XL7m5cE
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CC62D0316E4814C83B3DCB649EBF82C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9bea7a-41cd-4159-8d91-08d794150773
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 08:30:34.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2YxH4VS74IF8vvRRsEzexXJC09fS6SErYakKT/QGQE0oCTWcB8/FrR/NmkSU/NwwFex9PrRMMW687ysJMXf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-08 09:53:34, Anson Huang wrote:
> Switch the imx_clk_gate4_flags() function to clk_hw based API, rename
> accordingly and add a macro for clk based legacy. This allows us to
> move closer to a clear split between consumer and provider clk APIs.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

For the entire patchset:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
> Changes since V2:
> 	- Switch to latest i.MX clock driver base to redo the patch.
> ---
>  drivers/clk/imx/clk.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 65d80c6..b05213b 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -390,15 +390,18 @@ static inline struct clk_hw *imx_clk_hw_gate4(const=
 char *name, const char *pare
>  			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
>  }
> =20
> -static inline struct clk *imx_clk_gate4_flags(const char *name,
> +static inline struct clk_hw *imx_clk_hw_gate4_flags(const char *name,
>  		const char *parent, void __iomem *reg, u8 shift,
>  		unsigned long flags)
>  {
> -	return clk_register_gate2(NULL, name, parent,
> +	return clk_hw_register_gate2(NULL, name, parent,
>  			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>  			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
>  }
> =20
> +#define imx_clk_gate4_flags(name, parent, reg, shift, flags) \
> +	to_clk(imx_clk_hw_gate4_flags(name, parent, reg, shift, flags))
> +
>  static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iom=
em *reg,
>  			u8 shift, u8 width, const char * const *parents,
>  			int num_parents)
> --=20
> 2.7.4
>=20
