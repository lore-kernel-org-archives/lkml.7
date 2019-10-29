Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D221721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AaSyTZW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfJ2DMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 23:12:39 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:33348
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfJ2DMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 23:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQdUuI/Ta2644SCAf659Z9fFZMmOdtSUapuuf7zT4ByDcPpmQqhRnNUBK4g5c2l0vl22y9wcn4z4CwMA5TXUu1jmrBqY4jl4pBjG/f1rf2HkxKRAPqzBgDo/nJYIlpddXY4Ku3dn3zaFnvDr0QD535dBTn1hTJlftCkStX9oqZqwgkK14ukr1VFclgfBM8Bf+SvgvGuKCXdUUBG0RR7MkxNeLtlFxgh+t/+4WrQIDI5ka4qlHH/EgDqQzAlIN8TLbhBrLhY/2xAHwBWo36npCuxZT7F7PkLHlzLv7H3CxOKT/AiTtz69LMagFS+ZrX+gjSQQokZ8OLlXx/TdngaX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go9X6OwYSfmKvbnBiQOs0qj0n6FydJbCl5KbX58IJPY=;
 b=Q4O1bC85D8fQvFMJkQclv3QRPknC3v/0tlsQLalWJpIfGwG8tgcAEGCvS14Yh/JgAaf2NARu2iwDLNfMswa+rPmwQoP9U5rYplgFeSfAvY7GriVDbH/vk3TcocZvx1+zKgn6Gd8VBV5MtL+VkwS1b93XPTQZD4sSmCtx/rT01jTIOvq0qMExlZtYF9wvj9dfkEavo4Rj3z2xsCW50Frqbr5hprYTwGqO8JvKoH/mcP9K2JO9yYgZXwR2rcAc/yd8E/5uzTMQ+AsBnhOCN1p0woBHrfF9lkzUNBgFR8jKPVGKvP/DJUuEfWXW+1Hp1GsMI68l4qj5XMGbuQ8Uq66P8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go9X6OwYSfmKvbnBiQOs0qj0n6FydJbCl5KbX58IJPY=;
 b=AaSyTZW//yJQfpwhiWRuLJlzmiap7cHt6aJFV1NC/jpzKBuNcNLZIReTLP4QZ/XPQig3OyPY4NOgYVY7sjse/2oPh6hLJ3TbPI0osgx/5mlu8dLIXMkec40KW7Vq0ylEBJjjH8PWmJc2j1QzwoEucDqHx5mHtLE1SOd/Mmj73Qc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5149.eurprd04.prod.outlook.com (20.177.49.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Tue, 29 Oct 2019 03:12:35 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 03:12:35 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Topic: [PATCH] usb: cdns3: gadget: Don't manage pullups
Thread-Index: AQHViYCigHhLS+QXN0CJz1D+9q4PbKdn8nSAgAK+9ICAAHFQgIAF16UA
Date:   Tue, 29 Oct 2019 03:12:34 +0000
Message-ID: <20191029031223.GA26815@b29397-desktop>
References: <20191023090232.27237-1-rogerq@ti.com>
 <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20191025031343.GA13392@b29397-desktop>
 <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
In-Reply-To: <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcaedf75-761c-487d-f132-08d75c1dd86d
x-ms-traffictypediagnostic: VI1PR04MB5149:
x-microsoft-antispam-prvs: <VI1PR04MB514979F85D3519AD00972FC28B610@VI1PR04MB5149.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(3846002)(6116002)(6506007)(26005)(478600001)(25786009)(66476007)(186003)(316002)(54906003)(6512007)(71190400001)(8676002)(4326008)(4744005)(66446008)(6916009)(76176011)(33656002)(64756008)(76116006)(71200400001)(66946007)(86362001)(91956017)(229853002)(2906002)(66066001)(6436002)(6486002)(446003)(9686003)(6246003)(476003)(486006)(11346002)(14454004)(305945005)(53546011)(99286004)(33716001)(256004)(14444005)(102836004)(7736002)(1076003)(8936002)(44832011)(5660300002)(66556008)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5149;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQkZnlWpV8ea7AU7mvPHkdXgK245evQ8GUjb09ex7YBV9b87ZzNmGHPFs/a7nXWuA/aG7UcuiHP70t/eZZPn/UxWYSgGwkw/SpaqfxvbjlU7G1D5BfWaIJDL/IbRJgpa7MuDi3m0WS6eOgOv+MKCOj1o9PsWY45ntLDZw1x7Qgz2h7Hrf1B4/jVfso6dTMIrvxG17YUmBH6FTam/qoh5ZQwKf7mC+R+tDAtNvVTOdiaA1QSMTwmUrwAGuQuqbZejiMmtXiW96GVsn/fAazYCDC+KOj3mhy9lv/WPDaSOMbyVZFuf/amwQdhEUurec+VHSfJSU9/FoZWeh09YiOOEgqEkCx3wqj6NjBglSNnYfeMSp13wa2W4O32Zm0vNXQflyGIiJ1SiFtGaRVPx41uhx5y18ys/EQrT7RMsrq6MD1ARfTF/DeXmjwArJ9YhK+Zc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4021C72590E4AE43B655CF2F274B9E0E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaedf75-761c-487d-f132-08d75c1dd86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 03:12:34.9975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFiFeiCfsf1idm9bYreu8r+dvQeUJMTGTmKat+z5wUqAYf+9gkMP7yvGfrbdWd7RsjzFR1oFl5exTmK5G3cF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-25 12:59:17, Roger Quadros wrote:
> Peter,
>=20
> On 25/10/2019 06:13, Peter Chen wrote:
> > On 19-10-23 09:17:45, Pawel Laszczak wrote:
> > > Hi,
> > >=20
> > > Reviewed-by: Pawel Laszczak <pawell@cadence.com>
> >=20
> > Hi Roger & Pawel,
> >=20
> > Assume gadget function has already enabled, if you switch host mode
> > to device mode, with your changes, where the device mode will be enable=
d
> > again?
>=20
> When it switches from device mode to host the UDC is removed. When we swi=
tch
> back from host to device mode the UDC is added, so,
>=20
> usb_add_gadget_udc_release()-> check_pending_gadget_drivers()->
> udc_bind_to_driver()->usb_udc_connect_control()->usb_gadget_connect()->
> gadget->ops->pullup()

Thanks. I have another question how you decide when to store UDC name
to /sys/kernel/config/usb_gadget/g1/UDC? Do you have a user daemon program
to monitor VBUS or external connector? At host mode, the store operation
will fail due to there is NO UDC.

--=20

Thanks,
Peter Chen=
