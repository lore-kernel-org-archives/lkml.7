Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17812166E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gdHVEcbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403930AbfJYDQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:16:33 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:28777
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732607AbfJYDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:16:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFYAbmfz9LEo1Ojvjz13dzkzg0CGLSYCUAKGzGnTornxsNs0bzmoVFazscSgKct5Fh2n1QBqjmTXMTjmhEogxh4zpLedKRrdrXzkjl9mHcf3RD2cZ89ySH4nsUQKshXNBrzqPkVQEfA1aEBtqWrRz7oP/w5ODdhPrHzknToP1fhyjLmvuf5m4NeXbCZbqH4iFenYItrJSN6w2i9do3KXuk0oIAIUWvTYvX3wCpVC/SWH01v076GSt0L84fcIgRCTaT8XuNlY2bb+M4q71/7BAYShSuwBTZ0JJX03TJmN8ZvVUUK9daN37dVyc1d63FC4XQRTAFgq7HiajxNeWT+52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbjcr5QFtrK6wjxnnmu1H1AQy3zpiGK7sHRJSJKFBkw=;
 b=AcO0A3x1Ff2gCOwvSBebmDCjH7/8GT4rGUWl1WKsTvxGKbwlP6UsuA6/TVUOfU3Jhg4KMC2HtZNo7ze+APZM0HIHWSXejU053UOoE3ScbAVDN/Q3w3VYINRirt47UNdr8b/XqmVGTExplbqKHyV1MgMhUGBmD2yZS57+KF3qa/EfWh/ThRL692XKVWLEHF9xa0OjE9fTAoJv58bqtyyGjZ2GUd1fi+5fY2bXucXiDKiewOuFkS44AcadajCxCpiIrWBgBR9KE6kU7gzYYCW+lBAO1Ndj4qpVomduLpTMMaPT76Of6pTKmp8CCBy9TBHhbo8YDJgXki3JiFisaKUPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbjcr5QFtrK6wjxnnmu1H1AQy3zpiGK7sHRJSJKFBkw=;
 b=gdHVEcbJ7R0JmrijPMp6PLDiP/0JQG4S3BE4+VCJRReZKDpOE8ZL2NUjTer5m7O8ppqiiJ60AKwZbDymOtmphnsMsVpsu/98/He7GXKIjVcSZ1QfQHaNIch+8289AwwYZ+HSd5YnWwY0GQLKKdHHMYv1/fMF7Y5iaGzbkqwHoh0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3966.eurprd04.prod.outlook.com (10.171.183.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 03:16:30 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 03:16:29 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH trivial] usb: Spelling s/disconnet/disconnect/
Thread-Topic: [PATCH trivial] usb: Spelling s/disconnet/disconnect/
Thread-Index: AQHVin+ZNsO2g/j6A0Guc+9EU74T0KdqsCMA
Date:   Fri, 25 Oct 2019 03:16:29 +0000
Message-ID: <20191025031618.GB13392@b29397-desktop>
References: <20191024152747.30617-1-geert+renesas@glider.be>
In-Reply-To: <20191024152747.30617-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 031c26c8-0c87-4c86-1a87-08d758f9baa6
x-ms-traffictypediagnostic: VI1PR04MB3966:|VI1PR04MB3966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB39665DDA307F225CB19550158B650@VI1PR04MB3966.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(476003)(66946007)(66556008)(66476007)(66446008)(76116006)(446003)(64756008)(91956017)(33716001)(2906002)(486006)(7736002)(6512007)(11346002)(316002)(14454004)(6486002)(3846002)(6116002)(33656002)(25786009)(44832011)(9686003)(229853002)(305945005)(54906003)(81166006)(8936002)(8676002)(478600001)(4326008)(81156014)(102836004)(86362001)(6246003)(99286004)(76176011)(1076003)(186003)(5660300002)(66066001)(6506007)(53546011)(6436002)(256004)(26005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3966;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/ilkD0AnRJqh+NZakH6JhVDEeCL5wlONu5m4WxX3/LbStWAL7RZHDokJlC7BxTHK5OSQqVIhByhCPl6Bs3IscIUulHYKRwP3qilD1AOtUXn/maniS+08vanzCgwmrY2nVroBEukb2Tq5VjeMnVbXTK9jRub+Pwvit765BJCxf8aUcWmgWKu8PQI06CoJIO+oxXP245Zi5MF/E8ZVag8u+fAAdpu+pnFLFjiUIYNl1VIk5JHug1eVOQtj4kzeKjgbMcjChlihYuIFPbgPSpeUb6qRR5Yrj70QnQS98xIBA2ygme5DEUQDdU67matqHiOhF75QMHy0JyAAiYDSDe9lpG5zk45/c5rlR/h2WeAJcn2Pi2ulS5Sc5Ya9qsnQdPycyCkFe1w5i9CoRlZC6XZXN7sYKmqd2CLcnjSxZSwezmABsbgk6nXf4lb534zJpgm
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35403781C405C64487AFD3524C82F751@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031c26c8-0c87-4c86-1a87-08d758f9baa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 03:16:29.6744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hH/a8AbxNPn5quN9k+tswXmaSan19Ztsmr/42df6B/2G3Xi7CuQSHkDyXVBthPe6irQdaOPlKthiv9KLDvNiww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-24 17:27:47, Geert Uytterhoeven wrote:
> Fix misspellings of "disconnect".
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/usb/chipidea/udc.c            | 2 +-
>  drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 8f18e7b6cadf4306..0b6166a64d72a762 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1612,7 +1612,7 @@ static int ci_udc_selfpowered(struct usb_gadget *_g=
adget, int is_on)
>  }
> =20
>  /* Change Data+ pullup status
> - * this func is used by usb_gadget_connect/disconnet
> + * this func is used by usb_gadget_connect/disconnect
>   */
>  static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
>  {
> diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/u=
dc/fsl_udc_core.c
> index 20141c3096f68ab4..7114a0ef4b13b4e6 100644
> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
> @@ -1208,7 +1208,7 @@ static int fsl_vbus_draw(struct usb_gadget *gadget,=
 unsigned mA)
>  }
> =20
>  /* Change Data+ pullup status
> - * this func is used by usb_gadget_connect/disconnet
> + * this func is used by usb_gadget_connect/disconnect
>   */
>  static int fsl_pullup(struct usb_gadget *gadget, int is_on)
>  {

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
