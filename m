Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DBC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ED4214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LZbgbd8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfKFNrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:47:53 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:30363
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfKFNrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBJb0aZlCso2BiQoHzrA3zX/rt0E7Lu4273tZ3WvQ9HgvtffPxaPwXcEbdGz9Wpg+KloEWrFGiq71Xu5WKyWHgp58Xp+lEapewL4GugSMFV+REGAcSSt+4oFKBVUzeChy9NZ3NFLtGWm4we2r+dUXI8rXvtth62ElZ+QdfVA8hXhNlIVtCu6MKNcCOmozgHfXrNAN4M1o086yUw4a+9Fi164aEJl0P21gzuzrFJnytWLpb/Iy1jxpd/Cd73RiwAQB473LM1wDAWloFkMo8owgIsg2+DbkrcFUot7THV15p+ylNFAuFSJEuM0qkLDBEGCe6kwl5I2JnLyu2NzSXlvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cojqmL+MtB33r2Mf97GTs7TJdYeDFKeljZg83PEJhWU=;
 b=n4J+xz42SLpEv2BsSGjS83iqtRKzf0jzPabhO1m82JNqCQ8KYdx3rlPzpPctiOe+jRgNiwjrvyg6NxZTbQMDMb+8dd3GzttxRa6nXFXN8+QwJJ9bgrAvsId0KYJgGDpDzWjtQap9AS/I/wPN5Dy6t8P6hCJ4v61UzS+4farY6i1ywmYCrwM2LzMKpGbOdMY/+mkHTVtWBbsQygWiNN5o/9doeZMZA5vV9FO/7XxrCs0w88K42zcbcQacywG4kz4/eWU1nxiilmTp+7KpJDv3ATfvjgW7ok+ugvNs2PfEd4nS5dBstHfsRhpa/lTuP+cOGB+1ZOCZqAurj9vy5EYkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cojqmL+MtB33r2Mf97GTs7TJdYeDFKeljZg83PEJhWU=;
 b=LZbgbd8ufFmfrs3L9yilm7Afe5d1V9fD3WLiw6MwhHzd730yfiLCFycU1HJP0hhgUnJk/n3m5jqBt9+RZJQ8KEayprZ1YYfmcnlTYMoswUeaFOtXP0qwsQz0lLq4EUPLjGus50C43rqXtW5hyjyau28CQlYnRaaYuZW5khz+zck=
Received: from DB6PR0402MB2789.eurprd04.prod.outlook.com (10.172.245.7) by
 DB6PR0402MB2792.eurprd04.prod.outlook.com (10.172.246.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 13:47:48 +0000
Received: from DB6PR0402MB2789.eurprd04.prod.outlook.com
 ([fe80::4a8:4223:6954:59b9]) by DB6PR0402MB2789.eurprd04.prod.outlook.com
 ([fe80::4a8:4223:6954:59b9%9]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 13:47:48 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: RE: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect STP
 to CPU
Thread-Topic: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Thread-Index: AQHVk9VwUttQp4rnGEyeNWyFfbjmDKd8oR0AgAAAhWCAABrTAIABX2xA
Date:   Wed, 6 Nov 2019 13:47:47 +0000
Message-ID: <DB6PR0402MB27899B298481E7A3460BB9BFE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
 <20191105142202.GC7189@lunn.ch>
 <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20191105155954.GE17620@lunn.ch>
In-Reply-To: <20191105155954.GE17620@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0fab34e-38ed-4017-5ad2-08d762bfe8e0
x-ms-traffictypediagnostic: DB6PR0402MB2792:
x-microsoft-antispam-prvs: <DB6PR0402MB2792A557FDEE2A9EA0168A24E0790@DB6PR0402MB2792.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(26005)(6916009)(229853002)(6436002)(8676002)(55016002)(446003)(54906003)(76176011)(44832011)(9686003)(316002)(52536014)(76116006)(8936002)(6246003)(81166006)(81156014)(478600001)(25786009)(11346002)(186003)(5660300002)(66476007)(64756008)(66446008)(66556008)(14454004)(86362001)(66946007)(476003)(71200400001)(71190400001)(256004)(7736002)(4326008)(3846002)(6116002)(74316002)(305945005)(2906002)(7696005)(486006)(102836004)(99286004)(6506007)(33656002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2792;H:DB6PR0402MB2789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mA6NupQFxpOPJT9NsJY6XTGVfOz2F4LdP0WGmhW4LBkpwdR36WRXqFf+CPVX1Gq/HeNkub1Q+cX6I8bKfT7Wz+QFPaqZXS7SJNRdeRPa2DGl0loadm5zqerZKSekjywYT67+1VSC5iX3gonLnLiV+MzyZ0Ap0MgV/Z4aKQAw0IEs9EdBoKtXIDq93b9StaYcqBBJekksSVfk/KOpiSFQ5zU9X9FyOvIqRXLmlGki6imosr28r6FXGBXcj27JltBzh0dbht4Y3b2D+IWfi1jdbrPxxtK4mRj7oIIIRdEHF174jun60k0PcWck5IgHSUSnQsSYow2Jg5A3op6PzVe0EXw3GUdPzBKQDd2WCB4uCL+dlzNpE9OQ6ucoub5piyqLMm0zgNzow4Vi8h1IkqX5LukYL6Yp3/J1oFzaYfebSMNFwB+37cRtimji778S9t6F
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fab34e-38ed-4017-5ad2-08d762bfe8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 13:47:48.0697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y44KpDKn5d/Su9lMoFl+Zs+hmhgR1rILogZ5rbjA6zSgwsaTKmKm9FEY73rUcNeYzT3jNBuGkcsD3Z0x9pSTLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirec=
t
> STP to CPU
>=20
> > The control queues do not form an actual interface in the sense that
> > the CPU does not receive unknown unicast, broadcast and multicast
> > frames by default.  For each frame that we want to direct to the CPU
> > we must add an ACL entry.
>=20
> So this appears to be one of the dumbest switches so far :-(

To be fair, the actual hardware can do much more.
The problem here is that the firmware models the switch in a non-Linux styl=
e.

>=20
> Can you add an ACL which is all L2 broadcast/multicast?  That would be a =
good
> first step.

I can add that but it would not be enough.
For example, unknown unicast would not be matched thus would not reach the =
CPU.

>=20
> Does the ACL stop further processing of the frame? Ideally you want the
> switch to also flood broadcast/multicast out other ports, if they are in =
a
> bridge. If it cannot, you end up with the software bridge doing the flood=
ing.

Yes, the ACL stops any further processing.=20

>=20
> So i also assume it does not perform learning on CPU frames? That probabl=
y
> means you need to connect up the fdb add/remove calls to add in ACLs. And
> you will need to implement ndo_set_rx_mode. Each unicast and multicast
> address needs to be turned into an ACL. What i don't know is if the netwo=
rk
> stack will automatically add the interfaces own MAC address. You might ha=
ve
> to handle that special case.
>=20
>     Andrew

Your assumption is true, learning, with the current implementation, is not =
possible for CPU frames.
In .ndo_start_xmit() we inject directly into the switch port's Tx queues, t=
hus bypassing the entire learning process.

All in all, I do not see a way out just by using the ACL mechanism (because=
 of unknown unicast frames).

I have to talk in detail with the firmware team, but from what I can unders=
tand if we make the following changes in firmware it would better fit the L=
inux framework:
 * make the CPU receive unknown unicast, broadcast and multicast frames by =
default (without any ACLs)
 * frames originated on the CPU should not bypass the learning process (it =
should have its own Tx queues that go through the same learning process)

Thanks,
Ioana


