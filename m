Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8980CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFF020867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U61crKF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbfJYDN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:13:59 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:4434
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391987AbfJYDN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuiDbnTlplcEAsL/+Cqwm9VTRsG1jzmQlu7CcM6vVnB/SRxMz5MlieibXv/w3BSY7oqBhndkjWpxrG9SZ4zNs96VKmZR6UIlO7omjJOltn/5yZHPJqv8rwI4LzlgdFDZKLa4y6VOz6wpefuKwUQ6hJqdnGYTNTPCrjEjXooYW0XcrUrRvRsRDu03R3WDrcYkSCGaXVEvoAoAx+iTv+7BlCDLaeMZq+B3+cc5n3jSkmvt3DjS31NTGevoRM4woNt6KEq4iNnZpHL37lFe1l+vFLK75W0UH44UJUa3ICewq6upqSQezB9vvjAqdL+wSCmDUmKbZ9FAVEE7Z685AQLXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grUJUlgj5/Db6iMX81Vp7dEE8np1Pq+4rlUmyolSJcs=;
 b=gPP6dC7BlfBZFF5ZsfhwFk+t9HeGKM8CczsbJz1eGP1Etz2fm2rOvqcdAf1HI3qfTbA+noenbL6vlZTVbDRN2wIn+E/ZnoeamkZrkNvWDiJVSlhTipHE6qW1PuvDl85zCcoDLBcTBe3DRHnvRv3dHpkkd9p8bcNeQnI5FJSvDlQkBfhZhg4X+xZVTYPMlLjf4JUsnfYEo2989XLDgnFu5Nxa8LDxoZeqZ69/nWrFq1hlkDK9f0SrHHXbsHb5d/kJVtZ2gMz3Hf9u/4P1eYlPTh+MTmahOjAPOX7XTP61dIz7ne3gTzrzOQMMF+NlvHCwbsPFzIgpTWAGpk1iHg3b9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grUJUlgj5/Db6iMX81Vp7dEE8np1Pq+4rlUmyolSJcs=;
 b=U61crKF3vRsvDUzEtN4waZwQNzANd/oNL4IdFqAimnlPU1bKEU3GghsyaFnB+KCGfcvfddvGYmK8I3Tsb6q4/V3eB5PYwU12VtOD9qKf2CF+AFWj5Ynjz1Kp6X/qf1m4TyXtE/bFU2tHfbToQZ8pysydGK/zV5RsyfMIUyXhcPA=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB3966.eurprd04.prod.outlook.com (10.171.183.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 03:13:55 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 03:13:54 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Topic: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Index: AQHViYCigHhLS+QXN0CJz1D+9q4PbKdn8nSAgAK+9IA=
Date:   Fri, 25 Oct 2019 03:13:54 +0000
Message-ID: <20191025031343.GA13392@b29397-desktop>
References: <20191023090232.27237-1-rogerq@ti.com>
 <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6887b738-7b52-4303-e213-08d758f95e5e
x-ms-traffictypediagnostic: VI1PR04MB3966:
x-microsoft-antispam-prvs: <VI1PR04MB39663FD17B5248EF99371E438B650@VI1PR04MB3966.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(476003)(66946007)(66556008)(66476007)(66446008)(76116006)(446003)(64756008)(91956017)(33716001)(2906002)(486006)(7736002)(6512007)(11346002)(316002)(14454004)(6486002)(3846002)(6116002)(33656002)(25786009)(44832011)(9686003)(229853002)(305945005)(54906003)(6916009)(81166006)(8936002)(8676002)(478600001)(4326008)(81156014)(102836004)(86362001)(6246003)(99286004)(76176011)(66574012)(1076003)(186003)(5660300002)(66066001)(14444005)(6506007)(53546011)(6436002)(256004)(26005)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3966;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +h9yFB4wPPT7tnIidnyi6DPLbw4EBu4RTtUrtbdBKhxqhhLyAJVvjHiCSb5zSA1r191KvrE1EMecZ8PlSxk3bHZhlr9vKDDooHBlMuRtiv0NoZBUpcjOePU276qh8viOTkMQcKT3BmLRp4AEFHsUNsLyETM/ygM/BmYsvBcuhCCNQpu9HPICLtn46qx0iOosVkhTmeGUumzYHwxuplRj2qtuwJZjUKTnGsyNvjpyZm8o3ciOYkiqWee59OoAr8Lm/NklkC8C2xPJ3RpIwptDdCV7UWBxdjHyl+k2UbJWgiI6RBIPcrS9xNZudXUvjOuEmSmgbYbObGH29rHLrIn1G9Td9sNKro0BnnlgTXR1o8hh57pS5U8s68muJ0zdyuEc4v8KXSAzPvWFuAD1T9V9pF2RiRvGjvAonnrcqpS1UKiKybkLJf4jyHavPZwsyBbA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB5B58989835C5428788BF3A068EA261@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6887b738-7b52-4303-e213-08d758f95e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 03:13:54.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHAKWQwZsGeNQMhxggBz8NfzxjcdI2/PKqTIaHVLAnlrxfJ/9PrOBfYf/EWejBFL4v1jPNIuPWuvMiQZA5rzig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-23 09:17:45, Pawel Laszczak wrote:
> Hi,
>=20
> Reviewed-by: Pawel Laszczak <pawell@cadence.com>

Hi Roger & Pawel,

Assume gadget function has already enabled, if you switch host mode
to device mode, with your changes, where the device mode will be enabled
again?

Peter
>=20
> Regards,=20
> Pawel,=20
>=20
> >The USB gadget core is supposed to manage pullups
> >of the controller. Don't manage pullups from within
> >the controller driver. Otherwise, function drivers
> >are not able to keep the controller disconnected from
> >the bus till they are ready. (e.g. g_webcam)
> >
> >Signed-off-by: Roger Quadros <rogerq@ti.com>
> >---
> >Hi Greg/Felipe,
> >
> >This can be used for -rc as it is a bug fix.
> >
> >cheers,
> >-roger
> >
> > drivers/usb/cdns3/gadget.c | 4 ----
> > 1 file changed, 4 deletions(-)
> >
> >diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> >index 2ca280f4c054..714382d96055 100644
> >--- a/drivers/usb/cdns3/gadget.c
> >+++ b/drivers/usb/cdns3/gadget.c
> >@@ -2324,8 +2324,6 @@ static void cdns3_gadget_config(struct cdns3_devic=
e *priv_dev)
> > 	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
> >
> > 	cdns3_configure_dmult(priv_dev, NULL);
> >-
> >-	cdns3_gadget_pullup(&priv_dev->gadget, 1);
> > }
> >
> > /**
> >@@ -2708,8 +2706,6 @@ static int cdns3_gadget_suspend(struct cdns3 *cdns=
, bool do_wakeup)
> > 	/* disable interrupt for device */
> > 	writel(0, &priv_dev->regs->usb_ien);
> >
> >-	cdns3_gadget_pullup(&priv_dev->gadget, 0);
> >-
> > 	return 0;
> > }
> >
> >--
> >Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

--=20

Thanks,
Peter Chen=
