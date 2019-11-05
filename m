Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1440C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A27D21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EJ3FeuEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbfKEObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:31:38 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:34626
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389459AbfKEObi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:31:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRTrPudTMeYJlwTWdA67LS2wb79asijcjxFhJ007BFFjtvC9YwkbZbxDrFLz4svkSCNpWZBXHRQ7vHWib5Sgmw6rFz3uMzoy5wiYa/T702dEvpaHIfpCuvHn0PDChLnqdXkkoyD1K7zde05sJ5gr1c0xURayVht2MOB42wfQB4E0GfmaL2Q++1+dP57WCM5xWDEkqQil3rF352brwsvyX9QC0zSQbMQ6GI06LrV+coBTfRn1mM1hbIxrGx3AKoCv6UaX3JSVdBDbXmfGvsVsr9Vht0u4iv85GbudUxuzQl/JbD6D9TLof3zCtXjBcajn7tS72IRwE+HEQYt0kvAnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS8navh9a7ESKiVar6GrSEaMBrTxvUG+nuIBf6SQ7Fc=;
 b=B7I8Ilwd8kjYF3y5nBmIE2PXTC2XtKWOK5vaQmzqA9mNMj2+nR6+ybYk2AI9Bu0mKyxido9/BhJO/Je4VP70at4qWi7vWVOC/h+6ovcBRQrWnEo0ucc7nf8axl8EGbLXDL7C1Th2Oct5tEyy+Tw+cj26zWES3ZbxRmaR/hUeHQemmRx5jggRWvao5Uf9UTBOOG/YAwOm8pYAlAScK1xK9dAaoE4znPK7VwVTClUTGPz7nnZfiRb4qi6cX5ifah0lwBjfksDw+e3iqjBzbCiM6p4+b/6r3nAIgwkXsFnl5Z2VhL7IMRuRZxg3qSttRQTM5DIDJ4SehO/2252ro8XoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS8navh9a7ESKiVar6GrSEaMBrTxvUG+nuIBf6SQ7Fc=;
 b=EJ3FeuEjddaPs4sv7qwkqTn1hw3fKsOKdD8D5ORUlWj3BM7xya52Qu7nT+sNzJjcM3O1fnpPUKBBEgRmpzv4qlnT3tW9BTxCyNB8/USXZp+74arL5P5tICr2dC1+tdxtFWnJlQQ5sbE6UE6Zf7vVLKDIjNaohO/zIDz52orMHfk=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.175.24.138) by
 VI1PR0402MB3790.eurprd04.prod.outlook.com (52.134.18.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 14:31:35 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::749b:178a:b8c5:5aaa]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::749b:178a:b8c5:5aaa%11]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 14:31:35 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: RE: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect STP
 to CPU
Thread-Topic: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Thread-Index: AQHVk9VwUttQp4rnGEyeNWyFfbjmDKd8oR0AgAAAhWA=
Date:   Tue, 5 Nov 2019 14:31:35 +0000
Message-ID: <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
 <20191105142202.GC7189@lunn.ch>
In-Reply-To: <20191105142202.GC7189@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ddf62c0-005a-46bd-047e-08d761fcdc57
x-ms-traffictypediagnostic: VI1PR0402MB3790:
x-microsoft-antispam-prvs: <VI1PR0402MB3790FF3503FC87E51DAE7352E07E0@VI1PR0402MB3790.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(6506007)(11346002)(7696005)(478600001)(71190400001)(6436002)(71200400001)(316002)(99286004)(54906003)(26005)(81166006)(81156014)(305945005)(6116002)(6916009)(66556008)(3846002)(7736002)(2906002)(76116006)(66946007)(66066001)(9686003)(55016002)(229853002)(476003)(446003)(44832011)(186003)(74316002)(8676002)(64756008)(66446008)(8936002)(66476007)(486006)(6246003)(86362001)(256004)(5660300002)(102836004)(4744005)(14454004)(76176011)(33656002)(52536014)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3790;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NbqPceIndCx/pAh48tdOUt9Mg3XzECOdxDr4w31LZCOUhL03z0FBH/tZJAg8uRnw68iF5RHqxHHfX6Zu3JjVxe7IsglZB0CoR11s+bNsHKqE4JH80Tb39rJ6bKBCUfXyhL4wYvmQ9boVKoVzE8EaGyAlHQH33q5fGJjkTVZ0mShPTlSjTAz+gJmk7613VfM0bX5UKy+JRZeltQRuBe3MpaWPuPpM7xSMUG5pdgGSCgCzDPzCgSeudSMigzSFc186KjrX9TRXTVBf0Kpxm5Pid35jtnQiw/8jllUeBP7pcKmS0Zg9mTjcA25b/6Cg4XXw4XG4k41J1V+2tJF74KjYJ0vMib1fSGW2XKryQcjrCjagwCUN/RFdZj5mY7YLeMelGChhmq8/0wRUPVesegc/p13ugMgdMIXhNFs3SBwEyc5CEvvqjr6ZIhIsVxWxu2Y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddf62c0-005a-46bd-047e-08d761fcdc57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 14:31:35.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiYjoMwwBebl+3ZmowflXYxer5+R5RiIPubJMAxLl+xHP4zKtV1PKb1lKuvES+IEbwHJIEjq8mn7VsAKG1MSZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirec=
t
> STP to CPU
>=20
> > +static int ethsw_port_set_ctrl_if_acl(struct ethsw_port_priv
> > +*port_priv) {
> > +	const char stp_mac[ETH_ALEN] =3D {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00}=
;
>=20
> I think there is a standard define for that somewhere in include/linux or
> maybe include/net.
>=20
> But thinking about the big picture, i wonder why this is needed, at least=
 in a
> minimal implementation. Bit 0 is set in this MAC address, so it is a L2 m=
ulticast
> frame. By default, all L2 multicast frames should be delivered to the CPU=
. So
> it should work without this.
>=20
>        Andrew

Now I see that I should have been more clear about what our switch can do.

The control queues do not form an actual interface in the sense that the CP=
U does not receive unknown unicast, broadcast and multicast frames by defau=
lt.
For each frame that we want to direct to the CPU we must add an ACL entry.

Ioana

