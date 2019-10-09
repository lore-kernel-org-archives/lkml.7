Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE2C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160B02070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jfey/RUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfJIC2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:28:36 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:13379
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfJIC2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:28:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npm01p7ID+kf8WrtlNxcrIqYhMd8oUD5x9W+UJ/kh70h2RINP+3rRW0NPZAmEZZmPQ1ZM8HM/pvA3CIsBE6zlTRzpjWkllIZh/hwsGzW2WUICspYyTcs5TNIke4nX8j+2x9EdsVwb1CY+cBy5M9mIxSOE3MdipYgBvVkfU/vygS/yUEZQdRa4o1VRx/HiDcP5JT1AJFqLPYMVsuWtpbTblvwIbqAI2ffPshMjjFZ/wI7aRE95/y+XI0GeUm1zazKzh49rXyyjMlXmIga76jpbcqyKlkzqhhBULPrwqtL2KyTAOKPDOcCfTFaSKuODZcuvGVo2LnDympDcoCWRo7ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5WEI/TlYv+OWpJGItC85RQvnEpV7LOb+ccGbt0aEs4=;
 b=agYAW5jk9tE6fdLvkg45gybzh09zLTEjzfXteW5Y6YGCAbO0WOJzsTH2gmVt9nNO6CUcqMFF5j8vObpsAm8R3Dm8xDaSwcvmXAXh1u8ZX5w3uAgjDrLD15XFIygznYDZ7WZH53EkcvYMyLYNku1sWB+ePwYRHQPbyi+GYRXYVzVVfRHN3MSBqbkr2Q0g/0gTvfa63N/n4RH+XZaB9QlY/2/AWiCzTahzJDuXn2cyWyHVApNTyJ/riECvkaZoIP40aqd6ZYvu4S6emOpaYCgLWqCd26LIXrXAQOpw6uO1boK9LvMsF2y5zYoZRBv4mGQkzsnnBMGSru++UCT28Jpwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5WEI/TlYv+OWpJGItC85RQvnEpV7LOb+ccGbt0aEs4=;
 b=jfey/RUeOIHxrGCebMLKgSV0XicqEA6dHtw0qfwTwhhpJcWlfUv8aA2poK1k8RifiAGGZhlbGhcpsFDSmn+aIHo6gFPtqOfafplrqjUwd8dzZpFrsuBD1QvRFJ9RnthjtC1XjuYb+yx579ZLMBVmNC8l8E4fIXoIvgD2rtskfUY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB3198.eurprd04.prod.outlook.com (10.170.228.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 02:28:32 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 02:28:32 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Topic: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
Thread-Index: AQHVfNoJ++ECtmBATUSOETiOVkdrz6dQUUWAgABlUYCAAOIegA==
Date:   Wed, 9 Oct 2019 02:28:31 +0000
Message-ID: <20191009022815.GI5670@b29397-desktop>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
 <20191008065619.GE5670@b29397-desktop> <87a7abv1f2.fsf@gmail.com>
In-Reply-To: <87a7abv1f2.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daf0d558-640c-4ded-f821-08d74c6060c9
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB3198:
x-microsoft-antispam-prvs: <VI1PR04MB3198723E052236A40E616E2F8B950@VI1PR04MB3198.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(66476007)(66556008)(64756008)(66446008)(54906003)(186003)(66946007)(5660300002)(86362001)(102836004)(305945005)(7736002)(6436002)(6486002)(66066001)(476003)(9686003)(6512007)(486006)(446003)(11346002)(91956017)(316002)(6246003)(44832011)(33656002)(4326008)(26005)(76116006)(229853002)(2906002)(1076003)(25786009)(71190400001)(71200400001)(81156014)(53546011)(6916009)(14454004)(76176011)(14444005)(256004)(6506007)(7416002)(478600001)(8936002)(8676002)(99286004)(33716001)(3846002)(81166006)(6116002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3198;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nASzDPMnNgzJPv2p/qGKVPacyX8Rb4B6CxH1weSGtOQ/1ycIGlVS9CQ/c+zveOO7dxxFwLih9CuqV1cAc7KKkx3OBIom02M6vB/lAErzX4JngWrQq2nVSO3HtGJw7cFu7qT5GB4+6Xeh07SHzC/NVIIOlvmcKQG6N6hP6eRMLJw6Eq9Y/7KdA59gESIwPrVfRU74qcM3AINOyd9XQRO0qwDIWtTsXnNlQ16qW3pgPsaIAUpjp0IpsQOBPsE/yC37ThW/9JEhY4k93YbV4vbL/9FAFBZF6FUaS7RJhb/GGlMlAgYF3g4NzpIU4x272QoGH3R2MlEIAB+jK93eVfNvbspRDpS8PhA02VZMl4EtJfR1JbODzDyM8/CdXfeKsNt9JzUq63dILxRRNV5OE/O8hwhHE21eYzpm7eXh9dYYY7U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44072C5C5C95F541BD4D0C19BD176C39@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf0d558-640c-4ded-f821-08d74c6060c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 02:28:31.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvkGGTWgBonFUv38Z73+C41ShHHp/Qj8MFDQ4UyNEL55DXuUPEBF5mAsZTsrADtgCTHAQfv9SMPTT3ePffBEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-08 15:58:57, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Peter Chen <peter.chen@nxp.com> writes:
> > On 19-10-07 07:39:11, Pawel Laszczak wrote:
> >> Patch fixes issue with Halt Endnpoint Test observed
> >
> > %s/Endnpoint/Endpoint
> >
> >>
> >> during using g_zero
> >> driver as DUT. Bug occurred only on some testing board.
> >
> > g_zero is legacy, please use configfs function source_sink or loopback
> > instead.
>=20
> We still want fixes for those ;-)

Yes, g_zero also uses source_sink and loopback, we just suggest the user
configfs instead of legacy modules.

>=20
> >> Endpoint can defer transition to Halted state if endpoint has pending
> >> requests.
> >
> > The implementation of halt handling is a little complicated, you may
> > consider return -EAGAIN for functional stall through usb_ep_set_halt
> > from function driver if the requests are pending, it doesn't need to
> > defer such kinds of functional stall.
>=20
> -EAGAIN, IIRC is only supposed to be used for IN endpoint stalls.
>=20

Yes, you are right.

--=20

Thanks,
Peter Chen=
