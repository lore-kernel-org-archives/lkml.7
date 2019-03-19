Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B94220854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="UmNZUjap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCSFav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:30:51 -0400
Received: from mail-eopbgr820042.outbound.protection.outlook.com ([40.107.82.42]:55744
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfCSFau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z37/LlU3ekIy9A2w11z4m8UnqdsuKz6cHEd8ZPuUrOg=;
 b=UmNZUjapRGgPvu4fCFIIvEdmtRp6HBgXI5n9Pk0TA443GS+daNnA/LXxWqhE1fQqp6SEexIObHgwieAUK60fvuCAD0P1Vjee2sSCUqu8IZ6NIN15o9u2Lb36toQfybm8y0LkGShtgaYEP9sW+Zxs2+KB8MMkJzO6cIHjJzKhSLo=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4165.namprd03.prod.outlook.com (20.177.184.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 05:30:46 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:30:46 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: berlin: as370: Fix to avoid NULL pointer
 dereference
Thread-Topic: [PATCH] pinctrl: berlin: as370: Fix to avoid NULL pointer
 dereference
Thread-Index: AQHU3eOVCyAoHQ02Q0m13kE3SnRdmqYSa/KA
Date:   Tue, 19 Mar 2019 05:30:46 +0000
Message-ID: <20190319132319.098c5fa3@xhacker.debian>
References: <20190318233734.9991-1-pakki001@umn.edu>
In-Reply-To: <20190318233734.9991-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:404:ce::20) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48dd33e2-3bfd-4b15-adae-08d6ac2c09c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4165;
x-ms-traffictypediagnostic: BYAPR03MB4165:
x-microsoft-antispam-prvs: <BYAPR03MB4165516D82EDADB93592A918ED400@BYAPR03MB4165.namprd03.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(366004)(136003)(189003)(199004)(6246003)(11346002)(5660300002)(476003)(81166006)(71200400001)(6512007)(478600001)(386003)(105586002)(6506007)(106356001)(9686003)(71190400001)(72206003)(86362001)(256004)(229853002)(81156014)(4326008)(186003)(2171002)(68736007)(25786009)(1076003)(446003)(7736002)(305945005)(6916009)(99286004)(54906003)(6116002)(53936002)(52116002)(316002)(8936002)(3846002)(14454004)(50226002)(97736004)(102836004)(486006)(8676002)(76176011)(26005)(6486002)(6436002)(66066001)(2906002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4165;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g0j8PenavNOKXpSjtaeKb7GpfpUbHUfpY4MnBDyXb5iJngGqsqDMG8pPpWeKNg2aoby7nQUYX8NoVyCGOC8CMBOYWc6krU56laM/hpx3H7tKS87NjEX/0BZJM4AHzntbkohxzyTcYR6fa4It2E58qUZMEcMrYe6VZG3GQMzWjQIPG4mGrizpH5jbGTDK+vIqJt94vciU7zV5teWZ5oSdym1jfkInEhyqHORna8SOejAn+PcQUWn81NMNiDXTET+EWvq7nS1qz8FLaaJ69vwFx2ySXa8Gs/SHoBJ3y/jKh5biej9okKAiYmiEE70emzOLIxt9CHbWm9CZMmj9inkUe8mkLIle3DO2XjG+vx1IA2LQMaacKeobOt5WthsWWzwi+dv5YQCOV0FKmYhRMlapQO9cbk49c1eFiL6V5GIJVmo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F1F7E10119CB6B439D3E4AAD9A843A63@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dd33e2-3bfd-4b15-adae-08d6ac2c09c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:30:46.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 18:37:27 -0500 Aditya Pakki wrote:
>=20
>=20
> of_match_device in as370_pinctrl_probe can return a NULL value
> when the matching device is not found. The patch avoids a potential

Similar as the comment to your previous patch, this could not happen.
If the probe is called, it means OF registered a device with a valid
compatible string, so match cannot be NULL.

> dereference in such scenario.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/pinctrl/berlin/pinctrl-as370.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pinctrl/berlin/pinctrl-as370.c b/drivers/pinctrl/ber=
lin/pinctrl-as370.c
> index 44f8ccdbeeff..78bb5b866c99 100644
> --- a/drivers/pinctrl/berlin/pinctrl-as370.c
> +++ b/drivers/pinctrl/berlin/pinctrl-as370.c
> @@ -337,6 +337,8 @@ static int as370_pinctrl_probe(struct platform_device=
 *pdev)
>         struct resource *res;
>         void __iomem *base;
>=20
> +       if (!match)
> +               return -ENODEV;
>         rmconfig =3D devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERN=
EL);
>         if (!rmconfig)
>                 return -ENOMEM;
> --
> 2.17.1
>=20

