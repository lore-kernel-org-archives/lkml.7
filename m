Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q/rO5tDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHVX2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:28:34 -0400
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:55267
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725710AbfHVX2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:28:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqDr06FcpSyuoAqawA9pkNNi/c1YzVOGm/KGbot1TzDezgkDJSZ30iPTSGCGC8SlG74CSURzRtfEHhOk/OPskLquL5djVaJ8khrKr+KH/isX/yvPFZh+F+F549nlTiksqGGfgCKmxJndGiTv+dkcMTfKuGz9mP4mEpe5H5VNvTUT8SuV5yZyQViTPw4yvMjGBA8CRrQmdgOy0v23GDN+PBNf1WjTzUoMCvopfL+v3Nm1Pa3tFFZ9rPDscAGRyqWF5sDeBJCMIw4VBFmKSNdD8A1RPhN5/L2X7qj/4UdSzuuoFs2SMGXwPy1yBjpYu1sgdQtosKGlLKa6A6mID9pqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKGezJuiDZGt0BOthMbkHp+PTJEtwD8fgj/9Mhb3JYg=;
 b=ZvmQAYAkFZbbJGwfApJOHQfvPnzAD9V/mS2sCkmhF4SfrQnBF53yq1z46v31sRn41BnpaAsR7jGHjv61Y1kXZ1QL1X+rq7td4hMTmLhdO+LnziR/oho1bJfdIvkQ/yoqC5QbB/T/gh6roYKTfYXVyyU1+L+prLWixBsy5QoIilDqQmYv5P+GNyrP1tyuP/1c8xmL5uaDli3oEvHvczGm2iLDHW/0BRQGyk7L8ueDyK+8Xh1YwrvpQMHD/7k/q4MhdwKpcT64OSNXrhzLLkNfIVIoV1Rt56aQWLTsjGVt7wRaIh9WFqVQ++6MEIbBs6TF69wQDjBS2dPV+A9z1dFWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKGezJuiDZGt0BOthMbkHp+PTJEtwD8fgj/9Mhb3JYg=;
 b=Q/rO5tDtYcODFuHFzMxzk1kSC4RcbnL+Lw4oOFCGc5Ikl9TcrAqrzhQ+dmupbCX3S85Zhf76WCHrtGA/4ONVmeIqqSPNLmdPBd/PMqSF5b0P60B2aw5zwH0H8uQLiu7z+5H3kxdb41Ghopum5f82IKYy6crfPK3dDcxaAasLC8k=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5757.eurprd04.prod.outlook.com (20.178.127.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 23:26:47 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 23:26:47 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH] ARM: imx: Drop imx_anatop_init()
Thread-Topic: [PATCH] ARM: imx: Drop imx_anatop_init()
Thread-Index: AQHVR8oGvyTNCOZoFU6BqtEMTuzaog==
Date:   Thu, 22 Aug 2019 23:26:47 +0000
Message-ID: <VI1PR04MB70238747C8EDB6C9A67700A3EEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190731180131.8597-1-andrew.smirnov@gmail.com>
 <VI1PR04MB7023AE3910B261877892EEABEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHQ1cqHBzFi80ZCa+jgs0Qy=dMP4yP7am1x-hMTxzb-8Zpok0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:e6e7:49ff:fe63:c221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171616da-cc11-4dd0-d6d8-08d7275833e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5757;
x-ms-traffictypediagnostic: VI1PR04MB5757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5757EA71ED054958E4F71731EEA50@VI1PR04MB5757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(33656002)(71190400001)(71200400001)(316002)(4326008)(54906003)(486006)(5660300002)(102836004)(6116002)(446003)(2906002)(186003)(229853002)(305945005)(6916009)(7736002)(99286004)(6246003)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(256004)(14444005)(86362001)(6506007)(44832011)(74316002)(53546011)(52536014)(6436002)(7696005)(76176011)(9686003)(8936002)(81156014)(14454004)(55016002)(81166006)(25786009)(478600001)(8676002)(46003)(476003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5757;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v9Dn0mLju8xBgHX3MZrKtGY38r1EbrFojW0X1dyrmIEaaO1XEjXGCiLEM4sGjQbdDIrFYimF7lWak4zJDgWqV70zwnXkaqoI406kjeikEGRFXvVomXcxO/dzh+d/2/hGQh/fLQuPqttiKrhh0PiLyrQqoKuI3JeuaLW5KoK4EcBOqhMY/V2PfedgG27gV3ApxJ+cs+X+LvI5e4etakqahgWY6EcC2kL/w52AFClTeq04iqSUYEhln0yF4aGv2I8DWPfgsI3Fl3xB4o+ooqSujBrB1a0LD3sF51rnKEl8twguowz9Gl+mdNKcgFOh1RTYFivZ2Y8XxIt8py6iH3246QbRUyPmZOdldvKpBLx9sR0yfdiQ6UzOiCDeqJrOTiQZxJSicmfHt+YtcE6ufQWU3SGYFp0mg5wYAZPo4WhZplY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171616da-cc11-4dd0-d6d8-08d7275833e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 23:26:47.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqVlbPRZrPvjftyA/lOb/8h8F8lpwSenl3+oXIVITuetYEI1VlDXvce8w7ccUGORHkmvSyxqjiz/AdK6gFXMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2019 23:06, Andrey Smirnov wrote:=0A=
>> On 31.07.2019 21:01, Andrey Smirnov wrote:=0A=
>>> With commit b5bbe2235361 ("usb: phy: mxs: Disable external charger=0A=
>>> detect in mxs_phy_hw_init()") in tree all of the necessary charger=0A=
>>> setup is done by the USB PHY driver which covers all of the affected=0A=
>>> i.MX6 SoCs.=0A=
>>>=0A=
>>> NOTE: Imx_anatop_init() was also called for i.MX7D, but looking at its=
=0A=
>>> datasheet it appears to have a different USB PHY IP block, so=0A=
>>> executing i.MX6 charger disable configuration seems unnecessary.=0A=
>>>=0A=
>>> -void __init imx_anatop_init(void)=0A=
>>> -{=0A=
>>> -     anatop =3D syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop")=
;=0A=
>>> -     if (IS_ERR(anatop)) {=0A=
>>> -             pr_err("%s: failed to find imx6q-anatop regmap!\n", __fun=
c__);=0A=
>>> -             return;=0A=
>>> -     }=0A=
>>=0A=
>> This patch breaks suspend on imx6 in linux-next because the "anatop"=0A=
>> regmap is no longer initialized. This was found via bisect but=0A=
>> no_console_suspend prints a helpful stack anyway:=0A=
>>=0A=
>> (regmap_read) from [<c01226e4>] (imx_anatop_enable_weak2p5+0x28/0x70)=0A=
>> (imx_anatop_enable_weak2p5) from [<c0122744>]=0A=
>> (imx_anatop_pre_suspend+0x18/0x64)=0A=
>> (imx_anatop_pre_suspend) from [<c0124434>] (imx6q_pm_enter+0x60/0x16c)=
=0A=
>> (imx6q_pm_enter) from [<c018c8a4>] (suspend_devices_and_enter+0x7d4/0xcb=
c)=0A=
>> (suspend_devices_and_enter) from [<c018d544>] (pm_suspend+0x7b8/0x904)=
=0A=
>> (pm_suspend) from [<c018b1b4>] (state_store+0x68/0xc8)=0A=
>>=0A=
> =0A=
> My bad, completely missed that fact that anatop was a global variable=0A=
> in  imx_anatop_init(). Sorry about that.=0A=
> =0A=
>> Minimal fix looks like this:=0A=
>>=0A=
>> --- arch/arm/mach-imx/anatop.c=0A=
>> +++ arch/arm/mach-imx/anatop.c=0A=
>> @@ -111,6 +111,12 @@ void __init imx_init_revision_from_anatop(void)=0A=
>>            digprog =3D readl_relaxed(anatop_base + offset);=0A=
>>            iounmap(anatop_base);=0A=
>>=0A=
>> +       anatop =3D syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop"=
);=0A=
>> +       if (IS_ERR(anatop)) {=0A=
>> +               pr_err("failed to find imx6q-anatop regmap!\n");=0A=
>> +               return;=0A=
>> +       }=0A=
>>=0A=
>> Since all SOCs that called imx_anatop_init also call=0A=
>> imx_init_revision_from_anatop this might be an acceptable solution,=0A=
>> unless there is some limitation preventing early regmap lookup.=0A=
>>=0A=
> =0A=
> Would making every function that uses anatop explicitly request it via=0A=
> syscon_regmap_lookup_by_compatible("fsl,imx6q-anatop") be too much of=0A=
> a code duplication? This way we won't need to worry if=0A=
> imx_init_revision_from_anatop() was called before any of them are=0A=
> used.=0A=
=0A=
It's only used from pre_suspend and post_suspend, everything else in =0A=
arch/arm/mach-imx/anatop.c is static. Doing a lookup every time would be =
=0A=
silly, it's fine to let this be global.=0A=
=0A=
I was wondering if maybe imx_init_revision could somehow end up getting =0A=
called before syscon/regmap core init.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
