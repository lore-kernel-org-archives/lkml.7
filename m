Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C25C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426C720B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZyOEmTY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfJIFqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:46:07 -0400
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:48035
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729734AbfJIFqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLR62fzqteT4EwNO91OjGB2N0IIrXqfOh6+5ocZ9iM1kd9Y08MN03vhWo1g9KrV27FqqU/BG8llwbyUU4A6Zm2ZOY5kb85IkIX3qD43faaGQmObfeXgofPEK7Aui5aj7N06UymRqY8/L6Gt8+H3ZCuXbRRhek0Tss+PwsLjgtzEKUDe/qDqyELJMVqvibi9EubMi/dbZAI9+PGh7hmf7Zv4K1qlpXk9gG+xmFI9FW/CHjIiFDZZD7lYPdU+7BwZSG5DebnCdsvX+3X5s+0xeNArnZli+vS0v9lJ/mfsTOBSEJ8R1/By7NdLBMSf4c2SOMdFpbyLjkzaOeOr6zVHFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzsjWajiuMl2pbfa8vOlRdEaUkEfeFk+cRpuDwDZa+I=;
 b=BNZgVw7Blu5ovtkK/RfQ1FZGw8BDmh94JRuhYC5U0YaCmvsnyotruVWtC/NLncZSfXRMxrVQAWswsGqCtc2w3Wtee2gU4MjQafeb2ByjtNmFPSEH08fXQw81HnqUlqClIkRHAgwE4tEGLQbHAPoCdYJyoNywAYiwiAUIaysfGLnF67iAWWTlSwRU+IpCvhXH0CkoujOWaNWkFo8dIqL+95XkKASEgLlQj1RSw0+6BNw0BZN17orfF9JwoH6WFiDg04s48fSdY8nyefG4i9v+ZHSnlT9MBJzFKAkMG8Fs8rq7l3pcb4CK+SqloOxHnUcj1KND4D/VWkfF3nEoV7+tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzsjWajiuMl2pbfa8vOlRdEaUkEfeFk+cRpuDwDZa+I=;
 b=ZyOEmTY2oJsddaYPCh+GlMSbZO0/Ojz6atL/GTJ3ZvgGhV07PNceeiQ0+H3mvg4hF8q1/I3ZbYVhOGWRpUJFMihX0xu/4UOUcluHOQc0/z7J9umttDsZe5papmXPgVsLURLvLVJOwM93W3C2QIVdg8WFQHddXdkp29RbZ0bVDvw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6180.eurprd04.prod.outlook.com (20.179.34.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 05:46:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 05:46:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "srini@kernel.org" <srini@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: RE: [PATCH] nvmem: imx: scu: fix dependency in Kconfig
Thread-Topic: [PATCH] nvmem: imx: scu: fix dependency in Kconfig
Thread-Index: AQHVeH5AAFLd9tyLJkG68seucRSNAadR2I1A
Date:   Wed, 9 Oct 2019 05:46:02 +0000
Message-ID: <AM0PR04MB44812421FF0082E1927E818488950@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20191001173232.18822-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20191001173232.18822-1-srinivas.kandagatla@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 678739f4-0174-4122-2ef9-08d74c7bf85d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB6180:
x-microsoft-antispam-prvs: <AM0PR04MB61802BB84A329BB193E943A788950@AM0PR04MB6180.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(51914003)(199004)(189003)(81166006)(54906003)(81156014)(74316002)(66066001)(102836004)(110136005)(7736002)(4744005)(256004)(8936002)(52536014)(305945005)(71200400001)(5660300002)(71190400001)(8676002)(316002)(11346002)(14454004)(478600001)(7696005)(446003)(99286004)(486006)(476003)(76176011)(6246003)(9686003)(2906002)(55016002)(186003)(86362001)(33656002)(6436002)(44832011)(229853002)(6506007)(4326008)(3846002)(6116002)(25786009)(76116006)(2501003)(66556008)(64756008)(66446008)(66476007)(26005)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6180;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03DpfO3bxLxWL6tiYxEFiTz9mHaYHVaE+zuuSxEwVxZBmX18ZiPMYjDU4ZV5T0ZydF6C16GOqDC4vkE4zvOPQwd3MDK383h6ji6ASdspkfHLDSK6dNlOnXZXrdKNKMp7byffDsgAk3HlsGZ18VgJBSfoJQUiFx7rnJ0GoeMMGZf8fwfdI+GEnFKFbhwAE04aofCO+hsZWr2g9St1D6sTWv+bQk8vGHB1CSKwTEF1pTzhwzHOHuSTrXxQDARqvUjaizYExsyAMs1m2qkrNhTTESBcodBXaj/GLxNW4PvNUNRNESf5uEgqBIlyrOkOWU6XU6hOvd8DKz4f5s9uknIIT4FG8j4Yh/DgD4iSXRXBGy6TI0DheKG3u5D8118ZoQriYSNY7x8CDkNoaPpZRxInMtEJ5J8/mlW9ZQESEHfDnN0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678739f4-0174-4122-2ef9-08d74c7bf85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 05:46:02.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mc6DeVGbiL5vmH8IfuNq58MJGwJj3B14JjgRFDMqJknIGzbGXPZZJ2LwmoH7dN38WaF8AvEHSKXs7Y7nfuzEbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] nvmem: imx: scu: fix dependency in Kconfig
>=20
> Fix below error by adding HAVE_ARM_SMCCC dependency in Kconfig
> ERROR: "__arm_smccc_smc" [drivers/nvmem/nvmem-imx-ocotp-scu.ko]
> undefined!
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig index
> 8fd425d38d97..fd0716818881 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -50,6 +50,7 @@ config NVMEM_IMX_OCOTP  config
> NVMEM_IMX_OCOTP_SCU
>  	tristate "i.MX8 SCU On-Chip OTP Controller support"
>  	depends on IMX_SCU
> +	depends on HAVE_ARM_SMCCC
>  	help
>  	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
>  	  available on i.MX8 SoCs.

Thanks for the fix.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.

> --
> 2.21.0

