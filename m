Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CBFC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D8920830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdxRzeV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfILMpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:45:04 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:55214
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731639AbfILMpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:45:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuWd3C6tyXQ9LkHDjp1Q0wTi1HTcQBZlgIiuc/dtNENiXzE1YWdRGnQxlrnrrMP3L0msIiCJHJg1i+gJqxRQ3bWHZO5GZhcw6QzrsWIPOK2mJUUE6sX6Otl8i88UAD2/+b67TwBuPu43y7whqSwk3ioVK+ra6q7u/QJ+aGv043jPKNTxgxrzoYw4r31XBEmDpYGg2kXfGqhf3RAbeIBpAZTjbLmLCPM1t/01eugSvYUwKoFF256Q6+2ymZCnzO/7K/I9u2MePiQ1yzj513nZZDAf//zuVzYBjBWogETK5HhKwXG0YkxL2DrhahNkbnyp3ESR+xQSSUAcWcNHqJ0fmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGahAQxc2HkHtNbbTjxT9uc/iUTyMjrYFAOCcQhnSN0=;
 b=a2QgXC1q7ylEdun+w5A27QFfiegpMgmyr1cYijoeQcq/rJulds36jmSnKLxYCEB6HCjnmOZJAbJwIM/pmW4Ds/0nfZddEaafnF/XDs6fzn1jIcJadZMbkta9imPUaepopnXIKCkbP0VY58Ds/dgNSfimBJ40IIU9fOkVrCbBnAShyWasbuY3/fB2NXBuPSM/+3+0dvin/dPXODUph7LTzLQwWic9cb0p3nY8WIp5dylUqXHOAtmCqBkoHorisZNnhkzw4qZk89cWfvLs4ggSN4ngSbWthUYP276EDXKmILqJpxw6Gam7HdjwxOPpz7Cqed843Qh6mnT+xq3KWVAS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGahAQxc2HkHtNbbTjxT9uc/iUTyMjrYFAOCcQhnSN0=;
 b=TdxRzeV2HdKRAT//NDMkCn9w54svLd2WFnhVtu2L9E8BBB407qjvLvuv106yftUkf8M4nNKr50PZwtKLE09P6kzwlbMWtEEeucYSiwkju9vy/S0p2ucykWuvcifGsRQFoS096K1M0auUdZ7XUotuB8rVIYlhtUfz+RVxDgceXFM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5998.eurprd04.prod.outlook.com (20.178.123.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 12:45:00 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 12:45:00 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Correct speed grading fuse settings
Thread-Topic: [PATCH 1/2] ARM: dts: imx7d: Correct speed grading fuse settings
Thread-Index: AQHVaRXU/9RJ5I1OdEC5dKjrHftFtg==
Date:   Thu, 12 Sep 2019 12:45:00 +0000
Message-ID: <VI1PR04MB7023E48B04999733859F7158EEB00@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1568256992-31707-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cd2d14c-ff1d-4f38-8a78-08d7377f069a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5998;
x-ms-traffictypediagnostic: VI1PR04MB5998:|VI1PR04MB5998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5998E07225B3E9B88C6B1959EEB00@VI1PR04MB5998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(81166006)(478600001)(6506007)(33656002)(8936002)(53546011)(102836004)(186003)(5660300002)(486006)(25786009)(55016002)(476003)(9686003)(26005)(44832011)(6246003)(76176011)(305945005)(7736002)(74316002)(4744005)(52536014)(64756008)(66446008)(76116006)(256004)(2501003)(66946007)(6116002)(54906003)(316002)(110136005)(3846002)(71190400001)(86362001)(91956017)(66556008)(66476007)(7696005)(229853002)(99286004)(71200400001)(14454004)(8676002)(66066001)(53936002)(81156014)(4326008)(446003)(2906002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5998;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pTDJx+o5Ll5kj6bI4y7/v5TbPj8bWMX2j37CPk42vOZMx6wf5TQXiujl8pe+S1gl4KJYhPHtKIrV62COhjEZqtfReDC2rv27Bkg6CGNgyUmdX6alI8BGD14kEctGO+YLvWQTLdgaFxY3wJ2xXlzoRUBjpvSamY3Qhn9uXCDwJiahhFuR/JGsWGdS6j4pHQh43XqCLx+lgrSOFgekOdY70mOpRVwbxWbIH2hSoi6bFj1YoZU/WNFAuoZ7atvxe1R0GSqWLj/oVtwmDejcEpJfYgptUoHUgTVVJeKo0sgrfzfFCDU8CxMbLFv9QY025r4uzSgWgQAvFqlUOwVT2G26gvrDPcwOOpe7RbaHKlp8CbX+oqY+Rsh3ArSx3Skl1u6y0YoU1WABilJQgklHOde86hPVC+DKDmIumA7zrploxXQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd2d14c-ff1d-4f38-8a78-08d7377f069a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 12:45:00.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wD+9p1umL5y1Dd88FO0V7mlrHwDBLKQ54cYsThwsF8adFU7doAUxBhn69g3kyR6TZuw20FDvYjnjWrSdhMpmfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-12 5:57 AM, Anson Huang wrote:=0A=
> The 800MHz opp speed grading fuse mask should be 0xd instead=0A=
> of 0xf according to fuse map definition:=0A=
> =0A=
> SPEED_GRADING[1:0]	MHz=0A=
> 	00		800=0A=
> 	01		500=0A=
> 	10		1000=0A=
> 	11		1200=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
Are you going to add the 500mhz OPP as well?=0A=
