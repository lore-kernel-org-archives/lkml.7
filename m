Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA66C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4782071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OB6J+IPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfKTQwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:52:02 -0500
Received: from mail-eopbgr730058.outbound.protection.outlook.com ([40.107.73.58]:60672
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728314AbfKTQwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:52:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPPw4Z6hEKYGPq6k76IM4X2BfARJky8FJ4d5SbX1udcU9kzkMLkAlxwkOYvahg+JyO2Q2jvaXRicqBpXz6MyGuu96UPe4t+nOMnbom+nIxv52NmdZzieyYvC+p4czhIOmLtYxSEy6Y5OghqWIPs89UH/EG6+p+MgWKtFTaAVK9Kbea0Uwzbscw3HT022C2JZpdchycAWVX9pS6Gsn1dJJlF9vpIEd/MQ5e5diCr2VHH+40BktU9xgMHjfVXSIWquqVz3s1uAo2gHKqoJUax7KG0GbvWUCCn49LykgaBaXPx2Qw+iKZLjKc+0i4XaD9Wy/ysnVXL5SlWr/upeDNRrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thFrq2uC425RbwQApO4noTMRO3cIYXGjW1vhMIrLfdE=;
 b=QCpuPt3Cxuu/kMWvBfI9P6SYGQKpW7LTruHkK75v+lkT1VSdqc4gBW2jBC7TszVjvJCDsc13n2j+VAehhpxWYZZQnUQWmA5WwhZWBhJZTfPPnhCcyilQmNVMwzyA/IRw05NdGPf2pkXrw2eV1ELMv8BaAalYW2JlLjJiVr6pgYbcyduvKLWAXfXaVKfdCc00MK0Nu41jFbSKJcd5zHP9emMP5ouLsYWPf7w7WusG8Wfprxf0Dq6gapOwEPAwF+8Um8O/uuQ8K3bGg63i7OmBFggZBryCVYnSfXoeTMxGjukHcRjiRskm9bGF1acesp5wbCfHlC6SYuJ6TtBpi+20Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thFrq2uC425RbwQApO4noTMRO3cIYXGjW1vhMIrLfdE=;
 b=OB6J+IPbkhVwjzoAAC2Ob9zcDp3rYF4Txv2pixAMoXHLhGmOBxoahYVSBRQAdP4P5KKKj888dNqJ3n+Q/gcRd6gSGP2fCMD3fEiXi2yJBko651O5MVvpWwMkgqdQYWkx5eG+JozkzNi5R+VLE3s5YUYHJ6un4/o3ItFfD4ZXd9E=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB7045.namprd02.prod.outlook.com (20.180.11.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 16:51:59 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 16:51:59 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Derek Kiernan <dkiernan@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] misc: Fix Kconfig indentation
Thread-Topic: [PATCH] misc: Fix Kconfig indentation
Thread-Index: AQHVn6gmBH3T0s6ZdkikOAV1Uu5hCqeURYTw
Date:   Wed, 20 Nov 2019 16:51:59 +0000
Message-ID: <CH2PR02MB63595AD1DC283AB0E09B72BECB4F0@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20191120134056.14677-1-krzk@kernel.org>
In-Reply-To: <20191120134056.14677-1-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41b8b598-3764-4e80-ff6d-08d76dd9f59c
x-ms-traffictypediagnostic: CH2PR02MB7045:|CH2PR02MB7045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB70451AAFACF52F38102EED61CB4F0@CH2PR02MB7045.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(13464003)(199004)(189003)(54906003)(26005)(186003)(256004)(446003)(53546011)(6506007)(102836004)(11346002)(4326008)(66066001)(2501003)(76176011)(6246003)(76116006)(486006)(55016002)(6436002)(229853002)(7696005)(81156014)(81166006)(3846002)(6116002)(52536014)(71190400001)(71200400001)(74316002)(5660300002)(476003)(478600001)(8676002)(14454004)(8936002)(7736002)(9686003)(305945005)(33656002)(2906002)(66556008)(25786009)(110136005)(316002)(99286004)(66446008)(66476007)(66946007)(86362001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB7045;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +smWHWwY+bSplQ8KMHOMNvyK7mgAPCuqMwpFNsVtrrpfpXryUHYDUD66XcO8nGSiBvgfcjwnqnsuyuO1l0tbpxfSlghTCo9L5Ad8FsXEMJXJrxSCSUvha7qHfX3TmWAFZbNZfaHqDK+wGEOIseDdda5qCr/jLkZd4V4PPHUeOSsgb5U/Ez2aPdiIfG3LTDMLCdsasF8Pe3SUX5SDHREsVDJv+j05YUJp9Vku+8yPCK3M96VN8/8iDfxSGyNMWLtisGqX4NrQKZZQ5/rWzY4Ctr8SWLjXUhr5cZNjvONz4MWEGmKq9V7wy8butlhPHBvsCO43gN8YNxOTawIDXtlKido8WpMCJfDwJYaDupLJkjsKnh9hnZacssuPkvzFuhOZZKCN4fKSbsnGElfJ6nlEfxtGUtACMhS5QeNof5bLkeFfjWT9YSKndW+gLwy1qE/x
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b8b598-3764-4e80-ff6d-08d76dd9f59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 16:51:59.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vz8TSE78qhtDx9MHg0VwQrdxOU0CdPlXClKTxR2LOhcPvrB847xzvfPpDvC08MH/Ae7ThqAfvGPMISmRzbSDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

This patch is not for SDFEC driver.

Regards
Dragan


> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
> Sent: Wednesday 20 November 2019 13:41
> To: linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>; Derek Kiernan <dkiernan@xilinx=
.com>; Dragan Cvetic <draganc@xilinx.com>; Arnd
> Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: [PATCH] misc: Fix Kconfig indentation
>=20
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/misc/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 94b14abb5404..b93757efb058 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -338,14 +338,14 @@ config SENSORS_TSL2550
>  	  will be called tsl2550.
>=20
>  config SENSORS_BH1770
> -         tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
> -         depends on I2C
> -         ---help---
> -           Say Y here if you want to build a driver for BH1770GLC (ROHM)=
 or
> +	 tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
> +	 depends on I2C
> +	 ---help---
> +	   Say Y here if you want to build a driver for BH1770GLC (ROHM) or
>  	   SFH7770 (Osram) combined ambient light and proximity sensor chip.
>=20
> -           To compile this driver as a module, choose M here: the
> -           module will be called bh1770glc. If unsure, say N here.
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called bh1770glc. If unsure, say N here.
>=20
>  config SENSORS_APDS990X
>  	 tristate "APDS990X combined als and proximity sensors"
> @@ -450,8 +450,8 @@ config PCI_ENDPOINT_TEST
>  	select CRC32
>  	tristate "PCI Endpoint Test driver"
>  	---help---
> -           Enable this configuration option to enable the host side test=
 driver
> -           for PCI Endpoint.
> +	   Enable this configuration option to enable the host side test driver
> +	   for PCI Endpoint.
>=20
>  config XILINX_SDFEC
>  	tristate "Xilinx SDFEC 16"
> --
> 2.17.1

