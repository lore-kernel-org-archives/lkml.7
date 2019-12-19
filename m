Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093DFC2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98A2227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JMoTnPc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLSG6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:58:12 -0500
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:39014
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726882AbfLSG6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fveJ7MHx9iAeNat5J7doDg/QOm85UVtvnHhgTe9k0JmPlkza8CxfLdRGUtQ306W0bhqG+zmRiEy7tNOkMLwEvwM6wSGN7G1utr0irsZi+l3OKsMBIZF0IzbWthnuSGIHXLwHCi4OS1qgMWA/xwFSkHgT1o8Y02gLDv6GwUjDXa0/W/CE92wxOxV+TkHYTNTgUZo04/dNQfNCjHQBRhwpsj61VLErKlz8eofnuGjsABfcWidXPaWIEBTeEX7eiRIhXHXHsCFGvNv7FiiCZiRob+9XVbb4YDJ/NeQG26DwBl7/B65r++xW7bffpDx7s/QRv1uP2CsAS9dFpsmytoEaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osTIJzd5BdDhsoxmnt7CRuFq/aUPhgoanv00jxTz2G0=;
 b=nJ9i7qHIbh4iYVrT3zZYxK2rgniA7Xhv2ZkTDqkIaYplySYJc/KKwB+adHwogIu7KFbLwDXRGvKbXbAexHaXeRh+QcWy7Ajza/0q/o3RALcSSzwSDLmUH6NxOpLi1rHyruBZdtYBR3/N8BPpItqJ2wyRuBPf2BLB6u+3gWV/S5Rx9DUT47BokFgX/1seN+u561gnpAPa408HkSGUY87/KQ8rlbD9Zoj4AQDqnnsdq4HiOpJ91Ft+AVY6kYhx2Om8Yj+5EWvkoTkmIY7Lfd5IY58cnljGu/4GrZKti1F0eC77GnHrcppQFcZ7J4eBlnX18S6Xi82RW/hJkMVsM3CdIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osTIJzd5BdDhsoxmnt7CRuFq/aUPhgoanv00jxTz2G0=;
 b=JMoTnPc9Xdl5LAX9lWxTJFT5Tfu6+swdajJ1qi6mxAGGLcXHa+SwCCeN169u8WzlYw4I0exzKiR+cxwHfd6E+urCYJJhcMBKW8QS4XwmvprsqWd5fd0BhlhNCWNitJUj3Ux0pAMgpjx/iwge8+fvOMN3nO6Tpn6nhUsjNVQFVyM=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4589.eurprd04.prod.outlook.com (20.177.55.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 06:58:03 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 06:58:03 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA
 Tegra support
Thread-Topic: [PATCH v1 1/4] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA
 Tegra support
Thread-Index: AQHVtcwUkMMUkU3UcUKBBXgSTVt7iafBB7QA
Date:   Thu, 19 Dec 2019 06:58:03 +0000
Message-ID: <20191219065800.GB19921@b29397-desktop>
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-2-digetx@gmail.com>
In-Reply-To: <20191218175313.16235-2-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3630267c-720e-4ffa-bf5f-08d78450cad7
x-ms-traffictypediagnostic: VI1PR04MB4589:
x-microsoft-antispam-prvs: <VI1PR04MB458966E1219BE7D35288D4018B520@VI1PR04MB4589.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(26005)(8936002)(81166006)(81156014)(186003)(53546011)(33716001)(6506007)(6486002)(66446008)(66476007)(66556008)(64756008)(7416002)(91956017)(76116006)(66946007)(6512007)(6916009)(44832011)(9686003)(86362001)(4326008)(1076003)(4744005)(71200400001)(316002)(8676002)(54906003)(478600001)(2906002)(33656002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4589;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s7NEMo6LKIRgdmM+zu6mCrsTEL/ANoJCxQJCuHSHzec9m9cMPAs/ammMQutEob99MfUzwL4rRioOxVY7PidJDRT4rDtf9XkYzDPxSHRn7zs+zVajcZGGXbCs7WcHpUloUImEsRyEGeROAflkd0fmfoLinPOXxX+iW+e2TPDz49gTbKcNqbKEzHnJTcgrzyiR0amKfWWnRZrWir7IqCFCygDDZLcCG3J0af2QK7vf/XJf3ezAlKYC4ESDkZTnfLpvjDVzBx8QEjCQetmIyyL6o3VXkhNgvpUfIKtjjMHKxJJpDYIcudQZ3YBVAMv7HIUK8ZzKKgJvp5a2TXH4H2InYXrJcrAOODfCWvibcLwsNfY+GpvGEa2eT7u06PfupbRYGEmZQP5fqENrR4g9iGWjWMP1KePFyLGf+0ZUIFYzuUtOhx3NLnm960keDrXcFRJC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B49D0639DF65C0448C79274696758281@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3630267c-720e-4ffa-bf5f-08d78450cad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 06:58:03.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkNaNKHzk8dyqqLr6mjo16RNDarwRURi8WtF28stkLMPtXpb+yPR6BwtWp9sLgR62+RV6ZHSMK7BVoFPDQEdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-18 20:53:10, Dmitry Osipenko wrote:
> NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Doc=
umentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> index cfc9f40ab641..51376cbe5f3d 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -15,6 +15,10 @@ Required properties:
>  	"qcom,ci-hdrc"
>  	"chipidea,usb2"
>  	"xlnx,zynq-usb-2.20a"
> +	"nvidia,tegra20-udc"
> +	"nvidia,tegra30-udc"
> +	"nvidia,tegra114-udc"
> +	"nvidia,tegra124-udc"
>  - reg: base address and length of the registers
>  - interrupts: interrupt for the USB controller
> =20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
