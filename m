Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F4820854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="eXSbp1nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCSF3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:29:22 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:1249
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfCSF3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl2eZHoBPke0J/d0ip8Kmo0+9JLrZhRSy0FBDXgLP/g=;
 b=eXSbp1nn9b9RZBMew7eZwPmHIA1c1qjGh0Jn8LezNeuM/4avsQbW3m/fr5uWMjDo97+rV9lgBAq6GKkPWI2mGCn4+jjza+VWFaMNYTvIt+8EBfsjcvOj69oQABoHTkqAoZom8kqldwgfSsqzKRy7E5+IYcsjT0hCnJB7FL8AViQ=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3813.namprd03.prod.outlook.com (20.176.254.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 05:29:18 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:29:18 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: berlin: Fix to avoid NULL pointer dereference
Thread-Topic: [PATCH] pinctrl: berlin: Fix to avoid NULL pointer dereference
Thread-Index: AQHU3eK81Pz1/QYQ2UmyKh1IU2VjIaYSa4wA
Date:   Tue, 19 Mar 2019 05:29:18 +0000
Message-ID: <20190319132152.7e1fef48@xhacker.debian>
References: <20190318233131.9642-1-pakki001@umn.edu>
In-Reply-To: <20190318233131.9642-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:404:e2::29) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f38ef5d-4298-4467-052a-08d6ac2bd53c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3813;
x-ms-traffictypediagnostic: BYAPR03MB3813:
x-microsoft-antispam-prvs: <BYAPR03MB3813CF4C5638AAB0B7EF1A50ED400@BYAPR03MB3813.namprd03.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(66066001)(86362001)(9686003)(6512007)(8936002)(256004)(6916009)(50226002)(486006)(71200400001)(71190400001)(6246003)(186003)(229853002)(68736007)(6436002)(6486002)(3846002)(6116002)(106356001)(53936002)(105586002)(97736004)(476003)(72206003)(446003)(386003)(6506007)(11346002)(4326008)(54906003)(1076003)(316002)(52116002)(81156014)(2171002)(81166006)(8676002)(76176011)(4744005)(2906002)(26005)(5660300002)(7736002)(305945005)(478600001)(99286004)(25786009)(102836004)(14454004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3813;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kf2+TWSHR2JXk2VxVuxDW631Ab5Wtl+boTr4FxvspEdCN0CeP7jaRVGlH/HwO3Gp7XIxGoOdfSqvWVnEMY9/Yd/UTMBAWoG2zG0roTLVDhngdEveSP7/JlCnOEUDkqPnS11vZEaIb38lBVjWJH/9I8OnCyWNFOLNYvId1Sb0ytZQsLjgwHBsIIX2gYa53dWQwokx+u+jge2/iYwROWKnXRx8/yxVgIg5vTyYFNKW1yFVX+K8uohi+NohG8M7NPABSnTZM+I4hLqL6CTrFjFxGr0OokSM4phN/BMKWIK4mc0HazDg+gmCnU34G0J1KpO3LPvUZDjJJ3ZjhG8eCmpn6cJMLPWKV5RpbDrYV/7euPnPD/FYY7ProDzIhwRtbiRfO4DTuhxeTvXk+rWqt+QSYsPnLWNwvhe8K8i7hvtmiJw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1233552374A7074894CFA92DC7EB46D0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f38ef5d-4298-4467-052a-08d6ac2bd53c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:29:18.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3813
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 18:31:29 -0500 Aditya Pakki wrote:
>=20
>=20
> of_match_device can return a NULL value when the matching device is

This could not happen. If the probe is called, it means OF registered a
device with a valid compatible string, so match cannot be NULL.

> not found. The patch avoids a potential dereference in such scenario.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/pinctrl/berlin/berlin-bg4ct.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berl=
in/berlin-bg4ct.c
> index 6a7fe929a68b..2d5e82938ef9 100644
> --- a/drivers/pinctrl/berlin/berlin-bg4ct.c
> +++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
> @@ -456,6 +456,9 @@ static int berlin4ct_pinctrl_probe(struct platform_de=
vice *pdev)
>         struct resource *res;
>         void __iomem *base;
>=20
> +       if (!match)
> +               return -ENODEV;
> +
>         rmconfig =3D devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERN=
EL);
>         if (!rmconfig)
>                 return -ENOMEM;
> --
> 2.17.1
>=20

