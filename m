Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC9C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F07C2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="b0iUyxFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDCKhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:37:02 -0400
Received: from mail-eopbgr1400114.outbound.protection.outlook.com ([40.107.140.114]:33632
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfDCKhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnziTkeurCieu0T4zQ8GL2S6efHkESvnj+aBcPEfkTM=;
 b=b0iUyxFN+zjt6yNHBTHhgERc2mEZhbr0yNq3m6MWpwHOEgUPhfYzisO/v1qxykeZh7DiyU+dLFiVNO/0hE5OUhIMyHqPCDb00qhtFBOHWMuIZOrNqDutq6J43BDc4OyDF05VEgA9+8DUq+FgX8kRkdMkIJM5otjw4yESbkTXx3k=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1593.jpnprd01.prod.outlook.com (52.133.163.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Wed, 3 Apr 2019 10:36:57 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::b593:2e3c:aa50:2273]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::b593:2e3c:aa50:2273%4]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 10:36:57 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 2/3] phy: renesas: rcar-gen3-usb2: Use pdev's device
 pointer on dev_vdbg()
Thread-Topic: [PATCH 2/3] phy: renesas: rcar-gen3-usb2: Use pdev's device
 pointer on dev_vdbg()
Thread-Index: AQHU6IMxuqCpHsux6Eat45uJvbsB+aYqQRLQ
Date:   Wed, 3 Apr 2019 10:36:57 +0000
Message-ID: <TY1PR01MB1770A0BBFF5253357A15AA61C0570@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1554120083-29990-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aba18cde-7475-4057-9d23-08d6b8204c53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TY1PR01MB1593;
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB1593DC1AD733A8F4FB630515C0570@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(97736004)(54906003)(476003)(106356001)(99286004)(74316002)(53936002)(44832011)(7696005)(25786009)(52536014)(2501003)(107886003)(5660300002)(55016002)(9686003)(66066001)(486006)(86362001)(4326008)(68736007)(446003)(3846002)(6116002)(186003)(6246003)(6436002)(26005)(105586002)(11346002)(110136005)(305945005)(316002)(7736002)(81166006)(256004)(8676002)(102836004)(8936002)(478600001)(6506007)(71200400001)(71190400001)(14454004)(2906002)(76176011)(33656002)(229853002)(53546011)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3uFvhxnTek+GzTPHVq6P95hBdnyecxt+5jIWRv+OK5UmWE2ZQkFzcdKCmDJLjU6tpxnp6yx7fzbWed0MHgphcC6H7aqsHU5RxLLNBZ3Fh46R9PVTPPuRD2a2/rpNycvA1+EL5Qb6rSlTnu6JTC7x/F6eQaJk78NGWJqWQaXfySOJRDOzHBVNV39bGd9Th/Eqjqc04SHscQM2BpuiB28dUqI58IRiM4b7zIvZMP/pP+5KoLc+qfNtMx69zMv+m/5sJlsLJKYDXfJ6VEvu8RBQfzdBzBNhB7vSC/j1PUX97Uj4pE841mqtMT4xM6dldiq6tIY7PoHo3S7wm2KSAf9VNpTDhrP7I+IKc2VuLUqQsXIaPaeMz9QpyfWgWtDhWMTA6ZgzF0JrJpQ+ZurJ9JUSzk55uGu6pP3fIw/bC/jveCY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba18cde-7475-4057-9d23-08d6b8204c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:36:57.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yoshihiro-san,

Thank you for your patch!

> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf Of Yoshihiro Shimoda
> Sent: 01 April 2019 13:01
> Subject: [PATCH 2/3] phy: renesas: rcar-gen3-usb2: Use pdev's device poin=
ter on dev_vdbg()
>=20
> To implement multiple phy instances in the future, this patch uses
> pdev's device pointer on dev_vdbg() instead of the phy's device
> pointer.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
> index 0a34782..4bdb2ed 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -80,6 +80,7 @@
>=20
>  struct rcar_gen3_chan {
>  	void __iomem *base;
> +	struct device *dev;	/* platform_device's device */
>  	struct extcon_dev *extcon;
>  	struct phy *phy;
>  	struct regulator *vbus;
> @@ -120,7 +121,7 @@ static void rcar_gen3_set_host_mode(struct rcar_gen3_=
chan *ch, int host)
>  	void __iomem *usb2_base =3D ch->base;
>  	u32 val =3D readl(usb2_base + USB2_COMMCTRL);
>=20
> -	dev_vdbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, val, host);
> +	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, host);
>  	if (host)
>  		val &=3D ~USB2_COMMCTRL_OTG_PERI;
>  	else
> @@ -133,7 +134,7 @@ static void rcar_gen3_set_linectrl(struct rcar_gen3_c=
han *ch, int dp, int dm)
>  	void __iomem *usb2_base =3D ch->base;
>  	u32 val =3D readl(usb2_base + USB2_LINECTRL1);
>=20
> -	dev_vdbg(&ch->phy->dev, "%s: %08x, %d, %d\n", __func__, val, dp, dm);
> +	dev_vdbg(ch->dev, "%s: %08x, %d, %d\n", __func__, val, dp, dm);
>  	val &=3D ~(USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
>  	if (dp)
>  		val |=3D USB2_LINECTRL1_DP_RPD;
> @@ -147,7 +148,7 @@ static void rcar_gen3_enable_vbus_ctrl(struct rcar_ge=
n3_chan *ch, int vbus)
>  	void __iomem *usb2_base =3D ch->base;
>  	u32 val =3D readl(usb2_base + USB2_ADPCTRL);
>=20
> -	dev_vdbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, val, vbus);
> +	dev_vdbg(ch->dev, "%s: %08x, %d\n", __func__, val, vbus);
>  	if (vbus)
>  		val |=3D USB2_ADPCTRL_DRVVBUS;
>  	else
> @@ -401,7 +402,7 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, vo=
id *_ch)
>  	irqreturn_t ret =3D IRQ_NONE;
>=20
>  	if (status & USB2_OBINT_BITS) {
> -		dev_vdbg(&ch->phy->dev, "%s: %08x\n", __func__, status);
> +		dev_vdbg(ch->dev, "%s: %08x\n", __func__, status);
>  		writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
>  		rcar_gen3_device_recognition(ch);
>  		ret =3D IRQ_HANDLED;
> @@ -499,6 +500,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_d=
evice *pdev)
>=20
>  	platform_set_drvdata(pdev, channel);
>  	phy_set_drvdata(channel->phy, channel);
> +	channel->dev =3D dev;
>=20
>  	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>  	if (IS_ERR(provider)) {
> --
> 2.7.4

