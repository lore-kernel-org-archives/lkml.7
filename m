Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30CCA9EC3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4BA20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VgHtmcNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJ3DA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:00:29 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:3512
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726714AbfJ3DA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:00:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTe8Vcb31uptQfpb3r/X8p6vcRvV4FqvHtaCsyDZlFM3ezxwaVSRI+SHkFoWkVZ/+hnwEaraEZZaKuKZH2vo/tn37WdtlGGpMPQv6+4YvajyC3zNg+f/GJYRmjQz7kzRKvpnwFdouDJlaeRRnFM27LyH5rQLKjDVuM/TVM9xIcnwube9sotF2Grinka7LEeLwOE3Ok+lxRHNgQIAJES3m2uNVCGVadM+oDJakCmwh+Ac+uHN6ggi9KnBm4cRtHdnWlmRqL/kDe3vyWpVNJmu+fzTfl9t8ANbyitkjPsrhGQ9SXEvEmv1or+NCutgDewkNSctzSbf31IL2KdQYyO7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gxOMv45ptpqiyt+HmlyCjSSg1T3ZprTAZaIVmwzDeo=;
 b=YtW4xZuIrRKTRK/R6ixrxo0CugxsOMRisUMD7BWP/lkEMO2INqnHCLRz7e3XSh9+hvWTpnSbF5rHJlR3fEFcJKfgj3y58p01vkkXZ3RFITYzY2E1qVGBQf6O3DBp9cHTPI4pXfHY+90Ih0rJ0zPL74qnG49h/FvUzR8xAEUmMSU2IxpXknsvAqBeWGQgm13p3ZhO0kA1af0hELuBa8iaL5dh3nY9llUMhrJjKRt96ICiq2/HzD+soUBjiRs2OLZZd/40GF6xl/D3f16D5S3fDRSWuO+zYtTTgpViUG0Nn9v5ddBDJQCpMru9Ye6frHTBS8EUScwtiu/UCMnAoZ5ekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gxOMv45ptpqiyt+HmlyCjSSg1T3ZprTAZaIVmwzDeo=;
 b=VgHtmcNaIhJzHIkD2ADRX/00JY2fniKFwCJSdeODXr/HtDu6Ia0mBlE9RU0XnkF0Gd6VRYGfZHspzb5Ww42Y122niNniYdKoYaxcanTvdc1Lre1Va4Q96/b/nfjgv/ILLnq3i5jQJQS2S2QlVGz+g/Fb09tY04qSB3A/UTVAXac=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.52.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 30 Oct 2019 03:00:25 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Wed, 30 Oct 2019
 03:00:25 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Sanket Parmar <sparmar@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH] usb: cdns3: gadget: reset EP_CLAIMED flag while unloading
Thread-Topic: [PATCH] usb: cdns3: gadget: reset EP_CLAIMED flag while
 unloading
Thread-Index: AQHVjlPrT/MJnfa1mUOR+qlmLDEOZKdyf6UA
Date:   Wed, 30 Oct 2019 03:00:25 +0000
Message-ID: <20191030030014.GD26815@b29397-desktop>
References: <20191029122441.5816-1-sparmar@cadence.com>
In-Reply-To: <20191029122441.5816-1-sparmar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3565f3ec-8b93-4a1b-6586-08d75ce55010
x-ms-traffictypediagnostic: VI1PR04MB5135:
x-microsoft-antispam-prvs: <VI1PR04MB513518CB5E2EF7C97149313A8B600@VI1PR04MB5135.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(7736002)(6486002)(6436002)(99286004)(256004)(71190400001)(71200400001)(6512007)(9686003)(33656002)(6116002)(54906003)(76176011)(6916009)(229853002)(305945005)(2906002)(66066001)(478600001)(8936002)(6246003)(3846002)(86362001)(316002)(446003)(5660300002)(26005)(186003)(476003)(25786009)(486006)(4326008)(81166006)(81156014)(44832011)(33716001)(1076003)(66946007)(53546011)(66556008)(64756008)(6506007)(66476007)(4744005)(102836004)(76116006)(11346002)(66446008)(14454004)(8676002)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5135;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsgWfD3N7ihEL05T04Ji/AnDz7dysAb/74z7LIPW0hX70vBEgcIpXChoTZrC5g5eqg3SHviSsdJCBZqtZGNGkoed+OBSQyXxUiy9ktcOzZG2LEgiAUYiw2obTZF+5e/yWnw8uO5QWOP0xg5ncN+erxnJY4FtxMmcUdYbmMZJIePwQNK+SCWjYbwiPCnRKB+ANIOxqaDwdBTsp3r9tpGvmpiFOTX7RO2aO9x6KreK5cIKpdSbJpMDgA5VqJAiRuLnsJmjU/tiZMgPhjmSgBsKuphLBvep15rZShW4LIJ8b0yG7QkZ6/sMn1e0x86YRsnz1bA3JUbCLtpluzBXiZ9uKTTGddsQZkgJ12rAbsd+e9wePRiS7Z1W9iLYDOVN5cBxhx1ZUeDA/RnSJ7lnVl8giP77Q1eeNwqL8/Pgr8rXs5bC5KRQeIZ+hqAFgB0EgtuX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <323FD7B0B942E544B8026F03440BAB5A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3565f3ec-8b93-4a1b-6586-08d75ce55010
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 03:00:25.6252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHWpgvg9lh2Gwaa4FVmNOz6hZKqwxrfUJaIxRbsR8vWafqOAjycM5o8a7XKszS9VkPQKCgIq96kqbj75/8/meg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-29 12:24:41, Sanket Parmar wrote:
> EP_CLAIMED flag is used to track the claimed endpoints. While unloading t=
he
> module, Reset EP_CLAIMED flag for all enabled endpoints. So that it can b=
e
> reused.
>=20
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---
> Hi Greg/Felipe,
>=20
> This can be used for -rc as it is bug fix.
>=20
> Regards,
> Sanket
>=20
>  drivers/usb/cdns3/gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 9050b380ab83..2fb78322ed3c 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2381,6 +2381,8 @@ static int cdns3_gadget_udc_stop(struct usb_gadget =
*gadget)
>  		writel(EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
>  		readl_poll_timeout_atomic(&priv_dev->regs->ep_cmd, val,
>  					  !(val & EP_CMD_EPRST), 1, 100);
> +
> +		priv_ep->flags &=3D ~EP_CLAIMED;
>  	}
> =20
>  	/* disable interrupt for device */
> --=20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
