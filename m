Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83311C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E81D20643
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qlULKKXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfDPPno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:43:44 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:28384
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbfDPPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMxZLj0ANNVBIiOHAD+bgA9O5CS4Q9Umc1ogmTTQGLE=;
 b=qlULKKXqbnBt4TOWjKUuaOsl4RujPZY8VicuRCDQR9F/Fgdfwl18epebNR6f01AoMvQymlylHaW0HLHwnP8BJ+4smOSLr6p5Nu+3J0YTnHHO92osbv/+r81/UolZjwCnh4Tmv2Af7XI1QiBcxxI3aHEQhGfXE+XXwJ6ZMx3rZC0=
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com (10.168.64.146) by
 VI1PR0401MB2352.eurprd04.prod.outlook.com (10.169.133.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Tue, 16 Apr 2019 15:43:40 +0000
Received: from VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::2cba:efb0:12d5:243c]) by VI1PR0401MB2463.eurprd04.prod.outlook.com
 ([fe80::2cba:efb0:12d5:243c%8]) with mapi id 15.20.1813.011; Tue, 16 Apr 2019
 15:43:40 +0000
From:   Diana Madalina Craciun <diana.craciun@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 20/76] powerpc/64: Disable the speculation barrier
 from the command line
Thread-Topic: [PATCH 4.9 20/76] powerpc/64: Disable the speculation barrier
 from the command line
Thread-Index: AQHU9GspWTZ2wufWykODQsLkIlslGQ==
Date:   Tue, 16 Apr 2019 15:43:40 +0000
Message-ID: <VI1PR0401MB2463835B1223FDAE2EFFCD43FF240@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183712.869759410@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a3c3664-1092-44ea-2bff-08d6c2824c8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2352;
x-ms-traffictypediagnostic: VI1PR0401MB2352:
x-microsoft-antispam-prvs: <VI1PR0401MB2352CFFF53C92306CCF815A9FF240@VI1PR0401MB2352.eurprd04.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(55016002)(110136005)(7696005)(99286004)(7736002)(9686003)(305945005)(3846002)(6116002)(106356001)(4326008)(256004)(14444005)(71200400001)(8936002)(2906002)(71190400001)(6246003)(105586002)(2501003)(54906003)(81166006)(68736007)(53936002)(52536014)(81156014)(25786009)(316002)(74316002)(5660300002)(8676002)(476003)(446003)(229853002)(6436002)(102836004)(486006)(26005)(53546011)(6506007)(76176011)(186003)(86362001)(33656002)(478600001)(97736004)(14454004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2352;H:VI1PR0401MB2463.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xBvDOWhWvTBL3vJEccR85/78ZGPdc1Tmj2QEPbkeIk6C/yvQUPBCJYWoMhSVCd4M0huDBY5V5c9TJSCf/jDRXzHMzZPdtOYwtbNLCOOkjx9uM4OUFQNtPJomd70aU+QlUibLAgzpfzI4fJamOoucBbZ69e8RIiEd9gNVa35O7k22GOvo8aotNnULFv1unSMbD/m1OujIxNaXnF0XItjCCAQgnpztNHmiHfqEb0HYX9KSFIE7od+27Awg5KX26VI3UadrwiKep+qarwqRQdFUpj/hXfoczg8Jl9V1Lxq1irpW1DEfFYvqxtyCH191OH82lXOfbjYAFCBHv12SCgBCroz9qcNhIt+CjOTst123FHAaz41oMbWjRgJDg8jUt1ASmNQ/QNQYo3ftEDYCtHjCn+SjycAnHyUIkrRJhX6tTvw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3c3664-1092-44ea-2bff-08d6c2824c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 15:43:40.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
I have tested the patches on NXP platforms and they worked as expected.=0A=
=0A=
Diana=0A=
=0A=
On 4/15/2019 9:45 PM, Greg Kroah-Hartman wrote:=0A=
> commit cf175dc315f90185128fb061dc05b6fbb211aa2f upstream.=0A=
>=0A=
> The speculation barrier can be disabled from the command line=0A=
> with the parameter: "nospectre_v1".=0A=
>=0A=
> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>=0A=
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>=0A=
> Signed-off-by: Sasha Levin <sashal@kernel.org>=0A=
> ---=0A=
>  arch/powerpc/kernel/security.c | 12 +++++++++++-=0A=
>  1 file changed, 11 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securit=
y.c=0A=
> index bf298d0c475f..813e38ff81ce 100644=0A=
> --- a/arch/powerpc/kernel/security.c=0A=
> +++ b/arch/powerpc/kernel/security.c=0A=
> @@ -17,6 +17,7 @@=0A=
>  unsigned long powerpc_security_features __read_mostly =3D SEC_FTR_DEFAUL=
T;=0A=
>=0A=
>  bool barrier_nospec_enabled;=0A=
> +static bool no_nospec;=0A=
>=0A=
>  static void enable_barrier_nospec(bool enable)=0A=
>  {=0A=
> @@ -43,9 +44,18 @@ void setup_barrier_nospec(void)=0A=
>         enable =3D security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&=0A=
>                  security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);=0A=
>=0A=
> -       enable_barrier_nospec(enable);=0A=
> +       if (!no_nospec)=0A=
> +               enable_barrier_nospec(enable);=0A=
>  }=0A=
>=0A=
> +static int __init handle_nospectre_v1(char *p)=0A=
> +{=0A=
> +       no_nospec =3D true;=0A=
> +=0A=
> +       return 0;=0A=
> +}=0A=
> +early_param("nospectre_v1", handle_nospectre_v1);=0A=
> +=0A=
>  #ifdef CONFIG_DEBUG_FS=0A=
>  static int barrier_nospec_set(void *data, u64 val)=0A=
>  {=0A=
> --=0A=
> 2.19.1=0A=
>=0A=
>=0A=
>=0A=
>=0A=
=0A=
