Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488AECA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1DF2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="dTU3rPmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbfJ1MHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:07:37 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:50006
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730055AbfJ1MHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBzTCjDEw38KUxDrYmdx6lZBve85jF/4wl6wgk/f5APbconVucOPuULRM5mNjVQiQkrNCCNLtnQfLdD60BYeukh3gYDeK30KwSFn8eGM4Ip1KQPMsVL3YlV1I8VDbncWomWzCswuEnIEfZgDZaohBcfVMBWdagqTUimP+hQvE4vXII6FC98RtYQFgpETgkxvMoRg5fJPWOfZcyeK2ee1OaiPRWlEfgKm2bj/4B9npxbEkOEmd4Vr78nkeMI9LNuUhqy/l4gZbHk6CfdzBtlF17GifGuDMkleYb9Kul0B5iy6wc6UJkEVVzrKmDvZ7fZGT1Yb7KEnPvHtndLVXNinTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufPYz03fbF/xvq6ZzQ02XZGBMh6qy4seCZ22vlZbH+k=;
 b=AeO8NX7p4dJUzeo9xXJvAOePLeQoql4ZAWpznow+NaIiJnrohUW+MCBrxJe7nK1g7Mulbd8mbLCwpz9BlJJ/scTGIPaDxpUlKhNCKRVjho3F1pBckLi33NIH8x9rHomlQ0WsddtOJkSlxLuvZaMytY5DNqr0gVgrSBadWqo6BOIKhYs6WvszXXT5ZvhEZ9hyLSwygchr/Da6m4UOeHoqfGFaS/EtJudx1Ap0wEl0vt63I0lKCW6NHgHHm2vsBhVCdkJKD84lkP/iQNiOV8zo9sInmAmIQ5iXFvtSW9hsHBQvt2mCaX7gciWtAZNbaO3r7/1M+AHVHqSOaf7wcyAHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufPYz03fbF/xvq6ZzQ02XZGBMh6qy4seCZ22vlZbH+k=;
 b=dTU3rPmVyD35xaZW1/0GWr+9f1dRHHai0PNqxPNdhkLYB4Rz2b0UDWIXwXczwKhoiuPSmRcq2qaSveYuTSkT5CtFXNjpcF0FwUEHuhyqEYTo7VI47aULskEPIndTz9jBccQyEXIR7Yq4sxjnlWfVkzJAd/BRZoYgpKWhQp4B+Ek=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB1879.eurprd09.prod.outlook.com (10.171.76.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 12:07:32 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::b1b2:ecb1:9c98:6b74%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 12:07:32 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: arm: fsl: Document Variscite i.MX6q
 devicetree
Thread-Topic: [PATCH v1] dt-bindings: arm: fsl: Document Variscite i.MX6q
 devicetree
Thread-Index: AQHVikyT2KF91MXB10mxyuBdtabWT6dv89SAgAAHgYA=
Date:   Mon, 28 Oct 2019 12:07:32 +0000
Message-ID: <20191028120519.GA4147@optiplex>
References: <20191024092019.4020-1-oliver.graute@kococonnector.com>
 <20191028113826.GD16985@dragon>
In-Reply-To: <20191028113826.GD16985@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::34) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d1bfcb2-8a21-4b88-465a-08d75b9f6929
x-ms-traffictypediagnostic: DB6PR0902MB1879:
x-microsoft-antispam-prvs: <DB6PR0902MB187975BD0711DB16777B34FBEB660@DB6PR0902MB1879.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:255;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(136003)(366004)(376002)(396003)(39830400003)(189003)(199004)(81156014)(229853002)(33656002)(386003)(6506007)(25786009)(66476007)(66556008)(66446008)(7416002)(64756008)(186003)(3846002)(66066001)(6116002)(66946007)(26005)(86362001)(6246003)(102836004)(5660300002)(476003)(8676002)(4326008)(6486002)(11346002)(508600001)(4744005)(81166006)(6512007)(6916009)(71200400001)(6436002)(14454004)(1076003)(446003)(71190400001)(33716001)(305945005)(7736002)(54906003)(8936002)(9686003)(44832011)(256004)(76176011)(99286004)(486006)(316002)(2906002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB1879;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2pucoY+MLAmupebskQvw1ztiy3DNpDBxGOn0JQaxpbqZ/XyvWHBRzbNHPS45Tj6BruaSkg8Gm4jfGDU43atyN6jGVY7rXAXrfq4Myj4km1kwAPkfO2DZMQ2QskI4Ojgj4y820wWK4WIPcQkqKO3Q4UEegVGwX2+1WVyND29CgLnv59bQ23yuWhFROM0Sx9DgTAAUzHefmMehoADV/YWJkyOtOZbLQ/BT8OpknMgMG8VcLpOLbap1PCdKdK4MSNqJK08fZLRT6dRNfCd28txt2Gd4CLnXoC5FunY9artVHDGNJw7wWR01zF/QhUY74x9hxH/QiYGzKM6WIqDeA2+f8U8UJak1SLrkbzR7G8tcM04NwVflx8VBjWFjbdZVAavR93W2hJGj7x9e0i/O4gDoETWhDNi0MJtJWOOExwP76JW4149Sr+LPNpP+kO6Q7wc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BDBB041599490542A768DC713BCDDB55@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1bfcb2-8a21-4b88-465a-08d75b9f6929
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 12:07:32.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/VoaNVKWW5yIOVSuewyeuNmty1dOSaPcFwwGzsP2G7PA/pZ+V5Lx+1Di/HGn1KNvt5BX3bzZOBMsOdJIdKueCsftTtaQQFM2OKzX9onnt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB1879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/19, Shawn Guo wrote:
> On Thu, Oct 24, 2019 at 09:22:37AM +0000, Oliver Graute wrote:
> > Document the Variscite i.MX6qdl board devicetree binding
> > already supported:
> >=20
> > - variscite,dt6customboard
> >=20
> > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
>=20
> Please organise it into the patch series, where it's being used.

I think this was just forgotten on this commit:

commit 26b7784b29e90da926ff3c290107f7e78c807314
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Mon Dec 4 10:21:09 2017 +0100

    ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board support

    This patch adds support for the i.MX6 Quad variant of the Variscite DAR=
T-MX6
    SoM Carrier-Board.


Best Regards,

Oliver
