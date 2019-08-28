Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17615C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E2A2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L/m0O1IM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH1DYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:24:05 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:28226
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbfH1DYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nER46pRldVT35Eu9aM798dYmvkYR56kUxej1LQURmOKNLE3pSfRI2qS/K/xGE7T3GAPjiBaCGSceqNzM29jMvepqyZfs1BD4TQ7uv6OEKKljAuWObrvHYur1zmI7QnpyoEYWD+qBuYWwSU2XdZxo2rYqLkDpJJ4DABvY8a9orClh2veM8uhTgT8quIbrHC7KcOfs0cENliOkYYRQt388RX8JksSzfuaB5J4B8NtF/viCaqWigjG4jbRG81dFn68D6EcQn/t/CHGgIJcAOo5hdIsss2cVzIPyK10pmgFnuZ1gSE/VjD+THjpRdgKGOyKv8vqCy9u+0NATz4zUJZy3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hem/93KMxl+2QcuwnNmBYBm0xDv/98eD4ErxefjGYfg=;
 b=f8bxO1mbAnV6X4cgeBnlKK+F/3UY8zJO46DYctr5HrrLCNjSYhBJ5P0VDDOQ/qGQkSw6cUWsWZVaQlf7LmWRN90CY5nkMFZdT5ZIuEARFogcNIuI0fvkflKPgRy/38iHqeyegd9udnkenLJ3OU2T46aMgcoqlzw54hrrDm7IB3zjdihnEnv/ACf5nk5y+j6eVinA/eOnZNosKz1h4vL7H4KgSQgovRT23qG1z28ZMrufSS2Q9TJ6FmRwSzTlL5yaZZ4zdDCTol+WZcizKEmhJoJWoHgx8ilRSZlxQFPhJhupIplWWmV/alhE/YfE8zs0Mv2ZUSrSK3y/UgUb1hv3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hem/93KMxl+2QcuwnNmBYBm0xDv/98eD4ErxefjGYfg=;
 b=L/m0O1IMCvfqn4apZus6h4Q5PeLx3/IksKlC/mMTzA1NZelRJ49Fpr40RKJUC6q4QOs1olhiiEy8nMrd540t+KwgWvKhSsofTlLKMv78Ru3+ElRLDs5oOxoYUlSQATEgGjXfKen+zrPqwj+LfJA1n/mm6wivEDzk5UN1kZsbGC8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5215.eurprd04.prod.outlook.com (20.177.51.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 28 Aug 2019 03:24:00 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::e039:172d:fe77:320a]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::e039:172d:fe77:320a%4]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 03:24:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: msm: Use device-managed registration API
Thread-Topic: [PATCH] usb: chipidea: msm: Use device-managed registration API
Thread-Index: AQHVQQMqCyiV6SBdkkOiu7Ig/zYETKcQHUkA
Date:   Wed, 28 Aug 2019 03:24:00 +0000
Message-ID: <20190828032118.GA2966@b29397-desktop>
References: <20190723030206.2919-1-hslester96@gmail.com>
In-Reply-To: <20190723030206.2919-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 768941c9-8779-4dd5-19c6-08d72b672b93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5215;
x-ms-traffictypediagnostic: VI1PR04MB5215:
x-microsoft-antispam-prvs: <VI1PR04MB5215B0F234FD62DCA98E07038BA30@VI1PR04MB5215.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(9686003)(5660300002)(99286004)(6512007)(76116006)(66946007)(33656002)(4326008)(91956017)(6486002)(229853002)(478600001)(86362001)(6246003)(3846002)(6116002)(7736002)(305945005)(53936002)(33716001)(1076003)(25786009)(66066001)(6436002)(64756008)(76176011)(6916009)(14454004)(102836004)(446003)(11346002)(53546011)(26005)(6506007)(81156014)(71190400001)(71200400001)(486006)(8936002)(186003)(54906003)(8676002)(1411001)(316002)(66446008)(2906002)(44832011)(476003)(256004)(66556008)(81166006)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5215;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6pJpJgrMW5TVQE+yTHOaFMQqmtQzmI0laLLrgrXybv/03xhxTgswJDK13loNjHnrgvBWA0Dccv2GjedV3IWH1NbkuIaGSV3wvA1ss5NHTNLlsF7QXA0bvGyYpUtosdishrBxl5ppgOIwLUCc9Bm7dKXp1fRO2RZKZexITrbGtiunQpgVQO9rhO1LwHV0VVKHRxSeLNmkSikaqJXL2IwrTX14BXioUkSjZ/z5BTg3qRWS9tUZwRTFsaIQVGLqkGwXk9o152nSY4RzQotRldXpNfJDSS8e6W91ATWdpDw5EtxlpLOXMIwIKBjxcWutc+z8tITtn/tExG+jN5ps5I4oXVps3kkvUbJHR3Gk9JikLlgybrWxG9DKRr4vITL/TTD7Q4JQAqSv4LEdyfiL5ATk1IMXBhW+hMOJsPpKTV3pmOc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <272B15344AB0F742B560731FEC28A3E0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768941c9-8779-4dd5-19c6-08d72b672b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 03:24:00.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQuVKBv1n6/4SI43mQSde7nPj1wUsPNgsz4Ae8E2ZLIGTG5v8ywJ3nZloH6LG0u1depYAZOR72ckcyFZk5854w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-23 11:02:07, Chuhong Yuan wrote:
> Use devm_reset_controller_register to get rid
> of manual unregistration.
>=20
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_msm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci=
_hdrc_msm.c
> index bb4645a8ca46..067542e84aea 100644
> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> @@ -216,7 +216,7 @@ static int ci_hdrc_msm_probe(struct platform_device *=
pdev)
>  	ci->rcdev.ops =3D &ci_hdrc_msm_reset_ops;
>  	ci->rcdev.of_node =3D pdev->dev.of_node;
>  	ci->rcdev.nr_resets =3D 2;
> -	ret =3D reset_controller_register(&ci->rcdev);
> +	ret =3D devm_reset_controller_register(&pdev->dev, &ci->rcdev);
>  	if (ret)
>  		return ret;
> =20
> @@ -272,7 +272,6 @@ static int ci_hdrc_msm_probe(struct platform_device *=
pdev)
>  err_iface:
>  	clk_disable_unprepare(ci->core_clk);
>  err_fs:
> -	reset_controller_unregister(&ci->rcdev);

It is devm API, why the unregister needs to be called at
fail path?

Peter

>  	return ret;
>  }
> =20
> @@ -284,7 +283,6 @@ static int ci_hdrc_msm_remove(struct platform_device =
*pdev)
>  	ci_hdrc_remove_device(ci->ci);
>  	clk_disable_unprepare(ci->iface_clk);
>  	clk_disable_unprepare(ci->core_clk);
> -	reset_controller_unregister(&ci->rcdev);
> =20
>  	return 0;
>  }
> --=20
> 2.20.1
> =
