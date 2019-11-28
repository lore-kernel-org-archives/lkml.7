Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37131C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF0216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rZyz3lnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK1J2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:28:37 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:49038
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfK1J2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:28:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEYf80RMc7KD2MmuaQWf/0K6SKNhVia2N1SIRU2Oh4FVs4puvCnKwzo/ZU1a1z3kKKtDk4ewYewtgnHANfYY1/wGgC5LmZ5x73QwdkvzPYUQGlIGXcEpPaJitTZPhOD6X0DBD3Hq3oi1yh4/o4ijV0LVT3w1AzgqW7kYfBax7Ss/l3tHFnjSbj0UbSQ8v7E/WqPZQV5TVAPhxENIPbjxBe7Lt/DL2aea7ipM6BxsnCYvczOHa6jpUsuzWQyfja/5l51fM36zNrd+j+cBb5GjBP1HHV6b1ogJ3R8/6mWPpZcVCBaHFwy+t1FwN34NOvtZgkewfDPL7/ZTCqFSE9GeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JMLzyvCGZHK1RpUvZ6VPRGWWmw1cSMq1Le/FIwyFaQ=;
 b=fTqkWIRFKXiyLNewQ3wwHkJjK8ranLtgXVPnVbYBBjt3f/8B0729177pOBdnpNDcFQV3MUc770dG3IPFWSyV7ssvScec1BSbxt+ajRt9XyiRGKeVmoEeycyuzDPyYjKDqzmRg2P72sonMkQrC1J6O7usZ2TipZiN/2qX3xJ15x+awHh4Qr4BTAzUWliD7hD6I9D/nh3gt/afsQ3H4KoGJr60b4v6EWOKT9CAHms4I27CTQPjS2IC5WCctaYNa8QWUCSVgYq+oi9VQbGo4BxIezI/c/ovVTg0YKFZryQmKdR73+9iCB4NdkJIBnAptiLttlowHGGaFFXWvroLmzqjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JMLzyvCGZHK1RpUvZ6VPRGWWmw1cSMq1Le/FIwyFaQ=;
 b=rZyz3lnZLg+YFIg0luAhv8KaSunhF6uESqqDmNgQApjzn6p2+TdlvCQJDD3t5MxXnYGuVsWcmCgIOiixa9+ZDL4lx0qYlv/enM9eRxKCZhI1qRd41GX+t/ZLMJrxf5cYAK4oOJlfzUkKOeiQu8Xz4sN9CC9GGlGCpmplvzfvMts=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4063.eurprd04.prod.outlook.com (52.133.13.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 09:28:32 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 09:28:32 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Henry Lin <henryl@nvidia.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Romain Izard <romain.izard.pro@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        EJ Hsu <ejh@nvidia.com>
Subject: RE: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Topic: [PATCH] usb: gadget: f_ncm: fix wrong usb_ep
Thread-Index: AQHVoCLqKGYVyVjGs0eFFEwrEIcffKebTxyAgAHGIQCAAAb9cIAAJQiAgAEJN3CAAg+WAIAAAccg
Date:   Thu, 28 Nov 2019 09:28:32 +0000
Message-ID: <VI1PR04MB53277F89D11A5EE67F95861C8B470@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20191121041858.15746-1-henryl@nvidia.com>,<20191125042039.GA10953@b29397-desktop>
 <MN2PR12MB33899F0DEEA0A22086ACE0ECAC450@MN2PR12MB3389.namprd12.prod.outlook.com>,<VI1PR04MB53277359AF0E283AE948F34C8B450@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <MN2PR12MB33894E3D1D9AC14B8C9E2966AC450@MN2PR12MB3389.namprd12.prod.outlook.com>,<VI1PR04MB532730D2E1BA4108B37155D08B440@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <MN2PR12MB3389A88286B9A8348596F947AC470@MN2PR12MB3389.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3389A88286B9A8348596F947AC470@MN2PR12MB3389.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e7da355-f8f4-474e-e16c-08d773e55621
x-ms-traffictypediagnostic: VI1PR04MB4063:
x-microsoft-antispam-prvs: <VI1PR04MB40634D78FC2CC213598BAAEB8B470@VI1PR04MB4063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(54906003)(81166006)(99286004)(66066001)(229853002)(81156014)(8936002)(8676002)(6436002)(186003)(6506007)(71200400001)(71190400001)(6916009)(256004)(76176011)(14444005)(7696005)(11346002)(102836004)(44832011)(446003)(33656002)(26005)(52536014)(7736002)(4326008)(6246003)(5660300002)(305945005)(3846002)(6116002)(2906002)(74316002)(9686003)(55016002)(316002)(25786009)(86362001)(4744005)(66476007)(76116006)(66946007)(478600001)(14454004)(64756008)(66556008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4063;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGmGlMyktmQLujbOt+GFcKiMyHi7JJXGA6rpXQpo/3biCKi+hPjbXciMAl1U/ebhHFhF8/17SHu55Y2cH/yVqNQVbMQh/1PV6Vo1uBBg1RVa69Somio872im8resDhpArRKkrLgvK+ZXTS/+aLK2h1+Ky092WFaOPsWDcAHEJfuXetLlUui+ir2iTY275COXaPztVKTSA0iQDQTf2KEP6O425anSjh3lhdq19922AZ6Di+tHSwyPjf24ez/Xo63+v3SpKsyHaAmFOSBJiTan0VvV/Ix1Inqosbg/gsS9iwBWkkbVaDjK9p4uekoblvXZnI1jTry2wT0D0wB9qv3Ay6UercYjWofRxX3kRxBXfkDpu6aw0KaOPVEJG8pNi3aZr4hvtBElO+HOxrDTFH+xdZF3p4xXunjLLiGF7vlbly/W5o9cYBRr0+SZbRIZREVs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7da355-f8f4-474e-e16c-08d773e55621
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 09:28:32.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Rj1IwThvYjEw+EDHviAHweTLAuxrhQz2kO22cuulM2ZIDUg58W/AdeuR9F06duPnafgO3YyHaZ3M005fHzfHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >> >It should set all desc to NULL at related function ->disable.
> >>
> >> For ECM case, if ecm_set_alt() gets called with alt =3D=3D 0, in_ep->d=
esc
> >> and out_ep-
> >> >desc will be set up. But these two ep will not be enabled as
> >> >gether_connect() is not
> >> executed. During disconnect from the host, ecm_disable() gets called
> >> with ep disabled. In this case, gether_disconnect() will not get calle=
d to set desc
> to NULL.
>=20
> >Would you please share your test case? I use Linux host, and the host
> >will always set alt for 1, and doesn't have this issue.
> Using Windows host (without any proprietary NCM/ECM driver installed) can
> reproduce set alt to 0. We just used Win10 to confirm this.

Ok, feel free to submit a patch to fix it.

Peter
