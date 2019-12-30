Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2303C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE9420718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kbfoNlHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfL3CYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:24:46 -0500
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:61250
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbfL3CYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:24:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE4CNj4dCVZnlhNFDMLzuSRuXjZ41l6mYq5/ei/9rNUeo2c5SzG7L4GmVt2RDmw6mNR32+5QD9Ah3QzD8XDRL60OqQ7cmXpbGpf1mTceV6B4Azyzy1bC3qdhh4pBHAzfQogii96CHvuY022KF5nRgMRKfcCPdcceYKIdWNRrzz+uNPOKpEfmFVa8G7OpgXGNAurFkB38uL6xqzlc2b4D5OnADggyQe8QT4CKvBlsevzMFXhv1unRZgYL33hoZ4x3oG/oyXky3lpkGEyt/UC0E3qpRusVONG7dtANSgFq3NXA/bW6cjisVz3apihmpDmnUTZnGWYqCfz/WOwU9yYkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+0MiultKootwcriXky49DJcMcWlfdqM4+o6p9mdmig=;
 b=CKVFVS/1CFtIE5SNs+w6607/EJtVsAV4VQZpKvKwUsUmtU0nf128MAzcaEzJCPzcWVAz8f6SYs1K48BwFJ8LRxDR6pGoGMXOGaebYT4dpGs+/N9yzlq6F2+JHOTKwCqtS0ftJ47/GTZ05iCo+mV+P6z/3WeTqZCUHoindhXni3Hoc6/ILiPtKWpces7wb3uBK3nap1sqhQP1MjfwbIjXq6OP1CnBLc+ibZ5DE1MpJefrWoRe+4r+wxa3mkLvlxnMqIG7Bt0992rU8I9hddX+JyjAq9f2VljOXTywXqo6ThZBuiSsBEZh/bPrWx4/NSbajOzBSMob2ucZiuhwDgAgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+0MiultKootwcriXky49DJcMcWlfdqM4+o6p9mdmig=;
 b=kbfoNlHa2+LhCa+rY6LhpgRQmFznWHgtSaBSxIHhdLD2saWLrLETrG9JWszO6SrPQv0zLUxjR/QlL7u/1VarkbHXjSLkOkhWNK5Tk3tTkTbKB5x8qJ1U5dblHKFM4wAUY64DDZx4jTxunyfnBYEdCAs67XdnotrrIzILRFfeCSQ=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB2975.eurprd04.prod.outlook.com (10.170.228.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 02:24:40 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::c7d:58a2:7265:407e%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 02:24:40 +0000
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
Subject: Re: [PATCH v3 14/16] usb: chipidea: tegra: Stop managing PHY's power
Thread-Topic: [PATCH v3 14/16] usb: chipidea: tegra: Stop managing PHY's power
Thread-Index: AQHVvb5yypSAkWdzC0CHQHijrFydE6fR9ROA
Date:   Mon, 30 Dec 2019 02:24:40 +0000
Message-ID: <20191230022437.GC5283@b29397-desktop>
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-15-digetx@gmail.com>
In-Reply-To: <20191228203358.23490-15-digetx@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c7b2348-ee29-4d0f-0ebb-08d78ccf6cdb
x-ms-traffictypediagnostic: VI1PR04MB2975:
x-microsoft-antispam-prvs: <VI1PR04MB29754C9776BFC95ED58CF9018B270@VI1PR04MB2975.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(71200400001)(86362001)(5660300002)(44832011)(186003)(6486002)(7416002)(54906003)(2906002)(6916009)(4326008)(316002)(6512007)(9686003)(1076003)(33716001)(66556008)(66446008)(8676002)(6506007)(53546011)(91956017)(33656002)(66946007)(81156014)(64756008)(76116006)(81166006)(26005)(66476007)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2975;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9t5JzaYnzuTy8/L0O48LuMBiiw1Wx0wySQxOmW+EdJVLePcovRPs5vuGw7hSfRZIYU50qDiZ+ZWWKJ9oMwoYc6wd3JiIRUxZjq1B9O+TYYXCPVNvsLqEPUzEF4WKxWj4asbBlIN5H5YCY9zBiczfuJNQ4PEKLTzUS7i8AHzaIaZRfIDcys9nUxpWB/HIRKnbT2sHeGMm0mzKa8+d4igR5cPq5Yy4HCea9V4hLpNaZDbCQGXjncT/N2yUM4noSp8U6KPuUI8EhFYhU/IQiA+3kPdPqfgt/PIri05vx+J8hC2BON9h7JvalBvF5L+0eFHScqOj/NPbfAxsZn7hdtQSuZyH7AGen3hJa7to1L3mNKp4TvcuoytE57DK+nHx/tQmmko6d0lnWaG5RanYOM1s0Irm8w6QrkdAwxAuKeuz/L+9sJa6L+VNfTm8zt9Op4l
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA1EFAA76B873D4EB7085D0BBD969BC1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7b2348-ee29-4d0f-0ebb-08d78ccf6cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 02:24:40.7159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3N6qAkn3QnAThoxb4hHwWcwRCvzc+dSgIC7WElW7nrzTSogdf/2zDhJ63Ce0toh2fY8NEx3byKhepVXTXbhz8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-12-28 23:33:56, Dmitry Osipenko wrote:
> Tegra's USB PHY driver now provides generic PHY init/shutdown callbacks
> and thus the custom PHY management could be removed from Tegra-specific
> part of the ChipIdea driver.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/=
ci_hdrc_tegra.c
> index 0c9911d44ee5..7455df0ede49 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -83,13 +83,6 @@ static int tegra_udc_probe(struct platform_device *pde=
v)
>  		return err;
>  	}
> =20
> -	/*
> -	 * Tegra's USB PHY driver doesn't implement optional phy_init()
> -	 * hook, so we have to power on UDC controller before ChipIdea
> -	 * driver initialization kicks in.
> -	 */
> -	usb_phy_set_suspend(udc->phy, 0);
> -
>  	/* setup and register ChipIdea HDRC device */
>  	udc->data.name =3D "tegra-udc";
>  	udc->data.flags =3D soc->flags;
> @@ -109,7 +102,6 @@ static int tegra_udc_probe(struct platform_device *pd=
ev)
>  	return 0;
> =20
>  fail_power_off:
> -	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
>  	return err;
>  }
> @@ -119,7 +111,6 @@ static int tegra_udc_remove(struct platform_device *p=
dev)
>  	struct tegra_udc *udc =3D platform_get_drvdata(pdev);
> =20
>  	ci_hdrc_remove_device(udc->dev);
> -	usb_phy_set_suspend(udc->phy, 1);
>  	clk_disable_unprepare(udc->clk);
> =20
>  	return 0;
> --=20
> 2.24.0
>=20

Acked-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
